<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<link rel="stylesheet" type="text/css" href="/css/skill.css">
	<script type="text/javascript" src="/js/app.js"></script>
</head>

<body>
	<div class="wrapper">

	<div class="wrapper searchResults">
	
		<div class="navwrapper navLI">
		
			<div class="nav">
				
				<div class="nav1">

					<p class="llogo">Lonked<span>in</span></p>
					<form action="/search" method="POST">
						<input class="search" name="search" type="text" placeholder="Search Users">
						<input class="searchSubmit" type="submit" value="Search" />
					</form>
				</div>
				<div class="nav2">
					<div class="icons">
						<a class="icon-box" href="/dashboard/${ sessionScope.user_id }">
							<img class="fafa" src="/images/home.png" alt="home" >
						</a>
						<a href="/jobs">
							<img class="icon-box fafa" src="/images/friendsI_Icon.jpg" alt="logo"  />
						</a>
						<a class="icon-box" href="/connections/${sessionScope.user_id}">
							<img class="fafa" src="/images/friends2.png" alt="friends"  />
						</a>
						<a class="icon-box" href="/skill">
							<img class="fafa" src="/images/chost.png" alt="friends"  />
						</a>
					</div>
				</div>
				<div class="nav3">
					<a class = "links" href="/dashboard/${ sessionScope.user_id }">Dashboard</a>
					<a class = "links" href="/logout">Lonkout</a>
				</div>
				
			</div>
			
		</div>

		<div class="navSpacer navLISpacer"></div>

		<!-- JOB FORMS -->

		<div class="skillForms"></div>


		<div class="col1 skillForm">
			<h2>Add a New Skill</h2>
			<p>
				<form:errors path="skill.*" />
			</p>
			
			<form:form class="form" action="/skill/add" method="post" modelAttribute="skill">
				<form:input class="input" list="characters" path="name" placeholder="Skill Name"></form:input>
				<datalist id="characters">
						<c:forEach var="skill" items="${allSkills}">
						<c:if test="${user.skills.contains(skill) ==false}">
							<option value="${skill.id}" label="${skill.name}">
						</c:if>
					</c:forEach>
				</datalist>
				<input type="submit" value="Create a Skill!" />
			</form:form>
		</div>

			<div>
			<h2>Your Skills</h2>
					<c:forEach items="${user.skills}" var="uskill">
						<p>${uskill.name}</p>
					</c:forEach>
			</div>
		</div>

	</div>
</body>

</html>