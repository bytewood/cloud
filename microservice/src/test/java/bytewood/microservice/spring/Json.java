package bytewood.microservice.spring;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.SneakyThrows;

public interface Json {
    ObjectMapper om = new ObjectMapper().findAndRegisterModules();

    @SneakyThrows
    default <T> String json(T object) {
        return om.writeValueAsString(object);
    }
}
