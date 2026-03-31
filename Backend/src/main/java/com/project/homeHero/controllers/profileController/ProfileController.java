package com.project.homeHero.controllers.profileController;

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
public class ProfileController {
    private final ProfileService profileService;

    @Autowired
    public ProfileController(ProfileService profileService) {
        this.profileService = profileService;
    }

    @Operation(
            summary = "Get app configuration",
            description = "Returns the authenticated user's profile and app configuration settings."
    )
    @RequestMapping(value = "/loadProfile", produces = "application/json", method = RequestMethod.GET)
    public Profile loadProfile(@Parameter(hidden = true) Authentication authentication) {
        String userId = (String) authentication.getPrincipal();

        return profileService.getProfileById(UUID.fromString(userId));
    }
}
