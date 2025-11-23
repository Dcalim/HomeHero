package com.project.homeHero.persistance;

import com.project.homeHero.model.auth.Profile;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ProfileMapper {

    @Select("SELECT * from public.profiles")
    List<Profile> getAllProfiles();
}
