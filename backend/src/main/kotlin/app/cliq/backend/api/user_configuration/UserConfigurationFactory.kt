package app.cliq.backend.api.user_configuration

import app.cliq.backend.api.user.User
import org.springframework.stereotype.Service
import java.time.Clock
import java.time.OffsetDateTime

@Service
class UserConfigurationFactory(
    private val clock: Clock,
) {
    fun createFromParams(configurationParams: ConfigurationParams, user: User): UserConfiguration {
        return create(configurationParams.configuration, user)
    }

    fun create(encryptedConfig: String, user: User): UserConfiguration {
        return UserConfiguration(
            user,
            encryptedConfig,
            OffsetDateTime.now(clock),
            OffsetDateTime.now(clock)
        )
    }
}
