<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" %>
    
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
    
<!DOCTYPE html>
    
<html>
<head>
	<title>Home</title>
  <script  src="http://code.jquery.com/jquery-1.7.2.js"  integrity="sha256-FxfqH96M63WENBok78hchTCDxmChGFlo+/lFIPcZPeI="  crossorigin="anonymous"></script>
  <script src="${pageContext.request.contextPath}/resources/js/autocomplete/jquery.textcomplete.js" type="text/javascript"></script>

	<script type="text/javascript">	
	function init(){
		var obj =$('input[type=text], textarea');
		//alert(obj.val());
		//alert($("textarea[name=userArea]").val());

		//$('input[type=text], textarea').mention();
		//$("textarea[name=userArea]").mention();
		
		var li = $('li');
		li.map(function(index, elem){
			//console.log(index);
			console.log(elem);
		})
				
        getData();
		
		$("#pleaseEvent").on("keyup", function() {
			checkKey();
		});
		
		$("#textDiv").on("keyup", function() {
			checkKey();
		});
		
		
		var jsonObj = JSON.parse('{ "name":"김지훈", "나이":26, "지역":"서울" }');
		console.log(jsonObj.name);
		
		/* $("#pleaseEvent").on("keyup", function() {
			console.log('keyup');
			checkKey();
		})
		
		$("#pleaseEvent").on("click", function() {
			console.log('click');
			checkKey();
		}) */
        
		/*  var obj = {
			    data:["1|김태우|경영","2|김예린|수학"]
			  }
		var json_data = JSON.stringify(obj); // form의 값을 넣은 오브젝트를 JSON형식으로 변환
		var mentions = json_data;
		
		 $.map(this.mentions, function (mention) {
	  		 console.log(mention);
		 }) */
		 
		/* $mentions.map(function(index,mention){
			console.log(mention);
		}) */
		
		/* 
	  	 $.map(this.mentions, function (mention) {
	  		 console.log(mention);
                if(mention.indexOf(term) === 0){
                    var arryMention = mention.split('|');
                     alert( arryMention[0] + '<br>' + '(' + arryMention[1] + '), ' + arryMention[2]);
                }else{
                    null;
                }
            })   */
	}
	
	/*
	$.fn.mention = function(param, callback){
	    // JSON 은 '아이디|이름|소속'으로 구성됨
	    var url = '[주소]';
	    var __this = this;
	    $.getJSON(url, function(jdata){
	        $(__this).textcomplete([
	            {
	                mentions: jdata.data,
	                match : /\B@([\.\w]*)$/,
	                search: function (term, callback) {
	                    callback($.map(this.mentions, function (mention) {
	                        if(mention.indexOf(term) === 0){
	                            var arryMention = mention.split('|');
	                            return arryMention[0] + '<br>' + '(' + arryMention[1] + '), ' + arryMention[2];
	                        }else{
	                            null;
	                        }
	                    }));
	                },
	                index: 1,
	                replace: function (mention) {
	                    var arryMention = mention.split('<br>');
	                    return '@' + arryMention[0] + ' ';
	                }
	            }
	        ]);
	    });
	};
*/
function getData(){
	//$('#treeData').append('<tr><td>id</td><td>name</td><td>price</td><td>description</td></tr>');
	//$(function(){
		$.getJSON("/assistant/json/getJsonArray.do",function(data){
			//console.log($('#treeData').html());
			$('#treeData').append('<tr><td>id</td><td>name</td><td>price</td><td>description</td></tr>');
			console.log(data);
			$.each(data,function(){
				$('#treeData').append('<tr><td>'+this.id+'</td>'
						+'<td>'+this.name+'</td>'
						+'<td>'+this.price+'</td>'
						+'<td>'+this.description+'</td></tr>')
			});	//each
		})//getJSON
	//})//$function
	 
	}
	
function getData2(){

    var url = '/assistant/json/getJsonArray.do';
    var __this = this;
    $.getJSON(url, function(jdata){
        $(__this).textcomplete([
            {
                mentions: jdata.data,
                match : /\B@([\.\w]*)$/,
                search: function (term, callback) {
                    callback($.map(this.mentions, function (mention) {
                        if(mention.indexOf(term) === 0){
                            var arryMention = mention.split('|');
                            return arryMention[0] + '<br>' + '(' + arryMention[1] + '), ' + arryMention[2];
                        }else{
                            null;
                        }
                    }));
                },
                index: 1,
                replace: function (mention) {
                    var arryMention = mention.split('<br>');
                    return '@' + arryMention[0] + ' ';
                }
            }
        ]);
    });
}
 

var strategies = [{
	match: /(^|\b)(\w{2,})$/,
    search: function (term, callback) {
    	console.log(term);
        var words = ['google', 'facebook', 'github', 'microsoft', 'yahoo'];
        callback($.map(words, function (word) {
        	console.log(words);
            return word.indexOf(term) === 0 ? word : null;
        }));
    },
    replace: function (word) {    	
        return word.name + ' ';
    }
}];

//============================================================
var contextFunc = function (jsonData) { 
	var resultList = new Array();
	console.log(jsonData);
	$(jsonData).each(function(){
		//console.log(this.name);
	});

	return jsonData.toLowerCase(); 
};

//@입력시 나오는 리스트
var templateFunc = function (value) {
		var jsonObj = value;  //JSON.parse(value);
	  // `value` is an element of array callbacked by searchFunc.
	  //console.log(jsonObj);
	  return '<b>' + jsonObj.name + '</b>';
	};
	
var completeParam = [
	  { // mention strategy /(^|\s)@(\w*|(가-힣ㄱ-ㅎㅏ-ㅣ)*)$/
		    match: /(^|\s)@([a-zA-Z]*|[가-히ㄱ-ㅎ]*)$/,    ///(^|\s)@(\w*)$/,
		    search: function (term, callback) {
		      console.log(term);	
		      callback(term, true);
		      $.getJSON('/assistant/json/getJsonArray.do', { q: term })
		        .done(function (resp) { callback(resp); })
		        .fail(function ()     { callback([]);   });
		    },
		    replace: function (value) { //선택시 입력되는 값
		    	console.log("value:"+value);
		      return '$1@' + value.name + ' ';
		    }
		    ,cache: true
		    ,template: templateFunc
		  }
];

var completeOption = [{ maxCount: 20, debounce: 500 }];



function checkKey(){
	//$("#pleaseEvent").textcomplete(strategies);
	$("#pleaseEvent").textcomplete(completeParam);
	$("#textDiv").textcomplete(completeParam);
	
}	


  </script>
  
  	
</head>
<body onload="javascript:init();">
<h1>
	Hello KTW!  
</h1>

 <input type="text" name="user" value="김태" />
 <textarea id="pleaseEvent" > <br>김태우</br> </textarea>
 <div id="textDiv" style="background-color:pink;width:200px;height:50px;border:1px" contenteditable="true">
 	안녕하세요~ <br>김태우</br>
 </div>

	<ui>
		<li>html</li>
		<li>css</li>
		<li>javascript</li>
	</ui>

	<table id="treeData" border="1">
	</table>
	
	
</body>
</html>
