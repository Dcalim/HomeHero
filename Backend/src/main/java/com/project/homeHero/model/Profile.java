package com.project.homeHero.model;

import com.project.homeHero.model.constants.Ui_mode;

import java.util.UUID;

public class Profile {
    private UUID id;
    private String full_name;
    private String first_name;
    private String last_name;
    private String phone_number;
    private String email;
    private UUID home_code;
    private Ui_mode ui_mode;

    public Profile() {
    }

    public Profile(UUID id, String full_name, String first_name, String last_name, String phone_number, String email, UUID home_code, Ui_mode ui_mode) {
        this.id = id;
        this.full_name = full_name;
        this.first_name = first_name;
        this.last_name = last_name;
        this.phone_number = phone_number;
        this.email = email;
        this.home_code = home_code;
        this.ui_mode = ui_mode;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getFullName() {
        return full_name;
    }

    public void setFullName(String full_name) {
        this.full_name = full_name;
    }

    public String getFirstName() {
        return first_name;
    }

    public void setFirstName(String first_name) {
        this.first_name = first_name;
    }

    public String getLastName() {
        return last_name;
    }

    public void setLastName(String last_name) {
        this.last_name = last_name;
    }

    public String getPhoneNumber() {
        return phone_number;
    }

    public void setPhoneNumber(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public UUID getHomeCode() {
        return home_code;
    }

    public void setHomeCode(UUID home_code) {
        this.home_code = home_code;
    }

    public Ui_mode getUiMode() {
        return ui_mode;
    }

    public void setUiMode(Ui_mode ui_mode) {
        this.ui_mode = ui_mode;
    }
}
