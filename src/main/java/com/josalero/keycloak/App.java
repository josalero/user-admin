package com.josalero.keycloak;

import java.util.NoSuchElementException;

import com.josalero.keycloak.providers.JsonProviderFactory;
import org.keycloak.Config;
import org.keycloak.exportimport.ExportImportManager;
import org.keycloak.models.KeycloakSession;
import org.keycloak.services.managers.ApplianceBootstrap;
import org.keycloak.services.resources.KeycloakApplication;
import org.keycloak.services.util.JsonConfigProviderFactory;

import jakarta.ws.rs.ApplicationPath;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ApplicationPath("/")
public class App extends KeycloakApplication {

	private KeycloakProperties keycloakProperties;

	public App() {
		super();
	}

	@Override
	protected void loadConfig() {
		JsonConfigProviderFactory factory = new JsonProviderFactory();
		Config.init(factory.create().orElseThrow(() -> new NoSuchElementException("No value present")));
	}

	@Override
	protected ExportImportManager bootstrap() {
		keycloakProperties = SpringContextAdapter.getBean(KeycloakProperties.class);
		//System.getProperties().putAll(keycloakProperties.getRealmProperties());

		final ExportImportManager exportImportManager = super.bootstrap();
		createMasterRealmAdminUser();
		return exportImportManager;
	}

	private void createMasterRealmAdminUser() {
		log.info("Creating administrative user.");
		try (KeycloakSession session = getSessionFactory().create()) {
			ApplianceBootstrap applianceBootstrap = new ApplianceBootstrap(session);
			try {
				session.getTransactionManager().begin();
				applianceBootstrap.createMasterRealmUser(keycloakProperties.getServer("username"), keycloakProperties.getServer("password"));
				session.getTransactionManager().commit();
			} catch (Exception ex) {
				log.warn("Couldn't create keycloak master admin user: {}", ex.getMessage());
				session.getTransactionManager().rollback();
			}
		}
	}

}
