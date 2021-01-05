<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === #24. tiles 를 사용하는 레이아웃1 페이지 만들기 === --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<%
   String ctxPath = request.getContextPath();
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SKY UNIVERSITY</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%= ctxPath %>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
  	<script type="text/javascript" src="<%= ctxPath %>/resources/jquery-ui-1.11.4.custom/jquery-ui.js"></script>
  
    <link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/layoutStyle.css" />
    <link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/ansehyeong.css" />
  
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <%--  ===== #179. 스피너를 사용하기 위해  jquery-ui 사용하기 ===== --%>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jquery-ui-1.11.4.custom/jquery-ui.css" />
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	
	

</head>
<body>
   <div id="mycontainer">
      <div id="myheader">
         <tiles:insertAttribute name="header" />
         
      </div>
      
      <div id="mycontent" align="center" style="">
         <tiles:insertAttribute name="content" />
      </div>
      
      <div id="myfooter" style="clear: both;">
         <tiles:insertAttribute name="footer" />
      </div>
   </div>
</body>
</html>    