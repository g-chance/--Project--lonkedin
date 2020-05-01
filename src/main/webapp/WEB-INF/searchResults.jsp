<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<link rel="stylesheet" type="text/css" href="/css/searchResults.css">
	<script type="text/javascript" src="/js/app.js"></script>
</head>

<body>

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
						<img class="icon-box fafa" src="/images/friends.png" alt="logo"  />
						<a class="icon-box" href="/dashboard">
							<img class="fafa" src="/images/home.png" alt="home" >
						</a>
						<a class="icon-box" href="/connections/${user.id}">
							<img class="fafa" src="/images/friends.png" alt="friends"  />
						</a>
						<a class="icon-box" href="/connections/${user.id}">
							<img class="fafa" src="/images/skull.png" alt="enemies" />
						</a>
					</div>
				</div>
				<div class="nav3">
					<a class = "links" href="/dashboard">Dashboard</a>
					<a class = "links" href="/logout">Logout</a>
				</div>
				
			</div>
			
		</div>

		<div class="navSpacer navLISpacer"></div>
		
		<div class="main">
		<c:forEach items="${ searchResults }" var="result">
		<c:if test="${ !friends.contains(result) && result != user }">
			<div class="row">
				<p>${ result.name } (${ result.universe })</p>
				<a href="/requestConnection/${ result.id }">Request Connection</a>
			</div>
		</c:if>
		</c:forEach>
		</div>
	
	</div>
</body>

</html>