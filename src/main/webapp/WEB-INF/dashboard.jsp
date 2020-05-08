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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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
					<a class="links faq" href="/about">FAQ</a>
					<a class="links logout" href="/logout">Lonkout</a>
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
						<a class="ddlink" href="/about">FAQ</a>
						<a class="ddlink" href="/logout">Lonkout</a>
                     </div>
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
					<div class="profileInfo">
						<h1>${ user.name } (${user.universe})</h1>
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
						<p>${ enemiesCount } Enemies</p>
					</div>
				</div>
				<c:if test="${ sessionScope.user_id == user.id }">
				<c:if test="${ user.getFriendRequests().size() != 0 }">
					<div class="row">
						<h3>Friend Requests</h3>
						<div class="friendRequests">
							<c:forEach items="${ friendRequests }" var="request">
								<div>
									<p><a href="/dashboard/${ request.id }">${ request.name }</a> (${ request.universe })</p>
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
				
				<div class="row">
					<h3>About</h3>
				</div>
				
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
							<a>${ sessionScope.user_id == user.id ? "You have" : user.name.concat(" has") }  no enemies</a>
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

				<div class="row">
					<h3>Skills</h3>
					<c:if test="${ user.id == sessionScope.user_id }">
					<div class="skillLink">
						<a href="/skill">
							<button>Add Skill</button>
						</a>
					</div>
					</c:if>
					<div class="skillsGrid">
					<c:forEach items="${ skills }" var="us">
						<div>
							<c:set var="ct">${ us.count }</c:set>
							<p>${ us.skill.name } <span ${ us.count > -1 || us.count == null ? "class='green'" : "class='red'" }>${ us.count > -1 || us.count == null ? "+".concat(ct) : ct }</span></p>
							<p class="skillLevel">
							<c:if test="${ us.skill.level == 0}">
							Novice
							</c:if>
							<c:if test="${ us.skill.level == 1}">
							Intermediate
							</c:if>
							<c:if test="${ us.skill.level == 2}">
							Advanced
							</c:if>
							</p>
							<c:if test="${ user != loggedIn }">
							<c:choose>
								<c:when test="${ user.friends.contains(loggedIn) && user.game.characters.contains(loggedIn) && user.job.morality == loggedIn.job.morality}">
								<form action=""></form>
							<form action="/endorse/${ user.id }/${ us.skill.id }" method="POST">
								<input type="hidden" name="endorse" value="endorse"/>
								<input type="submit" class="endorse" value="Endorse" />
							</form>
								</c:when>
								<c:when test="${ user.game.characters.contains(loggedIn) && user.job.morality != loggedIn.job.morality}">
							<form action="/endorse/${ user.id }/${ us.skill.id }" method="POST">
								<input type="hidden" name="endorse" value="discredit"/>
								<input type="submit" class="discredit" value="Attack" />
							</form>
								</c:when>
								<c:when test="${ user.friends.contains(loggedIn) }">
							<form action="/endorse/${ user.id }/${ us.skill.id }" method="POST">
								<input type="hidden" name="endorse" value="endorse"/>
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
												<p class="postName">${ post.creator.name } (${ post.creator.universe })</p>
												<p class="postJob">${ post.creator.job.title } -- ${ post.creator.game.name }</p>
												<p class="postCreated">${ post.createdAt }</p>
											</div>
										</div>
										<p class="postContent">${ post.content }</p>
									</div>
								</c:forEach>
								<c:if test="${allPosts.size() <= 2}">
								<div class="post">
									<div class="postGrid">
										<img class="postPic" src="${ lonkpost.creator.picture }"
											alt="" />
										<div>
											<p class="postName">${ lonkpost.creator.name } (${ lonkpost.creator.universe })</p>
											<p class="postJob">${ lonkpost.creator.job.title } -- ${ lonkpost.creator.game.name }</p>
											<p class="postCreated">${ lonkpost.createdAt }</p>
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
							<div class="feedSubHeader">
								<h3>Recent Job Listings</h3>
								<c:if test="${ jobs.size() == 0 }">
									<p class="jobListing">There are no current job listings</p>
								</c:if>
								<c:forEach items="${ jobs }" var="job">
									<p class="jobListing">${ job.game.name } is hiring! <a href="/game/${ job.game.id }">Checkout</a>
										their new posting for ${ job.title }!</p>
								</c:forEach>
							</div>
							<div class="feedSubHeader">
								<h3>Newest Games</h3>
								<c:forEach items="${ games }" var="game">
								<c:if test="${ game != games.get(games.size()-1) }">
									<a href="/game/${ game.id }" class="gameListing">${ game.name }</a>
								</c:if>
								</c:forEach>
								<a href="/game/${ games.get(games.size()-1).id }" class="gameListing lastGame">${ games.get(games.size()-1).name }</a>
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