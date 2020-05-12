<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Dashboard</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<link rel="stylesheet" type="text/css" href="/css/dash.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript" src="/js/app.js"></script>
</head>

<body>

	<div class="wrapper dashboard">

	<!-- NAV -->
		<div class="navwrapper navLI">
			<div class="nav">
				<div class="nav1">
					<p class="llogo">
						Lonked<span>in</span>
					</p>
					<form class="searchForm" action="/search" method="POST">
						<input class="search" name="search" type="text" placeholder="Search Users">
						<input class="searchSubmit" type="submit" value="Search" />
					</form>
				</div>
				<div class="nav2 smHide">
					<div class="icons">
						<a class="icon-box" href="/dashboard/${ sessionScope.user_id }">
							<img class="fafa" src="/images/home.png" alt="home" title="Home">
						</a> 
						<a class="icon-box" href="/jobs"> 
							<img class="fafa job" src="/images/briefcase.png" alt="logo" title="Jobs" />
						</a> 
						<a class="icon-box" href="/connections/${sessionScope.user_id}">
							<img class="fafa" src="/images/friends2.png" alt="friends" title="Connections" />
						</a> 
						<a class="icon-box" href="/skill"> 
							<img class="fafa skill" src="/images/skill.png" alt="skills" title="Skills" />
						</a>
					</div>
				</div>
				<div class="nav3 smHide">
					<a class="links faq" href="/about">FAQ</a>
					<a class="links logout" href="/logout">Lonkout</a>
				</div>
			<!-- NAV DROPDOWN -->
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
						<a class="ddlink" href="/about">FAQ</a>
						<a class="ddlink" href="/logout">Lonkout</a>
					</div>
				</div>
			</div>
		</div>

	<!-- Nav Spacer -->
		<div class="navSpacer"></div>

	<!-- HEADER -->

	<!-- DASH GRID -->
		<div class="dash">
		<!-- Dash Grid COLUMN 1 -->
			<div class="col1">
			<!-- Profile -->
				<div class="row profileRow">
					<img id="profileImage" src="${ user.picture }" alt="logo" class="logo" />
					<div class="profileInfo">
						<h1>${ user.name } (${user.universe})</h1>
						<c:choose>
							<c:when test="${ user.job != null }">
								<p><a style="font-weight: bold; color: green"
										href="/game/${ user.game.id }">${user.game.name}</a></p>
								<p style="font-weight: bold; color: green">
									${user.job.title} (${ user.job.morality == true ? "Good Guy" : "Bad Guy" })</p>
							</c:when>
							<c:otherwise>
								<p style="font-weight: bold; color: green">Seeking Work</p>
							</c:otherwise>
						</c:choose>
						<p>${ user.email }</p>
						<p class="connectionsCount">
							<a href="/connections/${ user.id }">${ connectionsCount } Connections</a>
							<c:if test="${ user != loggedIn && !user.friends.contains(loggedIn) && !user.friendRequests.contains(loggedIn) && !loggedIn.friendRequests.contains(user) }">
								<span>(<a href="/requestConnection3/${ user.id }">Request Connection</a>)</span>
							</c:if>
							<c:if test="${ user.friendRequests.contains(loggedIn) || loggedIn.friendRequests.contains(user) }">
								<span>Pending Connection</span>
							</c:if>
						</p>
						<p><a class="enemyCount" href="/connections/${ user.id }">${ enemiesCount } Enemies</a></p>
					</div>
				</div>
			<!-- Friend and Enemy Requests -->
				<c:if test="${ sessionScope.user_id == user.id }">
					<c:if test="${ user.getFriendRequests().size() != 0 }">
						<div class="row">
							<h3>Friend Requests</h3>
							<div class="friendRequests">
								<c:forEach items="${ friendRequests }" var="request">
									<div>
										<p><a href="/dashboard/${ request.id }">${ request.name }</a> (${
											request.universe })</p>
										<form action="/accept/${ request.id }" method="post">
											<input class="accept" type="submit" value="Accept" />
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
				</c:if>
			<!-- About -->
				<div class="row">
					<h3>About</h3>
					<div class="feed">
						<c:if
							test="${ user == loggedIn && user.description == '' || user == loggedIn && editDesc == true }">
							<p class="error">
								<form:errors path="user.*" />
							</p>
							<form:form class="form formDesc" action="/adddescription/${ user.id }" method="post"
								modelAttribute="user">
								<form:textarea class="content" path="description" placeholder="Show yourself off!" />
								<input class="submit subDesc" type="submit" value="Update" />
							</form:form>
						</c:if>
						<c:if test="${ user.description != '' && editDesc == null }">
							<p class="description">${ user.description }</p>
						</c:if>
						<c:if test="${ user == loggedIn && user.description != '' && editDesc == null }">
							<a class="editDesc" href="/editDesc/${ user.id }"><button class="submit">Edit</button></a>
						</c:if>
					</div>
				</div>
			<!-- Connections -->
				<div class="row">
					<h3>Connections</h3>
					<div class="dashConnections">
						<c:forEach items="${ friends }" var="friend">
							<c:if test="${ friend.name != null }">
								<div class="dashConnectionsRow">
									<img src="${ friend.picture }" />
									<a href="/dashboard/${ friend.id }">
										${ friend.name } (${ friend.universe })
									</a>
								</div>
							</c:if>
						</c:forEach>
					</div>
					<h3>Enemies</h3>
					<div class="dashConnections">
						<c:if test="${ enemies.size() == 0 }">
							<a>${ sessionScope.user_id == user.id ? "You have" : user.name.concat(" has") } no
								enemies</a>
						</c:if>
						<c:forEach items="${ enemies }" var="enemy">
							<div class="dashConnectionsRow">
								<img src="${ enemy.picture }" />
								<a href="/dashboard/${ enemy.id }">
									${ enemy.name } (${ enemy.universe })
								</a>
							</div>
						</c:forEach>
					</div>
				</div>
			<!-- Skills -->
				<div class="row">
					<h3>Skills</h3>
					<c:if test="${ user.id == sessionScope.user_id }">
						<div class="skillLink">
							<a href="/skill">
								<button>Manage Skills</button>
							</a>
						</div>
					</c:if>
					<div class="skillsGrid">
						<c:forEach items="${ skills }" var="us">
							<div>
								<c:set var="ct">${ us.count }</c:set>
								<p>${ us.skill.name } <span ${ us.count> -1 || us.count == null ? "class='green'" :
										"class='red'" }>${ us.count > -1 || us.count == null ? "+".concat(ct) : ct
										}</span></p>
								<p class="skillLevel">
									<c:if test="${ us.count <= -1000}">
										Atrocious
									</c:if>
									<c:if test="${ us.count <= -20 && us.count > -1000}">
										Incompetent
									</c:if>
									<c:if test="${ us.count < 0 && us.count > -20}">
										Questionable
									</c:if>
									<c:if test="${ us.count >= 0 && us.count < 10}">
										Novice
									</c:if>
									<c:if test="${ us.count >= 10 && us.count < 20}">
										Intermediate
									</c:if>
									<c:if test="${ us.count >= 20 && us.count < 1000}">
										Advanced
									</c:if>
									<c:if test="${ us.count >= 1000}">
										Master
									</c:if>
								</p>
								<c:if test="${ user != loggedIn }">
									<c:choose>
										<c:when
											test="${ user.friends.contains(loggedIn) && user.game.characters.contains(loggedIn) && user.job.morality == loggedIn.job.morality}">
											<form action=""></form>
											<form action="/endorse/${ user.id }/${ us.skill.id }" method="POST">
												<input type="hidden" name="endorse" value="endorse" />
												<input type="submit" class="endorse" value="Endorse" />
											</form>
										</c:when>
										<c:when
											test="${ user.game.characters.contains(loggedIn) && user.job.morality != loggedIn.job.morality}">
											<form action="/endorse/${ user.id }/${ us.skill.id }" method="POST">
												<input type="hidden" name="endorse" value="discredit" />
												<input type="submit" class="discredit" value="Attack" />
											</form>
										</c:when>
										<c:when test="${ user.friends.contains(loggedIn) }">
											<form action="/endorse/${ user.id }/${ us.skill.id }" method="POST">
												<input type="hidden" name="endorse" value="endorse" />
												<input type="submit" class="endorse" value="Endorse" />
											</form>
										</c:when>
										<c:otherwise>${ null }</c:otherwise>
									</c:choose>
								</c:if>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		<!-- Dash Grid COLUMN 2 -->
			<div class="col2">
			<!-- Feed -->
				<div class="row">
					<h3>Feed</h3>
				<!-- Feed Grid -->
					<div class="feed">
					<!-- Post Form -->
						<p class="error">
							${ postError }
							<form:errors path="post.*" />
						</p>
						<form:form class="form" action="/newpost/${ user.id }" method="post" modelAttribute="post">
							<form:input class="content" path="content" placeholder="Share what's on your mind!" />
							<input class="submit" type="submit" value="Post" />
						</form:form>
					<!-- Feed Subheaders -->
						<div class="feed">
						<!-- Posts -->
							<div class="feedSubHeader">
								<h3>Posts</h3>
								<c:forEach items="${ posts }" var="post">
									<div class="post">
										<div class="postGrid">
											<img class="postPic" src="${ post.creator.picture }" alt="" />
											<div>
												<p class="postName"><a style="text-decoration:none; color:black"
														href="/dashboard/${ post.creator.id }">${ post.creator.name
														}</a> (${ post.creator.universe })</p>
												<p class="postJob">${ post.creator.job != null ?
													post.creator.job.title.concat(" -- ").concat(post.creator.game.name)
													: "Seeking Work" } </p>
												<p class="postCreated"><fmt:formatDate pattern="MMM dd, yyyy -- hh:mm a" value="${ post.createdAt }" /></p>
											</div>
										</div>
										<p class="postContent">${ post.content }</p>
									</div>
								</c:forEach>
								<c:if test="${allPosts.size() <= 2}">
									<div class="post">
										<div class="postGrid">
											<img class="postPic" src="${ lonkpost.creator.picture }" alt="" />
											<div>
												<p class="postName"><a style="text-decoration:none; color:black"
														href="/dashboard/${ lonkpost.creator.id }">${
														lonkpost.creator.name }</a> (${ lonkpost.creator.universe })</p>
												<p class="postJob">${ lonkpost.creator.job.title } -- ${
													lonkpost.creator.game.name }</p>
												<p class="postCreated"><fmt:formatDate pattern="MMM dd, yyyy -- hh:mm a" value="${ lonkpost.createdAt }" /></p>
											</div>
										</div>
										<p class="postContent">${ lonkpost.content }</p>
									</div>
								</c:if>
								<div class="loadMore">
									<c:if test="${posts.size() < allPosts.size() && allPosts.size() >= 4}">
										<a href="/dashboard/${user.id}/loadmore">
											<button>Load More</button>
										</a>
									</c:if>
									<c:if test="${posts.size() >= allPosts.size() && allPosts.size() > 3}">
										<p>No more posts...
											<a href="/dashboard/${user.id}">Click to fold</a>
										</p>
									</c:if>
								</div>
							</div>
						<!-- Recent Jobs -->
							<div class="feedSubHeader">
								<h3>Recent Job Listings</h3>
								<c:if test="${ jobs.size() == 0 }">
									<p class="jobListing">There are no current job listings</p>
								</c:if>
								<c:forEach items="${ testing2.content }" var="job">
									<p class="jobListing">${ job.game.name } is hiring! <a class="jobListLink"
											href="/game/${ job.game.id }">Checkout</a>
										their new posting for ${ job.title }!</p>
								</c:forEach>
							</div>
						<!-- Newest Games -->
							<div class="feedSubHeader">
								<h3>Newest Games</h3>
								<c:forEach items="${ games }" var="game">
									<c:if test="${ game != games.get(games.size()-1) }">
										<a href="/game/${ game.id }" class="gameListing">${ game.name }</a>
									</c:if>
								</c:forEach>
								<a href="/game/${ games.get(games.size()-1).id }" class="gameListing lastGame">${
									games.get(games.size()-1).name }</a>
							</div>
						</div>
					<!-- End Feed Subheaders -->
					</div>
				<!-- End Feed Grid -->
				</div>
			<!-- End Feed Row -->
			</div>
		<!-- End Dash Grid Col 2 -->
		</div>
	<!-- End Dash Grid -->
	</div>
<!-- End Wrapper -->

</body>

</html>