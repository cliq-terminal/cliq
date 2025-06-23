package app.cliq.backend.api.user

import app.cliq.backend.api.user.event.UserCreatedEvent
import app.cliq.backend.service.SnowflakeGenerator
import org.springframework.context.ApplicationEventPublisher
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service
import java.time.Clock
import java.time.OffsetDateTime

@Service
class UserFactory(
    private val passwordEncoder: PasswordEncoder,
    private val snowflakeGenerator: SnowflakeGenerator,
    private val clock: Clock,
    private val eventPublisher: ApplicationEventPublisher,
    private val userRepository: UserRepository
) {

    fun createFromRegistrationParams(
        registrationParams: UserRegistrationParams,
    ): User {
        val hashedPassword = passwordEncoder.encode(registrationParams.password)

        var user = createUser(
            email = registrationParams.email,
            password = hashedPassword,
            name = registrationParams.username,
            locale = registrationParams.locale,
        )

        user = userRepository.save(user)
        userRepository.flush()

        eventPublisher.publishEvent(UserCreatedEvent(user.id))

        return user
    }

    private fun createUser(
        email: String,
        password: String,
        name: String,
        locale: String = DEFAULT_LOCALE,
    ): User {
        val id = snowflakeGenerator.nextId().getOrThrow()

        return User(
            id = id,
            email = email,
            password = password,
            name = name,
            locale = locale,
            createdAt = OffsetDateTime.now(clock),
            updatedAt = OffsetDateTime.now(clock),
        )
    }
}
