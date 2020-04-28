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
		
			<h1>Register!</h1>
			<a href="/logout">Logout</a>
			
		</div>	    
	    
	    <p><form:errors path="user.*"/></p>
	    <form:form method="POST" action="/registration" modelAttribute="user">
	        <p>
	            <form:label path="name">Name:</form:label>
	            <form:input type="text" path="name"/>
	        </p>
	        <p>
	            <form:label path="email">Email:</form:label>
	            <form:input type="email" path="email"/>
	        </p>
	        <p>
	            <form:label path="password">Password:</form:label>
	            <form:password path="password"/>
	        </p>
	        <p>
	            <form:label path="confirmPassword">Confirm Password:</form:label>
	            <form:password path="confirmPassword"/>
	        </p>
	        <input type="submit" value="Register!"/>
	    </form:form>
	    
	    <p>Already have an account? <a href="/login">Login</a></p>
	    
    </div>
    
</body>
</html>