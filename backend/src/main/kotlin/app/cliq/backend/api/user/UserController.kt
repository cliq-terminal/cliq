package app.cliq.backend.api.user

import EmailOccupiedConstraint
import app.cliq.backend.api.error.exception.EmailNotFoundOrValidException
import app.cliq.backend.api.error.exception.PasswordResetTokenExpired
import app.cliq.backend.api.error.exception.PasswordResetTokenNotFound
import app.cliq.backend.api.user.view.UserResponse
import io.swagger.v3.oas.annotations.Operation
import io.swagger.v3.oas.annotations.media.Content
import io.swagger.v3.oas.annotations.media.Schema
import io.swagger.v3.oas.annotations.responses.ApiResponse
import io.swagger.v3.oas.annotations.responses.ApiResponses
import io.swagger.v3.oas.annotations.tags.Tag
import jakarta.validation.Valid
import jakarta.validation.constraints.Email
import jakarta.validation.constraints.NotBlank
import jakarta.validation.constraints.NotEmpty
import jakarta.validation.constraints.Size
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.server.ResponseStatusException
import org.thymeleaf.TemplateEngine
import org.thymeleaf.context.Context

@RestController
@RequestMapping("/api/v1/user")
@Tag(name = "User", description = "User management")
class UserController(
    private val userFactory: UserFactory,
    private val userService: UserService,
    private val userRepository: UserRepository,
    private val templateEngine: TemplateEngine,
) {
    @PostMapping("/register")
    @Operation(summary = "Register a new user")
    @ApiResponses(
        value = [
            ApiResponse(
                responseCode = "201",
                description = "User successfully created",
                content = [
                    Content(
                        mediaType = MediaType.APPLICATION_JSON_VALUE,
                        schema = Schema(implementation = UserResponse::class),
                    ),
                ],
            ),
            ApiResponse(
                responseCode = "400",
                description = "Invalid input",
                content = [Content()],
            ),
        ],
    )
    fun register(
        @Valid @RequestBody registrationParams: UserRegistrationParams,
    ): ResponseEntity<UserResponse> {
        val user = userFactory.createFromRegistrationParams(registrationParams)
        val response = UserResponse.fromUser(user)

        return ResponseEntity.status(HttpStatus.CREATED).body(response)
    }

    @GetMapping("/verify/{verificationToken}")
    @Operation(summary = "Verify a users email address")
    @ApiResponses(
        value = [
            ApiResponse(
                responseCode = "200",
                description = "Email successfully verified",
                content = [
                    Content(
                        mediaType = MediaType.TEXT_HTML_VALUE,
                        schema = Schema(implementation = String::class),
                    ),
                ],
            ),
            ApiResponse(
                responseCode = "403",
                description = "Verification token is invalid or expired",
                content = [
                    Content(
                        mediaType = MediaType.TEXT_HTML_VALUE,
                        schema = Schema(implementation = String::class),
                    ),
                ],
            ),
            ApiResponse(
                responseCode = "404",
                description = "Verification token not found",
                content = [Content()],
            ),
        ],
    )
    fun verify(
        @PathVariable @Valid @NotBlank verificationToken: String,
    ): ResponseEntity<String> {
        val user =
            userRepository.findUserByEmailVerificationToken(verificationToken) ?: throw ResponseStatusException(
                HttpStatus.NOT_FOUND,
                "Verification token not found",
            )

        val context = Context(user.getUserLocale())

        if (!user.isEmailVerificationTokenValid()) {
            val htmlContent = templateEngine.process("email-verification-token-inavlid.html", context)

            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(htmlContent)
        }

        userService.verifyUserEmail(user)

        val htmlContent = templateEngine.process("email-verified.html", context)

        return ResponseEntity.ok().contentType(MediaType.TEXT_HTML).body(htmlContent)
    }

    @PostMapping("/resend-verification-email")
    @Operation(summary = "Resend verification email")
    @ApiResponses(
        value = [
            ApiResponse(
                responseCode = "204",
                description = "Verification email successfully resent",
            ),
            ApiResponse(
                responseCode = "400",
                description = "Invalid E-Mail or email already verified",
                content = [Content()],
            ),
        ],
    )
    fun resendVerificationEmail(
        @Valid @RequestBody params: ResendVerificationEmailParams,
    ): ResponseEntity<Void> {
        userRepository.findUserByEmail(params.email)?.let {
            if (it.isEmailVerified()) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).build()
            }

            userService.sendVerificationEmail(it)

            return ResponseEntity.noContent().build()
        }

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).build()
    }

    @PostMapping("/init-reset-password")
    @Operation(summary = "Start the reset password process")
    @ApiResponses(
        value = [
            ApiResponse(
                responseCode = "204",
                description = "Reset password email successfully sent",
            ),
            ApiResponse(
                responseCode = "400",
                description = "Invalid E-Mail or email not verified",
                content = [Content()],
            ),
        ],
    )
    fun startResetPasswordProcess(
        @Valid @RequestBody params: StartResetPasswordProcessParams,
    ): ResponseEntity<Void> {
        val user = userRepository.findUserByEmail(params.email) ?: throw EmailNotFoundOrValidException()

        if (!user.isEmailVerified()) {
            throw EmailNotFoundOrValidException()
        }

        userService.sendResetPasswordEmail(user)

        return ResponseEntity.noContent().build()
    }

    @PostMapping("/reset-password")
    @Operation(summary = "Reset a users password")
    @ApiResponses(
        value = [
            ApiResponse(
                responseCode = "200",
                description = "Password successfully reset",
            ),
            ApiResponse(
                responseCode = "400",
                description = "Invalid reset token or password",
                content = [Content()],
            ),
        ],
    )
    fun resetPassword(@Valid @RequestBody params: ResetPasswordParams): ResponseEntity<Void> {
        val user = userRepository.findUserByResetToken(params.resetToken) ?: throw PasswordResetTokenNotFound()
        if (!user.isPasswordResetTokenValid()) {
            throw PasswordResetTokenExpired()
        }

        TODO()
    }
}

const val MIN_PASSWORD_LENGTH = 8
const val MAX_PASSWORD_LENGTH = 256

const val EMAIL_EXAMPLE = "user@example.lan"
const val EXAMPLE_PASSWORD = "CLIq123!"

@Schema
data class UserRegistrationParams(
    @field:Schema(example = EMAIL_EXAMPLE) @field:Email @field:NotEmpty @field:EmailOccupiedConstraint val email:
    String,
    @field:Schema(example = EXAMPLE_PASSWORD) @field:NotEmpty @field:Size(
        min = MIN_PASSWORD_LENGTH,
        max = MAX_PASSWORD_LENGTH,
    ) val password: String,
    @field:Schema(
        description = "An arbitrary username. Can be the user's full name",
        example = "John Doe",
    ) @field:NotEmpty val username: String,
    @field:Schema(example = DEFAULT_LOCALE, defaultValue = DEFAULT_LOCALE) val locale: String = DEFAULT_LOCALE,
)

@Schema
data class ResendVerificationEmailParams(
    @field:Schema(example = EMAIL_EXAMPLE) @field:Email @field:NotEmpty val email: String,
)

@Schema
data class StartResetPasswordProcessParams(
    @field:Schema(example = EMAIL_EXAMPLE) @field:Email @field:NotEmpty val email: String,
)

@Schema
data class ResetPasswordParams(
    @field:Schema(example = EXAMPLE_PASSWORD) @field:NotEmpty @field:Size(
        min = MIN_PASSWORD_LENGTH,
        max = MAX_PASSWORD_LENGTH,
    ) val password: String,
    @field:Schema(example = "reset-token") @field:NotBlank val resetToken: String,
)
