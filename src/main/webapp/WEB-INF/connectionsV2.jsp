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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript" src="/js/app.js"></script>
</head>

<body>

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
					<a class="links" href="/logout">Lonkout</a>
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
						<a class="ddlink" href="/logout">Lonkout</a>
                     </div>
                 </div>

			</div>

		</div>

		<div class="navSpacer navLISpacer"></div>
		
		<div>
			<h1>${ sessionScope.user_id != user.id ? user.name.concat("'s") : "Your " } Connections:</h1>
			<div class="connectionsGrid main">
			<c:forEach items="${ user.friends }" var="result">
			<c:if test="${ result.name == null }">
				<div class="row">
					<p></p>
					<p>This user hasn't finished their profile</p>
				</div>
			</c:if>
			<c:if test="${ result.name != null }">
				<div class="row">
					<img src="${ result.picture }" alt="" />
					<div class="resultInfo">
						<a href="/dashboard/${ result.id }">${ result.name } (${ result.universe })</a>
						<p>${ result.job != null ? result.job.title.concat(" -- ").concat(result.game.name) : "Seeking Work"}</p>
					</div>
					<c:choose>
						<c:when test="${ sessionScope.user_id == user.id && result != lonk }">
					<a class="status" href="/friend/${ result.id }/remove">Remove Connection</a>
						</c:when>
						<c:otherwise>
							<c:if test="${ !loggedIn.friends.contains(result) && loggedIn != result }">
								<c:choose>
								<c:when test="${ !result.friendRequests.contains(loggedIn) }">
					<a class="status" href="/requestConnection2/${ result.id }/${ user.id }">Request Connection</a>		
								</c:when>
								<c:otherwise>
					<a class="status">Pending Connection</a>
								</c:otherwise>
								</c:choose>
							</c:if>
						</c:otherwise>
					</c:choose>
				</div>
			</c:if>
			</c:forEach>
			</div>
		</div>
	</div>
</body>

</html>