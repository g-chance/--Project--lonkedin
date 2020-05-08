<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Jobs</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<link rel="stylesheet" type="text/css" href="/css/jobs.css" media="screen" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript" src="/js/app.js"></script>
</head>

<body>
	<div class="wrapper">

		<div class="navwrapper navLI">
		
			<div class="nav">

				<div class="nav1">

					<p class="llogo">
						Lonked<span>in</span>
					</p>
					<form class="searchForm" action="/search" method="POST">
						<input class="search" name="search" type="text"
							placeholder="Search Users"> 
						<input class="searchSubmit"
							type="submit" value="Search" />
					</form>
				</div>
				<div class="nav2 smHide">
					<div class="icons">
						<a class="icon-box" href="/dashboard/${ sessionScope.user_id }">
							<img class="fafa" src="/images/home.png" alt="home">
						</a> <a href="/jobs"> <img class="icon-box fafa"
							src="/images/friendsI_Icon.jpg" alt="logo" />
						</a> <a class="icon-box" href="/connections/${sessionScope.user_id}">
							<img class="fafa" src="/images/friends2.png" alt="friends" />
						</a> <a class="icon-box" href="/skill"> <img class="fafa"
							src="/images/chost.png" alt="friends" />
						</a>
					</div>
				</div>
				<div class="nav3 smHide">
					<a class="links logout" href="/logout">Lonkout</a>
				</div>
				
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

		<!-- JOB FORMS -->
		

		<!-- JOB LISTINGS -->
		<div class="jobListings">
			<!-- For loops for displaying current available jobs -->
			<h1 class="aboutHeader">About Us...</h1>
			<h3>Our Vision</h3>
			<p>Here at LonkedIn, our mission is to connect people from 
			across all the multiverse, and build a community of lonkified game characters. We look 
			to create a network of good and bad guys that together, work in harmony to 
			produce the gaming experience that ours users have come to expect. 
			Founded in 2020 by a small group Coding Ninjas, 
			LonkedIn is a 501(3)C Non-Profit guided by a volunteer based council. </p>
			<h1>FAQs</h1>
			<h3>Connections</h3>
			<p>Q:How do I add a connection?</p>
			<p>A:</p>
			<p>Q:How do I add an enemy?</p>
			<p>A:</p>
			<h3>Jobs</h3>
			<p>Q:How do I apply for a job?</p>
			<p>A:</p>
			<p>Q:How do I create a new job?</p>
			<p>A:</p>
			<p>Q:How do I become the CEO of a game?</p>
			<p>A:</p>
			
			<h3>Skills</h3>
			<p>Q:How do I add a skill to my profile?</p>
			<p>A:</p>
			<p>Q:Can I have multiple skills?</p>
			<p>A:</p>
			<p>Q:How do I Endorese or Discredit another character's skills?</p>
			<p>A:</p>
			
			
		</div>
	</div>
</body>

</html>