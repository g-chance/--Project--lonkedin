<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

					<p class="llogo">
						Lonked<span>in</span>
					</p>
					<form action="/search" method="POST">
						<input class="search" name="search" type="text"
							placeholder="Search Users"> <input class="searchSubmit"
							type="submit" value="Search" />
					</form>
				</div>
				<div class="nav2">
					<div class="icons">
						<a class="icon-box" href="/dashboard/${ sessionScope.user_id }">
							<img class="fafa" src="/images/home.png" alt="home">
						</a> <a href="/jobs"> <img class="icon-box fafa"
							src="/images/friendsI_Icon.jpg" alt="logo" />
						</a> <a class="icon-box" href="/connections/${sessionScope.user_id}">
							<img class="fafa" src="/images/friends2.png" alt="friends" />
						</a> <a class="icon-box" href="/skill"> <img class="fafa"
							src="/images/chost.png" alt="friends" />
						</a>
					</div>
				</div>
				<div class="nav3">
					<a class="links" href="/logout">Lonkout</a>
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
				<div class="row profileRow">
					<img id="profileImage" src="${ user.picture }" alt="logo"
						class="logo" />
					<div>
						<h1>${ user.name }(${user.universe})</h1>
						<c:choose>
							<c:when test="${ user.job != null }">
								<p style="font-weight: bold; color: green">${user.game.name}</p>
								<p style="font-weight: bold; color: green">
									${user.job.title} (${ user.job.morality == true ? "Good Guy" : "Bad Guy" })</p>
							</c:when>
							<c:otherwise>
								<p style="font-weight: bold; color: green">Seeking Work</p>
							</c:otherwise>
						</c:choose>
						<p class="connectionsCount">
							<a href="/connections/${ user.id }">${ connectionsCount }
								Connections</a>
						</p>
						<p>${ enemiesCount }Enemies</p>
					</div>
				</div>
				<c:if test="${ user.getFriendRequests().size() != 0 }">
					<div class="row">
						<h3>Friend Requests</h3>
						<div class="friendRequests">
							<c:forEach items="${ friendRequests }" var="request">
								<div>
									<p>${ request.name }(${ request.universe })</p>
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
				<c:if test="${ user.getEnemyRequests().size() != 0 }">
					<div class="row">
						<h3>Enemy Requests</h3>
					</div>
				</c:if>
				<div class="row">
					<h3>Connections</h3>
					<div class="connections">
						<c:forEach items="${ friends }" var="friend">
							<div class="connectionsRow">
								<img src="${ friend.picture }" /> <a
									href="/dashboard/${ friend.id }">
									<p>${ friend.name }(${ friend.universe })</p>
								</a>
							</div>
						</c:forEach>
					</div>
					<h3>Enemies</h3>
					<div class="connections">
						<c:if test="${ enemies.size() == 0 }">
							<p>You have no enemies</p>
						</c:if>
						<c:forEach items="${ enemies }" var="enemy">
							<div class="connectionsRow">
								<img src="${ enemy.picture }" /> <a
									href="/dashboard/${ enemy.id }">
									<p>${ enemy.name }(${ enemy.universe })</p>
								</a>
							</div>
						</c:forEach>
					</div>
				</div>

				<div class="row">
					<h3>Skills</h3>
					<div class="skillLink">
						<a href="/skill">
							<button>Add Skill</button>
						</a>
					</div>
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
						<p class="error">
							<form:errors path="post.*" />
						</p>
						<form:form class="form" action="/newpost/${ user.id }"
							method="post" modelAttribute="post">
							<form:input class="content" path="content"
								placeholder="Share what's on your mind!" />
							<input class="submit" type="submit" value="Post" />
						</form:form>
						<div class="feed">

							<div class="feedSubHeader">
								<h3>Posts</h3>

								<c:forEach items="${ posts }" var="post">
									<div class="post">
										<div class="postGrid">
											<img class="postPic" src="${ post.creator.picture }" alt="" />
											<div>
												<p class="postName">${ post.creator.name }(${ post.creator.universe })</p>
												<p class="postJob">${ post.creator.job.title }--${ post.creator.game.name }</p>
												<p class="postCreated">${ post.createdAt }</p>
											</div>
										</div>
										<p class="postContent">${ post.content }</p>
									</div>
								</c:forEach>

								<div class="post">
									<div class="postGrid">
										<img class="postPic" src="${ lonkpost.creator.picture }"
											alt="" />
										<div>
											<p class="postName">${ lonkpost.creator.name }(${ lonkpost.creator.universe })</p>
											<p class="postJob">${ lonkpost.creator.job.title }--${ lonkpost.creator.game.name }</p>
											<p class="postCreated">${ lonkpost.createdAt }</p>
										</div>
									</div>
									<p class="postContent">${ lonkpost.content }</p>
								</div>
								<div class="skillLink">
									<a href="/dashboard/${user.id}/loadmore">
										<button>Load More</button>
									</a>
								</div>
							</div>
							<div class="feedSubHeader">
								<h3>Recent Job Listings</h3>
								<c:forEach items="${ jobs }" var="job">
									<p class="jobListing">${ job.game.name }is hiring! Checkout
										their new posting for ${ job.title }!</p>
								</c:forEach>
							</div>
							<div class="feedSubHeader">
								<h3>Newest Games</h3>
								<c:forEach items="${ games }" var="game">
									<p class="gameListing">${ game.name }</p>
								</c:forEach>
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