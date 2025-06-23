package app.cliq.backend.api.user.listener

import app.cliq.backend.api.user.UserRepository
import app.cliq.backend.api.user.UserService
import app.cliq.backend.api.user.event.UserCreatedEvent
import app.cliq.backend.service.EmailService
import org.slf4j.LoggerFactory
import org.springframework.context.event.EventListener
import org.springframework.stereotype.Component

@Component
class UserCreatedEventListener(
    private val userRepository: UserRepository,
    private val emailService: EmailService,
    private val userService: UserService,
) {
    private val logger = LoggerFactory.getLogger(UserCreatedEventListener::class.java)

    @EventListener(UserCreatedEvent::class)
    fun sendVerificationEmail(event: UserCreatedEvent) {
        val user = userRepository.findById(event.userId).orElseThrow {
            logger.error("User with ID ${event.userId} not found")
            IllegalArgumentException("User not found")
        }

        if (!emailService.isEnabled()) {
            userService.verifyUserEmail(user)
        } else {
            userService.sendVerificationEmail(user)
        }
    }
}
