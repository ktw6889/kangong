<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" %>
    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>JSRender Test</title>

<script src="http://code.jquery.com/jquery-1.11.2.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/jsrender.min.js" type="text/javascript"></script>
<link href="${ctx}/resources/css/demos.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/resources/css/movielist.css" rel="stylesheet" type="text/css" />	


</head>
<body >
<button id="btnToggle">Toggle Pending</button>
<br/>
<div id="divPending">Pending</div>

<script>
/**
 * 
 */

 (function(){
	var pendingInterval = false,
		div = document.getElementById("divPending"),
		btn = document.getElementById("btnToggle");
	
	function startPending(){
		if(div.innerHTML.length > 13){
			div.innerHTML = "Pending";
		}
		div.innerHTML +=".";
	};
	btn.addEventListener("click",function(){
		if(!pendingInterval){
			if(!pendingInterval){
				pendingInterval=setInterval(startPending,500);
			}else{
				clearInterval(pendingInterval);
				pendingInterval = false;
			}
		}
	});
 }());
</script>

</body>
</html>