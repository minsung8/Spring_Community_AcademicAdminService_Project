<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/20.2.4/css/dx.common.css" />
<link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/20.2.4/css/dx.light.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>

	#noticeBlock, #mysubjectsBlock, #scheduleBlock {
		/* border: solid 1px gray; */
		width: 100%;
	}
	
	#notice, #mysubjects, #schedule {
		/* border: solid 1px gray; */
		width: 100%; 
	}
	
	div#indexContainer {
		/* border: solid 1px red; */
	}
	
	div#block1 {
		/* border: solid 1px blue; */
		display: flex;
		padding: 0 20px;
		justify-content: space-between;
	}
	
	div#block2 {
		display: flex;
		flex-direction: column;
		width: 43%;
	}
	
	#noticeBlock {
		/* border: solid 1px gray; */
		height: 400px;
	}
	
	#mysubjectsBlock {
		/* border: solid 1px gray; */
		height: 300px;		
		
	}
	
	#scheduleBlock {
		width: 55%;
	}
	
	td {
		text-align: left;
	}

	tr.nLine:hover {
		cursor: pointer;
		background-color: rgb(228,239,251, 0.8);
	}
	
	#mysubjects {
		border: 1px solid #c5c5c5;
		border-radius: 3px;
		padding: 1em 1.4em;
	}
	
	#mycontent {
		padding-top:20px;
	}

</style>
<script src="https://cdn3.devexpress.com/jslib/20.2.4/js/dx.all.js"></script>
<script type="text/javascript" src="https://unpkg.com/frozor-hybrid@2.0.4/index.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		$("tr.nLine").click(function(){
			
			var noticeNo = $(this).find(".noticeNo").val();
			//console.log(noticeNo);
			var nStatus = $(this).find(".status").val();
			//console.log(status);
			
			popup(noticeNo, nStatus)
			//console.log(url);
			
		});
		
	}); // end of $(document).ready(function(){});-----------------
	
	function popup(arg1, arg2){
		window.open("hsnotice.sky?noticeNo="+arg1+"&nStatus="+arg2,"공지사항", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=no");
	}

		
	$( function() {
	    $( "#tabs" ).tabs();
	  } );

	
	
	function showSubject(){
	
	};

</script>

<div id="indexContainer">

	<div id="block1">
		<div id="block2">
			<div id="noticeBlock">
				<h3>공지사항</h3>
				<div id="tabs" style="height: 330px;">
				  <ul>
				    <li><a href="#tabs-1">전체공지</a></li>
				    <li><a href="#tabs-2">학과공지</a></li>
				    <li><a href="#tabs-3">과목공지</a></li>
				  </ul>
				  <div id="tabs-1">
					  <table class="table" style="text-align: center;">
							<thead>
								<tr>
									<th>No</th>
									<th>제목</th>
									<th>게시일</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${empty hsNoticeList}">
									<tr>
										<td colspan="3">등록된 공지가 없습니다.</td>
									 </tr>
								</c:if>
								<c:if test="${not empty hsNoticeList}">
									<c:forEach var="n" items="${hsNoticeList}">
										<tr class="nLine">
											<td>
												<input type="hidden" class="noticeNo" value="${n.noticeNo}"/>
												<input type="hidden" class="status" value="${n.status}"/>
												${n.rno}
											</td>
											<td>${n.subject}</td>
											<td>${n.writeday}</td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
					</div>
				  <div id="tabs-2">
				   		<table class="table" style="text-align: center;">
							<thead>
								<tr>
									<th>No</th>
									<th>학과</th>
									<th>제목</th>
									<th>게시일</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${empty deptNoticeList}">
									<tr>
										<td colspan="3">등록된 공지가 없습니다.</td>
									 </tr>
								</c:if>
								<c:if test="${not empty deptNoticeList}">
									<c:forEach var="n" items="${deptNoticeList}">
										<tr class="nLine">
											<td>
												<input type="hidden" class="noticeNo" value="${n.noticeNo}"/>
												<input type="hidden" class="status" value="${n.status}"/>
												${n.rno}
											</td>
											<td>${n.deptName}</td>
											<td>${n.subject}</td>
											<td>${n.writeday}</td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
				  </div>
				  <div id="tabs-3">
				   		<table class="table" style="text-align: center;">
							<thead>
								<tr>
									<th>No</th>
									<th>과목</th>
									<th>제목</th>
									<th>게시일</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${empty subjectNoticeList}">
									<tr>
										<td colspan="3">등록된 공지가 없습니다.</td>
									 </tr>
								</c:if>
								<c:if test="${not empty subjectNoticeList}">
									<c:forEach var="n" items="${subjectNoticeList}">
										<tr class="nLine">
											<td>
												<input type="hidden" class="noticeNo" value="${n.noticeNo}"/>
												<input type="hidden" class="status" value="${n.status}"/>
												${n.rno}
											</td>
											<td>${n.subjectName}</td>
											<td>${n.subject}</td>
											<td>${n.writeday}</td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
				  </div>
				</div>
			</div>
			<div id="mysubjectsBlock">
				<h3>수강과목</h3>
				<div id="mysubjects">
					<table class="table" style="text-align: center;">
						<thead>
							<tr>
								<th>학기</th>
								<th>과목명</th>
								<th>비고</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${lectureList == '0'}">
								<tr>
									<td colspan="3" style="text-align: center;">수강중인 과목이 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${lectureList != '0'}">
								<c:forEach var="lList" items="${lectureList}">
									<tr>
										<td>${lList.courseYear}년&nbsp;${lList.semester}학기</td>
										<td>${lList.subjectName}</td>
										<td>${lList.lectureKind}</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		
		<div id="scheduleBlock" class="dx-viewport demo-container">
			<h3>학사일정</h3>
			<div id="scheduler"><jsp:include page="studentinfo/schedule.jsp" /></div>
		</div>
		
	</div>
</div>