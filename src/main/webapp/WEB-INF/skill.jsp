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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript" src="/js/app.js"></script>
</head>

<body>
	<div class="wrapper">

		<div class="wrapper searchResults">
	
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
								<img class="fafa" src="/images/home.png" alt="home"  title="Home">
							</a> <a href="/jobs"> <img class="icon-box fafa"
								src="/images/friendsI_Icon.jpg" alt="logo" title="Jobs"/>
							</a> <a class="icon-box" href="/connections/${sessionScope.user_id}">
								<img class="fafa" src="/images/friends2.png" alt="friends" title="Friends"/>
							</a> <a class="icon-box" href="/skill"> <img class="fafa"
								src="/images/chost.png" alt="skills" title="Skills" />
							</a>
						</div>
					</div>
					<div class="nav3 smHide">
						<a class="links faq" href="/about">FAQ</a>
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

			<div class="skillMain">


				<div class="col1 skillForm">
					<h1 class="header">Add a New Skill</h1>
		<%-- 			<form class="form" action="/skill/add" method="post">
								<select name = "userSkill" class="input">
								<c:forEach var="skill" items="${allSkills}">
								<c:if test="${user.skills.contains(skill) ==false}">
									<option value="${skill.id}" label="${skill.name}"> 
								</c:if>
							</c:forEach>
							</select>
									<p><input type="submit" value="Add from Skill Pool" class="submit" /></p>
					
						</form> --%>
						
		<%-- 			<form:form class="form" action="/skill/new" method="post" modelAttribute="skill">
						<form:input class="input" path="name" placeholder="Can't find the skill? Create One here!"></form:input>
						<p><input type="submit" value="Create and Add a New Skill" class="submit"/></p>
					</form:form> --%>
					<p class="error">
						${ error }
						<form:errors path="skill.*" />
					</p>
					<form:form class="form" action="/skill/new2" method="post" modelAttribute="skill">
						<form:input class="input" list="characters" path="name" placeholder="Skill Name"></form:input>
		<!-- 				<datalist id="characters">
							AXIOS API RESULT DISPLAYED HERE
						</datalist> -->
						<p><input type="submit" value="Add Skill" class="submit"/></p>
					</form:form>
		
				</div>

				<div class="yourSkills">
					<h2>Manage Skills</h2>
						<c:forEach items="${user.skills}" var="skill">
					<p>${skill.name}  <a href="/skill/${skill.id}/delete">Remove</a></p>
						</c:forEach>
				</div>
			</div>

		</div>
	</div>
</body>

</html>