package bytewood.microservice.spring;

import bytewood.microservice.domain.Settings;
import bytewood.microservice.domain.Model;
import bytewood.microservice.domain.ModelService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
public class ModelController {

    private final ModelService service;
    private final Settings settings;

    @GetMapping("/model/{id}")
    public Model get(@PathVariable("id") final Long id) {
        log(String.valueOf(id));
        return service.call(id);
    }

    @PostMapping("/model")
    public Model post(@RequestBody final Model model) {
        log(model.toString());
        return service.ret(model);
    }

    @GetMapping("/settings")
    public Settings settings() {
        log(settings.toString());
        return settings;
    }

    private void log(final String message) {
        final String hostname = System.getenv("HOSTNAME");
        log.debug(hostname + " " + message);
    }
}
