package com.project.homeHero.service.home;

import com.project.homeHero.model.Home;
import com.project.homeHero.persistance.HomeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class HomeService {
    private final HomeMapper homeMapper;

    @Autowired
    public HomeService(HomeMapper homeMapper) {
        this.homeMapper = homeMapper;
    }

    public List<Home> getHomes(UUID id) {
        List<Home> homes = homeMapper.getAllHomes(id);
        return homes;
    }
}
