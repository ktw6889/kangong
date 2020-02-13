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

<script>
/**
 * 문제 : i가 전역스코프로 마지막 것만 보게된다
 */
function forScope(){
	var len=3;
	for( let i=0; i<len; i++){
		document.getElementById("div"+i).addEventListener("click", function(){
			alert("You clicked div #"+i);
		},false);
	}
}

/**
 * 해결: function Scope으로 문제 해결
 */
function setDivClick(index){
	document.getElementById("divScope"+index).addEventListener(
			"click", 
			function(){
				alert("You clicked div #"+index);
			},
			false
	);
}

function forScopeUsingFunction(){
	var i, len=3;
	for(var i=0; i<len; i++){
		setDivClick(i);
	}
}

/**
 *  해결: 클로저를 사용한 문제해결
 */
 function forScopeUsingClosure (){
	 var i, len=3;
		for( i=0; i<len; i++){
			document.getElementById("divClosure "+i).addEventListener(
					"click", 
					(function(index){
						return function(){
							alert("You clicked divClosure  #"+index);
						};
					}(i)),
					false
			); //end listener
		}//end for
 }

/**
 * for 안의 변수들은  for Scope 변수로 접근 불가
 */
function forCal(){
	for(var i=0; i<10; i++){
		var total = (total || 0)+i;
		var last=i
		if(total > 16){
			break;
		}
	}
	console.log(typeof total !== "undefined"); 	//접근불가
	console.log(typeof last !== "undefined");	//접근불가
	console.log(typeof i !== "undefined");		//접근불가
	console.log("total === "+total+", last ==="+last);
}

/**
 * function Scope
 */
function functionScope(){
	var b ="Can you access me?";
}
console.log(typeof b === "undefined");

/**
 * catch Scope  : catch()안의 변수만 해당
 */
function tryScope(){
	try{
		throw new exception("fake exception!");
	}catch(err){
		var test = "Can you see me";
		console.log(err instanceof ReferenceError === true);
	}
	console.log(test === "Can you see me"); 	//접근가능
	console.log(typeof err === "undefined"); 	//접근불가
}

/**
 * with Scope : with는 사용하지 말자
 */
function withScope(){
	with ({inScope:"You can't see me"}){
		var notInScope = "but you can see me";
		console.log(inScope === "You can't see me"); 	//접근가능
	}
	console.log(typeof inScope === "undefined");		//접근불가
	console.log(notInScope === "but you can see me");	//접근가능
}
	
/**
 * 클로저1
 */

function closureSpec1(){
	
	function outer(){
		var count = 0;
		var inner = function(){
			return ++count;
		};
		return inner;
	}
	var increase = outer();
	
	console.log(increase());
	console.log(increase());
}

/**
 * 클로저2
 */
 function closureSpec2(){
	function outer(){
		var count = 0;
		return {
			increase: function(){
				return ++count;
			},
			decrease: function(){
				return --count;
			}
		};
	}
	var counter = outer();
	console.log(counter.increase());
	console.log(counter.increase());
	console.log(counter.decrease());
	
	//새롭게 count됨
	var counter2 = outer();
	console.log(counter2.increase());
}

/**
 * 클로저3
 */
 function closureSpec3(){
 
 var countFactory = (function(){
	 var staticCount = 0;
	 return function(){
		var localCount = 0;
		return {
			increase: function(){
				return{
					static: ++staticCount,
					local: ++localCount
				};
			},
			decrease: function(){
				return{
					static: --staticCount,
					local: --localCount
				};
			}
		};
	 };
 }());

 var counter = countFactory(), counter2 = countFactory();
 console.log(counter.increase());
 console.log(counter.increase());
 console.log(counter2.decrease());
 console.log(counter.increase());
}

/**
 * 클로저 쉽게 이해하기
 */
 function easeClosure(){
	
	function sum(base){
		var inClosure = base;
		return function (adder){
			return inClosure + adder;
		};
	};
	
	var fiveAdder = sum(5);  //inClosure = 5 and return function
	fiveAdder(3);	//inColsure(5) + adder(3) = 8
	var threeAdder = sum(3); //inClosure = 3 and return function
}
 
/**
 * init
 */
function init(){
	
	forScope();
	
	/* forCal();
	
	forScopeUsingFunction();
	forScopeUsingClosure ();
	
	closureSpec1();
	closureSpec3(); */
	
	easeClosure();
}
</script>
</head>
<body onload='init();'>
<div id="div0">Click me! Div 0</div>
<div id="div1">Click me! Div 1</div>
<div id="div2">Click me! Div 2</div>
<br/>
<br/>
<div id="divScope0">Click me! Div 0</div>
<div id="divScope1">Click me! Div 1</div>
<div id="divScope2">Click me! Div 2</div>
<br/>
<br/>
<div id="divClosure 0">Click me! Div 0</div>
<div id="divClosure 1">Click me! Div 1</div>
<div id="divClosure 2">Click me! Div 2</div>

</body>
</html>