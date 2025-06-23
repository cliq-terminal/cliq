package app.cliq.backend.config

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.crypto.argon2.Argon2PasswordEncoder
import org.springframework.security.crypto.password.PasswordEncoder

const val SALT_LENGTH = 16
const val HASH_LENGTH = 32
const val PARALLELISM = 4
const val MEMORY = 1 shl 14
const val ITERATIONS = 3

@Configuration
class SecurityConfig {

    @Bean
    fun passwordEncoder(): PasswordEncoder {
        return Argon2PasswordEncoder(SALT_LENGTH, HASH_LENGTH, PARALLELISM, MEMORY, ITERATIONS)
    }
}
