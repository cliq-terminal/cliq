package app.cliq.backend.api

import io.swagger.v3.oas.annotations.Hidden
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.core.io.ResourceLoader
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.servlet.view.RedirectView

const val SCALAR_RESOURCE_PATH = "classpath:static/scalar.html"

@RestController
@RequestMapping("/api")
class OpenApiController(
    @Autowired
    private val resourceLoader: ResourceLoader,
) {
    private var content: String? = null

    @GetMapping("/scalar")
    @Hidden
    fun scalarUi(): ResponseEntity<String> {
        return ResponseEntity.ok(getScalarUiContent())
    }

    @GetMapping
    @Hidden
    fun apiRedirect(): RedirectView {
        return RedirectView("/api/scalar")
    }

    private fun getScalarUiContent(): String {
        if (null !== content) return content!!

        content = resourceLoader.getResource(SCALAR_RESOURCE_PATH).inputStream.bufferedReader()
            .use { it.readText() }

        return content!!
    }
}
