package app.cliq.backend.acceptance.helper

import app.cliq.backend.api.session.Session
import app.cliq.backend.api.session.SessionCreationParams
import app.cliq.backend.api.session.SessionFactory
import app.cliq.backend.api.session.SessionRepository
import app.cliq.backend.api.user.User
import app.cliq.backend.api.user.UserFactory
import app.cliq.backend.api.user.UserRegistrationParams
import app.cliq.backend.api.user.UserRepository
import org.springframework.boot.test.context.TestComponent
import kotlin.random.Random

@TestComponent
class UserHelper(
    private val userRepository: UserRepository,
    private val sessionRepository: SessionRepository,
    private val userFactory: UserFactory,
    private val sessionFactory: SessionFactory,
) {
    fun createRandomUser(
        email: String = "user${Random.nextInt(0, 9999)}@cliq.test",
        password: String = "Cliq${Random.nextInt(0, 9999)}!",
        username: String = "CliqUser${Random.nextInt(0, 9999)}!"
    ): User {
        val params = UserRegistrationParams(email, password, username)
        val user = userFactory.createFromRegistrationParams(params)

        return userRepository.save(user)
    }

    fun createRandomAuthenticatedUser(
        email: String = "user${Random.nextInt(0, 9999)}@cliq.test",
        password: String = "Cliq${Random.nextInt(0, 9999)}!",
        username: String = "CliqUser${Random.nextInt(0, 9999)}!"
    ): Session {
        val user = createRandomUser(email, password, username)

        val params = SessionCreationParams(email, password)
        val session = sessionFactory.createFromCreationParams(params, user)

        return sessionRepository.save(session)
    }
}
