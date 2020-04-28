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
		
			<h1>Welcome, <c:out value="${user.email}" /></h1>
			<a href="/logout">Logout</a>
			
		</div>
			
		<div class="jobForms">
			
		<!-- jobForms COLUMN 1 **ADDING COMPANIES** -->
			<div class="col1 companyForm">
				<p><form:errors path="job.*"/></p>
				<form:form action="/jobs" method="post" modelAttribute="job">
				    <p>
				        <form:label path="company_name">Company Name:</form:label>
				        <form:input path="company_name"/>
				    </p>
				    <input type="submit" value="Submit"/>
				</form:form> 
			</div>
			
		<!-- jobForms COLUMN 2 **ADDING JOBS** -->		
			<div class="col2 jobForm">
				<p><form:errors path="_____.*"/></p>
				<form:form action="/_____" method="post" modelAttribute="_____">
				    <p>
				        <form:label path="_____">_____</form:label>
				        <form:input path="_____"/>
				    </p>
				    <input type="submit" value="Submit"/>
				</form:form> 
			</div>
			
		</div>
		
		<div class="jobListings">
		<!-- For loops for displaying current available jobs -->
		</div>
		
	</div>
</body>

</html>