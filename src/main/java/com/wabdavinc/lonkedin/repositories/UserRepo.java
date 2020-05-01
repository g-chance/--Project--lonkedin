package com.wabdavinc.lonkedin.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.wabdavinc.lonkedin.models.User;

@Repository
public interface UserRepo extends CrudRepository<User, Long> {

	List<User> findAll();
	List<User> findByNameContaining(String str);
	User findByEmail(String email);
	User findByNameAndUniverse(String name, String universe);
}
