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
<title>Scope</title>


</head>
<body onload="ktw()";>
<from name="bodyForm">
안녕하세요!!

</from>
<iframe name="iframe1"  width="3000" height="300"/>
<iframe name="iframe2"  width="3000" height="300"/>
<iframe name="iframe3"  width="3000" height="300"/>
</body>
</html>

<script>
var g="GLOBAL";
alert(g);
function test(){
	alert(g);
	var g = "Test";
	alert(g);
}


function ktw(){
	goIframe1();
	goIframe2();
}

function goIframe1(){
	var form = document.bodyForm;
	form.method = "post";
	form.target= "iframe1";
	form.action =	"http://localhost:8080/assistant/jscript/jsClosure.do";
	form.submit();
	
	//$("#ifrm_01").attr("src", 'iframe.html'); 
}
function goIframe2(){
	var form = document.bodyForm;
	form.method = "post";
	form.target= "iframe2";
	form.action =	"http://localhost:8080/assistant/jscript/jsClosure.do";
	form.submit();
	
	//$("#ifrm_01").attr("src", 'iframe.html'); 
}


var defaults = {
		 
	    // We define an empty anonymous function so that
	    // we don't need to check its existence before calling it.
	    onImageShow : function() {},
	 
	    // ... rest of settings ...
	 
	};
	 
	// Later on in the plugin:
	 
	nextButton.on( "click", showNextImage );
	 
	function showNextImage() {
	 
	    // Returns reference to the next image node
	    var image = getNextImage();
	 
	    // Stuff to show the image here...
	 
	    // Here's the callback:
	    settings.onImageShow.call( image );
	}
	
	//function getNextImage();

</script>