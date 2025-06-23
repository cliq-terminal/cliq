package app.cliq.backend.acceptance.instance

import app.cliq.backend.api.instance.Instance
import app.cliq.backend.api.instance.InstanceHandler
import app.cliq.backend.api.instance.InstanceRepository
import jakarta.persistence.EntityManager
import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.beans.factory.getBean
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.context.ApplicationContext
import org.springframework.test.annotation.DirtiesContext
import org.springframework.transaction.PlatformTransactionManager
import java.time.Clock
import java.time.OffsetDateTime
import kotlin.test.assertEquals
import kotlin.test.assertTrue

@SpringBootTest
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
class InstanceHandlerTests {

    @Autowired
    private lateinit var instanceRepository: InstanceRepository

    @Autowired
    private lateinit var applicationContext: ApplicationContext

    @AfterEach
    fun cleanup() {
        instanceRepository.deleteAll()
    }

    @Test
    fun `initialize should register with smallest available ID when no instances exist`(@Autowired instanceHandler: InstanceHandler) {
        val nodeId = instanceHandler.getCurrentNodeId()

        assertEquals(1U, nodeId)

        val instances = instanceRepository.findAll()
        assertEquals(2, instances.size)
        assertEquals(0U, instances[0].nodeId)
    }

    @Test
    fun `should use next available ID when some IDs are occupied`() {
        // Keep in mind that an instance with id 0 will be autowired
        val now = OffsetDateTime.now()
        instanceRepository.save(Instance(nodeId = 1U, createdAt = now, updatedAt = now))
        instanceRepository.save(Instance(nodeId = 2U, createdAt = now, updatedAt = now))

        val newHandler = createNewInstanceHandler()
        newHandler.initialize()

        assertEquals(3U, newHandler.getCurrentNodeId())

        val instances = instanceRepository.findAll()
        assertEquals(4, instances.size)
        assertTrue(instances.any { it.nodeId.toUInt() == 3U })
    }

    @Test
    fun `initialize should reuse existing inactive instance`() {
        val now = OffsetDateTime.now()
        val oldInstance = Instance(
            nodeId = 1U,
            createdAt = now.minusDays(1),
            updatedAt = now.minusDays(1)
        )
        instanceRepository.save(oldInstance)

        val newHandler = createNewInstanceHandler()
        newHandler.initialize()

        val instances = instanceRepository.findAll()
        assertEquals(2, instances.size)
        assertEquals(0U, instances[0].nodeId)
        assertEquals(1U, instances[1].nodeId)
    }

    private fun createNewInstanceHandler(): InstanceHandler {
        return InstanceHandler(
            instanceRepository,
            Clock.systemDefaultZone(),
            applicationContext.getBean<PlatformTransactionManager>(),
            applicationContext.getBean<EntityManager>()
        )
    }
}
