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
		<div class="nav">
			<div class="strip">
				<div class="icon-box">
					<img src="/images/friends.png" alt="logo" class="logo" />
				</div>
				<div class="search">
					<form action="/search" method="POST">
						<input type="text" placeholder="search">
						<button type="button">Search</button>
					</form>
				</div>

				<div class="icon-box">
					<a href="/dashboard">
						<img src="/images/home.png" alt="home" class="logo">
						<!-- <p>home</p> -->
					</a>
				</div>

				<div class="icon-box friend">
					<a href="/connections/${user.id}">
						<img src="/images/friends.png" alt="friends" class="logo" />
						<!-- <p>friends</p> -->
					</a>
				</div>
				<div class="icon-box">

					<a href="/connections/${user.id}"><img src="/images/skull.png" alt="enemies" class="logo" />
						<!-- <p>enemies</p> -->
					</a>
				</div>
				<div class="logout">
					<a href="/logout">Logout</a>
				</div>
			</div>
		</div>
		
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