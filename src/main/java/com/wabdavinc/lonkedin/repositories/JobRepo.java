package com.wabdavinc.lonkedin.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.wabdavinc.lonkedin.models.Game;
import com.wabdavinc.lonkedin.models.Job;

@Repository
public interface JobRepo extends CrudRepository<Job, Long>, PagingAndSortingRepository<Job, Long> {
	
    List<Job> findAll();
    Page<Job> findAllByCharactersIsEmpty(Pageable pageable);
    Job findByGameAndTitle(Game game, String title);
}