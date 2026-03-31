package com.project.homeHero.model;

import java.time.Instant;
import java.util.UUID;

public class Home {
    private int id;
    private String name;
    private UUID homeCode;

    public Home(int id, String name, UUID homeCode) {
        this.id = id;
        this.name = name;
        this.homeCode = homeCode;
    }

    public Home() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public UUID getHomeCode() {
        return homeCode;
    }

    public void setHomeCode(UUID homeCode) {
        this.homeCode = homeCode;
    }
}
