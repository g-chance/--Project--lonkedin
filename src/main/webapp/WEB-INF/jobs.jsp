<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Jobs</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<link rel="stylesheet" type="text/css" href="/css/jobs.css" media="screen" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript" src="/js/app.js"></script>
</head>

<body>
	<div class="wrapper">

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

		<div class="navSpacer"></div>

		<div class="jobContainer">
		<!-- JOB FORMS -->
			<div class="jobForms">

			<!-- **ADDING Games** -->
				<c:if test="${usersgame.id == null}">
					<div class="companyForm">
						<h1 class="header">Add a Game</h1>
						<p>
							<form:errors class="error" path="game.*" />
						</p>
						<form:form action="/game" method="post" modelAttribute="game">
							<p>
								<form:input path="name" placeholder="Name" />
							</p>
							<p>
								<form:input path="description" placeholder="Mission Statement" />
							</p>
							<input class="submit" type="submit" value="Create Game!" />
						</form:form>
					</div>
				</c:if>

			<!-- **ADDING JOBS** -->
				<c:if test="${usersgame.id != null}">
					<div class="jobForm">
						<h1 class="header">Add a Job</h1>
						<p>
							<form:errors class="error" path="job.*" />
						</p>
						<form:form action="/jobs" method="post" modelAttribute="job">
							<p>
								<form:input value="${usersgame.name}" path="game" disabled="true" />
							</p>
							<p>
								<form:input path="title" placeholder="Title" />
							</p>
							<p>
								<form:input path="description" placeholder="Description" />
							</p>
							<p>
								<form:input class="number" type="number" path="salary" placeholder="Rupees" />
								<form:select path="morality">
									<span>
										<form:option value="" disabled="true" selected="true">Morality</form:option>
									</span>
									<form:option value="true" label="Good Guy" />
									<form:option value="false" label="Bad Guy" />
								</form:select>
							</p>
							<input class="submit" type="submit" value="Create Job!" ${ usersgame.name == "The Legend of Zorldo" ? "style='background:lightgray' disabled" : null } />
							<c:if test="${ usersgame.name == 'The Legend of Zorldo'}">
								<p class="cant">You can't create jobs for The Legend of Zorldo</p>
							</c:if>
						</form:form>
					</div>
				</c:if>
			</div>


		<!-- JOB LISTINGS -->
			<div class="jobListings">
			<!-- For loops for displaying current available jobs -->
				<div class="currentJob">
					<div>
						<h3 style="color:grey">Your Current Job: ${userJob == null? "Unemployed" :userJob.title.concat("
							in ").concat(userJob.game.name)}</h3>
						<c:if test="${userJob != null}">
							<form:form action="/jobs/quit/${userJob.id}">
								<button type="submit">Quit</button>
							</form:form>
						</c:if>
					</div>
				</div>
				<h1 class="jobListings">Job Listings</h1>
				<div class="sortRow">
					<a href="/job/highpay"> <button class="action">Salary High - Low</button></a>
					<a href="/job/lowpay"><button class="action">Salary Low - High</button></a>
					<a href="/jobs"><button class="action">Most Recent</button></a>
				</div>

				<div class="jobListGrid">
					<p class="th">Job</p>
					<p class="th">Game</p>
					<p class="th">Description</p>
					<p class="th smCol">Rupees</p>
					<p class="th smCol">Morality</p>
					<p class="th smCol">Apply</p>
					<c:forEach var="job" items="${jobs}">
						<c:if test="${job.characters.size() == 0 }">
							<p class="mdCol">${job.title}</p>
							<p class="mdCol"><a href="/game/${ job.game.id }">${job.game.name}</a></p>
							<p class="lgCol">${job.description}</p>
							<p class="smCol">${job.salary}</p>
							<c:if test="${job.morality==true }">
								<p class="smCol">Good</p>
							</c:if>
							<c:if test="${job.morality==false }">
								<p class="smCol">Bad</p>
							</c:if>

						<!-- apply button  -->
							<form:form class="smCol" action="/apply/${job.id}"><button ${userJob.id !=null
									? "disabled style='background-color:lightgray'" : null}
									type="submit">Apply!</button></form:form>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</body>

</html>