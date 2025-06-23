package app.cliq.backend.api.session

import app.cliq.backend.api.error.exception.EmailNotVerifiedException
import app.cliq.backend.api.error.exception.InvalidEmailOrPasswordException
import app.cliq.backend.api.user.EMAIL_EXAMPLE
import app.cliq.backend.api.user.EXAMPLE_PASSWORD
import app.cliq.backend.api.user.MAX_PASSWORD_LENGTH
import app.cliq.backend.api.user.MIN_PASSWORD_LENGTH
import app.cliq.backend.api.user.UserRepository
import app.cliq.backend.api.user.UserService
import io.swagger.v3.oas.annotations.Operation
import io.swagger.v3.oas.annotations.media.Schema
import io.swagger.v3.oas.annotations.tags.Tag
import jakarta.validation.Valid
import jakarta.validation.constraints.Email
import jakarta.validation.constraints.NotEmpty
import jakarta.validation.constraints.Size
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/v1/session")
@Tag(name = "Session", description = "Session management")
class SessionController(
    private val userRepository: UserRepository,
    private val userService: UserService,
    private val sessionFactory: SessionFactory,
) {

    @PostMapping
    @Operation(summary = "Login/Create a session")
    fun createSession(
        @Valid @RequestBody sessionCreationParams: SessionCreationParams
    ) {
        val user = userRepository.findUserByEmail(sessionCreationParams.email)
            ?: throw InvalidEmailOrPasswordException()

        if (!user.isEmailVerified()) throw EmailNotVerifiedException()

        if (!userService.isPasswordValid(user, sessionCreationParams.password)) throw InvalidEmailOrPasswordException()

        val session = sessionFactory.createFromCreationParams(sessionCreationParams, user)

        // TODO create session response
    }
}

@Schema
data class SessionCreationParams(
    @field:Schema(example = EMAIL_EXAMPLE)
    @field:Email
    @field:NotEmpty
    val email: String,

    @field:Schema(example = EXAMPLE_PASSWORD)
    @field:NotEmpty @field:Size(min = MIN_PASSWORD_LENGTH, max = MAX_PASSWORD_LENGTH)
    val password: String,
    val name: String? = null,
    val userAgent: String? = null,
)
