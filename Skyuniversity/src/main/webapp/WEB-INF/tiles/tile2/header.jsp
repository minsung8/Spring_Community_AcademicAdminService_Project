<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ======= #28. tile2 중 header 페이지 만들기  ======= --%>
<%
   String ctxPath = request.getContextPath();
%>

<style>

 div#header {
 	font-family: "Open Sans", sans-serif, 돋움;
 }

 div#header {
 	height: 150px;
 	display: flex;
 	justify-content: space-between;
 }
 
 ul#myMenu {
 	list-style-type: none;
 }

 div#loginStudent {
 	align-self: flex-end;
 	padding-bottom: 50px;
 
 }

 span.sname {
 	font-size: 25pt;
 	font-weight: 600;
 }
  
  span.sinfo {
 	font-family: "Open Sans", sans-serif;
	font-size: 18pt;
	font-weight: 500;
 }

 div#logo {
 	padding-left: 30px;
 }
 
 span.btn {
 	cursor: pointer;
    margin: 3px;
    background-color: #0843ad;
    color: white;
    border-radius: 20px;
    font-weight: bold;
    font-size: 12pt;
 }
 
</style>

<div id="header">

	<div id="logo">
		<img src="<%= ctxPath %>/resources/images/logo_size.jpg" style="width: 250px; height: 100px; cursor: pointer;" onclick="location.href='<%= ctxPath %>/hsindex.sky';">
	</div>
	<div id="loginStudent">
	      <span class="sname">${sessionScope.loginuser.name}</span>
	      <span class="sinfo">${sessionScope.loginuser.deptName} ${loginuser.grade}학년</span>
	 </div>
	 <div>
	   <span class="btn" onclick="location.href='<%=ctxPath%>/index.sky';">커뮤니티</span>
	   <span class="btn" onclick="location.href='<%=ctxPath%>/logouths.sky';">로그아웃</span>
	 </div>
</div>
   
   