package app.cliq.backend.api.error.exception

import app.cliq.backend.api.error.ErrorCode
import org.springframework.http.HttpStatus

class ExpiredEmailVerificationTokenException :
    ApiException(HttpStatus.BAD_REQUEST, ErrorCode.EMAIL_VERIFICATION_TOKEN_EXPIRED)
