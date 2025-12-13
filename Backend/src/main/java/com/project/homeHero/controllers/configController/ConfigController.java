package com.project.homeHero.controllers.configController;

import com.project.homeHero.model.AppConfig;
import com.project.homeHero.model.Profile;
import com.project.homeHero.service.profile.ProfileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import io.swagger.v3.oas.annotations.tags.Tag;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;

import java.util.UUID;


@Tag(name = "Config", description = "App config endpoints")
@RestController
@RequestMapping("/api/v1")
public class ConfigController {
    private final ProfileService profileService;

    @Autowired
    public ConfigController(ProfileService profileService) {
        this.profileService = profileService;
    }

    @Operation(
            summary = "Get app configuration",
            description = "Returns the authenticated user's profile and app configuration settings."
    )
    @RequestMapping(value = "/config", produces = "application/json", method = RequestMethod.GET)
    public AppConfig config(@Parameter(hidden = true) Authentication authentication) {
        String userId = (String) authentication.getPrincipal();

        Profile profile = profileService.getProfileById(
                UUID.fromString(userId)
        );

        AppConfig appConfig = new AppConfig();
        appConfig.setProfile(profile);
        return appConfig;
    }
}
