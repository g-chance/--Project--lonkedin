<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>New Character</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript" src="/js/app.js"></script>
	<script>
	// Character randomization variables
		let characters = "";
		let random = Math.floor((Math.random() * 15240) + 1);
		let randList = "";
		for (let i = random; i < random + 19; i++) {
			randList += i + ',';
		}
		randList += random + 19;
		console.log(random)

	//Image randomization variables
		let randomImg = Math.floor((Math.random() * 350) + 21);
		let images = "";
		console.log(randomImg)

	// API calls
		const proxyurl = "https://cors-anywhere.herokuapp.com/";
		const url = "https://api-v3.igdb.com/characters";
		console.log(proxyurl + url)
		const url2 = "https://api-v3.igdb.com/character_mug_shots";
		console.log(proxyurl + url2)

		$(document).ready(function () {
			$.ajax({
				"url": proxyurl + url,
				"method": "POST",
				"timeout": 0,
				"headers": {
					'Accept': 'application/json',
					"user-key": "8a50eecd18de3490df8a98a7dafdea8e",
				},
				"data": "fields name; where id = (" + randList + "); limit 20;"
			}).done(function (response) {
				console.log(response);
				for (let i = 0; i < response.length; i++) {
					characters += '<option value="' + response[i].name + '">' + response[i].name + '</option>'
				}
				$("#characters").html(characters)
			});

			$.ajax({
				"url": proxyurl + url2,
				"method": "POST",
				"timeout": 0,
				"headers": {
					'Accept': 'application/json',
					"user-key": "8a50eecd18de3490df8a98a7dafdea8e",
				},
				"data": "fields image_id; where image_id!=(null); limit 374;"
			}).done(function (response) {
				console.log(response);
				for (let i = randomImg; i < randomImg + 21; i++) {
					images += '<img class="randomImage" src= https://images.igdb.com/igdb/image/upload/t_thumb/' + response[i].image_id + '.jpg alt="character mug shot">'
				}
				$("#flex").html(images);
			});

			$(document).ajaxComplete(function (e, xhr, settings) {
				$('img').click(function () {
					let picValue = $(this).attr("src");
					$("#picinput").attr("value", picValue);
					$("img").css("outline", "none");
					$(this).css("outline", "3px solid green");
				})
			})
		})
	</script>
</head>

<body>
	<div class="wrapper newCharacter">
		<div class="navwrapper">
			<div class="nav">
				<div class="nav1">
					<p class="llogo">Lonked<span>in</span></p>
				</div>
				<div class="nav2 smHide"></div>
				<div class="nav3 smHide">
					<a class="links logout" href="/logout">Lonkout</a>
				</div>
				<div class="dropdown lgHide">
					<div class="hamburger">
						<div></div>
						<div></div>
						<div></div>
					</div>
					<div class="ddlinks">
						<a class="ddlink" href="/logout">Lonkout</a>
					</div>
				</div>
			</div>
		</div>

		<div class="navSpacer"></div>

		<div class="regLog newChar">
			<h1 class="header">Tell us who you are!</h1>
			<p class="error">
				<form:errors path="user.*" />
			</p>
			<form:form class="form" action="/newcharacter" method="post" modelAttribute="user">
				<form:input class="input" list="characters" path="name" placeholder="What's your Name?"></form:input>
				<datalist id="characters">
					<!-- AXIOS API RESULT DISPLAYED HERE -->
				</datalist>
				<form:input class="input" path="universe" placeholder="What Universe are you from?" />
				<form:label class="input picture" path="picture">Select your avatar:</form:label>
				<div class="images">
					<div class="flex">
						<img class="lonkImage" src="/images/lonk.jpg" alt="" />
						<img class="lonkImage" src="/images/lonk.jpg" alt="" />
						<img class="lonkImage" src="/images/lonk.jpg" alt="" />
						<img class="lonkImage" src="/images/lonk.jpg" alt="" />
						<img class="lonkImage" src="/images/lonk.jpg" alt="" />
						<img class="lonkImage" src="/images/lonk.jpg" alt="" />
						<img class="lonkImage" src="/images/lonk.jpg" alt="" />
					</div>
				</div>
				<div class="images">
					<div id="flex"></div>
				</div>
				<form:input id="picinput" type="hidden" class="input" path="picture" value="" />
				<input class="input submit" type="submit" value="Submit" />
			</form:form>
		</div>
	</div>
</body>

</html>