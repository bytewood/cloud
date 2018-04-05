package bytewood.microservice.spring;

import bytewood.microservice.domain.Model;
import bytewood.microservice.domain.ModelService;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.SneakyThrows;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import static java.lang.System.setProperty;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;

@RunWith(SpringRunner.class)
@WebMvcTest({ModelController.class, GlobalExceptionHandler.class})
public class GlobalExceptionHandlerTest implements Json {

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
        when(service.ret(any(Model.class))).thenThrow(new RuntimeException("WTF"));
    }

    @Test
    public void anExceptionIsHandledByTheGlobalExceptionHandler() throws Exception {
        http.perform(post("/model")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonModel()))
                .andExpect(MockMvcResultMatchers.status().isInternalServerError());
    }

    private String jsonModel() {
        return json(Model.builder().name("name").build());
    }

}
