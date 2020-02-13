<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" %>
<html>
<head>
	<title>Home</title>
	<script
  src="http://code.jquery.com/jquery-2.2.4.js"
  integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI="
  crossorigin="anonymous"></script>
	
	<style>
	.divpop {
	    display: inline-block;
	    z-index: 3000;
	    position: absolute;
	    top: 0px;
	    left: 0px;
	}
	.divpop .divpop_frm {
	    display: inline-block;
	    background-color: #ffffff;
	    outline: 1px #57585b solid;
	    box-shadow: 2px 2px 5px rgba(30, 30, 30, 0.3);
	    -webkit-box-shadow: 2px 2px 5px rgba(30, 30, 30, 0.3);
	    -moz-box-shadow:2px 2px    5px    rgba(30, 30, 30, 0.3);
	}
	.divpop .divpop_titlebar {
	    background-color: #E4E4E4;
	    border-bottom: 1px solid #B4B4B4;
	    width: 100%;
	    min-height: 40px;
	    vertical-align: middle;
	    cursor: move;
	}
	.divpop .divpop_titlebar>span{    
	    display: inline-block;
	    margin: 0 10px;
	    line-height: 40px;    
	    vertical-align: middle;    
	}
	.divpop_titlebar .divpop_title {    
	    font-size: 10pt;
	    font-weight: bold;
	}
	.divpop_titlebar .btn_close {
	    cursor: pointer;
	    float: right;
	}
	.divpop_content {
	    display: inline-block;
	    text-align: left;
	    padding: 0em;
	    width: 100%;
	    overflow: auto;
	}
	.divpop_iframe {
	    width: 100%;
	    height: 100%;
	    border: 0px;
	}
	.divpop_back {
	    position: absolute;
	    width: 100%;
	    height: 100%;
	    top: 0px;
	    background-color: #000000;
	    opacity: 0.2;
	    z-index: 2999;
	}
	</style>
	
	<script type="text/javascript">
	function checkText(){	
	 	var str = "123456789";
		var err = 0; 
		  
		for (var i=0; i<str.length; i++)  { 
		    var chk = str.substring(i,i+1); 
		    if(!chk.match(/[0-9]|[a-z]|[A-Z]/)) { 
		        err = err + 1; 
		    } 
		} 
		
		if (err > 0) { 
		    alert("���� �� ������ �Է°����մϴ�."); 
		    return;
		} 
	}
	
	
	function checkNumber(){
		var str = "123456��";
		if ( str.match(/[^0-9]/) != null ) {
		  alert("���ڸ� �Է��� �� �ֽ��ϴ�.");
		  return;
		}
	}
	
	function checkAlpabet(){
		var str = "üũ�� ���ڿ�";
		if ( str.match(/[^a-zA-Z]/) != null ) {
		  alert("������ �Է��� �� �ֽ��ϴ�.");
		  return;
		}
	}
	
	function checkNumberAlpabet(){
		var str = "üũ�� ���ڿ�";
		if ( str.match(/[^a-zA-Z0-9]/) != null ) {
		  alert("���ڿ� ������ �Է��� �� �ֽ��ϴ�.");
		  return;
		}
	}
	
	function checkSpecialChar(){
		var str = "üũ�� ����";

		for (var i=0; i < str .length; i++) { 
		    ch_char = str .charAt(i);
		    ch = ch_char.charCodeAt();
		        if( (ch >= 33 && ch <= 47) || (ch >= 58 && ch <= 64) || (ch >= 91 && ch <= 96) || (ch >= 123 && ch <= 126) ) {
		            alert("Ư�����ڸ� ����� �� �����ϴ�");
		            return;
		        }
		}
	}
	
	function checkKoreanChar(){	
		var str = "123üũ���ڿ�";
		for (i = 0; i < str.length; i++) 
		{
		    if (!((str.charCodeAt(i) > 0x3130 && str.charCodeAt(i) < 0x318F) || (str.charCodeAt(i) >= 0xAC00 && str.charCodeAt(i) <= 0xD7A3))) 
		    {
		        alert("�ѱ۸� �Է����ּ���");
		        form.value = "";
		        form.focus();
		        return;
		    }
		}
		
	}
	
	function init(){
		//checkText();
		//alert("adf124".match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/));
		//alert("4".match(/[0-9]|[a-z]|[A-Z]/));
		//alert( "df124".match(/([a-zA-Z0-9])/)  );
		
		//checkNumber();

		//alert($(window).scrollTop()+":"+$(window).scrollLeft()+":"+$(window).height() );
		fnLayerOpen();
	}
	
	 function doScrollerIE(dir, src, amount) 
     {
             if (amount==null) amount=10;
             if (dir=="up")
                     document.all[src].scrollTop-=amount;
             else
                     document.all[src].scrollTop+=amount;
     }

	 function fnLayerOpen(){
		 //��ũ�� �κб��� ������ ȭ�� ��ü Height
		 var height = document.body.scrollHeight;
		 $("#divLayerBg").css("height",height);
		 $("#divLayerBg").show();
		 
		 //���̾ ����. fadein ȿ��
		 var layer = $("#divLayer");
		 layer.fadeIn();
		 
		 //ȭ���� �߾ӿ� ���̾ ����.
		 if(layer.outerHeight()<$(document).height()){
			 layer.css('margin-top','-'+layer.outerHeight()/2+'px');
	    }else{
	    	layer.css('left','0px');
	    }
	 }
	 
	 function fnLayerClose(){
		 $("#divLayerBg").fadeOut();
		 $("#divLayer").fadeOut();
	 }
	 
	 

	 function openDivPopup(title, width, height, type, content, formNm, appendTagId){    
		    closeDivPopup();
		    
		    /* div �˾� Background */
		    var div_pop_back = $("<div>",{
		        css:{
		            width:$(window.top.document).width(),
		            height:$(window.top.document).height(),
		            opacity:0.1
		        }
		    }).addClass("divpop_back").attr("id","divpop_back");
		    div_pop_back.appendTo($('body', window.top.document));
		    // jquery�� �̿��Ͽ� div��ҿ� css����
		    
		    /* div �˾�â */
		    var div_pop =  $("<div>").addClass("divpop").attr("id","divpop");
		    var div_pop_frm = $("<div>").addClass("divpop_frm").appendTo(div_pop); // div_pop�� div_pop_frm�� �߰�
		    if(width){
		        div_pop_frm.width(width);
		    }    
		    
		    /* div pop_titlebar */
		    var pop_titlebar =  $("<div>").addClass("divpop_titlebar").attr("onmousedown", "drag(this, event)");
		    var pop_title = $("<span>"+title+"</span>").addClass("divpop_title");    
		    var pop_close = $("<span class='btn_close'>��</span>").attr("onclick", "closeDivPopup()");
		    // append(), appendTo() �޼����� ���� 
		    // append() ��(��ü)�� ����(�ڷ�)�� append
		    // appendTo() ���� ��ü�� append
		    // append() : $('.tObj').append("<p>�ڷ�</p>");  /  appendTo() : $("<p>�ڷ�</p>").appendTo('.tObj');
		    
		    pop_titlebar.append(pop_title, pop_close);
		    
		    /* div pop_content */
		    var pop_content = $("<div>").addClass("divpop_content");
		    
		    if(height){
		        div_pop_frm.height(height+40);
		        pop_content.height(height);
		    }
		    if(type == "t"){ // text ���
		    	
		    	content = "���¿�<br/>���¿�<br/>���¿�<br/>���¿�<br/>���¿�<br/>���¿�<br/>���¿�<br/>���¿�<br/>���¿�<br/>���¿�<br/>���¿�<br/>���¿�<br/>���¿�<br/>���¿�<br/>���¿�<br/>���¿�<br/>���¿�<br/>���¿�<br/>���¿�<br/>";
		    	
		        var text = $("<span>").addClass("divpop_text").html(content);
		        pop_content.append(text);
		        div_pop_frm.append(pop_titlebar, pop_content);
		        div_pop.append(div_pop_frm);
		    }
		    else if(type == "f"){ // iframe�� �ּ� ����
		        var iframe = $("<iframe>").attr("name","divpop_iframe").addClass("divpop_iframe");
		        pop_content.append(iframe);
		        
		        div_pop_frm.append(pop_titlebar, pop_content);
		        div_pop.append(div_pop_frm);
		        if(formNm){
		            $("form[name='"+formNm+"']").attr("target","divpop_iframe");
		            $("form[name='"+formNm+"']").attr("action",content);
		            $("form[name='"+formNm+"']").submit();
		        }else{
		            iframe.attr("src",content);
		        }
		    }
		   
		    
		    if(appendTagId){
		        div_pop.appendTo($("#"+appendTagId));
		    }
		    else{
		        div_pop.appendTo($("body", window.top.document));
		    }
		    div_pop.center();
		 
		    $("#divpop_back").fadeIn('fast');
		    $("#divpop").fadeIn('fast');
		}
		 
		jQuery.fn.center = function () {
		    this.css("position","absolute");
		    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) 
		                                + $(window).scrollTop()) + "px");
		    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) 
		                                + $(window).scrollLeft()) + "px");
		    return this;    
		}
		 
		function drag(element, ev){
		    //element : �巡���� ���, ev:�̺�Ʈ
		    document.body.style.cursor = "move";// ���콺Ŀ�� �巡�� ������� ����
		    
		    var top = ev.pageY;
		    var left = ev.pageX;
		    
		    var preTop = $("#divpop").css("top");
		    var preLeft =  $("#divpop").css("left");
		 
		    preTop = preTop.substring(0, preTop.length-2);
		    preLeft = preLeft.substring(0, preLeft.length-2);
		            
		    var mouseTop = top-preTop;
		    var mouseLeft = left-preLeft;
		        
		    document.onmousemove = function(ev) {
		        ev = ev || window.event;
		        var top = ev.pageY;
		        var left = ev.pageX;
		        $("#divpop").css("position","absolute");
		        $("#divpop").css("top",top-mouseTop + "px");
		        $("#divpop").css("left",left-mouseLeft + "px");
		        return false;
		    };
		 
		    document.onmouseup = function(ev) {
		        ev = ev || window.event;
		        document.body.style.cursor = "auto";
		        document.onmousemove = null;
		        document.onmouseup = null;
		        return false;
		    };
		    return false;
		}
		 
		function closeDivPopup(){
		    $("#divpop_back").remove();
		    $("#divpop").remove();    
		}
  </script>
  	
</head>
<body onload="javascript:init()">
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>






    <a onclick="openDivPopup('div�˾� test',400,300,'t','����')">Div �˾� ����־ ����</a>
    <a onclick="openDivPopup('div�˾� test',400,300,'f','http://www.naver.com')">Div �˾� iFrame���� ����</a>

</body>
</html>
