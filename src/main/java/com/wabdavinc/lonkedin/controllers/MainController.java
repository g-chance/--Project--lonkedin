package com.wabdavinc.lonkedin.controllers;

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
	
	@GetMapping("newcharacter")
	public String newCharacter(Model model, HttpSession session) {
		model.addAttribute("user", urepo.findById((Long)session.getAttribute("user_id")).orElse(null));
		return "newCharacter.jsp";
	}
	
	
//	**************************************************************
	
//	VERNNON AND CHRISTINE
//	============================================================== Dashboard
	
	@GetMapping("/dashboard")
	public String dashboard(HttpSession session, Model model) {
		if(session.getAttribute("user_id") == null) {
			return "redirect:/lonkedin/registration";
		}
		Long id = (Long) session.getAttribute("user_id");
		model.addAttribute("user",urepo.findById(id).orElse(null));
		return "dashboard.jsp";
	}
	
	
//	**************************************************************
	
//	VERNON
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
		//TODO: ERROR HANDILING TO SAY IF THEY ARE AN ENEMY
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
		//TODO: ERROR HANDILING TO SAY IF THEY ARE AN ENEMY
		return "redirect:/connections/" + id;
	}
	
//	**************************************************************
	
//	JON AND ASHLEY
//	============================================================== JOBS
	
	@GetMapping("/jobs")
	public String newJobForm(Model model, HttpSession session) {
		Long id = (Long) session.getAttribute("user_id");
		model.addAttribute("job", new Job());
		model.addAttribute("game", new Game());
		model.addAttribute("jobs", jrepo.findAll());
		return "jobs.jsp";
	}
	//we need a way to check if company already exists in the database if the user is trying to create one 
	@PostMapping("/jobs")
	public String doJobs(Model model, HttpSession session, @Valid @ModelAttribute("job")Job job,BindingResult result) {
		if(result.hasErrors()) {
			model.addAttribute("jobs", jrepo.findAll());
            return "jobs.jsp";
          
        }else{

			Long userid=(Long) session.getAttribute("userid");
			User u =urepo.findById(userid).orElse(null);
			jrepo.save(job);
			return "redirect:/jobs";
			}
		} 
	
	@PostMapping("/game")
	public String doGames(Model model, HttpSession session, @Valid @ModelAttribute("game")Game game,BindingResult result) {
		if(result.hasErrors()) {
			model.addAttribute("game", grepo.findAll());
            return "jobs.jsp";
          
        }else{

			Long userid=(Long) session.getAttribute("userid");
			User u =urepo.findById(userid).orElse(null);
			grepo.save(game);
			return "redirect:/jobs";
			}
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
			return "register.jsp";
		}
		userv.registerUser(user);
		session.setAttribute("user_id", user.getId());
		return "redirect:/newcharacter";
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