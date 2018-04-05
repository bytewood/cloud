package bytewood.microservice.spring;

import bytewood.microservice.domain.Model;
import bytewood.microservice.domain.ModelService;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import java.time.ZonedDateTime;
import java.util.UUID;

import static java.lang.System.setProperty;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(SpringRunner.class)
@WebMvcTest(controllers = {ModelController.class})
public class ModelControllerTest implements Json {

    static {
        setProperty("spring.cloud.consul.enabled", "false");
        setProperty("endpoints.enabled", "false");
    }

    @Autowired
    private MockMvc http;

    @MockBean
    private ModelService service;

    @Before
    public void setUp() {
        Mockito.when(service.call(Mockito.any(Long.class))).thenReturn(newModel());
    }

    private Model newModel() {
        return Model.builder()
                .id(10L)
                .identifier(UUID.randomUUID())
                .name("testname")
                .timestamp(ZonedDateTime.now())
                .build()
                ;
    }

    @Test
    public void get() throws Exception {
        http.perform(
                MockMvcRequestBuilders
                        .get("/model/10")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }

    @Test
    public void post() throws Exception {
        http.perform(MockMvcRequestBuilders
                .post("/model")
                .content(json(Model.builder().name("testname").build()))
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }
}
