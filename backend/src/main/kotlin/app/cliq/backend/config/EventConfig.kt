package app.cliq.backend.config

import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.context.event.ApplicationEventMulticaster
import org.springframework.context.event.SimpleApplicationEventMulticaster
import org.springframework.core.task.SimpleAsyncTaskExecutor

@Configuration
class EventConfig(
    @Qualifier("applicationTaskExecutor") private val simpleAsyncTaskExecutor: SimpleAsyncTaskExecutor,
) {
    /**
     * This bean is used to handle application events asynchronously.
     * It uses a SimpleAsyncTaskExecutor to execute the events in a separate thread.
     *
     * Uses virtual threads if spring.threads.virtual.enabled is set to true.
     */
    @Bean(name = ["applicationEventMulticaster"])
    fun simpleApplicationEventMulticaster(): ApplicationEventMulticaster {
        val eventMulticaster = SimpleApplicationEventMulticaster()

        eventMulticaster.setTaskExecutor(this.simpleAsyncTaskExecutor)

        return eventMulticaster
    }
}
