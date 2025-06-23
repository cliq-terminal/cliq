package app.cliq.backend.api.user

import org.springframework.data.jpa.repository.JpaRepository

interface UserRepository : JpaRepository<User, Long> {
    fun existsUserByEmail(email: String): Boolean

    fun findUserByEmail(email: String): User?

    fun findUserByEmailVerificationToken(token: String): User?
}
