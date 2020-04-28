<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Dashboard</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<script type="text/javascript" src="/js/app.js"></script>
</head>

<body>
	<div class="wrapper">
	
		<div class="nav">
		
			<h1>Welcome, <c:out value="${user.email}" /></h1>
			<a href="/logout">Logout</a>
			
		</div>
			
		<div class="dash">
			
		<!-- COLUMN 1 -->
			<div class="col1">
			<!-- Each div you add below here will be a row in column 1 -->
				
			</div>
			
		<!-- COLUMN 2 -->		
			<div class="col2">
			<!-- Each div you add below here will be a row in column 2 -->
				
			</div>
			
		</div>
		
	</div>
</body>

</html>