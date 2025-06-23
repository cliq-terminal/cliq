package app.cliq.backend.acceptance.user

import app.cliq.backend.api.user.UserRepository
import com.fasterxml.jackson.databind.ObjectMapper
import com.icegreen.greenmail.configuration.GreenMailConfiguration
import com.icegreen.greenmail.junit5.GreenMailExtension
import com.icegreen.greenmail.util.ServerSetupTest
import org.apache.commons.mail2.jakarta.util.MimeMessageParser
import org.flywaydb.core.Flyway
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.RegisterExtension
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.http.MediaType
import org.springframework.test.annotation.DirtiesContext
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.status
import kotlin.test.assertContains
import kotlin.test.assertTrue


const val EMAIL = "cliq@localhost"
const val EMAIL_PWD = "cliq"
const val SMTP_HOST = "127.0.0.1"
const val SMTP_PORT = 3025

@SpringBootTest(
    properties = [
        "spring.flyway.clean-disabled=false",
        "spring.mail.host=${SMTP_HOST}",
        "spring.mail.port=${SMTP_PORT}",
        "spring.mail.username=${EMAIL}",
        "spring.mail.password=${EMAIL_PWD}",
        "spring.mail.protocol=smtp",
        "spring.mail.properties.mail.smtp.auth=true",
        "spring.mail.properties.mail.smtp.starttls.enable=false",
        "app.email.enabled=true",
        "app.email.from-address=${EMAIL}"
    ]
)
@AutoConfigureMockMvc
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
class UserRegistrationTests(
    @Autowired
    private val mockMvc: MockMvc,
    @Autowired
    private val userRepository: UserRepository,
) {
    companion object {
        @JvmField
        @RegisterExtension
        val greenMail: GreenMailExtension = GreenMailExtension(ServerSetupTest.SMTP_IMAP)
            .withConfiguration(
                GreenMailConfiguration
                    .aConfig()
                    .withUser(EMAIL, EMAIL_PWD)
            )
    }

    private val objectMapper = ObjectMapper()

    @BeforeEach
    fun clearDatabase(@Autowired flyway: Flyway) {
        flyway.clean()
        flyway.migrate()
    }

    @Test
    fun `user can register`() {
        val email = "test@example.lan"

        val userDetails = mapOf(
            "email" to email,
            "password" to "SecurePassword123",
            "username" to "testuser",
        )

        mockMvc.perform(
            MockMvcRequestBuilders.post("/api/v1/user/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(userDetails))
        ).andExpect(status().isCreated)

        assertTrue(greenMail.waitForIncomingEmail(1))

        val emailMessages = greenMail.receivedMessages[0]
        val parser = MimeMessageParser(emailMessages).parse()

        assertTrue(parser.hasHtmlContent())
        assertTrue(parser.hasPlainContent())

        var user = userRepository.findUserByEmail(email)
        assertTrue(user != null)

        assertTrue(user.emailVerificationToken != null)
        assertTrue(user.emailVerifiedAt == null)
        assertTrue(user.emailVerificationSentAt != null)

        assertContains(parser.htmlContent, user.emailVerificationToken!!)
        assertContains(parser.plainContent, user.emailVerificationToken!!)

        mockMvc.perform(
            MockMvcRequestBuilders.get("/api/v1/user/verify/{token}", user.emailVerificationToken!!)
        ).andExpect(status().isOk)

        user = userRepository.findUserByEmail(email)
        assertTrue(user != null)

        assertTrue(user.isEmailVerified())
        assertTrue(user.emailVerifiedAt != null)
        assertTrue(user.emailVerificationToken == null)
    }

    @Test
    fun `cannot register twice with the same email`() {
        val email = "test@example.lan"

        val userDetails = mapOf(
            "email" to email,
            "password" to "SecurePassword123",
            "username" to "testuser",
        )

        mockMvc.perform(
            MockMvcRequestBuilders.post("/api/v1/user/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(userDetails))
        ).andExpect(status().isCreated)

        mockMvc.perform(
            MockMvcRequestBuilders.post("/api/v1/user/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(userDetails))
        ).andExpect(status().isBadRequest)

        assertTrue(greenMail.waitForIncomingEmail(1))
    }

    @Test
    fun `cannot verify with an invalid token`() {
        val email = "test@example.lan"
        val userDetails = mapOf(
            "email" to email,
            "password" to "SecurePassword123",
            "username" to "testuser",
        )

        mockMvc.perform(
            MockMvcRequestBuilders.post("/api/v1/user/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(userDetails))
        ).andExpect(status().isCreated)

        mockMvc.perform(
            MockMvcRequestBuilders.get("/api/v1/user/verify/{token}", "invalid-token")
        ).andExpect(status().isNotFound)

        assertTrue(greenMail.waitForIncomingEmail(10_000, 1))

        val user = userRepository.findUserByEmail(email)
        assertTrue(user != null)

        assertTrue(user.isEmailVerified().not())
    }

    @Test
    fun `cannot verify twice`() {
        val email = "test@example.lan"
        val userDetails = mapOf(
            "email" to email,
            "password" to "SecurePassword123",
            "username" to "testuser",
        )

        mockMvc.perform(
            MockMvcRequestBuilders.post("/api/v1/user/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(userDetails))
        ).andExpect(status().isCreated)

        assertTrue(greenMail.waitForIncomingEmail(1))

        var user = userRepository.findUserByEmail(email)
        assertTrue(user != null)

        mockMvc.perform(
            MockMvcRequestBuilders.get(
                "/api/v1/user/verify/{token}",
                user.emailVerificationToken!!
            )
        ).andExpect(status().isOk)

        mockMvc.perform(
            MockMvcRequestBuilders.get(
                "/api/v1/user/verify/{token}",
                user.emailVerificationToken!!
            )
        ).andExpect(status().isNotFound)

        user = userRepository.findUserByEmail(email)
        assertTrue(user != null)

        assertTrue(user.isEmailVerified())
        assertTrue(user.emailVerifiedAt != null)
        assertTrue(user.emailVerificationToken == null)
        assertTrue(user.emailVerificationSentAt != null)
    }

    @Test
    fun `cannot verify with an expired token`() {
        // TODO!
    }
}
