package app.cliq.backend.acceptance.user

import app.cliq.backend.acceptance.AcceptanceTest
import app.cliq.backend.acceptance.AcceptanceTester
import app.cliq.backend.api.user.UserRepository
import com.fasterxml.jackson.databind.ObjectMapper
import org.apache.commons.mail2.jakarta.util.MimeMessageParser
import org.junit.jupiter.api.Disabled
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.assertNotNull
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.MediaType
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.status
import kotlin.test.assertContains
import kotlin.test.assertEquals
import kotlin.test.assertTrue

@AcceptanceTest
class UserRegistrationTests(
    @Autowired
    private val mockMvc: MockMvc,
    @Autowired
    private val userRepository: UserRepository,
    @Autowired
    private val objectMapper: ObjectMapper,
) : AcceptanceTester() {
    @Test
    fun `user can register`() {
        val email = "test@example.lan"

        val userDetails =
            mapOf(
                "email" to email,
                "password" to "SecurePassword123",
                "username" to "testuser",
            )

        mockMvc
            .perform(
                MockMvcRequestBuilders
                    .post("/api/v1/user/register")
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(objectMapper.writeValueAsString(userDetails)),
            ).andExpect(status().isCreated)

        assertTrue(greenMail.waitForIncomingEmail(1))

        val emailMessages = greenMail.receivedMessages[0]
        val parser = MimeMessageParser(emailMessages).parse()

        assertTrue(parser.hasHtmlContent())
        assertTrue(parser.hasPlainContent())

        var user = userRepository.findUserByEmail(email)
        assertTrue(user != null)

        assertTrue(user.emailVerificationToken != null)
        assertEquals(user.emailVerifiedAt, null)
        assertTrue(user.emailVerificationSentAt != null)

        assertContains(parser.htmlContent, user.emailVerificationToken!!)
        assertContains(parser.plainContent, user.emailVerificationToken!!)

        mockMvc
            .perform(
                MockMvcRequestBuilders.get("/api/v1/user/verify/{token}", user.emailVerificationToken!!),
            ).andExpect(status().isOk)

        user = userRepository.findUserByEmail(email)
        assertTrue(user != null)

        assertTrue(user.isEmailVerified())
        assertTrue(user.emailVerifiedAt != null)
        assertEquals(user.emailVerificationToken, null)
    }

    @Test
    fun `cannot register twice with the same email`() {
        val email = "test@example.lan"

        val userDetails =
            mapOf(
                "email" to email,
                "password" to "SecurePassword123",
                "username" to "testuser",
            )

        mockMvc
            .perform(
                MockMvcRequestBuilders
                    .post("/api/v1/user/register")
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(objectMapper.writeValueAsString(userDetails)),
            ).andExpect(status().isCreated)

        mockMvc
            .perform(
                MockMvcRequestBuilders
                    .post("/api/v1/user/register")
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(objectMapper.writeValueAsString(userDetails)),
            ).andExpect(status().isBadRequest)

        assertTrue(greenMail.waitForIncomingEmail(1))
    }

    @Test
    fun `cannot verify with an invalid token`() {
        val email = "test@example.lan"
        val userDetails =
            mapOf(
                "email" to email,
                "password" to "SecurePassword123",
                "username" to "testuser",
            )

        mockMvc
            .perform(
                MockMvcRequestBuilders
                    .post("/api/v1/user/register")
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(objectMapper.writeValueAsString(userDetails)),
            ).andExpect(status().isCreated)

        mockMvc
            .perform(
                MockMvcRequestBuilders.get("/api/v1/user/verify/{token}", "invalid-token"),
            ).andExpect(status().isNotFound)

        assertTrue(greenMail.waitForIncomingEmail(10_000, 1))

        val user = userRepository.findUserByEmail(email)
        assertTrue(user != null)

        assertTrue(user.isEmailVerified().not())
    }

    @Test
    fun `cannot verify twice`() {
        val email = "test@example.lan"
        val userDetails =
            mapOf(
                "email" to email,
                "password" to "SecurePassword123",
                "username" to "testuser",
            )

        mockMvc
            .perform(
                MockMvcRequestBuilders
                    .post("/api/v1/user/register")
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(objectMapper.writeValueAsString(userDetails)),
            ).andExpect(status().isCreated)

        assertTrue(greenMail.waitForIncomingEmail(1))

        var user = userRepository.findUserByEmail(email)
        assertTrue(user != null)

        mockMvc
            .perform(
                MockMvcRequestBuilders.get(
                    "/api/v1/user/verify/{token}",
                    user.emailVerificationToken!!,
                ),
            ).andExpect(status().isOk)

        mockMvc
            .perform(
                MockMvcRequestBuilders.get(
                    "/api/v1/user/verify/{token}",
                    user.emailVerificationToken!!,
                ),
            ).andExpect(status().isNotFound)

        user = userRepository.findUserByEmail(email)
        assertTrue(user != null)

        assertTrue(user.isEmailVerified())
        assertTrue(user.emailVerifiedAt != null)
        assertEquals(user.emailVerificationToken, null)
        assertTrue(user.emailVerificationSentAt != null)
    }

    @Test
    fun `cannot verify with an expired token`() {
        // Create User
        val email = "test@example.lan"

        val userDetails =
            mapOf(
                "email" to email,
                "password" to "SecurePassword123",
                "username" to "testuser",
            )

        mockMvc
            .perform(
                MockMvcRequestBuilders
                    .post("/api/v1/user/register")
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(objectMapper.writeValueAsString(userDetails)),
            ).andExpect(status().isCreated)

        assertTrue(greenMail.waitForIncomingEmail(1))
        val user = userRepository.findUserByEmail(email)
        assertNotNull(user)

        // Change the verification token to an expired one
        user.emailVerificationSentAt = user.emailVerificationSentAt!!.minusSeconds(60 * 60 * 24) // Set to 24 hours ago
        userRepository.save(user)

        // Try to verify with the expired token
        mockMvc
            .perform(
                MockMvcRequestBuilders.get("/api/v1/user/verify/{token}", user.emailVerificationToken!!),
            ).andExpect(status().isForbidden)
    }

    @Test
    fun `test resend verification email`() {
        // Create User
        val email = "test@example.lan"

        val userDetails =
            mapOf(
                "email" to email,
                "password" to "SecurePassword123",
                "username" to "testuser",
            )

        mockMvc
            .perform(
                MockMvcRequestBuilders
                    .post("/api/v1/user/register")
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(objectMapper.writeValueAsString(userDetails)),
            ).andExpect(status().isCreated)

        assertTrue(greenMail.waitForIncomingEmail(1))

        // Resend verification email
        mockMvc
            .perform(
                MockMvcRequestBuilders
                    .post("/api/v1/user/resend-verification-email")
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(objectMapper.writeValueAsString(mapOf("email" to email))),
            ).andExpect(status().isNoContent)
        assertTrue(greenMail.waitForIncomingEmail(1))

        val emailMessages = greenMail.receivedMessages[1]
        val parser = MimeMessageParser(emailMessages).parse()
        assertTrue(parser.hasHtmlContent())
        assertTrue(parser.hasPlainContent())
    }

    @Test
    @Disabled
    fun `test resend verfication email directly after it's expired`() {
        TODO()
    }

    // TODO: password reset tests
}
