<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Dashboard</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<link rel="stylesheet" type="text/css" href="/css/dash.css">
	<script type="text/javascript" src="/js/app.js"></script>
</head>

<body>

	<div class="wrapper dashboard">

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
					<a class = "links" href="/logout">Logout</a>
				</div>
				
			</div>
			
		</div>

		<div class="navSpacer"></div>

<!-- HEADER -->

<!-- DASH GRID -->

		<div class="dash">
		
			<!-- COLUMN 1 -->
			
			<div class="col1">
				<!-- Each div you add below here will be a row in column 1 -->

				<!-- Profile page -->
				<div class = "row profileRow">
					<img id="profileImage" src="${ user.picture }" alt="logo" class="logo" />
					<div>
						<h1>${ user.name } (${user.universe})</h1>
						<p style="font-weight: bold; color:green">${user.game.name} Game Placeholder</p>
						<p style="font-weight: bold; color:green"> ${user.job.title} Job Placeholder</p>
						<p>(number) Connections -- (num) friends, (num) enemies</p>
					</div>
				</div>
				<c:if test="${ user.getFriendRequests().size() != 0 }">
				<div class="row"> 
					<h3>Friend Requests</h3>
					<div class="friendRequests">
					<c:forEach items="${ friendRequests }" var="request">
						<div>
							<p>${ request.name } (${ request.universe })</p>
							<form action="/accept/${ request.id }" method="post">
								<input type="submit" value="Accept" />
							</form>
							<form action="/reject/${ request.id }" method="post">
								<input type="submit" value="Reject" />
							</form>
						</div>
					</c:forEach>
					</div>
				</div>
				</c:if>
				<div class="row"> 
					<h3>Enemy Requests</h3>
				</div>
				<div class="row">
					<h3>Connections</h3>
					<div class="connections">
					<c:forEach items="${ friends }" var="friend">
						<div>
							<img src="${ friend.picture }" />
							<p>${ friend.name } (${ friend.universe })</p>
						</div>
					</c:forEach>
					</div>
				</div>
				
				<div class="row">
					<h3>Skills</h3>
				</div>
				<!-- <c:forEach items="${connections}" var ="list">
					<c:if test = "${list.getFriends().contains(user) == false && list.getEnemies().contains(user) == false && list != user }">
						
							<li>${list.email}</li>
						
					</c:if>
				</c:forEach> -->
			</div>

			<!-- COLUMN 2 -->
			
			<div class="col2">
				<!-- Each div you add below here will be a row in column 2 -->
				<div class="row">
					<h3>Feed</h3>
					<div class="feed">
						<p class="error"><form:errors path="post.*"/></p>
						<form:form class="form" action="/newpost" method="post" modelAttribute="post">
						    <p>
						        <form:input class="content" path="content" placeholder="Share what's on your mind!"/>
						    	<input class="submit" type="submit" value="Post"/>
	   					    </p>
						</form:form> 
						<div class="feed">
	
							<div class="feedSubHeader post">
								<h3>Posts</h3>
									<c:forEach items="${ posts }" var="post">
										<c:if test="${ user.getFriends().contains(post.character) }">
								<p>${ post.content }</p>
										</c:if>
									</c:forEach>
							</div>
							<div class="feedSubHeader">
								<h3>Recent Job Listings</h3>
							</div>
							<div class="feedSubHeader">
								<h3>Newest Games</h3>
							</div>
						</div>
					</div>
					<!-- job postings, comments, updates from friends etc... -->
				</div>
			</div>
		</div>
	</div>

</body>

</html>