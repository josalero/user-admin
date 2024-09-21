package com.josalero.keycloak.providers;

import com.josalero.keycloak.SpringContextAdapter;
import com.josalero.keycloak.KeycloakProperties;
import org.keycloak.services.util.JsonConfigProviderFactory;

import java.util.Properties;

public class JsonProviderFactory extends JsonConfigProviderFactory {

	@Override
	protected Properties getProperties() {

		var keycloakProperties = SpringContextAdapter.getBean(KeycloakProperties.class);

		return keycloakProperties.getConnectionJpaProperties();
	}

}
