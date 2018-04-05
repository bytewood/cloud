package bytewood.microservice.spring;

import org.apache.catalina.connector.Connector;
import org.apache.coyote.http11.Http11NioProtocol;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.embedded.EmbeddedServletContainerFactory;
import org.springframework.boot.context.embedded.tomcat.TomcatEmbeddedServletContainerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;

import java.io.File;
import java.io.IOException;

//@Configuration
public class TlsConfiguration {

    private String keystoreFile = "bytewood-microservice.p12";
    private String keystorePass = "My0wn5peci@lSecret#";
    private String keyAlias = "bytewood-microservice";
    private String keyPass = keystorePass;
    private String keystoreType = "PKCS12";
    private String truststorePass = keystorePass;
    private String truststoreType = keystoreType;

    @Autowired
    ResourceLoader resourceLoader;

    @Bean
    public EmbeddedServletContainerFactory servletContainer() {
        TomcatEmbeddedServletContainerFactory tomcat = new TomcatEmbeddedServletContainerFactory();
        tomcat.addAdditionalTomcatConnectors(createSslConnector());
        return tomcat;
    }

    private Connector createSslConnector() {
        Connector connector = new Connector("org.apache.coyote.http11.Http11NioProtocol");
        Http11NioProtocol protocol = (Http11NioProtocol) connector.getProtocolHandler();
        try {
            Resource store = resourceLoader.getResource(keystoreFile);
            File keystore = store.getFile();
            File truststore = store.getFile();

            connector.setScheme("https");
            connector.setSecure(true);
            connector.setPort(8443);

            protocol.setSSLEnabled(true);
            protocol.setKeystoreType(keystoreType);
            protocol.setKeystoreFile(keystore.getAbsolutePath());
            protocol.setKeyAlias(keyAlias);
            protocol.setKeyPass(keyPass);
            protocol.setKeystorePass(keystorePass);

            return connector;
        } catch (IOException ex) {
            throw new IllegalStateException("can't access keystore: "
                    + "[" + "keystore" + "]"
                    + " or truststore: [" + "keystore" + "]", ex);
        }
    }
}
