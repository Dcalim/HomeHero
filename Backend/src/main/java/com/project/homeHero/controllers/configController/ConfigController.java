package com.project.homeHero.controllers.configController;

import com.project.homeHero.model.AppConfig;
import com.project.homeHero.model.Profile;
import com.project.homeHero.service.profile.ProfileService;
import com.project.homeHero.service.auth.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import java.util.UUID;

@RestController
@RequestMapping("/api/v1")
public class ConfigController {
    private final AuthService authService;
    private final ProfileService profileService;

    @Autowired
    public ConfigController(AuthService authService, ProfileService profileService) {
        this.authService = authService;
        this.profileService = profileService;
    }

    @RequestMapping(value = "/config", produces = "application/json", method = RequestMethod.GET)
    public AppConfig config(@RequestHeader("Authorization") String authHeader) {
        AppConfig appConfig = new AppConfig();

        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Missing Bearer token");
        }

        String token = authHeader.replace("Bearer ", "");
        String userId = authService.getUserIdFromToken(token);
        Profile profile = profileService.getProfileById(UUID.fromString(userId));

        appConfig.setProfile(profile);
        return appConfig;
    }
}
