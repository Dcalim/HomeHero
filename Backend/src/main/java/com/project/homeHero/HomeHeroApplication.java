package com.project.homeHero;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.mybatis.spring.annotation.MapperScan;

@SpringBootApplication
@MapperScan("com.project.homeHero.persistance")
public class HomeHeroApplication {

	public static void main(String[] args) {
		SpringApplication.run(HomeHeroApplication.class, args);
	}

}
