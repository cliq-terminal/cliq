package app.cliq.backend.unit.user

import app.cliq.backend.api.user.UNVERIFIED_USER_INTERVAL_MINUTES
import app.cliq.backend.api.user.User
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test
import java.time.OffsetDateTime

class UserTest {
    private fun createTestUser(
        emailVerificationToken: String? = null,
        emailVerificationSentAt: OffsetDateTime? = null,
    ): User =
        User(
            id = 1L,
            email = "test@example.com",
            name = "Test User",
            password = "password",
            emailVerificationToken = emailVerificationToken,
            emailVerificationSentAt = emailVerificationSentAt,
            createdAt = OffsetDateTime.now(),
            updatedAt = OffsetDateTime.now(),
        )

    @Test
    fun `isEmailVerificationTokenValid should return true when token is not null and not expired`() {
        // Given
        val user =
            createTestUser(
                emailVerificationToken = "valid_token",
                emailVerificationSentAt = OffsetDateTime.now(),
            )

        assertThat(user.isEmailVerificationTokenValid()).isTrue()
    }

    @Test
    fun `isEmailVerificationTokenValid should return false when token is null`() {
        // Given
        val user =
            createTestUser(
                emailVerificationToken = null,
                emailVerificationSentAt = OffsetDateTime.now(),
            )

        assertThat(user.isEmailVerificationTokenValid()).isFalse()
    }

    @Test
    fun `isEmailVerificationTokenValid should return false when sent date is null`() {
        // Given
        val user =
            createTestUser(
                emailVerificationToken = "valid_token",
                emailVerificationSentAt = null,
            )

        assertThat(user.isEmailVerificationTokenValid()).isFalse()
    }

    @Test
    fun `isEmailVerificationTokenValid should return false when both token and sent date are null`() {
        // Given
        val user =
            createTestUser(
                emailVerificationToken = null,
                emailVerificationSentAt = null,
            )

        assertThat(user.isEmailVerificationTokenValid()).isFalse()
    }

    @Test
    fun `isEmailVerificationTokenValid should return false when sent date was created before the specified time`() {
        // Given
        val pastTime = OffsetDateTime.now().minusMinutes(UNVERIFIED_USER_INTERVAL_MINUTES + 1)
        val user =
            createTestUser(
                emailVerificationToken = "valid_token",
                emailVerificationSentAt = pastTime,
            )

        assertThat(user.isEmailVerificationTokenValid()).isFalse()
    }
}
