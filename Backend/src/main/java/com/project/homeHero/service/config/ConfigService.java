package com.project.homeHero.service.config;

import com.project.homeHero.model.AppConfig;
import com.project.homeHero.model.Profile;
import org.springframework.stereotype.Service;

@Service
public class ConfigService {

    public AppConfig getConfig() {
        Profile testProfile = new Profile("id:12345", "Dion Calim", "dcalim@uoguelph.ca", "0987654321");
        AppConfig testConfig = new AppConfig(testProfile);
        return testConfig;
    }
}