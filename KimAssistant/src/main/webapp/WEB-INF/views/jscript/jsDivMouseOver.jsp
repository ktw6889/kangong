<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <title>Div Mouse Over 예제</title>
  <script>
 
  </script>
</head>
<body >
 	<div id="divMouseover">Mouse over Highlight</div>
 	<div id="divFloatingContent">Floating Content</div>
 	
 	<script>
 		(function(){
 			var divMouseover = document.getElementById("divMouseover"),
 				divFloatingContent = document.getElementById("divFloatingContent");
 			
 			divMouseover.onmouseover = function(){
 					var xhr = new XMLHttpRequest()
 						localDivMouseOverStyle = divMouseover.style;
 					localDivMouseOverStyle.backgroundColor = "#FF0000";
 					localDivMouseOverStyle.color = "white";
 					localDivMouseOverStyle.fontSize = "12px";
 					xhr.open("GET","http://localhost:8080/assistant/jscript/floating_contents");
 					xhr.onload = function(){
 						var localDivFloatingContent = divFloatingContent;
 						localDivFloatingContent.innerHTML = xhr.responseText;
 						localDivFloatingContent.style.display = "block";
 					};
 					xhr.send();
 			};
 			divMouseover.onmouseout = function(){
 				var localDivMouseOverStyle = divMouseover.style;
 				localDivMouseOverStyle.backgroundColor = "#FFFFFF";
 				localDivMouseOverStyle.color = "black";
 				localDivMouseOverStyle.fontSize = "10px";
 				divFloatingContent.style.display = "none";
 			};
 		}());
 	</script>
</body>
</html>