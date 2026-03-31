package com.project.homeHero.controllers.homeController;

import com.project.homeHero.model.Home;
import com.project.homeHero.model.Profile;
import com.project.homeHero.service.home.HomeService;
import com.project.homeHero.service.profile.ProfileService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@Tag(name = "Home", description = "App Home endpoints")
@RestController
@RequestMapping("/api/v1")
public class HomeController {
    private final HomeService homeService;

    @Autowired
    public HomeController(HomeService homeService) {
        this.homeService = homeService;
    }

    @Operation(
            summary = "Get app configuration",
            description = "Returns the authenticated user's profile and app configuration settings."
    )
    @RequestMapping(value = "/loadHomes", produces = "application/json", method = RequestMethod.GET)
    public List<Home> loadHome(@Parameter(hidden = true) Authentication authentication) {
        String userId = (String) authentication.getPrincipal();

        return homeService.getHomes(UUID.fromString(userId));
    }
}
