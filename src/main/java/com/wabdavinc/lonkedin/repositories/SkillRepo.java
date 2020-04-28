package com.wabdavinc.lonkedin.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.wabdavinc.lonkedin.models.Skill;

@Repository
public interface SkillRepo extends CrudRepository<Skill, Long> {
	
    List<Skill> findAll();
}
