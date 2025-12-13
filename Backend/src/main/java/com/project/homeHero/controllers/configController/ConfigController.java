package com.project.homeHero.controllers.configController;

import com.project.homeHero.model.AppConfig;
import com.project.homeHero.model.Profile;
import com.project.homeHero.service.profile.ProfileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequestMapping("/api/v1")
public class ConfigController {
    private final ProfileService profileService;

    @Autowired
    public ConfigController(ProfileService profileService) {
        this.profileService = profileService;
    }

    @RequestMapping(value = "/config", produces = "application/json", method = RequestMethod.GET)
    public AppConfig config(Authentication authentication) {
        String userId = (String) authentication.getPrincipal();

        Profile profile = profileService.getProfileById(
                UUID.fromString(userId)
        );

        AppConfig appConfig = new AppConfig();
        appConfig.setProfile(profile);
        return appConfig;
    }
}
