package app.cliq.backend.service

import app.cliq.backend.api.instance.InstanceHandler
import org.springframework.stereotype.Service
import java.security.SecureRandom
import java.util.*

const val RANDOM_BYTES_LENGTH = 32
const val EMAIL_VERIFICATION_TOKEN_LENGTH: UShort = 32U
const val RESET_PASSWORD_TOKEN_LENGTH: UShort = 16U
const val AUTH_VERIFICATION_TOKEN_LENGTH: UShort = 64U

@Service
class TokenGenerator(
    private val instanceHandler: InstanceHandler,
) {
    private val secureRandom = SecureRandom()
    private val base64Encoder = Base64.getUrlEncoder().withoutPadding()

    fun generateToken(length: UShort = 64U): String {
        require(length > 16U) { "Token length must be at least 16 characters" }

        val randomBytes = ByteArray(RANDOM_BYTES_LENGTH)
        secureRandom.nextBytes(randomBytes)

        val uuid = UUID.randomUUID()
        val instanceId = instanceHandler.getCurrentNodeId().toString()

        val combined =
            instanceId.toByteArray() +
                uuid.toString().toByteArray() +
                randomBytes

        val fullToken = base64Encoder.encodeToString(combined)
        return fullToken.take(length.toInt())
    }

    fun generateEmailVerificationToken(): String = generateToken(EMAIL_VERIFICATION_TOKEN_LENGTH)

    fun generatePasswordResetToken(): String = generateToken(RESET_PASSWORD_TOKEN_LENGTH)

    fun generateAuthVerificationToken(): String = generateToken(AUTH_VERIFICATION_TOKEN_LENGTH)
}
