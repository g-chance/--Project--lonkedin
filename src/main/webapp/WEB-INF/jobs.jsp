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
						<a href="/jobs">
							<img class="icon-box fafa" src="/images/friends.png" alt="logo"  />
						</a>
						<a class="icon-box" href="/dashboard/${ sessionScope.user_id }">
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

		<!-- JOB FORMS -->

		<div class="jobForms">

			<!-- jobForms COLUMN 1 **ADDING COMPANIES** -->
			<!-- //NEED TO FIND A WAY SO THAT ONLY THOSE WITHOUT CURRENT COMPANIES CAN MAKE COMPANIES -->
			<!-- VERIFY IF SOMEONE HAS ALREADY CREATED THE SAME COMPANY -->

			<div class="companyForm">
			<c:if test="${usersgame.id == null}">
				<h1 class="header">Add a Game</h1>
				<p>
					<form:errors path="game.*" />
				</p>
				<form:form action="/game" method="post" modelAttribute="game">
					<p>
						<form:input path="name" placeholder="Company Name"/>
					</p>
					<p>
						<form:input path="description" placeholder="Company Description"/>
					</p>
					<input type="submit" value="Create a Company!" />
				</form:form>
			</c:if>
			</div>

			<!-- jobForms COLUMN 2 **ADDING JOBS** -->
			<!-- NEED TO FIND A WAY SO THAT ONLY COMPANY CEOS/SUPERVISORS CAN MAKE JOBS FOR THE SPECIFIC COMPANY -->

			<div class="jobForm">
			<c:if test="${usersgame.id != null}">
				<h1 class="header">Add a Job</h1>
				<p>
					<form:errors path="job.*" />
				</p>
				<form:form action="/jobs" method="post" modelAttribute="job">
					<p>
						<form:input value="${usersgame.name}" path="game" disabled="true" />
					</p>
				    <p>
				        <form:input path="title" placeholder="Title"/>
                    </p>
                    <p>
				        <form:input path="description" placeholder="Description"/>
                    </p>
                    <p>
				        <form:input class="number" type="number" path="salary" placeholder="Rupees"/>
                        <form:select path="morality">
                        <span>
                        	<form:option value="" disabled="true" selected="true">Morality</form:option>
                       	</span>
                            <form:option value="true" label="Good Guy"/>
                            <form:option value="false" label="Bad Guy"/>
                        </form:select>
				    </p>
				    <input class="submit" type="submit" value="Create Job!"/>
				</form:form> 
			</c:if>
			</div>
		</div>

		<!-- JOB LISTINGS -->

		<div class="jobListings">
			<!-- For loops for displaying current available jobs -->
			<h1 class="jobListings">Job Listings</h1>
			<table>
				<thead>
					<tr>
						<th class="lgCol">Job </th>
						<th class="lgCol">Game </th>
						<th class="lgCol">Description</th>
						<th class="smCol">Rupees </th>
						<th class="smCol">Morality</th>
						<th class="smCol">Apply </th>
					</tr>
				</thead>
				<tbody>
				
					<c:forEach var="job" items="${jobs}">
					<tr>
						<td class="lgCol">${job.title}</td>
						<td class="lgCol">${job.game.name}</td>
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
						<form:form action="/apply/${job.id}"><button ${userJob.id != null ? "disabled" : null} type="submit">Apply!</button></form:form>
						</td>
						
							<!-- apply button  -->
					</tr>
				</c:forEach>
			
				</tbody>
			</table>
		</div>
	</div>
</body>

</html>