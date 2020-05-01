<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<script type="text/javascript" src="/js/app.js"></script>
</head>

<body>
	<div class="wrapper">

		<div class="nav">
			<div class="nav1">
				<h1>Welcome,
					<c:out value="${user.name}" />
				</h1>
			</div>
			<div class="nav2">
				<a href="/logout">Logout</a>
			</div>
		</div>

		<!-- JOB FORMS -->

		<div class="jobForms"></div>

		<!-- jobForms COLUMN 1 **ADDING COMPANIES** -->
		<!-- //NEED TO FIND A WAY SO THAT ONLY THOSE WITHOUT CURRENT COMPANIES CAN MAKE COMPANIES -->
		<!-- VERIFY IF SOMEONE HAS ALREADY CREATED THE SAME COMPANY -->

		<div class="col1 companyForm">
			<h2>Create a New Skill</h2>
			<p>
				<form:errors path="skill.*" />
			</p>
			<form:form action="/skill/new" method="post" modelAttribute="skill">
				<p>
					<form:label path="name">Skill Name:</form:label>
					<form:input path="name" />
				</p>

				<input type="submit" value="Create a Skill!" />
			</form:form>
		</div>

		<div class="col2 jobForm">
			<form action="/skill/add" method="POST">
				<select name="userSkill">
					<c:forEach var="skill" items="${allSkills}">
						<c:if test="${user.skills.contains(skill) ==false}">
							<option value="${skill.id}" label="${skill.name}">
						</c:if>
					</c:forEach>
				</select>
				<button type="submit" name="action">Add</button>
			</form>

			<div>
				<ul>
					<c:forEach items="${user.skills}" var="uskill">
						<li>${uskill.name}</li>
					</c:forEach>

				</ul>
				
			</div>
		</div>

	</div>
</body>

</html>