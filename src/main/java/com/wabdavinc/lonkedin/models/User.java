package com.wabdavinc.lonkedin.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "users")
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	@Email(message = "Invalid Email")
	private String email;
	@Size(min = 1, message = "Character Name must be at least 3 characters")
	private String name;
	@Size(min = 5, message = "Universe must be at least 5 characters")
	private String universe;
	@Size(min = 1, message = "Choose a profile image")
	private String picture;
	private String description;
	@Size(min = 8, message = "Password must be at least 8 characters")
	private String password;
	@Transient
	private String confirmPassword;
	
	@OneToMany(mappedBy = "character", fetch = FetchType.LAZY)
	private List<Post> posts;
	@OneToMany(mappedBy = "creator", fetch = FetchType.LAZY)
	private List<Post> createdPosts;
	
	@ManyToOne(fetch = FetchType.LAZY)
	private Game game;
	@ManyToOne(fetch = FetchType.LAZY)
	private Job job;
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
		    name = "users_skills", 
		    joinColumns = @JoinColumn(name = "user_id"), 
		    inverseJoinColumns = @JoinColumn(name = "skill_id")
		)
	private List<Skill> skills;

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
			name="friends",
			joinColumns = @JoinColumn(name = "friend_id"),
			inverseJoinColumns = @JoinColumn(name="other_friend_id"))
	private List<User> friends;
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
			name="friendRequests",
			joinColumns = @JoinColumn(name = "friend_id"),
			inverseJoinColumns = @JoinColumn(name="other_friend_id"))
	private List<User> friendRequests;
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
			name="enemies",
			joinColumns = @JoinColumn(name = "enemy_id"),
			inverseJoinColumns = @JoinColumn(name="other_enemy_id"))
	private List<User> enemies;
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
			name="enemyRequests",
			joinColumns = @JoinColumn(name = "friend_id"),
			inverseJoinColumns = @JoinColumn(name="other_friend_id"))
	private List<User> enemyRequests;
	
	@Column(updatable = false)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date createdAt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updatedAt;
	
	public User() {
		this.description = "";
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUniverse() {
		return universe;
	}

	public void setUniverse(String universe) {
		this.universe = universe;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public List<Post> getPosts() {
		return posts;
	}

	public void setPosts(List<Post> posts) {
		this.posts = posts;
	}

	public List<Post> getCreatedPosts() {
		return createdPosts;
	}

	public void setCreatedPosts(List<Post> createdPosts) {
		this.createdPosts = createdPosts;
	}

	public Game getGame() {
		return game;
	}

	public void setGame(Game game) {
		this.game = game;
	}

	public Job getJob() {
		return job;
	}

	public void setJob(Job job) {
		this.job = job;
	}

	public List<Skill> getSkills() {
		return skills;
	}

	public void setSkills(List<Skill> skills) {
		this.skills = skills;
	}

	public List<User> getFriends() {
		return friends;
	}

	public void setFriends(List<User> friends) {
		this.friends = friends;
	}

	public List<User> getFriendRequests() {
		return friendRequests;
	}

	public void setFriendRequests(List<User> friendRequests) {
		this.friendRequests = friendRequests;
	}

	public List<User> getEnemies() {
		return enemies;
	}

	public void setEnemies(List<User> enemies) {
		this.enemies = enemies;
	}

	public List<User> getEnemyRequests() {
		return enemyRequests;
	}

	public void setEnemyRequests(List<User> enemyRequests) {
		this.enemyRequests = enemyRequests;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	@PrePersist
	protected void onCreate() {
		this.createdAt = new Date();
		this.updatedAt = new Date();
	}
	@PreUpdate
	protected void onUpdate() {
		this.updatedAt = new Date();
	}

}
