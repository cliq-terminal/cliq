package app.cliq.backend.api.user

import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.Id
import jakarta.persistence.Table
import jakarta.persistence.UniqueConstraint
import java.time.OffsetDateTime
import java.util.*

const val DEFAULT_LOCALE = "en"
const val UNVERIFIED_USER_INTERVAL_MINUTES = 60L * 24L // 1 day
const val PASSWORD_RESET_TOKEN_INTERVAL_MINUTES = 30L // 30 minutes

@Entity
@Table(
    name = "users",
    uniqueConstraints = [
        UniqueConstraint(columnNames = ["email", "email_verification_token"]),
        UniqueConstraint(columnNames = ["email", "reset_token"]),
    ],
)
class User(
    @Id var id: Long = 0,
    @Column(nullable = false, unique = true) var email: String,
    @Column(nullable = false) var name: String,
    @Column(nullable = false) var locale: String = DEFAULT_LOCALE,
    @Column(nullable = false) var password: String,
    var resetToken: String? = null,
    var resetSentAt: OffsetDateTime? = null,
    var emailVerificationToken: String? = null,
    var emailVerificationSentAt: OffsetDateTime? = null,
    var emailVerifiedAt: OffsetDateTime? = null,
    @Column(nullable = false) var createdAt: OffsetDateTime,
    @Column(nullable = false) var updatedAt: OffsetDateTime,
) {
    fun isEmailVerified(): Boolean = null != emailVerifiedAt

    fun getUserLocale(): Locale = Locale.forLanguageTag(locale)

    fun isEmailVerificationTokenValid(): Boolean =
        emailVerificationToken != null && emailVerificationSentAt != null &&
            emailVerificationSentAt!!.isAfter(
                OffsetDateTime.now().minusMinutes(UNVERIFIED_USER_INTERVAL_MINUTES),
            )

    fun isPasswordResetTokenValid(): Boolean =
        resetToken != null && resetSentAt != null &&
            resetSentAt!!.isAfter(OffsetDateTime.now().minusMinutes(PASSWORD_RESET_TOKEN_INTERVAL_MINUTES))
}
