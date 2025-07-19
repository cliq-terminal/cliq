package app.cliq.backend.auth

import app.cliq.backend.api.error.ErrorResponseFactory
import app.cliq.backend.api.error.exception.ApiException
import app.cliq.backend.api.error.exception.InvalidAuthTokenException
import app.cliq.backend.api.session.SessionRepository
import app.cliq.backend.api.session.event.SessionUsedEvent
import com.fasterxml.jackson.databind.ObjectMapper
import jakarta.servlet.FilterChain
import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse
import org.springframework.context.ApplicationEventPublisher
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.stereotype.Component
import org.springframework.web.filter.OncePerRequestFilter

private const val AUTHORIZATION_HEADER = "Authorization"
private const val BEARER_PREFIX = "Bearer "

@Component
class BearerTokenAuthenticationFilter(
    private val sessionRepository: SessionRepository,
    private val eventPublisher: ApplicationEventPublisher,
    private val objectMapper: ObjectMapper,
    private val errorResponseFactory: ErrorResponseFactory
) : OncePerRequestFilter() {

    override fun doFilterInternal(
        request: HttpServletRequest, response: HttpServletResponse, filterChain: FilterChain
    ) {
        val token = extractBearerToken(request)
        if (token == null) {
            filterChain.doFilter(request, response)

            return
        }

        try {
            val session = sessionRepository.findByApiKey(token) ?: throw InvalidAuthTokenException()
            val authentication = BearerTokenAuthentication(session, token, true)
            SecurityContextHolder.getContext().authentication = authentication

            eventPublisher.publishEvent(SessionUsedEvent(session.id))
        } catch (e: ApiException) {
            val errorResponse = errorResponseFactory.handleApiException(e)
            response.writer.write(objectMapper.writeValueAsString(errorResponse))
        } catch (e: Exception) {
            logger.error("Failed to authenticate with Bearer token", e)

            throw e
        }

        filterChain.doFilter(request, response)
    }

    private fun extractBearerToken(request: HttpServletRequest): String? {
        val header = request.getHeader(AUTHORIZATION_HEADER)
        return if (header?.startsWith(BEARER_PREFIX) == true) {
            header.removePrefix(BEARER_PREFIX)
        } else null
    }
}
