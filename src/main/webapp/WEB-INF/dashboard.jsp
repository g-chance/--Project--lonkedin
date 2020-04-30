<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

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

<!-- HEADER -->

		<h1>Welcome,
			<c:out value="${user.name}" />
		</h1>

<!-- DASH GRID -->

		<div class="dash">
		
			<!-- COLUMN 1 -->
			
			<div class="col1">
				<h2>You are currently on your dashboard!</h2>
				<!-- Each div you add below here will be a row in column 1 -->

				<!-- Profile page -->
				<img class="profile" src="/images/lonk.jpg" alt="logo" class="logo" />
				<div class="profile_content">
					<h3>Connections</h3>
					<p>Blah blah blah</p>

				</div>

				<div class="missions">
					<h3>Current Missions Accepted</h3>
					<ol>
						<li>Job 1</li>
						<li>Job 2</li>
						<li>Job 3</li>
					</ol>
				</div>
			</div>

			<!-- COLUMN 2 -->
			
			<div class="col2">
				<!-- Each div you add below here will be a row in column 2 -->
				<div class="connection">
					<h3>Friend/Fight Requests</h3>
					<div class="feed">
						<h2>Feed</h2>
						<div class="job">
							<h3>Job Postings</h3>
							<a href="/job">Plummer Needed</a>
						</div>

						<div class="post">
							<h3>Posts</h3>
							<p>Bought some new shows</p>
						</div>
						<div class="updates">
							<h3>Updates</h3>
							<p>Lonk gets new job as a plummer!</p>
						</div>
					</div>
					<!-- job postings, comments, updates from friends etc... -->
				</div>
			</div>
		</div>
	</div>

</body>

</html>