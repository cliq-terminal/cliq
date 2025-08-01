package app.cliq.backend.api.error.exception

import app.cliq.backend.api.error.ErrorCode
import org.springframework.http.HttpStatus

class InvalidAuthTokenException : ApiException(HttpStatus.UNAUTHORIZED, ErrorCode.INVALID_AUTH_TOKEN)
