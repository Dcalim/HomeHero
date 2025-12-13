package com.project.homeHero.controllers.config;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.info.License;
import org.springframework.context.annotation.Configuration;

@Configuration
@OpenAPIDefinition(
        info = @Info(
                title = "HomeHero API",
                version = "v1",
                description = "Backend API for HomeHero (tasks, profiles, households).",
                contact = @Contact(name = "HomeHero Team", email = "support@homehero.app"),
                license = @License(name = "MIT", url = "https://opensource.org/licenses/MIT")
        )
)
public class OpenApiConfig {}
