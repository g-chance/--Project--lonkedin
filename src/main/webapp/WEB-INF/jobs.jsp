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
				<h1>Welcome, <c:out value="${user.email}" /></h1>/h1>
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
                <h2>ADD A COMPANY</h2>
				<p><form:errors path="game.*"/></p>
				<form:form action="/game" method="post" modelAttribute="game">
				    <p>
				        <form:label path="name">Company Name:</form:label>
				        <form:input path="name"/>
                    </p>
                    <p>
				        <form:label path="description">Company Description:</form:label>
				        <form:input path="description"/>
				    </p>
				    <input type="submit" value="Create a Company!"/>
				</form:form>
			</div>
			
<!-- jobForms COLUMN 2 **ADDING JOBS** -->
       	<!-- NEED TO FIND A WAY SO THAT ONLY COMPANY CEOS/SUPERVISORS CAN MAKE JOBS FOR THE SPECIFIC COMPANY -->
       	
            <div class="col2 jobForm">
                <h2>ADD A JOB</h2>
				<p><form:errors path="job.*"/></p>
				<form:form action="/jobs" method="post" modelAttribute="job">
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
                                <form:option value="good" label="For Good Guys"/>
                                <form:option value="bad" label="For Bad Guys"/>
                            </form:select>
				    </p>
				    <input type="submit" value="Create a new Job!"/>
				</form:form> 
			</div>
		</div>
		
<!-- JOB LISTINGS -->

        <div class="jobListings">
         <!-- For loops for displaying current available jobs -->
            <table>
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Salary</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${jobs}" var="job">
                        <tr>
                            <td>${job.title}</td>
                            <td>${job.description}</td>
                            <td>${job.salary}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
		</div>
	</div>
</body>

</html>