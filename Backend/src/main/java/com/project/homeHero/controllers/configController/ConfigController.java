package com.project.homeHero.controllers.configController;

import com.project.homeHero.model.AppConfig;
import com.project.homeHero.model.auth.Profile;
import com.project.homeHero.service.config.ConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1")
public class ConfigController {

    private final ConfigService configService;

    @Autowired
    public ConfigController(ConfigService configService) {
        this.configService = configService;
    }

    @RequestMapping(value = "/config", produces = "application/json", method = RequestMethod.GET)
    public List<Profile> getConfig() {
        return configService.getConfig();
    }
}
