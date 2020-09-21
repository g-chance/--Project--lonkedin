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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript" src="/js/app.js"></script>
</head>
<body>

	<div class="wrapper">
		<div class="navwrapper">
			<div class="nav">
				<div class="nav1">
					<p class="llogo">Lonked<span>in</span></p>
				</div>
				<div class="nav2"></div>
				<div class="nav3"></div>
			</div>
		</div>	
		
		<div class="navSpacer"></div>    
		
		<div class="regLog">
			<h1 class="welcome">Welcome, Character!</h1>
			<p class="blurb">As you're now aware, a rip in the space-time continuum has caused video game characters such as yourself to begin pouring into Hyrool from all manner of different Universes in the grand Multiverse. As such, we at LonkedIn decided to create this tool to help you connect with your alternate versions of yourselves and friends. We know you want to get back to work as a character, so sign up now, connect, and get back to work in your Game today!</p>
		
			<p class="error"><form:errors path="user.*"/></p>
			<form:form class="form" method="POST" action="/registration" modelAttribute="user">
					<form:input class="input" type="email" path="email" placeholder="Email"/>
					<form:password class="input" path="password" placeholder="Password"/>
					<form:password class="input" path="confirmPassword" placeholder="Confirm Password"/>
				<input class="input submit" type="submit" value="Register!"/>
			</form:form>
			
			<p class="switch">Already have an account? <a href="/login">Lonkin</a></p>
		</div>
    </div>
    
</body>
</html>