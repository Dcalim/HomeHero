package com.project.homeHero.service.config;

import com.project.homeHero.model.AppConfig;
import com.project.homeHero.model.auth.Profile;
import com.project.homeHero.persistance.ProfileMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ConfigService {

    private final ProfileMapper profileMapper;

    @Autowired
    public ConfigService(ProfileMapper profileMapper) {
        this.profileMapper = profileMapper;
    }

    public List<Profile> getConfig() {
        return profileMapper.getAllProfiles();
    }
}