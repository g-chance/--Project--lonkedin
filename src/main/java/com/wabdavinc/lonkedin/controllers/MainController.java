package com.wabdavinc.lonkedin.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

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
import com.wabdavinc.lonkedin.repositories.GameRepo;
import com.wabdavinc.lonkedin.repositories.JobRepo;
import com.wabdavinc.lonkedin.repositories.PostRepo;
import com.wabdavinc.lonkedin.repositories.SkillRepo;
import com.wabdavinc.lonkedin.repositories.UserRepo;
import com.wabdavinc.lonkedin.services.UserServ;
import com.wabdavinc.lonkedin.validator.UserValidator;

@Controller
public class MainController {

	private final UserRepo urepo;
	private final UserServ userv;
	private final UserValidator uvalid;
	private final GameRepo grepo;
	private final JobRepo jrepo;
	private final PostRepo prepo;
	private final SkillRepo srepo;
	
	public MainController(
			UserRepo urepo,
			UserServ userv,
			UserValidator uvalid,
			GameRepo grepo,
			JobRepo jrepo,
			PostRepo prepo,
			SkillRepo srepo
			) {
		this.urepo = urepo;
		this.userv = userv;
		this.uvalid = uvalid;
		this.grepo = grepo;
		this.jrepo = jrepo;
		this.prepo = prepo;
		this.srepo = srepo;
	}
	
	
//	GREG
//	============================================================== Create Character
	
	@GetMapping("/newcharacter")
	public String newCharacter(Model model, HttpSession session) {
		model.addAttribute("user", urepo.findById((Long)session.getAttribute("user_id")).orElse(null));
		return "newCharacter.jsp";
	}
	
	@PostMapping("/newcharacter")
	public String doNewCharacter(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
		uvalid.validate(user, result);
		if(result.hasErrors()) {
			return "newCharacter.jsp";
		}
		User u = urepo.findById((Long)session.getAttribute("user_id")).orElse(null);
		u.setName(user.getName());
		u.setUniverse(user.getUniverse());
		u.setPicture(user.getPicture());
		urepo.save(u);
		return("redirect:/dashboard");
	}
	
	
//	**************************************************************
	
//	GREG
//	============================================================== Dashboard
	
	@GetMapping("/dashboard")
	public String dashboard(HttpSession session, Model model) {
		if(session.getAttribute("user_id") == null) {
			return "redirect:/registration";
		}
		Long id = (Long) session.getAttribute("user_id");
		User user = urepo.findById(id).orElse(null);
		model.addAttribute("user",user);
		ArrayList<User> friends = new ArrayList<User>();
		if(user.getFriends().size() != 0) {
			for(int i=0;i<user.getFriends().size();i++) {
				friends.add(user.getFriends().get(i));
			}	
		}
		ArrayList<User> enemies = new ArrayList<User>();
		if(user.getEnemies().size() != 0) {
			for(int i=0;i<5;i++) {
				enemies.add(user.getEnemies().get(i));
			}	
		}
		String[] myArr;
		for(User friend : user.getFriends()) {
			friend.getPosts().size();
		}
//		user.getFriends().add(urepo.findByEmail("secondfall@gmail.com"));
//		urepo.save(user);
//		for(int i=0;i<user.getFriends().size();i++) {
//			System.out.println(user.getFriends().size());
//			System.out.println(user.getName());
//		}
		model.addAttribute("friends", user.getFriends());
		System.out.println(user.getFriends());
		model.addAttribute("enemies", enemies);
		model.addAttribute("posts",prepo.findAll());
		model.addAttribute("post", new Post());
		model.addAttribute("friendRequests", user.getFriendRequests());
		// List <User> connections = urepo.findAll();
		// model.addAttribute("user",urepo.findById(id).orElse(null));
		// model.addAttribute("connections",connections);
		return "dashboard.jsp";
	}
	
	@PostMapping("/newpost")
	public String newPost(@Valid @ModelAttribute("post") Post post, BindingResult result, Model model, HttpSession session) {
		if(result.hasErrors()) {
			User user = urepo.findById((Long)session.getAttribute("user_id")).orElse(null);
			model.addAttribute("user", user);
			return "dashboard.jsp";
		}
		prepo.save(post);
		return "redirect:/dashboard";
	}
	
	@PostMapping("/search")
	public String search(@RequestParam("search") String str, Model model, HttpSession session) {
		List<User> searchResults = urepo.findByNameContaining(str);
		for(int i=0;i<urepo.findByNameContaining(str).size();i++) {
			System.out.println(urepo.findByNameContaining(str).get(i).getName());
		}
		System.out.println(searchResults);
		model.addAttribute("searchResults", urepo.findByNameContaining(str));
		User u = urepo.findById((Long)session.getAttribute("user_id")).orElse(null);
		model.addAttribute("user", u);
		model.addAttribute("friends", u.getFriends());
		return "searchResults.jsp";
	}
	
	@PostMapping("/accept/{user_id}")
	public String accept(@PathVariable("user_id") Long id, HttpSession session) {
		User u = urepo.findById((Long)session.getAttribute("user_id")).orElse(null);
		User friend = urepo.findById(id).orElse(null);
		u.getFriends().add(friend);
		u.getFriendRequests().remove(friend);
		urepo.save(u);
		return "redirect:/dashboard";
	}
	@PostMapping("/reject/{user_id}")
	public String reject(@PathVariable("user_id") Long id, HttpSession session) {
		User u = urepo.findById((Long)session.getAttribute("user_id")).orElse(null);
		User friend = urepo.findById(id).orElse(null);
		u.getFriendRequests().remove(friend);
		urepo.save(u);
		return "redirect:/dashboard";
	}
	
//	============================================================== searchResults
	
	@GetMapping("/requestConnection/{userid}")
	public String requestConnection(@PathVariable("userid") Long connectionID, HttpSession session) {
		User connection = urepo.findById(connectionID).orElse(null);
		User user = urepo.findById((Long)session.getAttribute("user_id")).orElse(null);
//		System.out.println(connection.getName());
//		System.out.println(user.getName());
		System.out.println(connection.getFriendRequests());
		System.out.println(connection.getFriendRequests().size());
		if(connection.getFriendRequests().contains(user)) {
			return "redirect:/dashboard";
		}
		connection.getFriendRequests().add(user);
		urepo.save(connection);
		System.out.println(connection.getFriendRequests().size());
		return "redirect:/dashboard";
	}
	
//	**************************************************************
	
	
//	VERNON AND 
//	============================================================== Connections
	
	@GetMapping("/connections/{user_id}")
	public String connections(@PathVariable("user_id") Long uId,  HttpSession session, Model model){
		Long id = (Long) session.getAttribute("user_id");
		User loggedIn = urepo.findById(id).orElse(null);
		loggedIn.getFriends().sort((u1,u2)->u1.getEmail().compareTo(u2.getEmail()));
		model.addAttribute("user",loggedIn);
		return "connections.jsp";
	}
//
	@GetMapping("/friend/{user_id}")
	public String addFriend(@PathVariable("user_id")Long fId, HttpSession session) {
		Long id = (Long) session.getAttribute("user_id");
		User loggedIn = urepo.findById(id).orElse(null);
//		Two lines above give us the user id and the User object
		User friend = urepo.findById(fId).orElse(null);
		if(loggedIn.getFriends().contains(friend)== false && loggedIn.getEnemies().contains(friend)== false ) {
			loggedIn.getFriends().add(friend);
			urepo.save(loggedIn);
			friend.getFriends().add(loggedIn);
			urepo.save(friend);
		}
		//TODO: ERROR HANDILING TO SAY IF THEY ARE AN ENEMY
		return "redirect:/connections/" + id;
	}
	
	@GetMapping("/friend/{user_id}/remove")
	public String removeFriend(@PathVariable("user_id")Long fId, HttpSession session) {
		Long id = (Long) session.getAttribute("user_id");
		User loggedIn = urepo.findById(id).orElse(null);
//		Two lines above give us the user id and the User object
		User friend = urepo.findById(fId).orElse(null);
		if(loggedIn.getFriends().contains(friend)) {
			loggedIn.getFriends().remove(friend);
			urepo.save(loggedIn);
			friend.getFriends().remove(loggedIn);
			urepo.save(friend);
		}
		//TODO: ERROR HANDILING TO SAY IF THEY ARE AN ENEMY
		return "redirect:/connections/" + id;
	}
	
	@GetMapping("/enemy/{user_id}")
	public String addEnemy(@PathVariable("user_id")Long fId, HttpSession session) {
		Long id = (Long) session.getAttribute("user_id");
		User loggedIn = urepo.findById(id).orElse(null);
//		Two lines above give us the user id and the User object
		User enemy = urepo.findById(fId).orElse(null);
		if(loggedIn.getFriends().contains(enemy)== false && loggedIn.getEnemies().contains(enemy)== false ) {
			loggedIn.getEnemies().add(enemy);
			urepo.save(loggedIn);
			enemy.getEnemies().add(loggedIn);
			urepo.save(enemy);
		}
		//TODO: ERROR HANDILING TO SAY IF THEY ARE A FRIEND
		return "redirect:/connections/" + id;
	}
	
	@GetMapping("/enemy/{user_id}/remove")
	public String removeEnemy(@PathVariable("user_id")Long fId, HttpSession session) {
		Long id = (Long) session.getAttribute("user_id");
		User loggedIn = urepo.findById(id).orElse(null);
//		Two lines above give us the user id and the User object
		User enemy = urepo.findById(fId).orElse(null);
		if(loggedIn.getEnemies().contains(enemy)) {
			loggedIn.getEnemies().remove(enemy);
			urepo.save(loggedIn);
			enemy.getEnemies().remove(loggedIn);
			urepo.save(enemy);
		}
		//TODO: ERROR HANDILING TO SAY IF THEY ARE A FRIEND
		return "redirect:/connections/" + id;
	}
	
	@GetMapping("/skill")
	public String newSkill(Model model, HttpSession session) {
		Long id = (Long) session.getAttribute("user_id");
		model.addAttribute("skill", new Skill());
		model.addAttribute("allSkills", srepo.findAll());
		model.addAttribute("user",urepo.findById(id).orElse(null));
		return "skill.jsp";
	}
	
	@PostMapping("/skill/new")
	public String submitSkill(@Valid @ModelAttribute("skill") Skill skill, 
			BindingResult result, Model model, HttpSession session
			) {
		model.addAttribute("skill", new Skill());
		if(result.hasErrors()) {
			return "skill.jsp";
		}
		//Add Validator to prevent duplicate skills later
		else {
			srepo.save(skill);
		}
		return "redirect:/dashboard";
		
		
	}
	
	@PostMapping("/skill/add")
	public String addSkill(@Valid @ModelAttribute("skill") Skill skill, 
			BindingResult result, Model model, HttpSession session, @RequestParam("userSkill") Long sId) {
		model.addAttribute("skill", new Skill());
		if(result.hasErrors()) {
			return "skill.jsp";
		}else {
			Long id = (Long) session.getAttribute("user_id");
			User loggedIn = urepo.findById(id).orElse(null);
			Skill thisSkill =srepo.findById(sId).orElse(null);
			loggedIn.getSkills().add(thisSkill);
			urepo.save(loggedIn);
		}
		return "redirect:/dashboard";
		
		
	}
	
	
	
//	**************************************************************
	
//	JON AND ASHLEY
//	============================================================== JOBS
	
	@GetMapping("/jobs")
	public String newJobForm(Model model, HttpSession session) {
		Long id = (Long) session.getAttribute("user_id");
		User user= urepo.findById(id).orElse(null);
		 
		model.addAttribute("job", new Job());
		model.addAttribute("game", new Game());
		model.addAttribute("jobs", jrepo.findAll());
		model.addAttribute("userJob",user.getJob());
		model.addAttribute("usersgame", user.getGame());
		model.addAttribute("user", user);
		return "jobs.jsp";
	}
	

	//we need a way to check if company already exists in the database if the user is trying to create one 
	@PostMapping("/jobs")
	public String doJobs(Model model, HttpSession session, @Valid @ModelAttribute("job")Job job,BindingResult result) {
		if(result.hasErrors()) {
			model.addAttribute("game", new Game());
			model.addAttribute("job", new Job());
			model.addAttribute("jobs", jrepo.findAll());
			return "jobs.jsp";
          
        }else{
        	Long userid=(Long) session.getAttribute("user_id");
			User u =urepo.findById(userid).orElse(null);
			Game g = grepo.findById(u.getGame().getId()).orElse(null);
			System.out.println(g);
			Job j = jrepo.save(job);
			j.setGame(g);
			
			jrepo.save(j);

			return "redirect:/jobs";
			}
		} 
	
	@PostMapping("/jobs/quit/{job_id}")
	public String quitJob(Model model, HttpSession session, @PathVariable("job_id") Long jId){
		Long userid=(Long) session.getAttribute("user_id");
		User u =urepo.findById(userid).orElse(null);
		Game g = grepo.findById(u.getGame().getId()).orElse(null);
		Job j =jrepo.findById(jId).orElse(null);
		u.setJob(null);
		u.setGame(null);
		urepo.save(u);
		j.getCharacters().remove(u);
		jrepo.save(j);
		return "redirect:/jobs";
	}

	@PostMapping("/game")
	public String doGames(Model model, HttpSession session, @Valid @ModelAttribute("game")Game game,BindingResult result) {
		if(result.hasErrors()) {
			System.out.println(game.getId());
			model.addAttribute("job", new Job());
			model.addAttribute("jobs", jrepo.findAll());
            return "jobs.jsp";
          
        } else {
			// create game
			grepo.save(game);

			// create job
			Job job = new Job();
			job.setTitle("CEO");
			job.setDescription("Head honcho");
			job.setSalary(10);
			job.setMorality(true);
			job.setGame(game);
			jrepo.save(job);

			// add game and job to user
			User user = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
			user.setGame(game);
			user.setJob(job);
			urepo.save(user);

			return "redirect:/jobs";
			}
		} 

		@PostMapping("/apply/{job_id}")
		public String apply(@PathVariable("job_id") Long id, HttpSession session, Model model){
			Job job= jrepo.findById(id).orElse(null);
			User user = urepo.findById((Long) session.getAttribute("user_id")).orElse(null);
			Game game = grepo.findById(job.getGame().getId()).orElse(null);
			user.setJob(job);
			user.setGame(game);
			urepo.save(user);
			return "redirect:/jobs";
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
		if(result.hasErrors()) {
			System.out.println(user.getId());
			return "register.jsp";
		}
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
	public String doLogin(@RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session) {
		if(!userv.authenticateUser(email, password)) {
			model.addAttribute("error", "Incorrect email / password combination");
			return "login.jsp";	
		}
		User user = urepo.findByEmail(email);
		session.setAttribute("user_id", user.getId());
		if(user.getName() == null) {
			return "redirect:/newcharacter";
		}
		return "redirect:/dashboard";
	}
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
	
	
//	************************************************************** END	
}