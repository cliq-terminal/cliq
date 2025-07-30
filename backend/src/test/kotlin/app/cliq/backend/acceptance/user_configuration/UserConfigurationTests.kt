package app.cliq.backend.acceptance.user_configuration

import app.cliq.backend.acceptance.helper.UserHelper
import app.cliq.backend.acceptance.user.EMAIL
import app.cliq.backend.acceptance.user.EMAIL_PWD
import app.cliq.backend.acceptance.user.SMTP_HOST
import app.cliq.backend.acceptance.user.SMTP_PORT
import com.icegreen.greenmail.configuration.GreenMailConfiguration
import com.icegreen.greenmail.junit5.GreenMailExtension
import com.icegreen.greenmail.util.ServerSetupTest
import org.flywaydb.core.Flyway
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.RegisterExtension
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.context.annotation.ComponentScan
import org.springframework.test.annotation.DirtiesContext
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.status

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
@ComponentScan(basePackages = ["app.cliq.backend.acceptance.helper"])
class UserConfigurationTests(
    @Autowired
    private val mockMvc: MockMvc,
    @Autowired
    private val userHelper: UserHelper
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

    @BeforeEach
    fun clearDatabase(@Autowired flyway: Flyway) {
        flyway.clean()
        flyway.migrate()
    }

    @Test
    fun `test endpoints cannot be accessed without authentication`() {
        mockMvc.perform(
            MockMvcRequestBuilders.put("/api/v1/user/configuration")
        ).andExpect(status().isUnauthorized)

        mockMvc.perform(
            MockMvcRequestBuilders.get("/api/v1/user/configuration")
        ).andExpect(status().isUnauthorized)

        mockMvc.perform(
            MockMvcRequestBuilders.get("/api/v1/user/configuration/last-updated")
        ).andExpect(status().isUnauthorized)
    }

    @Test
    fun `test endpoints can be accessed wit authentication`() {
        val sessions = userHelper.createRandomAuthenticatedUser()

        mockMvc.perform(
            MockMvcRequestBuilders.put("/api/v1/user/configuration")
                .header("Authorization", "Bearer ${sessions.apiKey}")
        ).andExpect(status().isBadRequest)

        mockMvc.perform(
            MockMvcRequestBuilders.get("/api/v1/user/configuration")
                .header("Authorization", "Bearer ${sessions.apiKey}")
        ).andExpect(status().isNotFound)

        mockMvc.perform(
            MockMvcRequestBuilders.get("/api/v1/user/configuration/last-updated")
                .header("Authorization", "Bearer ${sessions.apiKey}")
        ).andExpect(status().isOk)
    }
}
