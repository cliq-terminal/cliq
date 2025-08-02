package app.cliq.backend.api.userconfig.view

import io.swagger.v3.oas.annotations.media.Schema
import java.time.OffsetDateTime

@Schema
data class ConfigurationView(
    val configuration: String,
    val updatedAt: OffsetDateTime,
    val createdAt: OffsetDateTime,
)
