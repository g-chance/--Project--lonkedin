<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>

<head>
<link rel="stylesheet" type="text/css" href="/css/jobs.css" media="screen" />
	<meta charset="UTF-8">
	<title>Jobs</title>

	<script type="text/javascript" src="/js/app.js"></script>
</head>

<body>
	<div class="wrapper">

		<div class="nav">
			<div>
				<h1 style="color:black">Welcome,
					<c:out value= "${user.name}"/> 
				</h1>
				<h3 style="color:grey">Current Job: ${userJob == null? "Unemployed" :userJob.title.concat(", ").concat(userJob.game.name)}<form:form action="/jobs/quit/${userJob.id}"><button ${userJob.id == null ? "hidden" : null} type="submit">Quit!</button></form:form> 
			</h3>
			
			</div>
			<div class="nav2">
				<a href="/logout">Logout</a>
			</div>
		</div>

		<!-- JOB FORMS -->

		<div class="jobForms">

			<!-- jobForms COLUMN 1 **ADDING COMPANIES** -->
			<!-- //NEED TO FIND A WAY SO THAT ONLY THOSE WITHOUT CURRENT COMPANIES CAN MAKE COMPANIES -->
			<!-- VERIFY IF SOMEONE HAS ALREADY CREATED THE SAME COMPANY -->

			<div class="col1 companyForm">
				<c:if test="${usersgame.id == null}">
				<h2>ADD A COMPANY</h2>
				<p>
					<form:errors path="game.*" />
				</p>
				<form:form action="/game" method="post" modelAttribute="game">
					<p>
						<form:label path="name">Company Name:</form:label>
						<form:input path="name" />
					</p>
					<p>
						<form:label path="description">Company Description:</form:label>
						<form:input path="description" />
					</p>
					<input type="submit" value="Create a Company!" />
				</form:form>
			</c:if>
			</div>

			<!-- jobForms COLUMN 2 **ADDING JOBS** -->
			<!-- NEED TO FIND A WAY SO THAT ONLY COMPANY CEOS/SUPERVISORS CAN MAKE JOBS FOR THE SPECIFIC COMPANY -->

			<div class="col2 jobForm">
				<c:if test="${usersgame.id != null}">
				<h2>Add a Job for your Company</h2>
				<p>
					<form:errors path="job.*" />
				</p>
				<form:form action="/jobs" method="post" modelAttribute="job">
						<p>
							<form:label path="game">Game: </form:label>
							<form:input value="${usersgame.name}" path="game" disabled="true" />
						</p>

				    <p>
				        <form:label path="title">Title: </form:label>
				        <form:input path="title"/>
                    </p>
                    <p>
				        <form:label path="description">Description: </form:label>
				        <form:input path="description"/>
                    </p>
                    <p>
				        <form:label path="salary">Salary: </form:label>
				        <form:input path="salary"/>
                    </p>
                    <p>
				        <form:label path="morality">Morality (for good or bad guys?):</form:label>
                            <form:select path="morality">
                                <form:option value="true" label="For Good Guys"/>
                                <form:option value="false" label="For Bad Guys"/>
                            </form:select>
				    </p>
				    <input type="submit" value="Create a new Job!"/>
				</form:form> 
			</c:if>
			</div>
		</div>

		<!-- JOB LISTINGS -->

		<div class="jobListings">
			<!-- For loops for displaying current available jobs -->
			<table>
				<thead>
					<tr>
						<th>Jobs </th>
						<th>Company </th>
						<th>Description</th>
						<th>Salary </th>
						<th>Morality</th>
						<th>Apply </th>
					</tr>
				</thead>
				<tbody>
				
					<c:forEach var="job" items="${jobs}">
					<tr>
						<td>${job.title}</td>
						<td>${job.game.name}</td>
						<td>${job.description}</td>
						<td>${job.salary}</td>
						<td><c:if test="${job.morality==true }">
						<p>Good</p>
						</c:if>
						<c:if test="${job.morality==false }">
						<p>Bad</p>
						</c:if>
						
						</td>
						<td>
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