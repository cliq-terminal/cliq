package app.cliq.backend.api.user_configuration

import app.cliq.backend.api.user.User
import org.springframework.data.jpa.repository.JpaRepository

interface UserConfigurationRepository : JpaRepository<UserConfiguration, Long> {
    fun getByUser(user: User): UserConfiguration?
}
