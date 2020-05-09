package com.wabdavinc.lonkedin.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.wabdavinc.lonkedin.models.Game;
import com.wabdavinc.lonkedin.models.Job;
import com.wabdavinc.lonkedin.models.User;

@Repository
public interface UserRepo extends CrudRepository<User, Long>, PagingAndSortingRepository<User, Long>{

	List<User> findAll();
	Page<User> findAll(Pageable pageable);
	List<User> findAllByGame(Game game);
	List<User> findByNameContaining(String str);
	User findByEmail(String email);
	User findByNameAndUniverse(String name, String universe);
	User findByGameAndJob(Game game, Job job);
}
