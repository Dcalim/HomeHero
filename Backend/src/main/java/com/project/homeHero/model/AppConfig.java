package com.project.homeHero.model;

public class AppConfig {
    private Profile profile;

    public AppConfig(Profile profile) {
        this.profile = profile;
    }

    public Profile getProfile() {
        return profile;
    }

    public void setProfile(Profile id) {
        this.profile = profile;
    }
}
