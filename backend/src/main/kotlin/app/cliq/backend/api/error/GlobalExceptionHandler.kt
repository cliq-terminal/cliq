package app.cliq.backend.api.error

import app.cliq.backend.api.error.exception.ApiException
import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.MethodArgumentNotValidException
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.RestControllerAdvice

@RestControllerAdvice
class GlobalExceptionHandler {

    private val logger = LoggerFactory.getLogger(this::class.java)

    @ExceptionHandler(ApiException::class)
    fun handleApiException(apiException: ApiException): ResponseEntity<ErrorResponse> {
        val errorResponse = ErrorResponse.fromApiException(apiException)

        return ResponseEntity(errorResponse, apiException.statusCode)
    }

    @ExceptionHandler(MethodArgumentNotValidException::class)
    fun handleValidationException(exception: MethodArgumentNotValidException): ResponseEntity<ErrorResponse> {
        val fieldErrors = exception.bindingResult.fieldErrors.map { error ->
            mapOf(
                "field" to error.field,
                "message" to (error.defaultMessage),
                "rejectedValue" to error.rejectedValue
            )
        }

        val errorResponse = ErrorResponse(
            statusCode = HttpStatus.BAD_REQUEST,
            errorCode = ErrorCode.VALIDATION_ERROR,
            details = mapOf(
                "validationErrors" to fieldErrors,
                "totalErrors" to exception.bindingResult.errorCount
            )
        )

        return mapErrorResponseToResponseEntity(errorResponse)
    }

    private fun mapErrorResponseToResponseEntity(
        errorResponse: ErrorResponse
    ): ResponseEntity<ErrorResponse> {
        if (errorResponse.statusCode.is2xxSuccessful) {
            logger.warn("Returning error with a successful status code. {}", errorResponse)
        }
        if (errorResponse.statusCode.is5xxServerError) {
            logger.warn("Returning 5xx server error code. {}", errorResponse)
        }

        return ResponseEntity.status(errorResponse.statusCode).body(errorResponse)
    }
}
