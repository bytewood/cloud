package bytewood.microservice.domain;

import java.time.ZonedDateTime;
import java.util.Random;
import java.util.UUID;

public class DefaultModelService implements ModelService {

    private Random random = new Random();

    @Override
    public Model call(final Long id) {
        return Model.builder()
                .id(id)
                .identifier(UUID.randomUUID())
                .name("name")
                .timestamp(ZonedDateTime.now())
                .build()
                ;
    }

    @Override
    public Model ret(final Model model) {
        model.setId(random.nextLong());
        model.setIdentifier(UUID.randomUUID());
        model.setTimestamp(ZonedDateTime.now());
        return model;
    }
}
