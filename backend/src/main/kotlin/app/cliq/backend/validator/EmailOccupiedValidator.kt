package app.cliq.backend.validator

import EmailOccupiedConstraint
import app.cliq.backend.api.user.UserRepository
import jakarta.validation.ConstraintValidator
import jakarta.validation.ConstraintValidatorContext

class EmailOccupiedValidator(
    private val userRepository: UserRepository,
) : ConstraintValidator<EmailOccupiedConstraint, String> {
    override fun isValid(
        value: String?,
        context: ConstraintValidatorContext?,
    ): Boolean {
        if (value.isNullOrEmpty()) {
            return true
        }

        return !userRepository.existsUserByEmail(value)
    }
}
