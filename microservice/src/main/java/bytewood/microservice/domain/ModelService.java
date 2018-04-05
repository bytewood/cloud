package bytewood.microservice.domain;

public interface ModelService {
    Model call(Long id);

    Model ret(Model model);
}
