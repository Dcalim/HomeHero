package com.project.homeHero.service.profile;

import com.project.homeHero.model.Profile;
import com.project.homeHero.persistance.ProfileMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class ProfileService {

    private final ProfileMapper profileMapper;

    @Autowired
    public ProfileService(ProfileMapper jdbcTemplate) {
        this.profileMapper = jdbcTemplate;
    }

    public Profile getProfileById(UUID userId) {
        return profileMapper.getProfileById(userId);
    }
}