package app.cliq.backend.auth

import app.cliq.backend.api.session.SessionRepository
import jakarta.servlet.FilterChain
import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.stereotype.Component
import org.springframework.web.filter.OncePerRequestFilter

private const val AUTHORIZATION_HEADER = "Authorization"
private const val BEARER_PREFIX = "Bearer "

@Component
class BearerTokenAuthenticationFilter(
    private val sessionRepository: SessionRepository
) : OncePerRequestFilter() {

    override fun doFilterInternal(
        request: HttpServletRequest, response: HttpServletResponse, filterChain: FilterChain
    ) {
        // TODO:
        //  - better handling with better error codes
        //  - add cache
        val token = extractBearerToken(request)

        if (token != null) {
            try {
                val session = sessionRepository.findByApiKey(token)
                if (session != null) {
                    val authentication = BearerTokenAuthentication(session, token, true)
                    SecurityContextHolder.getContext().authentication = authentication
                }
            } catch (e: Exception) {
                logger.error("Failed to authenticate with Bearer token", e)

                throw e
            }
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
