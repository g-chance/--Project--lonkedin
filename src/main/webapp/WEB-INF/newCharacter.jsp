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
	<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
	<script>
		let characters = "";
		let random = Math.floor((Math.random()*100)+1);
		let randList = "";
		let images = "";
		for(let i=random;i<random+19;i++) {
			randList += i+',';
		}
		randList += random+19;
		console.log(random)
		
		const proxyurl = "https://cors-anywhere.herokuapp.com/";
		const url = "https://api-v3.igdb.com/characters";
		console.log(proxyurl+url)
		axios({
			url: proxyurl+url,
			method: 'POST',
			headers: {
				'Accept': 'application/json',
				'user-key': "fad35d151de40e5ff0d5b772bc15b3ef"
			},
			"data": "fields name; where id = ("+randList+"); limit 20;"
			})
			.then(response => {
				console.log(response.data);
				for(let i=0;i<response.data.length;i++) {
					characters += '<option value='+response.data[i].name+'>'+response.data[i].name+'</option>'
				}
				document.getElementById("characters").innerHTML = characters
			})
			.catch(err => {
				console.error(err);
			});
		
		const url2 = "https://api-v3.igdb.com/character_mug_shots";
		console.log(proxyurl+url2)
		axios({
			url: proxyurl+url2,
			method: 'POST',
			headers: {
				'Accept': 'application/json',
				'user-key': "fad35d151de40e5ff0d5b772bc15b3ef"
			},
			"data": "fields url;"
			})
			.then(response => {
				console.log(response.data);
				for(let i=0;i<response.data.length;i++) {
					images += '<img src='+response.data[i].url+' alt="">'
				}
				document.getElementById("images").innerHTML = images;
			})
			.catch(err => {
				console.error(err);
			});
	</script>
</head>

<body>
	<div class="wrapper">
		<div class="nav">
		
			<div class="nav1">
				<h1>Welcome to LonkedIn!</h1>
			</div>
			<div class="nav2">
				<a href="/logout">Logout</a>
			</div>
			
		</div>
		
		<h1>Create your character!</h1>
		
		<p><form:errors path="user.*"/></p>
		<form:form action="/newcharacter" method="post" modelAttribute="user">
			<p>
				<form:label path="name">Name</form:label>
				<form:select path="name" id="characters">
					<!-- AXIOS API RESULT DISPLAYED HERE -->
				</form:select>
			</p>
			<p>
				<form:label path="universe">Universe</form:label>
				<form:input path="universe"/>
			</p>
			<input type="submit" value="Submit"/>
		</form:form>

		<div id="images"></div>

	</div>
</body>

</html>