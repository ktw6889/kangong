<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <title>클로저 예제</title>
  <script>
  var x = "global";
  function f () {
      alert(x);            //undefined 출력
      
      var x = "local";    //지역변수 "local" 선언
      
      alert(x);            //"local" 출력
  }
  
  //==================================
	  
  function f1 () {
	    var a = 1;
	    f2 ();
	}
	 
	function f2 () {
	    return a;
	}
	 
	f1(); //a is not defined error

  
  function init(){
	  //f1();
	  console.log("선언을 안한 경우:")
  }
	
  </script>
</head>
<body onload="init();">
  <div id="wrapper">
    <button data-cb="1">Add div</button>
    <button data-cb="2">Add img</button>
    <button data-cb="delete">Clear</button>
    Adding below... <br/>
    <div id="appendDiv"></div>
  </div>
  <script>
    (function() {
      var appendDiv = document.getElementById("appendDiv");
      document.getElementById("wrapper").addEventListener("click", append);
      
      var myVariable=null;
      var myV = {};
      
      function append(e) {
        var target = e.target || e.srcElement || event.srcElement;
        var callbackFunction = callback[target.getAttribute("data-cb")];
        appendDiv.appendChild(callbackFunction());
      };
      
      var callback = {
        "1": (function () {
          var div = document.createElement("div");
          div.innerHTML = "Adding new div";
          return function () {
            return div.cloneNode(true);
          };
        })(),
        "2": (function () {
          var img = document.createElement("img");
          img.src = "https://dummyimage.com/600x400/000/fff";
          return function () {
            return img.cloneNode(true);
          };
        })(),
        "delete": function() {
          appendDiv.innerHTML = "";
          return document.createTextNode("Cleared");
        }
      };
    })();
  </script>
</body>
</html>