package app.cliq.backend.api.userconfig

import app.cliq.backend.api.user.User
import app.cliq.backend.service.SnowflakeGenerator
import org.springframework.stereotype.Service
import java.time.Clock
import java.time.OffsetDateTime

@Service
class UserConfigurationFactory(
    private val snowflakeGenerator: SnowflakeGenerator,
    private val clock: Clock,
) {
    fun createFromParams(
        configurationParams: ConfigurationParams,
        user: User,
    ): UserConfiguration = create(configurationParams.configuration, user)

    fun updateFromParams(
        existingConfig: UserConfiguration,
        configurationParams: ConfigurationParams,
        user: User,
    ): UserConfiguration =
        UserConfiguration(
            existingConfig.id,
            user,
            configurationParams.configuration,
            existingConfig.createdAt,
            OffsetDateTime.now(clock),
        )

    fun create(
        encryptedConfig: String,
        user: User,
    ): UserConfiguration =
        UserConfiguration(
            snowflakeGenerator.nextId().getOrThrow(),
            user,
            encryptedConfig,
            OffsetDateTime.now(clock),
            OffsetDateTime.now(clock),
        )
}
