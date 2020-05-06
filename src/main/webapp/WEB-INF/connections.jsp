<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Connections</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<link rel="stylesheet" type="text/css" href="/css/dash.css">
	<link rel="stylesheet" type="text/css" href="/css/connection.css">
	<script type="text/javascript" src="/js/app.js"></script>
</head>

<body>

	<div class="wrapper">
	
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
		
<!-- CONNECTIONS GRID -->
		
		<div class="connections">
			
<!-- CONNECTIONS COLUMN 1 -->
			
			 <div class="connectionscol1">
				<div class="friends">
					<h1>Friends</h1>

					<table >
						<thead>
							<tr>
								<th>Icon</th>
								<th>Name</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${user.friends}" var = "friend">
							<tr>
                                <td><img class="heart" src="/images/heart.jpg" alt="heart" ></td>
                                <!--route in td belownot created yet but should be for users display page-->
								<td><a class="link" href="">${friend.email}</a></td>
								<td ><a class="link" href="/friend/${friend.id}/remove">Remove</a></td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					
				</div>
			 </div>
				
			
<!-- CONNECTIONS COLUMN 2 -->
			
			<div class="connectionscol2">
				<div class="enemies">
					<h1>Enemies</h1>

					<table>
						<thead>
							<tr>
								<th>Icon</th>
								<th>Name</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${user.enemies}" var = "enemy">
							<tr>
								<td><img class="skull" src="/images/skull.png" alt="heart" class="heart"></td>
								<td><a class="link" href="">${enemy.email}</a></td>
								<td><a class="link" href="/enemy/${enemies.id}/remove">Remove</a></td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					
				</div>
			</div>
			
		</div>
	</div>

</body>

</html>