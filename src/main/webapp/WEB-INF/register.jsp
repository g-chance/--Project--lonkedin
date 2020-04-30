<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Page</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<script type="text/javascript" src="/js/app.js"></script>
</head>
<body>

	<div class="wrapper">
	
		<div class="nav">
		
			<div class="nav1">
				<h1>Register!</h1>
			</div>
			<div class="nav2">
				<a href="/logout">Logout</a>
			</div>
			
		</div>	    
		
		<div class="registration">
			<h1 class="welcome">Welcome, Character!</h1>
			<p class="blurb">As you're now aware, a rip in the space-time continuum has caused video game characters such as yourself to begin pouring in to the Milky Way Universe from all manner of different Universes in the grand Multiverse. As such, we at LonkedIn decided to create this tool to help you connect with your alternate versions of yourselves and friends. We know you want to get back to work as a character, so sign up now, connect, and get back to work in your Game today!</p>
		
			<p><form:errors path="user.*"/></p>
			<form:form class="form" method="POST" action="/registration" modelAttribute="user">
<%-- 				<p>
					<form:label path="email">Email:</form:label> --%>
					<form:input class="input" type="email" path="email" placeholder="Email"/>
				<!-- </p> -->
<!-- 				<p> -->
<%-- 					<form:label path="password">Password:</form:label> --%>
					<form:password class="input" path="password" placeholder="Password"/>
<%-- 				</p>
				<p>
					<form:label path="confirmPassword">Confirm Password:</form:label> --%>
					<form:password class="input" path="confirmPassword" placeholder="Confirm Password"/>
<!-- 				</p> -->
				<input class="input submit" type="submit" value="Register!"/>
			</form:form>
			
			<p class="already">Already have an account? <a href="/login">Login</a></p>
		</div>
    </div>
    
</body>
</html>