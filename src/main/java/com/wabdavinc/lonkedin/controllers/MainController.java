package com.wabdavinc.lonkedin.controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.wabdavinc.lonkedin.models.Game;
import com.wabdavinc.lonkedin.models.Job;
import com.wabdavinc.lonkedin.models.Post;
import com.wabdavinc.lonkedin.models.Skill;
import com.wabdavinc.lonkedin.models.User;
import com.wabdavinc.lonkedin.models.UserSkill;
import com.wabdavinc.lonkedin.repositories.GameRepo;
import com.wabdavinc.lonkedin.repositories.JobRepo;
import com.wabdavinc.lonkedin.repositories.PostRepo;
import com.wabdavinc.lonkedin.repositories.SkillRepo;
import com.wabdavinc.lonkedin.repositories.UserRepo;
import com.wabdavinc.lonkedin.repositories.UserSkillRepo;
import com.wabdavinc.lonkedin.services.UserServ;
import com.wabdavinc.lonkedin.validator.GameValidator;
import com.wabdavinc.lonkedin.validator.UserValidator;

@Controller
public class MainController {

	private final UserRepo urepo;
	private final UserServ userv;
	private final UserValidator uvalid;
	private final GameValidator gvalid;
	private final GameRepo grepo;
	private final JobRepo jrepo;
	private final PostRepo prepo;
	private final SkillRepo srepo;
	private final UserSkillRepo usrepo;

	public MainController(UserRepo urepo, UserServ userv, UserValidator uvalid, GameRepo grepo, GameValidator gvalid,
			JobRepo jrepo, PostRepo prepo, SkillRepo srepo, UserSkillRepo usrepo) {
		this.urepo = urepo;
		this.userv = userv;
		this.uvalid = uvalid;
		this.grepo = grepo;
		this.gvalid = gvalid;
		this.jrepo = jrepo;
		this.prepo = prepo;
		this.srepo = srepo;
		this.usrepo = usrepo;
	}

//	GREG
//	============================================================== Create Character

	@GetMapping("/newcharacter")
	public String newCharacter(Model model, HttpSession session) {
		if(session.getAttribute("user_id") == null) {
			return "redirect:/login";
		}

//	Add Lonk as a friend
		User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		
		if(u.getName() != null) {
			return "redirect:/dashboard/"+u.getId();
		}
		
		User lonk = urepo.findByEmail("lonk@lonkedin.com");
		System.out.println(u);
		System.out.println(lonk);
		if (!u.getFriends().contains(lonk)) {
			System.out.println(u.getFriends());
			System.out.println(lonk.getFriends());
			u.getFriends().add(lonk);
			lonk.getFriends().add(u);
			urepo.save(u);
			urepo.save(lonk);
		}

		model.addAttribute("user", u);
		return "newCharacter.jsp";
	}

	@PostMapping("/newcharacter")
	public String doNewCharacter(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
		uvalid.validate(user, result);
		if (result.hasErrors()) {
			return "newCharacter.jsp";
		}
		
		User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		u.setName(user.getName());
		u.setUniverse(user.getUniverse());
		u.setPicture(user.getPicture());
		urepo.save(u);
		
//	Create Newbie Skil if it doesn't exist
		if(srepo.findByName("Newbie") == null) {
			Skill newb = new Skill();
			newb.setName("Newbie");
			newb.setLevel(0);
			srepo.save(newb);
		}
		
//	Add Newbie skill to user
		UserSkill us = new UserSkill();
		Skill skill = srepo.findByName("Newbie");
		us.setUser(u);
		us.setSkill(skill);
		usrepo.save(us);
		
		return ("redirect:/dashboard/" + u.getId());
	}

//	**************************************************************

//	GREG
//	============================================================== Dashboard

	@GetMapping("/dashboard")
	public String dashboardcatch(HttpSession session, Model model) {
		if (session.getAttribute("user_id") == null) {
			return "redirect:/login";
		} else if(urepo.findById((Long)session.getAttribute("user_id")).orElse(null).getName() == null) {
			return "redirect:/newcharacter";
		}
		Long id = (Long) session.getAttribute("user_id");
		return "redirect:/" + id;
	}

	@GetMapping("/dashboard/{user_id}")
	public String dashboard(@PathVariable("user_id") Long userId, HttpSession session, Model model) {
		if (session.getAttribute("user_id") == null) {
			return "redirect:/login";
		} else if (urepo.findById((Long)session.getAttribute("user_id")).orElse(null).getName() == null) {
			return "redirect:/newcharacter";
		}
		
		if(session.getAttribute("postError") != null) {
			model.addAttribute("postError", "Post must include content");
			session.removeAttribute("postError");
		}
		if(session.getAttribute("editDesc") != null) {
			model.addAttribute("editDesc", true);
			session.removeAttribute("editDesc");
		}
		
		Long id = (Long) session.getAttribute("user_id");
		User user = urepo.findById(userId).orElse(null);
		User loggedIn = urepo.findById(id).orElse(null);

//	Add model attributes
		model.addAttribute("user", user);
		model.addAttribute("loggedIn", loggedIn);
		model.addAttribute("post", new Post());
//	Sort and filter posts to be descending per created date and to 5 by default
		List<Post> mylist = user.getPosts();
		mylist.sort((c1, c2) -> (int) c2.getCreatedAt().getTime() - (int) c1.getCreatedAt().getTime());
		int defaultDisplayIndex = 3;
		if (defaultDisplayIndex > user.getPosts().size()) { 
			defaultDisplayIndex = user.getPosts().size();
		}
		List<Post> myPosts = mylist.subList(0, defaultDisplayIndex);
		session.setAttribute("currentDisplayIndex", defaultDisplayIndex);
		model.addAttribute("allPosts",mylist);
		model.addAttribute("posts", myPosts);
		model.addAttribute("skills", usrepo.findAllByUser(user));
		model.addAttribute("lonkpost", urepo.findByEmail("lonk@lonkedin.com").getCreatedPosts().get(0));
		model.addAttribute("friendRequests", user.getFriendRequests());
//	Get a list of 10 games
		
//		List<Game> games = new ArrayList<Game>();
//		if (grepo.findAll().size() != 0) {
//			for (int i = 0; i < grepo.findAll().size() && i < 10; i++) {
//				games.add(grepo.findAll().get(i));
//			}
//		}
//		model.addAttribute("games", games);
		
		List<Game> myGames = grepo.findAll();
		myGames.sort((c1, c2) -> (int) c2.getCreatedAt().getTime() - (int) c1.getCreatedAt().getTime());
		int gameCounter = 0;
			for(int i=0;i<grepo.findAll().size() && i<10;i++) {
				gameCounter++;
			}
		model.addAttribute("games", myGames.subList(0, gameCounter));
//	Get a list of 10 jobs
		
//		List<Job> jobs = new ArrayList<Job>();
//		if (jrepo.findAll().size() != 0) {
//			for (int i = 0; i < jrepo.findAll().size() && jobs.size() < 10; i++) {
//				if (jrepo.findAll().get(i).getCharacters().size() == 0) {
//					jobs.add(jrepo.findAll().get(i));
//				}
//			}
//		}
//		model.addAttribute("jobs", jobs);
		
		Pageable pageable = PageRequest.of(0, 10, Sort.by("updatedAt").descending());
		model.addAttribute("testing2", jrepo.findAllByCharactersIsEmpty(pageable));
		
//	Get a list of 8 friends
		ArrayList<User> friends = new ArrayList<User>();
		if(user.getFriends().size() != 0) {
			for(int i=0;i<user.getFriends().size() && i<8;i++) {
				friends.add(user.getFriends().get(i));
			}
		}
		model.addAttribute("friends", friends);
//	Get a list of 4 enemies
		ArrayList<User> enemies = new ArrayList<User>();
//		if(user.getEnemies().size() != 0) {
//			for(int i=0;i<user.getFriends().size() && i<4;i++) {
//				enemies.add(user.getEnemies().get(i));
//			}	
//		}
		int enemyCount = 0;
		if(user.getGame() != null) {
			for(User character : user.getGame().getCharacters()) {
				if(user.getJob().getMorality() != character.getJob().getMorality()) {
					if(enemyCount < 4) {
						enemies.add(character);
						enemyCount += 1;
					} else {
						enemyCount += 1;
					}
				}
			}
		}
		model.addAttribute("enemies", enemies);
//	Get number of connections
		model.addAttribute("connectionsCount", user.getFriends().size() + user.getEnemies().size());
		model.addAttribute("friendsCount", user.getFriends().size());
		model.addAttribute("enemiesCount", enemyCount);
//	Get friend's latest posts
		List<Post> friendPosts = new ArrayList<Post>();
		for (User friend : user.getFriends()) {
			if (friend.getPosts().size() > 0) {
				friendPosts.add(friend.getPosts().get(friend.getPosts().size() - 1));
			}
		}
		model.addAttribute("friendPosts", friendPosts);

		return "dashboard.jsp";
	}

	@PostMapping("/newpost/{otherUser_id}")
	public String newPost(@PathVariable("otherUser_id") Long otherUserId, @Valid @ModelAttribute("post") Post post,
			BindingResult result, Model model, HttpSession session) {
		User user = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		User otherUser = urepo.findById(otherUserId).orElse(null);
		if (result.hasErrors()) {
			session.setAttribute("postError", "error");
//			model.addAttribute("user", user);
			return "redirect:/dashboard/" + otherUser.getId();
		}
		post.setCreator(user);
		post.setCharacter(otherUser);
		prepo.save(post);
		return "redirect:/dashboard/" + otherUser.getId();
	}
	@PostMapping("/adddescription/{userid}")
	public String addDescription(@PathVariable("userid") Long id, @Valid @ModelAttribute("user") User user, BindingResult result, Model model, HttpSession session ) {
		if(result.hasErrors()) {
			session.setAttribute("descError", "error");
			return "redirect:/dashboard/"+id;
		}
		User u = urepo.findById((Long)session.getAttribute("user_id")).orElse(null);
		u.setDescription(user.getDescription());
		urepo.save(u);
		return "redirect:/dashboard/"+id;
	}
	@GetMapping("editDesc/{userid}")
	public String editDescription(@PathVariable("userid") Long id, HttpSession session) {
		session.setAttribute("editDesc", "editDesc");
		return "redirect:/dashboard/"+id;
	}

	@GetMapping("/dashboard/{user_id}/loadmore")
	public String loadmorePost(@PathVariable("user_id") Long userId, HttpSession session, Model model) {
		if (session.getAttribute("user_id") == null) {
			return "redirect:/login";
		} else if(urepo.findById((Long)session.getAttribute("user_id")).orElse(null).getName() == null) {
			return "redirect:/newcharacter";
		}
		Long id = (Long) session.getAttribute("user_id");
		User user = urepo.findById(userId).orElse(null);
		User loggedIn = urepo.findById(id).orElse(null);

//	Add model attributes
		model.addAttribute("user", user);
		model.addAttribute("loggedIn", loggedIn);
		model.addAttribute("post", new Post());
		int currentDisplayIndex = (int)session.getAttribute("currentDisplayIndex") + 3;
		session.setAttribute("currentDisplayIndex",currentDisplayIndex);
		if (currentDisplayIndex >= user.getPosts().size()) {
			currentDisplayIndex = user.getPosts().size();
		}
		List<Post> mylist = user.getPosts();
		mylist.sort((c1, c2) -> (int) c2.getCreatedAt().getTime() - (int) c1.getCreatedAt().getTime());
		List<Post> myPosts = mylist.subList(0, currentDisplayIndex);
		model.addAttribute("allPosts",mylist);
		model.addAttribute("posts", myPosts);
		model.addAttribute("skills", usrepo.findAllByUser(user));
		model.addAttribute("lonkpost", urepo.findByEmail("lonk@lonkedin.com").getCreatedPosts().get(0));
		model.addAttribute("friendRequests", user.getFriendRequests());
//	Get a list of 10 games
//		List<Game> games = new ArrayList<Game>();
//		if (grepo.findAll().size() != 0) {
//			for (int i = 0; i < grepo.findAll().size() && i < 10; i++) {
//				games.add(grepo.findAll().get(i));
//			}
//		}
//		model.addAttribute("games", games);
		
		List<Game> myGames = grepo.findAll();
		myGames.sort((c1, c2) -> (int) c2.getCreatedAt().getTime() - (int) c1.getCreatedAt().getTime());
		int gameCounter = 0;
			for(int i=0;i<grepo.findAll().size() && i<10;i++) {
				gameCounter++;
			}
		model.addAttribute("games", myGames.subList(0, gameCounter));
		
//	Get a list of 10 jobs
//		List<Job> jobs = new ArrayList<Job>();
//		if (jrepo.findAll().size() != 0) {
//			for (int i = 0; i < jrepo.findAll().size() && jobs.size() < 10; i++) {
//				if (jrepo.findAll().get(i).getCharacters().size() == 0) {
//					jobs.add(jrepo.findAll().get(i));
//				}
//			}
//		}
//		model.addAttribute("jobs", jobs);
		
		Pageable pageable = PageRequest.of(0, 10, Sort.by("updatedAt").descending());
		model.addAttribute("testing2", jrepo.findAllByCharactersIsEmpty(pageable));
		
//	Get a list of 8 friends
		ArrayList<User> friends = new ArrayList<User>();
		if(user.getFriends().size() != 0) {
			for(int i=0;i<user.getFriends().size() && i<8;i++) {
				friends.add(user.getFriends().get(i));
			}
		}
		model.addAttribute("friends", friends);
//	Get a list of 4 enemies
		ArrayList<User> enemies = new ArrayList<User>();
//		if(user.getEnemies().size() != 0) {
//			for(int i=0;i<user.getFriends().size() && i<4;i++) {
//				enemies.add(user.getEnemies().get(i));
//			}	
//		}
		int enemyCount = 0;
		if(user.getGame() != null) {
			for(User character : user.getGame().getCharacters()) {
				if(user.getJob().getMorality() != character.getJob().getMorality()) {
					if(enemyCount < 4) {
						enemies.add(character);
						enemyCount += 1;
					} else {
						enemyCount += 1;
					}
				}
			}
		}
		model.addAttribute("enemies", enemies);
//	Get number of connections
		model.addAttribute("connectionsCount", user.getFriends().size() + user.getEnemies().size());
		model.addAttribute("friendsCount", user.getFriends().size());
		model.addAttribute("enemiesCount", enemyCount);
//	Get friend's latest posts
		List<Post> friendPosts = new ArrayList<Post>();
		for (User friend : user.getFriends()) {
			if (friend.getPosts().size() > 0) {
				friendPosts.add(friend.getPosts().get(friend.getPosts().size() - 1));
			}
		}
		model.addAttribute("friendPosts", friendPosts);

		return "dashboard.jsp";
	}
	@GetMapping("/search/{str}")
	public String search(@PathVariable("str") String str, Model model, HttpSession session) {
		if (session.getAttribute("user_id") == null) {
			return "redirect:/login";
		} else if(urepo.findById((Long)session.getAttribute("user_id")).orElse(null).getName() == null) {
			return "redirect:/newcharacter";
		}
		User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		model.addAttribute("user", u);
		model.addAttribute("friends", u.getFriends());
		model.addAttribute("str", str);
		
		if(str.equals("zxcvbnm")) {
			model.addAttribute("searchResults", urepo.findAll());
		} else {
			model.addAttribute("searchResults", urepo.findByNameContaining(str));
		}
		return "searchResults.jsp";
	}
	
	@PostMapping("/search")
	public String doSearch(@RequestParam("search") String str, Model model, HttpSession session) {
		session.setAttribute("searchResults", urepo.findByNameContaining(str));
		if(str.equals("")) {
			str = "zxcvbnm";
		}
		return "redirect:/search/"+str;
	}

	@PostMapping("/accept/{user_id}")
	public String accept(@PathVariable("user_id") Long id, HttpSession session) {
		User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		User friend = urepo.findById(id).orElse(null);
		u.getFriends().add(friend);
		u.getFriendRequests().remove(friend);
		friend.getFriends().add(u);
		urepo.save(u);
		urepo.save(friend);
		return "redirect:/dashboard/" + u.getId();
	}

	@PostMapping("/reject/{user_id}")
	public String reject(@PathVariable("user_id") Long id, HttpSession session) {
		User u = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		User friend = urepo.findById(id).orElse(null);
		u.getFriendRequests().remove(friend);
		urepo.save(u);
		return "redirect:/dashboard/" + u.getId();
	}
	
	@PostMapping("endorse/{user_id}/{skill_id}")
	public String endorse(@PathVariable("user_id") Long userid, @PathVariable("skill_id") Long skillid, @RequestParam("endorse") String str) {
		User u = urepo.findById(userid).orElse(null);
		Skill s = srepo.findById(skillid).orElse(null);
		UserSkill usk = usrepo.findByUserAndSkill(u, s);
		if(usk.getCount() == null) {
			if(str.equals("endorse")) {
				usk.setCount(1);	
			} else {
				usk.setCount(-1);
			}
		} else {
			if(str.equals("endorse")) {
				usk.setCount(usk.getCount()+1);	
			} else {
				usk.setCount(usk.getCount()-1);
			}
		}
		usrepo.save(usk);
		System.out.println(usk.getCount());
		return "redirect:/dashboard/"+userid;
	}

//	**************************************************************

//	GREG
//	============================================================== searchResults

//	Request Connection from Search Results Page
	@GetMapping("/requestConnection/{userid}/{str}")
	public String requestConnection(@PathVariable("userid") Long connectionId, @PathVariable("str") String str, HttpSession session) {
		if (session.getAttribute("user_id") == null) {
			return "redirect:/login";
		} else if(urepo.findById((Long)session.getAttribute("user_id")).orElse(null).getName() == null) {
			return "redirect:/newcharacter";
		}
		User user = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		User connection = urepo.findById(connectionId).orElse(null);
//		System.out.println(connection.getName());
//		System.out.println(user.getName());
//		System.out.println(connection.getFriendRequests());
//		System.out.println(connection.getFriendRequests().size());
		if (connection.getFriendRequests().contains(user)) {
			return "redirect:/dashboard/" + user.getId();
		}
		connection.getFriendRequests().add(user);
		urepo.save(connection);
//		System.out.println(connection.getFriendRequests().size());
		return "redirect:/search/"+str;
	}
	
//	Request Connection from Connections page
	@GetMapping("/requestConnection2/{connectionid}/{pageviewid}")
	public String requestConnection2(@PathVariable("connectionid") Long connectionId, @PathVariable("pageviewid") Long pageViewId, HttpSession session) {
		if (session.getAttribute("user_id") == null) {
			return "redirect:/login";
		} else if(urepo.findById((Long)session.getAttribute("user_id")).orElse(null).getName() == null) {
			return "redirect:/newcharacter";
		}
		User user = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		User connection = urepo.findById(connectionId).orElse(null);
		connection.getFriendRequests().add(user);
		urepo.save(connection);
		return "redirect:/connections/"+pageViewId;
	}

//	Request Connection from Dashboard
	@GetMapping("/requestConnection3/{connectionid}")
	public String requestConnection2(@PathVariable("connectionid") Long connectionId, HttpSession session) {
		if (session.getAttribute("user_id") == null) {
			return "redirect:/login";
		} else if(urepo.findById((Long)session.getAttribute("user_id")).orElse(null).getName() == null) {
			return "redirect:/newcharacter";
		}
		User user = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		User connection = urepo.findById(connectionId).orElse(null);
		connection.getFriendRequests().add(user);
		urepo.save(connection);
		return "redirect:/dashboard/"+connectionId;
	}
	
//	Request Connection from Game Page
	@GetMapping("/requestConnection4/{connectionid}")
	public String requestConnection4(@PathVariable("connectionid") Long connectionId, HttpSession session) {
		if (session.getAttribute("user_id") == null) {
			return "redirect:/login";
		} else if(urepo.findById((Long)session.getAttribute("user_id")).orElse(null).getName() == null) {
			return "redirect:/newcharacter";
		}
		User user = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		User connection = urepo.findById(connectionId).orElse(null);
		connection.getFriendRequests().add(user);
		urepo.save(connection);
		Game game = connection.getGame();
		return "redirect:/game/"+game.getId();
	}

//	**************************************************************

//	
//	============================================================== Connections

	@GetMapping("/connections/{user_id}")
	public String connections(@PathVariable("user_id") Long uId, HttpSession session, Model model) {
		if (session.getAttribute("user_id") == null) {
			return "redirect:/login";
		} else if(urepo.findById((Long)session.getAttribute("user_id")).orElse(null).getName() == null) {
			return "redirect:/newcharacter";
		}
		Long id = (Long) session.getAttribute("user_id");
		User loggedIn = urepo.findById(id).orElse(null);
		User u = urepo.findById(uId).orElse(null);
		u.getFriends().sort((u1,u2)->u1.getEmail().compareTo(u2.getEmail()));
		model.addAttribute("user",u);
		model.addAttribute("loggedIn", loggedIn);
		model.addAttribute("lonk", urepo.findByEmail("lonk@lonkedin.com"));
		
		List<User> enemies = new ArrayList<User>();
		if(u.getGame() != null) {
			for(User character : u.getGame().getCharacters()) {
				if(u.getJob().getMorality() != character.getJob().getMorality()) {
					enemies.add(character);
				}
			}
		}
		model.addAttribute("enemies", enemies);
		
		return "connectionsV2.jsp";
	}
//
//	@GetMapping("/friend/{user_id}")
//	public String addFriend(@PathVariable("user_id")Long fId, HttpSession session) {
//		Long id = (Long) session.getAttribute("user_id");
//		User loggedIn = urepo.findById(id).orElse(null);
////		Two lines above give us the user id and the User object
//		User friend = urepo.findById(fId).orElse(null);
//		if(loggedIn.getFriends().contains(friend)== false && loggedIn.getEnemies().contains(friend)== false ) {
//			loggedIn.getFriends().add(friend);
//			urepo.save(loggedIn);
//			friend.getFriends().add(loggedIn);
//			urepo.save(friend);
//		}
//		//TODO: ERROR HANDILING TO SAY IF THEY ARE AN ENEMY
//		return "redirect:/connections/" + id;
//	}

	@GetMapping("/friend/{user_id}/remove")
	public String removeFriend(@PathVariable("user_id") Long fId, HttpSession session) {
		if (session.getAttribute("user_id") == null) {
			return "redirect:/login";
		} else if(urepo.findById((Long)session.getAttribute("user_id")).orElse(null).getName() == null) {
			return "redirect:/newcharacter";
		}
		Long id = (Long) session.getAttribute("user_id");
		User loggedIn = urepo.findById(id).orElse(null);
//		Two lines above give us the user id and the User object
		User friend = urepo.findById(fId).orElse(null);
		if (loggedIn.getFriends().contains(friend)) {
			loggedIn.getFriends().remove(friend);
			urepo.save(loggedIn);
			friend.getFriends().remove(loggedIn);
			urepo.save(friend);
		}
		// TODO: ERROR HANDILING TO SAY IF THEY ARE AN ENEMY
		return "redirect:/connections/" + id;
	}

//	@GetMapping("/enemy/{user_id}")
//	public String addEnemy(@PathVariable("user_id")Long fId, HttpSession session) {
//		Long id = (Long) session.getAttribute("user_id");
//		User loggedIn = urepo.findById(id).orElse(null);
////		Two lines above give us the user id and the User object
//		User enemy = urepo.findById(fId).orElse(null);
//		if(loggedIn.getFriends().contains(enemy)== false && loggedIn.getEnemies().contains(enemy)== false ) {
//			loggedIn.getEnemies().add(enemy);
//			urepo.save(loggedIn);
//			enemy.getEnemies().add(loggedIn);
//			urepo.save(enemy);
//		}
//		//TODO: ERROR HANDILING TO SAY IF THEY ARE A FRIEND
//		return "redirect:/connections/" + id;
//	}
//	
//	@GetMapping("/enemy/{user_id}/remove")
//	public String removeEnemy(@PathVariable("user_id")Long fId, HttpSession session) {
//		Long id = (Long) session.getAttribute("user_id");
//		User loggedIn = urepo.findById(id).orElse(null);
////		Two lines above give us the user id and the User object
//		User enemy = urepo.findById(fId).orElse(null);
//		if(loggedIn.getEnemies().contains(enemy)) {
//			loggedIn.getEnemies().remove(enemy);
//			urepo.save(loggedIn);
//			enemy.getEnemies().remove(loggedIn);
//			urepo.save(enemy);
//		}
//		//TODO: ERROR HANDILING TO SAY IF THEY ARE A FRIEND
//		return "redirect:/connections/" + id;
//	}

	@GetMapping("/skill")
	public String newSkill(Model model, HttpSession session) {
		if (session.getAttribute("user_id") == null) {
			return "redirect:/login";
		} else if(urepo.findById((Long)session.getAttribute("user_id")).orElse(null).getName() == null) {
			return "redirect:/newcharacter";
		}
		Long id = (Long) session.getAttribute("user_id");
		User user = urepo.findById(id).orElse(null);
		model.addAttribute("skill", new Skill());
		model.addAttribute("user", user);
		model.addAttribute("allSkills", usrepo.findAllByUser(user));
		return "skill.jsp";
	}

//	@PostMapping("/skill/new")
//	public String submitSkill(@Valid @ModelAttribute("skill") Skill skill, BindingResult result, Model model, HttpSession session) {
//		model.addAttribute("skill", new Skill());
//		Long id = (Long) session.getAttribute("user_id");
//		User loggedIn = urepo.findById(id).orElse(null);
//		model.addAttribute("allSkills", srepo.findAll());
//		model.addAttribute("user", urepo.findById(id).orElse(null));
//		if (result.hasErrors()) {
//			return "skill.jsp";
//		}
//		// Add Validator to prevent duplicate skills later
//		
//		else {
//			System.out.println(srepo.findByName(skill.getName()));
//			Skill thisSkill = srepo.save(skill);
//			List<UserSkill> usk = usrepo.findAllByUser(loggedIn);
//			UserSkill test = new UserSkill();
//			test.setUser(loggedIn);
//			test.setSkill(thisSkill);
//			usk.add(test);
//			usrepo.save(test);
//		}
//		return "redirect:/skill";
//	}
	
	@PostMapping("/skill/new2")
	public String newSkill2(@Valid @ModelAttribute("skill") Skill skill, BindingResult result, Model model, HttpSession session) {
		Long id = (Long) session.getAttribute("user_id");
		User loggedIn = urepo.findById(id).orElse(null);
		model.addAttribute("user", loggedIn);
		model.addAttribute("allSkills", usrepo.findAllByUser(loggedIn));
		
		if(result.hasErrors()) {
 			System.out.println("Getting here?");
			return "skill.jsp";
		}
		if(srepo.findByName(skill.getName()) == null) {
			srepo.save(skill);
		}
		Skill thisSkill = srepo.findByName(skill.getName());
		
		if(loggedIn.getSkills().contains(thisSkill)) {
			model.addAttribute("skill", new Skill());
			model.addAttribute("error", "You already have this Skill");
			return "skill.jsp";
		}
		
		UserSkill usk = new UserSkill();
		usk.setUser(loggedIn);
		usk.setSkill(thisSkill);
		usrepo.save(usk);
		
		System.out.println(loggedIn.getSkills().size());
		
		return "redirect:/skill";
	}

//	@PostMapping("/skill/add")
//	public String addSkill(Model model, HttpSession session, @RequestParam("userSkill") Long sId) {
//			model.addAttribute("skill", new Skill());
//			Long id = (Long) session.getAttribute("user_id");
//			User loggedIn = urepo.findById(id).orElse(null);
//			Skill thisSkill = srepo.findById(sId).orElse(null);
//			List<UserSkill> usk = usrepo.findAllByUser(loggedIn);
//			UserSkill test = new UserSkill();
//			test.setUser(loggedIn);
//			test.setSkill(thisSkill);
//			usk.add(test);
//			usrepo.save(test);
//
//			return "redirect:/skill";
//		}
	
	@GetMapping("/skill/{skill_id}/delete")
	public String deleteSkill(Model model, HttpSession session, @PathVariable("skill_id") Long sId) {
		if (session.getAttribute("user_id") == null) {
			return "redirect:/login";
		} else if(urepo.findById((Long)session.getAttribute("user_id")).orElse(null).getName() == null) {
			return "redirect:/newcharacter";
		}
		User u = urepo.findById((Long)session.getAttribute("user_id")).orElse(null);
		Skill s = srepo.findById(sId).orElse(null);
		UserSkill thisUserSkill = usrepo.findByUserAndSkill(u, s);
//		UserSkill thisUserSkill = usrepo.findById(usId).orElse(null);
		usrepo.delete(thisUserSkill);
		return "redirect:/skill";
	}

//	**************************************************************

//	JON AND ASHLEY
//	============================================================== JOBS

	@GetMapping("/jobs")
	public String newJobForm(Model model, HttpSession session) {
		if (session.getAttribute("user_id") == null) {
			return "redirect:/login";
		} else if(urepo.findById((Long)session.getAttribute("user_id")).orElse(null).getName() == null) {
			return "redirect:/newcharacter";
		}
		Long id = (Long) session.getAttribute("user_id");
		User user = urepo.findById(id).orElse(null);
		List<Job> mylist = jrepo.findAll();
		mylist.sort((c1, c2) -> (int) c2.getCreatedAt().getTime() - (int) c1.getCreatedAt().getTime());
		model.addAttribute("job", new Job());
		model.addAttribute("game", new Game());
		model.addAttribute("jobs", jrepo.findAll(Sort.by("updatedAt").descending()));
		model.addAttribute("userJob", user.getJob());
		model.addAttribute("usersgame", user.getGame());
		model.addAttribute("user", user);
		
		return "jobs.jsp";
	}

	
	@GetMapping("/job/highpay")
	public String highPay(Model model, HttpSession session) {
		if (session.getAttribute("user_id") == null) {
			return "redirect:/login";
		} else if(urepo.findById((Long)session.getAttribute("user_id")).orElse(null).getName() == null) {
			return "redirect:/newcharacter";
		}
		Long id = (Long) session.getAttribute("user_id");
		User user = urepo.findById(id).orElse(null);
		model.addAttribute("job", new Job());
		model.addAttribute("game", new Game());
		List<Job> mylist = jrepo.findAll();
		mylist.sort((c1, c2) -> c2.getSalary() - c1.getSalary());
		model.addAttribute("jobs", mylist);
		model.addAttribute("userJob", user.getJob());
		model.addAttribute("usersgame", user.getGame());
		model.addAttribute("user", user);
		return "jobs.jsp";
	}
	
	@GetMapping("/job/lowpay")
	public String lowPay(Model model, HttpSession session) {
		if (session.getAttribute("user_id") == null) {
			return "redirect:/login";
		} else if(urepo.findById((Long)session.getAttribute("user_id")).orElse(null).getName() == null) {
			return "redirect:/newcharacter";
		}
		Long id = (Long) session.getAttribute("user_id");
		User user = urepo.findById(id).orElse(null);

		model.addAttribute("job", new Job());
		model.addAttribute("game", new Game());
		List<Job> mylist = jrepo.findAll();
		mylist.sort((c1, c2) -> c1.getSalary() - c2.getSalary());
		model.addAttribute("jobs", mylist);
		model.addAttribute("userJob", user.getJob());
		model.addAttribute("usersgame", user.getGame());
		model.addAttribute("user", user);
		return "jobs.jsp";
	}
	
	// we need a way to check if company already exists in the database if the user
	// is trying to create one
	@PostMapping("/jobs")
	public String doJobs(Model model, HttpSession session, @Valid @ModelAttribute("job") Job job,
			BindingResult result) {
		if (result.hasErrors()) {
			System.out.println("butts");
			Long id = (Long) session.getAttribute("user_id");
			User user = urepo.findById(id).orElse(null);

			model.addAttribute("game", new Game());
			model.addAttribute("jobs", jrepo.findAll());
			model.addAttribute("userJob", user.getJob());
			model.addAttribute("usersgame", user.getGame());
			model.addAttribute("user", user);
			return "jobs.jsp";

		} else {
			Long userid = (Long) session.getAttribute("user_id");
			User u = urepo.findById(userid).orElse(null);
			Game g = grepo.findById(u.getGame().getId()).orElse(null);
			System.out.println(g);
			Job j = jrepo.save(job);
			j.setGame(g);

			jrepo.save(j);

			return "redirect:/jobs";
		}
	}

	@PostMapping("/jobs/quit/{job_id}")
	public String quitJob(Model model, HttpSession session, @PathVariable("job_id") Long jId) {
		Long userid = (Long) session.getAttribute("user_id");
		User u = urepo.findById(userid).orElse(null);
//		Game g = grepo.findById(u.getGame().getId()).orElse(null);
		Job j = jrepo.findById(jId).orElse(null);
		u.setJob(null);
		u.setGame(null);
		urepo.save(u);
		j.getCharacters().remove(u);
		j.setUpdatedAt(new Date());
		jrepo.save(j);
		return "redirect:/jobs";
	}
	@PostMapping("/jobs/quit2/{job_id}")
	public String quitJob2(Model model, HttpSession session, @PathVariable("job_id") Long jId) {
		Long userid = (Long) session.getAttribute("user_id");
		User u = urepo.findById(userid).orElse(null);
		Game g = grepo.findById(u.getGame().getId()).orElse(null);
		Job j = jrepo.findById(jId).orElse(null);
		u.setJob(null);
		u.setGame(null);
		urepo.save(u);
		j.getCharacters().remove(u);
		j.setUpdatedAt(new Date());
		jrepo.save(j);
		return "redirect:/game/"+g.getId();
	}

	@PostMapping("/game")
	public String doGames(Model model, HttpSession session, @Valid @ModelAttribute("game") Game game, BindingResult result) {
		gvalid.validate(game, result);
		if (result.hasErrors()) {
			System.out.println(game.getId());
			model.addAttribute("job", new Job());
			model.addAttribute("jobs", jrepo.findAll());
			return "jobs.jsp";

		} else {
			User user = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
			// create game
			grepo.save(game);

			// create job
			Job job = new Job();
			job.setTitle("CEO");
			job.setDescription("Head honcho");
			job.setSalary(10);
			job.setMorality(true);
			job.setGame(game);
			List<User> userList = new ArrayList<User>();
			userList.add(user);
			job.setCharacters(userList);
			jrepo.save(job);

			// add game and job to user
			user.setGame(game);
			user.setJob(job);
			urepo.save(user);

			return "redirect:/jobs";
		}
	}
    
	@PostMapping("/apply/{job_id}")
	public String apply(@PathVariable("job_id") Long id, HttpSession session, Model model) {
		Job job = jrepo.findById(id).orElse(null);
		User user = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
		Game game = grepo.findById(job.getGame().getId()).orElse(null);
		user.setJob(job);
		user.setGame(game);
		urepo.save(user);
		return "redirect:/jobs";
	}
    
		
//		=======================Company==============================
		
		@GetMapping("/game/{game_id}")
		public String company(@PathVariable("game_id") Long id, HttpSession session, Model model) {
			if (session.getAttribute("user_id") == null) {
				return "redirect:/login";
			} else if(urepo.findById((Long)session.getAttribute("user_id")).orElse(null).getName() == null) {
			return "redirect:/newcharacter";
		}
			User user = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
			Game game= grepo.findById(id).orElse(null);
			Job job = jrepo.findByGameAndTitle(game, "ceo");
			List<Job> jobs = game.getJobs();
			jobs.sort((c1, c2) -> (int) c2.getUpdatedAt().getTime() - (int) c1.getUpdatedAt().getTime());
//			model.addAttribute("jobs", jrepo.findAll(Sort.by("updatedAt").descending()));
			model.addAttribute("jobs", jobs);
			model.addAttribute("user", user);
			model.addAttribute("lonk", urepo.findByEmail("lonk@lonkedin.com"));
			model.addAttribute("game", game);
			model.addAttribute("ceo", urepo.findByGameAndJob(game, job));
			model.addAttribute("employees", urepo.findAllByGame(game));
			
			int connections = 0;
			for(Job j : game.getJobs()) {
				if(j.getCharacters().size() > 0) {
					if(user.getFriends().contains(j.getCharacters().get(0))) {
						connections++;	
					}	
				}
			}
			model.addAttribute("connections", connections);
			
			return "company.jsp";
		}
		@PostMapping("/applyTwo/{job_id}")
		public String applyTwo(@PathVariable("job_id") Long id, HttpSession session, Model model){
			Job job= jrepo.findById(id).orElse(null);
			User user = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
			Game game = grepo.findById(job.getGame().getId()).orElse(null);
			user.setJob(job);
			user.setGame(game);
			urepo.save(user);
			return "redirect:/game/"+game.getId();
		}
		
//		==========================About=============================
		@GetMapping("/about")
		public String about(HttpSession session) {

			if (session.getAttribute("user_id") == null) {
				return "redirect:/login";
			} else if(urepo.findById((Long)session.getAttribute("user_id")).orElse(null).getName() == null) {
			return "redirect:/newcharacter";
		}

			return "about.jsp";
			
		}

    
//	**************************************************************

//	NO TOUCHY
//	============================================================== Login and Registration

	@GetMapping("/registration")
	public String registerUser(Model model) {
		model.addAttribute("user", new User());
		return "register.jsp";
	}

	@PostMapping("/registration")
	public String doRegisterUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
		uvalid.validate(user, result);
		if (result.hasErrors()) {
			System.out.println(user.getId());
			return "register.jsp";
		}
		
//	Create Lonk, Zorldo, and Goonanderp if they don't exist
		if (urepo.findByEmail("lonk@lonkedin.com") == null) {
			
			User lonk = new User();
			lonk.setName("Lonk");
			lonk.setUniverse("Hyrool");
			lonk.setEmail("lonk@lonkedin.com");
			lonk.setPicture("/images/lonk.jpg");
			lonk.setDescription("Hi, I'm Lonk. I was chosen by princess Zorldo to save Hyrool from the great evil Goonan. I've already saved the world dozens of times, but somehow it never seems to stick.");
			List<User> lonksFriends = new ArrayList<User>();
			lonk.setFriends(lonksFriends);
			urepo.save(lonk);
			
			User princess = new User();
			princess.setName("Princess Zorldo");
			princess.setUniverse("Hyrool");
			princess.setEmail("zorldo@lonkedin.com");
			princess.setPicture("/images/zorldo.png");
			princess.setDescription("Hi, I'm Princess Zorldo. I specialize in looking good, and needing to be saved from Goonan. I'm also a secret ninja.");
			List<User> princessFriends = new ArrayList<User>();
			princessFriends.add(lonk);
			princess.setFriends(princessFriends);
			urepo.save(princess);
			
			lonk.getFriends().add(princess);
			urepo.save(lonk);
			
			User goonan = new User();
			goonan.setName("Goonanderp");
			goonan.setUniverse("Hyrool");
			goonan.setEmail("goonan@lonkedin.com");
			goonan.setPicture("/images/goonan.png");
			goonan.setDescription("Lonk and Zorldo are jerks. I know I'm trying to kill them but they could at least accept my connection request. I'm trying to build my reputation here GAWL!");
			urepo.save(goonan);

			Game zorldo = new Game();
			zorldo.setName("The Legend of Zorldo");
			zorldo.setDescription("Save the princess");
			grepo.save(zorldo);

			Job lonkjob = new Job();
			lonkjob.setTitle("CEO");
			lonkjob.setDescription("Hero of the Game");
			lonkjob.setSalary(9999999);
			lonkjob.setMorality(true);
			lonkjob.setGame(zorldo);
			jrepo.save(lonkjob);
			
			Job zorldojob = new Job();
			zorldojob.setTitle("Princess");
			zorldojob.setDescription("Save me please!");
			zorldojob.setSalary(9999999);
			zorldojob.setMorality(true);
			zorldojob.setGame(zorldo);
			jrepo.save(zorldojob);
			
			Job goonanjob = new Job();
			goonanjob.setTitle("Last Boss");
			goonanjob.setDescription("Must kill Lonk");
			goonanjob.setSalary(9999999);
			goonanjob.setMorality(false);
			goonanjob.setGame(zorldo);
			jrepo.save(goonanjob);
			
			Skill swordfighter = new Skill();
			swordfighter.setName("Sword Fighter");
			swordfighter.setLevel(2);
			srepo.save(swordfighter);
			
			Skill stealth = new Skill();
			stealth.setName("Stealth");
			stealth.setLevel(2);
			srepo.save(stealth);
			
			Skill legs = new Skill();
			legs.setName("Strong Legs");
			legs.setLevel(2);
			srepo.save(legs);
			
//			Skill newb = new Skill();
//			newb.setName("Newbie");
//			newb.setLevel(0);
//			srepo.save(newb);
			
			UserSkill lonkSkill = new UserSkill();
			lonkSkill.setUser(lonk);
			lonkSkill.setSkill(swordfighter);
			lonkSkill.setCount(1000);
			usrepo.save(lonkSkill);
			
			UserSkill zorldoSkill = new UserSkill();
			zorldoSkill.setUser(princess);
			zorldoSkill.setSkill(stealth);
			zorldoSkill.setCount(1000);
			usrepo.save(zorldoSkill);
			
			UserSkill goonanSkill = new UserSkill();
			goonanSkill.setUser(goonan);
			goonanSkill.setSkill(legs);
			goonanSkill.setCount(-1000);
			usrepo.save(goonanSkill);
			
			Post welcome = new Post();
			welcome.setContent(
					"Welcome to LonkedIn, friend! Looking forward to getting to know you better! We're always looking for good people at The Legend of Zorldo, <a href='/game/1'> check out our Game page<a> to see if there are any new job listings!");
			welcome.setCreator(lonk);
			prepo.save(welcome);

			lonk.setGame(zorldo);
			lonk.setJob(lonkjob);
			princess.setGame(zorldo);
			princess.setJob(zorldojob);
			goonan.setGame(zorldo);
			goonan.setJob(goonanjob);
			
			urepo.save(lonk);
			urepo.save(princess);
			urepo.save(goonan);
		}
		
//	Create new user
		userv.registerUser(user);
		session.setAttribute("user_id", user.getId());
		return "redirect:/newcharacter";
	}

	@GetMapping("/")
	public String index() {
		return "redirect:/login";
	}

	@GetMapping("/login")
	public String login() {
		return "login.jsp";
	}

	@PostMapping("/login")
	public String doLogin(@RequestParam("email") String email, @RequestParam("password") String password, Model model,
			HttpSession session) {
		if (!userv.authenticateUser(email, password)) {
			model.addAttribute("error", "Incorrect email / password combination");
			return "login.jsp";
		}
		User user = urepo.findByEmail(email);
		session.setAttribute("user_id", user.getId());
		if (user.getName() == null) {
			return "redirect:/newcharacter";
		}
		session.setAttribute("defaultDisplayIndex", 4);
		return "redirect:/dashboard/" + user.getId();
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}

//	************************************************************** END	
}