package com.wabdavinc.lonkedin.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.wabdavinc.lonkedin.models.User;
import com.wabdavinc.lonkedin.repositories.GameRepo;
import com.wabdavinc.lonkedin.repositories.JobRepo;
import com.wabdavinc.lonkedin.repositories.PostRepo;
import com.wabdavinc.lonkedin.repositories.SkillRepo;
import com.wabdavinc.lonkedin.repositories.UserRepo;
import com.wabdavinc.lonkedin.services.UserServ;
import com.wabdavinc.lonkedin.validator.UserValidator;

@Controller
//@RequestMapping("/lonkedin")
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
	
	@GetMapping("/dashboard")
	public String dashboard(HttpSession session, Model model) {
		if(session.getAttribute("user_id") == null) {
			return "redirect:/lonkedin/registration";
		}
		Long id = (Long) session.getAttribute("user_id");
		model.addAttribute("user",urepo.findById(id).orElse(null));
		return "dashboard.jsp";
	}
	
	
//	Login and Registration
	
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
		return "redirect:/dashboard";
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
		return "redirect:/dashboard";
	}
	@GetMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
	
}
