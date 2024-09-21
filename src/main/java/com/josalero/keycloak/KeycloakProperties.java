package com.josalero.keycloak;

import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import java.util.Map;
import java.util.Properties;

@Getter
@Setter
@Configuration
@ConfigurationProperties(prefix = "keycloak")
public class KeycloakProperties {

  public static final String REALM_ID = "id";
  public static final String FRONTEND_URL = "frontend-url";
  private static final String KEYCLOAK_REALM_PREFIX = "keycloak.realm.";
  private static final String KEYCLOAK_CONNECTIONS_JPA_PREFIX = "keycloak.connectionsJpa.";
  public static final String OIDC_CLIENT_ID = "client.oidc.id";
  public static final String OIDC_CLIENT_REDIRECT_URI = OIDC_CLIENT_ID + "redirect-uri";
  public static final String SERVER_CONTEXT_PATH = "context-path";
  public static final String ADMIN_USER_USERNAME = "admin-user.username";
  public static final String ADMIN_USER_PASSWORD = "admin-user.password";
  public static final String ADMIN_USER_EMAIL = "admin-user.email";

  private Map<String, String> server;

  private Map<String, String> realm;

  private Map<String, String> connectionsJpa;

  public Properties getConnectionJpaProperties() {

    final var properties = new Properties(connectionsJpa.size());

    connectionsJpa.forEach(
        (key, value) -> properties.put(KEYCLOAK_CONNECTIONS_JPA_PREFIX + key, value));

    return properties;
  }

  public Properties getRealmProperties() {
    final var properties = new Properties(connectionsJpa.size());

    realm.forEach((key, value) -> properties.put(KEYCLOAK_REALM_PREFIX + key, value));

    return properties;
  }

  /**
   * Returns a single value from the Realm configuration data.
   *
   * @param key the key of the data to return.
   * @return the configuration data for the key.
   */
  public String getRealm(String key) {
    return realm.get(key);
  }

  /**
   * Returns a single value from the server configuration data.
   *
   * @param key the key of the data to return.
   * @return the configuration data for the key.
   */
  public String getServer(String key) {
    return server.get(key);
  }
}
