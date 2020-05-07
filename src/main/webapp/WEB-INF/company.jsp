<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Jobs</title>
	<script type="text/javascript" src="/js/app.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<link rel="stylesheet" type="text/css" href="/css/jobs.css" media="screen" />
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
						<a class="icon-box" href="/dashboard/${sessionScope.user_id}">
							<img class="fafa" src="/images/home.png" alt="home" >
						</a>
						<a href="/jobs">
							<img class="icon-box fafa" src="/images/friendsI_Icon.jpg" alt="logo"  />
						</a>
						<a class="icon-box" href="/connections/${user.id}">
							<img class="fafa" src="/images/friends2.png" alt="friends"  />
						</a>
						<a class="icon-box" href="/skill">
							<img class="fafa" src="/images/chost.png" alt="friends"  />
						</a>
					</div>
				</div>
				<div class="nav3">
					<a class = "links" href="/dashboard">Dashboard</a>
					<a class = "links" href="/logout">Lonkout</a>
				</div>
				
			</div>
			
		</div>

		<div class="navSpacer"></div>
		<!-- JOB FORMS -->
		<!-- JOB LISTINGS -->
		<div class="jobListings">
			<!-- For loops for displaying current available jobs -->
			<h1 class="jobListings">Available Jobs at ${game.name}</h1>
			<h3>Total Employees: ${game.getCharacters().size()}</h3>
			<h3>Game Description: ${game.description}</h3>
			
			<h3>CEO:${ceo !=null ? ceo.name : "Position Available!"}</h3>

			<p><a href="/jobs">Back to Joblistings</a></p>
			<div class="currentJob">
				<h3 style="color:grey">Current Job: ${user.job == null? "Unemployed" :user.job.title.concat(", ").concat(user.job.game.name)}</h3>
				<form:form action="/jobs/quit/${userJob.id}">
					<button ${userJob.id == null ? "hidden" : null} type="submit">Quit</button>
				</form:form>
            </div>
			<table>
				<thead>
					<tr>
						<th class="smCol">Title</th>
						<th class="smCol">Description</th>
						<th class="smCol">Rupees</th>
						<th class="smCol">Morality</th>
						<th class="smCol">Apply</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="job" items = "${game.getJobs()}">
						<c:if test="${job.characters.size() == 0 }">
					<tr>
						<td class="smCol">${job.title}</td> 
						<td class="smCol">${job.description}</td>
						<td class="smCol">${job.salary}</td>
						<td class="smCol"><c:if test="${job.morality==true }">
							<p>Good</p>
							</c:if>
							<c:if test="${job.morality==false }">
							<p>Bad</p>
							</c:if>
						</td>
						<td class="smCol">
							<form:form action="/applyTwo/${job.game.id}"><button ${user.job.id != null ? "disabled style='background-color:lightgray'" : null} type="submit">Apply!</button></form:form>
					</tr>
				</c:if>	
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>

</html>