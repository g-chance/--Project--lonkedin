<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Skills</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<link rel="stylesheet" type="text/css" href="/css/skill.css">
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
					<a class="links faq" href="/about">FAQ</a>
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

		<div class="skillMain">
			<div class="col1 skillForm">
				<h1 class="header">Add a New Skill</h1>
				<p class="error">
					${ error }
					<form:errors path="skill.*" />
				</p>
				<form:form class="form" action="/skill/new2" method="post" modelAttribute="skill">
					<form:input class="input" list="characters" path="name" placeholder="Skill Name"></form:input>
					<p><input type="submit" value="Add Skill" class="submit" /></p>
				</form:form>
			</div>
			<div class="yourSkills">
				<h2>Manage Skills</h2>
				<c:forEach items="${user.skills}" var="skill">
					<p>${skill.name} <a href="/skill/${skill.id}/delete">Remove</a></p>
				</c:forEach>
			</div>
		</div>
	</div>
</body>

</html>