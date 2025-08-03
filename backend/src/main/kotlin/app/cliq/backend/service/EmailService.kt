package app.cliq.backend.service

import app.cliq.backend.config.EmailProperties
import jakarta.mail.internet.InternetAddress
import org.slf4j.LoggerFactory
import org.springframework.mail.javamail.JavaMailSender
import org.springframework.mail.javamail.MimeMessageHelper
import org.springframework.stereotype.Service
import org.thymeleaf.TemplateEngine
import org.thymeleaf.context.Context
import java.nio.charset.StandardCharsets
import java.util.Locale

@Service
class EmailService(
    private val emailProperties: EmailProperties,
    private val templateEngine: TemplateEngine,
    private val mailSender: JavaMailSender?,
) {
    private val logger = LoggerFactory.getLogger(this::class.java)

    /**
     * Checks if the email service is enabled and properly configured
     * @return true if email service is enabled and configured
     */
    fun isEnabled(): Boolean {
        if (emailProperties.enabled && mailSender == null) {
            logger.warn("Email is enabled but mailSender is null")
        }

        return emailProperties.enabled && mailSender != null
    }

    /**
     * Sends an email using a Pebble template with both HTML and plain text versions
     * @param to Recipient email address
     * @param subject Email subject
     * @param context Map of variables to be passed to the template
     * @param templateName Name of the Template (without extension/without .html or .txt)
     */
    fun sendEmail(
        to: String,
        subject: String,
        context: Map<String, Any>,
        locale: Locale,
        templateName: String,
    ) {
        if (!isEnabled()) {
            logger.warn("Email service is disabled. Not sending email to $to with subject '$subject'.")
            return
        }

        try {
            val fromAddress =
                emailProperties.fromAddress
                    ?: throw IllegalStateException("From address is not configured")
            val fromName = emailProperties.fromName

            val htmlContent = renderTemplate("emails/$templateName.html", context, locale)
            val textContent = renderTemplate("emails/$templateName.txt", context, locale)

            if (htmlContent.isBlank() && textContent.isBlank()) {
                logger.error(
                    "Both HTML and text content are empty for email to $to with subject '$subject'. Not sending email.",
                )
                return
            }

            val message = mailSender!!.createMimeMessage()
            val helper = MimeMessageHelper(message, true, StandardCharsets.UTF_8.name())

            helper.setTo(to)
            helper.setSubject(subject)
            helper.setFrom(InternetAddress(fromAddress, fromName))

            helper.setText(textContent, htmlContent)

            mailSender.send(message)

            logger.info("Email sent to $to with subject '$subject'")
        } catch (e: Exception) {
            logger.error("Failed to send email to $to with subject '$subject'", e)

            throw e
        }
    }

    /**
     * Renders a Pebble template with the given context
     * @param templatePath Path to the template file
     * @param context Variables to be passed to the template
     * @return The rendered template as a string
     */
    private fun renderTemplate(
        templatePath: String,
        context: Map<String, Any>,
        locale: Locale,
    ): String = templateEngine.process(templatePath, Context(locale, context))
}
