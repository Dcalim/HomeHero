package com.project.homeHero.persistance;

import com.project.homeHero.model.Home;
import com.project.homeHero.model.Profile;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.UUID;

public interface HomeMapper {
    @Select("SELECT h.* FROM public.homes h JOIN public.profile_to_homes pth ON pth.home_id = h.id WHERE pth.profile_id = #{id}")
    @Results({
            @Result(column = "home_code", property = "homeCode"),
    })
    List<Home> getAllHomes(@Param("id")  UUID id);
}
