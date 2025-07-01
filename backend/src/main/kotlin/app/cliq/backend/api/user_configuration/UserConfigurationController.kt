package app.cliq.backend.api.user_configuration

import app.cliq.backend.api.user.User
import io.swagger.v3.oas.annotations.Operation
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.http.ResponseEntity
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/v1/user/configuration")
@Tag(name = "User Configuration", description = "User configuration management")
class UserConfigurationController {

    @PutMapping
    @Operation(summary = "Insert or update user configuration")
    fun put(
        @AuthenticationPrincipal user: User,
    ): ResponseEntity<Void> {
        TODO()
    }
}
