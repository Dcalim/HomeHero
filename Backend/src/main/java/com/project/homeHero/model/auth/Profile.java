package com.project.homeHero.model.auth;

public class Profile {
    private String uuid;
    private String first_name;
    private String last_name;
    private String phone_number;
    private String email;

    // Constructor
    public Profile(String uuid, String first_name, String last_name, String phone_number, String email) {
        this.uuid = uuid;
        this.first_name = first_name;
        this.last_name = last_name;
        this.phone_number = phone_number;
        this.email = email;
    }

    // Getters
    public String getUuid() {
        return uuid;
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
    public void setUuid(String uuid) {
        this.uuid = uuid;
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
