<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>About</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<link rel="stylesheet" type="text/css" href="/css/about.css" media="screen" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript" src="/js/app.js"></script>

</head>

<body>
	<div class="wrapper">
	
	<!-- NAV -->
		<div class="navwrapper navLI">
			<div class="nav">
				<div class="nav1">
					<p class="llogo">
						Lonked<span>in</span>
					</p>
					<form class="searchForm" action="/search" method="POST">
						<input class="search" name="search" type="text" placeholder="Search Users">
						<input class="searchSubmit" type="submit" value="Search" />
					</form>
				</div>
				<div class="nav2 smHide">
					<div class="icons">
						<a class="icon-box" href="/dashboard/${ sessionScope.user_id }">
							<img class="fafa" src="/images/home.png" alt="home" title="Home">
						</a> 
						<a class="icon-box" href="/jobs"> 
							<img class="fafa job" src="/images/briefcase.png" alt="logo" title="Jobs" />
						</a> 
						<a class="icon-box" href="/connections/${sessionScope.user_id}">
							<img class="fafa" src="/images/friends2.png" alt="friends" title="Connections" />
						</a> 
						<a class="icon-box" href="/skill"> 
							<img class="fafa skill" src="/images/skill.png" alt="skills" title="Skills" />
						</a>
					</div>
				</div>
				<div class="nav3 smHide">
					<a class="links logout" href="/logout">Lonkout</a>
				</div>
			<!-- NAV DROPDOWN -->
				<div class="dropdown lgHide">
					<div class="hamburger">
						<div></div>
						<div></div>
						<div></div>
					</div>
					<div class="ddlinks">
						<a class="ddlink" href="/dashboard/${ sessionScope.user_id }">Dashboard</a>
						<a class="ddlink" href="/jobs">Jobs</a>
						<a class="ddlink" href="/connections/${sessionScope.user_id}">Connections</a>
						<a class="ddlink" href="/skill">Skills</a>
						<a class="ddlink" href="/about">FAQ</a>
						<a class="ddlink" href="/logout">Lonkout</a>
					</div>
				</div>
			</div>
		</div>

		<div class="navSpacer"></div>

		<div class="about">
			<div class="jobListings">
				<h1 class="header">About Us...</h1>
				<h2>Our Vision</h2>
				<p class="lonkquote"> "Here at LonkedIn, our mission is to connect people from
					across all the multiverse, and build a community of lonkified game characters. We look
					to create a network of good and bad guys that together, work in harmony to
					produce the gaming experience that ours users have come to expect." <span> -Lonk (Hyrool)</span>
				</p>
				<p class="busblurb">Founded in 2020 by a small group of Coding Ninjas,
					LonkedIn is a 501(3)C Non-Profit guided by a volunteer based council. </p>

				<h1>FAQs</h1>
				<h2>Connections</h2>
				<div class="QA">
					<p><span class="bold">Q:</span> How do I add a connection?</p>
					<p><span class="bold">A:</span> Using the connections icon on the navigation bar, you can visit the
						connections page where
						you can search for characters you choose to connect with. Once you send a connections request,
						the requested character with have a choice to either accept or reject the request.
					</p>
				</div>
				<div class="QA">
					<p><span class="bold">Q:</span> What if I don't know how to spell the character's name correctly?
					</p>
					<p><span class="bold">A:</span> You can enter part of the characters name, and it will find all the
						characters
						containing the partial search.
					</p>
				</div>
				<div class="QA">
					<p><span class="bold">Q:</span> Who are my enemies?</p>
					<p><span class="bold">A:</span> When you decide to apply for a job, that job has a morality of
						either good or bad. If your job morality
						does not match a characters job morality, you will automatically become enemies. Enemies do not
						have to be
						a connection, but you can choose to become a connection with enemies.
					</p>
				</div>

				<h2>Jobs</h2>
				<div class="QA">
					<p><span class="bold">Q:</span> How do I become the CEO of a game?</p>
					<p><span class="bold">A:</span> To become the CEO of a game, can either apply for an open CEO
						position, or create a new game automatically becoming the CEO.
						Once you become the CEO, you can create new jobs for others to apply for.
						Only CEOs have the ability to create new jobs for a given game.
					</p>
				</div>
				<div class="QA">
					<p><span class="bold">Q:</span> How do I apply for a job?</p>
					<p><span class="bold">A:</span> Using the navigation bar, click on jobs icon to view job listings to
						view available positions at various games in the multiverse.
						You can view the job's title, description, salary, and morality. If you currently have a job,
						you will
						not be able to apply for a new job. Your current job is displayed on the jobs listing page, and
						you have the option
						to quit your current job, allowing you to apply for another position.
					</p>
				</div>
				<div class="QA">
					<p><span class="bold">Q:</span> How do I create a new job?</p>
					<p><span class="bold">A:</span> Only CEOs can create new jobs for others to apply for. You can
						become a CEO by either applying for an open CEO
						position, or creating a new game. Once you create a new game, you will automatically become the
						CEO.
					</p>
				</div>
				<div class="QA">
					<p><span class="bold">Q:</span> How do I quit my current job?</p>
					<p><span class="bold">A:</span> You can quit your current job on the jobs listing page using the
						quit button. Once you have quit your job,
						you will become unemployed, and be able to apply for any open position in the multiverse. </p>
				</div>

				<h2>Skills</h2>
				<div class="QA">
					<p><span class="bold">Q:</span> How do I add a skill to my profile?</p>
					<p><span class="bold">A:</span> Using the navigation bar, click on the skills icon to visit the
						skills page. You can add skills that others have
						entered into the skills pool, or create a new skill which will automatically add that skill to
						your profile.
					</p>
				</div>
				<div class="QA">
					<p><span class="bold">Q:</span> Can I have multiple skills?</p>
					<p><span class="bold">A:</span> Yes. You can add multiple skills to your profile as you acquire
						them. These can be skills you have created, or a skill added
						from the skill pool.
					</p>
				</div>
				<div class="QA">
					<p><span class="bold">Q:</span> What is my skill level?</p>
					<p><span class="bold">A:</span> Your skill level is based upon how many endorsements or attacks
						other characters have placed on
						a particular skill you have acquired. Only characters with matching moralities can endorse a
						kill. Only characters with
						opposing moralities can attack a skill.
					</p>
				</div>
				<div class="QA">
					<p><span class="bold">Q:</span> How do I Endorse or Attack another character's skills?</p>
					<p><span class="bold">A:</span> To endorse a character's skill, you can visit their profile page,
						and click endorse next to the selected skill.
						You can only endorse skills of a character that have the same morality as yourself. If you do
						not have matching moralities,
						you can attack that character's skill, allowing others to see that charater's skill level.
					</p>
				</div>

				<h2>Feed</h2>
				<div class="QA">
					<p><span class="bold">Q:</span> What is displayed on my feed?</p>
					<p><span class="bold">A:</span> The feed will display posts from other characters, recent job
						listings, and the newest games. You can contribute
						to this feed with a post, creating a new job or game.
					</p>
				</div>
				<div class="QA">
					<p><span class="bold">Q:</span> How do I create a post?</p>
					<p><span class="bold">A:</span> Using the home icon on the navigation bar, you can enter a post into
						the feed for others to see.
					</p>
				</div>
				<div class="QA">
					<p><span class="bold">Q:</span> Who can see my posts?</p>
					<p><span class="bold">A:</span> The feed displays posts from all characters in the multiverse.
						Everyone can see everyone's posts.</p>
				</div>
			</div>
		</div>
	</div>
</body>

</html>