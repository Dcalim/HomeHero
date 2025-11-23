package com.project.homeHero.model.auth;

import java.util.UUID;

public class Profile {
    private UUID id;
    private String full_name;
    private String first_name;
    private String last_name;
    private String phone_number;
    private String email;

    // Constructor
    public Profile(UUID id, String full_name, String first_name, String last_name, String phone_number, String email) {
        this.id = id;
        this.full_name = full_name;
        this.first_name = first_name;
        this.last_name = last_name;
        this.phone_number = phone_number;
        this.email = email;
    }

    // Getters
    public UUID getid() {
        return id;
    }

    public String getfull_name() {
        return full_name;
    }

    public String getFirst_name() {
        return first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public String getEmail() {
        return email;
    }

    // Setters
    public void setId(UUID id) {
        this.id = id;
    }

    public void setfull_name(String full_name) {
        this.full_name = full_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public void setEmail(String email) {
        this.email = email;
    }

}
