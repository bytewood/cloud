package bytewood.microservice.spring;

import bytewood.microservice.domain.DefaultModelService;
import bytewood.microservice.domain.ModelService;
import bytewood.microservice.domain.Settings;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class MicroserviceApplication {

    public static void main(String[] args) {
        SpringApplication.run(MicroserviceApplication.class, args);
    }

    @Bean
    public ModelService modelService() {
        return new DefaultModelService();
    }

    @Bean
    @ConfigurationProperties(prefix = "bytewood")
    public Settings settings() {
        return new Settings();
    }
}
