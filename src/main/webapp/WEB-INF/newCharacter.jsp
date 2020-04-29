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
	<script type="text/javascript" src="/js/app.js"></script>
</head>

<body>
	<div class="wrapper">
		<div class="nav">
		
			<div class="nav1">
				<h1>Welcome to LonkedIn!</h1>
			</div>
			<div class="nav2">
				<a href="/logout">Logout</a>
			</div>
			
		</div>
		
		<h1>Create your character!</h1>
		
		<p><form:errors path="user.*"/></p>
		<form:form action="/newcharacter" method="post" modelAttribute="user">
			<p>
				<form:label path="name">Name</form:label>
				<form:select path="name">
					<form:option value="">Placeholder</form:option>
				</form:select>
			</p>
			<p>
				<form:label path="universe">Universe</form:label>
				<form:input path="universe"/>
			</p>
			<input type="submit" value="Submit"/>
		</form:form>

	</div>
</body>

</html>