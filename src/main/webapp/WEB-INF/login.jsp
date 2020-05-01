<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<script type="text/javascript" src="/js/app.js"></script>
</head>
<body>
	
	<div class="wrapper">
	
		<div class="navwrapper">
			<div class="nav">
				<div class="nav1">
					<p class="llogo">Lonked<span>in</span></p>
				</div>
				<div></div>
				<div class="nav3">
					<a class="links" href="/logout">Logout</a>
				</div>
			</div>
		</div>
		
		<div class="navSpacer"></div>
		
		<div class="regLog log">
			<h1 class="header">Login</h1>
			<p class="error"><c:out value="${error}" /></p>
			<form class="form" method="post" action="/login">
<!-- 				<p>
					<label for="email">Email</label> -->
					<input class="input" type="text" id="email" name="email" placeholder="Email"/>
<!-- 				</p>
				<p>
					<label for="password">Password</label> -->
					<input class="input" type="password" id="password" name="password" placeholder="Password"/>
<!-- 				</p> -->
				<input class="input submit" type="submit" value="Login!"/>
			</form>
			
			<p class="switch">Don't have an account? <a href="/registration">Register</a></p>
		</div>
		
    </div>
    
</body>
</html>