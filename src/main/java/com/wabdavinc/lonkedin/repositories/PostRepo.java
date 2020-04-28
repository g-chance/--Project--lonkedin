package com.wabdavinc.lonkedin.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.wabdavinc.lonkedin.models.Post;

@Repository
public interface PostRepo extends CrudRepository<Post, Long> {
	
    List<Post> findAll();
}
