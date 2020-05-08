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

		<div class="navSpacer navLISpacer"></div>
		<!-- JOB FORMS -->
		<!-- JOB LISTINGS -->
		<div class="jobContainer">
			<p class="back"><a href="/jobs">All Jobs</a></p>
			<div class="gameHeader">
				<h1>${ game.name }</h1>
				<p>CEO: ${ceo !=null ? ceo.name : " Position Available!"}</p>
			</div>
			
			<div class="aboutGame">
				<h4>About ${ game.name }:</h4>
				<p>Mission Statement: ${game.description}</p>
				<p>Total Employees: ${game.getCharacters().size()}</p>
				<p>Connections Here: </p>
				<p>Jobs Available:</p>
			</div>
		
			<div class="jobListings">
				<!-- For loops for displaying current available jobs -->
				
				<h1>Available Jobs at ${game.name}</h1>
				<div class="currentJob">
					<form:form action="/jobs/quit/${userJob.id}">
						<button ${userJob.id == null ? "hidden" : null} type="submit">Quit</button>
					</form:form>
	            </div>
				<table>
					<thead>
						<tr>
							<th class="mdCol">Title</th>
							<th class="lgCol">Description</th>
							<th class="smCol">Rupees</th>
							<th class="smCol">Morality</th>
							<th class="smCol">Apply</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="job" items = "${game.getJobs()}">
							<c:if test="${job.characters.size() == 0 }">
						<tr>
							<td class="mdCol">${job.title}</td> 
							<td class="lgCol">${job.description}</td>
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
	</div>
</body>

</html>