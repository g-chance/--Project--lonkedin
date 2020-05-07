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
		
		<div class="main">
		<c:forEach items="${ searchResults }" var="result">
		<c:if test="${ !friends.contains(result) && result != user }">
			<div class="row">
					<img src="${ result.picture }" alt="" />
				<div>
					<p>${ result.name } (${ result.universe })</p>
					<p>${ result.job != null ? result.job.title.concat(" -- ").concat(result.game.name) : "Seeking Work"}</p>
				</div>
				<c:choose>
				<c:when test="${ !result.friendRequests.contains(user) }">
					<a href="/requestConnection/${ result.id }/${ str }">Request Connection</a>
				</c:when>
				<c:otherwise>
					<a>Pending Connection</a>
				</c:otherwise>
				</c:choose>
			</div>
		</c:if>
		</c:forEach>
		</div>
	
	</div>
</body>

</html>