package com.josalero;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import org.junit.jupiter.api.Test;

class ManagementYamlProbeSettingsTest {

  @Test
  void applicationYamlEnablesActuatorHealthProbes() throws Exception {
    try (InputStream in =
        Thread.currentThread().getContextClassLoader().getResourceAsStream("application.yml")) {
      assertThat(in).as("classpath application.yml").isNotNull();
      String yaml = new String(in.readAllBytes(), StandardCharsets.UTF_8);
      assertThat(yaml).contains("management:");
      assertThat(yaml).contains("probes:");
      assertThat(yaml).contains("livenessstate:");
      assertThat(yaml).contains("readinessstate:");
    }
  }
}
