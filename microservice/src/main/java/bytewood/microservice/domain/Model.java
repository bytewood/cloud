package bytewood.microservice.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.time.ZonedDateTime;
import java.util.UUID;

@Data
@Builder
@AllArgsConstructor
public class Model {
    private Long id;
    private UUID identifier;
    private String name;
    private ZonedDateTime timestamp;
}
