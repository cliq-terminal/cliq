package app.cliq.backend.api.user_configuration

import app.cliq.backend.api.user.User
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import java.time.OffsetDateTime

interface UserConfigurationRepository : JpaRepository<UserConfiguration, Long> {
    fun getByUser(user: User): UserConfiguration?

    @Query("SELECT uc.updatedAt FROM UserConfiguration uc WHERE uc.user = :user")
    fun getUpdatedAtByUser(user: User): OffsetDateTime?
}
