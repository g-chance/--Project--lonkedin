package com.wabdavinc.lonkedin.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.wabdavinc.lonkedin.models.Skill;
import com.wabdavinc.lonkedin.models.User;
import com.wabdavinc.lonkedin.models.UserSkill;

@Repository
public interface UserSkillRepo extends CrudRepository<UserSkill, Long> {
	
	List<UserSkill> findAll();
	List<UserSkill> findAllByUser(User user);
	UserSkill findByUserAndSkill(User user, Skill skill);
}
