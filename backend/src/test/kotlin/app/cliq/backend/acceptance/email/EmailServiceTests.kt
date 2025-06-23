package app.cliq.backend.acceptance.email

import app.cliq.backend.service.EmailService
import com.icegreen.greenmail.configuration.GreenMailConfiguration
import com.icegreen.greenmail.junit5.GreenMailExtension
import com.icegreen.greenmail.util.ServerSetupTest
import jakarta.mail.internet.MimeMessage
import org.apache.commons.mail2.jakarta.util.MimeMessageParser
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.RegisterExtension
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.annotation.DirtiesContext
import java.util.*
import kotlin.test.assertTrue

const val EMAIL = "cliq@localhost"
const val EMAIL_PWD = "cliq"
const val SMTP_HOST = "127.0.0.1"
const val SMTP_PORT = 3025

@SpringBootTest(
    properties = [
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
@DirtiesContext
class EmailServiceTests(
    @Autowired
    private val emailService: EmailService
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

    @Test
    fun `isEnabled should return true`() {
        assertTrue(emailService.isEnabled())
    }

    @Test
    fun `sendEmail should render templates and send email with proper content`() {
        // Verify email service is enabled
        assertTrue(emailService.isEnabled())

        // Test data
        val toEmail = "test@example.com"
        val subject = "Test Email"
        val templateName = "test-email"
        val context = mapOf(
            "subject" to subject,
            "userName" to "John Doe",
            "message" to "Hello World"
        )
        val locale = Locale.ENGLISH

        // Send email
        emailService.sendEmail(
            to = toEmail,
            subject = subject,
            context = context,
            locale = locale,
            templateName = templateName
        )

        assertTrue(greenMail.waitForIncomingEmail(1))

        val receivedMessages = greenMail.receivedMessages

        val message = receivedMessages[0]
        assertEquals(subject, message.subject)
        assertEquals(message.allRecipients.size, 1)
        assertEquals(toEmail, message.allRecipients[0].toString())

        // Verify content types exist (both HTML and text)
        assertTrue(message.contentType.contains("multipart/mixed"))

        val parser = MimeMessageParser(message as MimeMessage)
            .parse()

        assertTrue(parser.hasHtmlContent())
        assertTrue(parser.hasPlainContent())

        val textContent = parser.plainContent
        val htmlContent = parser.htmlContent

        // Verify Text content
        assertTrue(textContent.contains("John Doe"))
        assertTrue(textContent.contains("Hello World"))

        // Verify HTML content
        assertTrue(htmlContent.contains("<html lang=\"en\">"))
        assertTrue(htmlContent.contains("John Doe"))
        assertTrue(htmlContent.contains("Hello World"))

        // Verify that HTML and text content are different
        assertTrue(textContent != htmlContent, "Text and HTML content should not be the same")
    }
}
