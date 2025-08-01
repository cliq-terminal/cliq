package app.cliq.backend.config

import io.swagger.v3.oas.annotations.enums.SecuritySchemeIn
import io.swagger.v3.oas.annotations.enums.SecuritySchemeType
import io.swagger.v3.oas.annotations.security.SecurityScheme
import io.swagger.v3.oas.models.OpenAPI
import io.swagger.v3.oas.models.info.Info
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

const val API_TOKEN_SECURITY_SCHEME_NAME = "API Token"

@Configuration
@SecurityScheme(
    name = API_TOKEN_SECURITY_SCHEME_NAME,
    type = SecuritySchemeType.HTTP,
    bearerFormat = "API_KEY",
    scheme = "bearer",
    `in` = SecuritySchemeIn.HEADER
)
class OpenApiConfig(
    @Value($$"${app.info.name}") private val name: String,
    @Value($$"${app.info.version}") private val version: String,
    @Value($$"${app.info.description}") private val description: String,
) {

    @Bean
    fun apiDocConfig(): OpenAPI {
        return OpenAPI()
            .info(
                Info()
                    .title(name)
                    .version(version)
                    .description(description)
            )
    }
}
