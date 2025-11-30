package com.project.homeHero.model;

public class AppConfig {
    private Profile profile;

    public AppConfig() {}

    public AppConfig(Profile profile) {
        this.profile = profile;
    }

    public Profile getProfile() {
        return profile;
    }

    public void setProfile(Profile profile) {
        this.profile = profile;
    }
}
