<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
   String ctxPath = request.getContextPath();
%>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<style type="text/css">
.check {
	text-align: center;
}
#info {
	color: #737373;
}

</style>
<script type="text/javascript">

	function funcCheck(index){
		var no = $("input#no"+index).val();
		var subno = $("#subno"+index).text();
		var subname = $("#subname"+index).text();
		var proname = $("span#prname"+index).text();
		var semester = $("#semes"+index).text(); 

		location.href="<%=ctxPath%>/checkSub.sky?courseno="+no+"&subno="+subno+"&subname="+subname+"&proname="+proname+"&semester="+semester;
	}
</script>

<div style="padding-left: 10px; padding-right: 10px;">
<div>
	<span style="font-size: 12pt; font-weight: bold;">강의평가</span>
</div>
<br>
<div>
<table class="table table-bordered">
	<thead>
		<tr class="check">
			<td style="font-weight: bold;">년도/학기</td>
			<td style="font-weight: bold;">과목명</td>
			<td style="font-weight: bold;">과목코드</td>
			<td style="font-weight: bold;">교수명</td>
			<td style="font-weight: bold;">강의평가</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${checklist}" var="map" varStatus="status">
			<tr class="check">
				<td>${map.courseyear}/<span id='semes${status.index}'>${map.semester}</span></td>
				<td><span id="subname${status.index}">${map.subjectname}</span></td>
				<td><span id="subno${status.index}">${map.fk_subjectno}</span>
					<input id="no${status.index}" type="text" value="${map.courseno}" hidden="true"/>
				</td>
				<td><span id="prname${status.index}">${map.name}</span></td>
				<c:if test="${map.classchk == 0}">
				<td><button id="btn${status.index}" onclick="funcCheck(${status.index})" style="color:red; font-weight: bold; border: solid 1px #cccccc;">강의평가</button></td>
				</c:if>
				<c:if test="${map.classchk == 1}">
				<td><button disabled="disabled" style="color:#0066cc; font-weight: bold;">평가완료</button></td>
				</c:if>
			</tr>
		</c:forEach>
	</tbody>
</table>
</div>
<div id="divbtn">
<span style="font-size: 12pt; font-weight: bold; color: #ff4000">강의평가 안내</span>
</div>
<div style="padding-top: 20px;">
<ul id="info" >
    <li>강의평가 참여자의 익명성은 철저히 보장합니다.</li>
	<li>수강과목별로 강의평가 입력 후 저장하세요.</li>
	<li>중간강의평가 결과는 담당 교수님들께서 수강 학생들의 의견을 수렴하고, 강의품질 제고 및 강의내용을 개선하는 자료로 활용하오니 신중하게 실시하여 주시기 바랍니다.</li>
	<li>평가한 내용에 대한 학생들의 신분은 절대 노출되지 않음을 알려드립니다. </li>
</ul>
</div>
</div>
