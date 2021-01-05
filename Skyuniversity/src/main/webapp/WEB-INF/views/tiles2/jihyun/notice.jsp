<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
</head>

<style>

	#classContainer {
		margin: 10px auto;
		width: 80%;
	}
	
	#subject {
		border-top: solid 2px #375472;
		border-bottom: solid 1px gray;
		padding: 7px 20px;
		text-align: center;
		font-size: 15pt;
		font-weight: bold;
	}
	
	#detailview {
		border-bottom: solid 1px gray;
		display: flex;
		justify-content: space-between;
		font-size: 11pt;
		background-color: rgb(250,250,250);
		color: gray;
		padding: 5px 15px;
	}
	
	#content {
		/* border: solid 1px gray; */
		padding: 20px;
		/* text-align: center; */
	}

</style>

<script type="text/javascript">

	console.log("${noticeInfo.readcount}");

</script>

<body>

	<div id="classContainer">
	
	  <c:set var="info" value="${noticeInfo}"/>
      <c:choose>
         <c:when test = "${noticeInfo.status == '1'}">
           <p style="font-size: 17pt; font-weight: bold;">학과공지</p>
         </c:when>
         <c:when test = "${noticeInfo.status == '2'}">
           <p style="font-size: 17pt; font-weight: bold;">과목공지</p>
         </c:when>
         <c:otherwise>
            <p style="font-size: 17pt; font-weight: bold;">전체공지</p>
         </c:otherwise>
      </c:choose>
		<div id="subject">
			${noticeInfo.subject}
		</div>
		<div id="detailview">
		<c:if test="${not empty noticeInfo.deptName}">
			<span>${noticeInfo.deptName}</span>
		</c:if>
		<c:if test="${not empty noticeInfo.subjectName}">
			<span>${noticeInfo.subjectName}</span>
		</c:if>
		<span></span>
		<span>${noticeInfo.readcount}</span>
			
		</div>
		<div id="content">
			${noticeInfo.contents}
		</div>
	</div>

</body>
</html>