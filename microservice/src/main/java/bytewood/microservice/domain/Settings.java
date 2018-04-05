package bytewood.microservice.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Settings {
    private String enviro;
    private String secret;
}
