<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
   String ctxPath = request.getContextPath();
%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<style type="text/css">
#info {
	color: #737373;
	font-size: 9.5pt;
	padding-left: 5px;
}
#info > li {
	padding-bottom: 10px;
}
.info > td {
	width: 550px;
}
.info > td > input {
	border: none;
	color: #0066cc;
	font-weight: bold;
}
table#scroltbl {
	border-collapse:collapse; width:100%;
}
#scrolth {
	float:left; width:100%;
}
#bodys {
	overflow-y:auto; overflow-x:hidden; float:left; width:100%; height:350px;
}
#subli {
	display: table; width: 1370px;
}
.sublicl {
	display:table; width:1370px;
} 
.sublicl > td {
	font-size: 9pt;
	text-align: center;	
}
#subli > td {
	width:280px;
	font-size: 9pt;
	text-align: center;
}
#workli > li {
	padding-bottom: 10px;
}
* {box-sizing: border-box}

/* Set height of body and the document to 100% */
body, html {
  height: 100%;
  margin: 0;
  font-family: Arial;
}

/* Style tab links */
.tablink {
  background-color: #555;
  color: white;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  font-size: 17px;
  width: 500px;
  
}

.tablink:hover {
  background-color: #777;
}

/* Style the tab content (and add height:100% for full page content) */
.tabcontent {
  color: white;
  display: none;
  padding: 100px 20px;
  height: 100%;
}

#Home {background-color: red;}
#News {background-color: green;}
#Contact {background-color: blue;}
#About {background-color: orange;}

#trth > th{
}

.trtd > td{
} 
#trth, .trtd {
   text-align: center;
   font-weight: normal;
}
.title{
   width: 300px;
}
.content{
   width: 1200px;
   height: 200px;
}
#plan, #worknotice {
   text-align: center;
   color:black;
}
#tbldiv {
   margin: 0 auto;
   width: 1500px;
}
#include {
   margin: 0 auto;
   width: 1600px;
}
#includenext {
   border: solid 1px #f2f2f2;
   width: 800px;
   height: 650px;
}
#nextol > li {
   font-size: 18pt;
}
#container {
   height: 1000px;
}
#classli {
   font-size: 15pt;

}
#classul {
   width: 300px;
}
#title {
   font-size: 18pt;
}
#div1 {
   width:500px;
}
.ulstyle {
   background-color: white;
   border: none;   
}
.ulstyle:hover{
   background-color: white;
   border: none;
}
.ulstyle:click{ 
   background-color: white;
   color: red;
   border: none;
}
#contain {
   width: 1000px;
   margin: 0 auto;
}
#full {
   text-align: center;
}
#includes {
	width: 800px;
	padding-top: 20px;
	height: 100px;
}
#subtitle{
	display: block;
}
</style>
<script type="text/javascript">
</script>
<div style="padding-left: 10px; padding-right: 10px;">  

<div>
	<span style="font-size: 12pt; font-weight: bold;float: left;">수강과목 및 과제</span>
</div>  
<br><br>       
<div style="border: solid 2px #cccccc; padding: 10px; border-radius: 6px; float: left; width: 49%; height: 250px;">
<div style="background-color:#fff2e6; padding: 5px; font-weight: bold;text-align: center;">
<span>2020학년 2학기 수강과목</span>
</div>	
<br>
	<ul>    
		<c:forEach items="${sublist}" var="str" >
		<li style="padding-bottom: 5px; font-weight: bold;">${str}</li>     
		</c:forEach>
	</ul>
</div>      
<div style="border: solid 2px #cccccc; padding: 10px; border-radius: 6px;  float: right; width: 49%; height: 250px; margin-bottom: 10px;">
<div style="background-color:#fff2e6; padding: 5px; font-weight: bold;text-align: center;">
<span>수강과목 과제</span>
</div>
<br>
<c:forEach items="${worklist}" var="vo" varStatus="status">
<label>[${vo.subjectName}]&nbsp;과제</label>
<p><a href="#ex${status.index}" rel="modal:open"  onclick="funcmodal();" style="font-weight: bold;">${vo.subject}</a></p>
<br/>
<div style="text-align: center;">
<div id="ex${status.index}" class="modal" style="width:500px; margin: 0 auto; height: 300px; margin-top: 100px;">
	<div>
		<h4 style="font-weight: bold;">[<span style="color:red;">${vo.subjectName}</span>]&nbsp;과제</h4>
	</div>	
	<br>
		<ul id="workli">
			<li style="padding-left: 0px;">
				<label>기간:</label>
				<span>${vo.startDate}~${vo.endDate}</span>
			</li>
			<li style="padding-left: 0px; ">
				<label>과제제목:</label>
				<span>${vo.subject}</span>
			</li>
			<li style="padding-left: 0px; ">
				<label>과제내용:</label>
				<span>${vo.contents}</span>
			</li>
		</ul>								 
		<a href="#" rel="modal:close" onclick="funcclose();" style="float: right;">닫기</a>
	
</div>
</div>           
</c:forEach>		
</div>
<br/>
<div style="padding-top: 10px; clear: both;">
	<span style="font-size: 12pt; font-weight: bold; ">과제 스케줄러</span>
</div>   
<br>
<div style="border: solid 2px #cccccc; padding: 20px; border-radius: 6px; clear: both; height: 750px; text-align: center;">
	<div style="background-color:#d9f2e5; padding: 5px; font-weight: bold;text-align: center;">
<span>과제 스케줄을 등록하고 관리하세요.</span>
</div>	
	<div id="includes" style="margin: 0 auto;">
		<jsp:include page="a.jsp"/>
	</div>
</div>

</div>