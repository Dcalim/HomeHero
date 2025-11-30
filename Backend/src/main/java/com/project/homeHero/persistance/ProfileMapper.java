package com.project.homeHero.persistance;

import com.project.homeHero.model.Profile;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.UUID;

@Mapper
public interface ProfileMapper {

    @Select("SELECT * from public.profiles")
    List<Profile> getAllProfiles();

    @Select("SELECT * FROM public.profiles WHERE id = #{id}")
    Profile getProfileById(@Param("id") UUID id);
}
