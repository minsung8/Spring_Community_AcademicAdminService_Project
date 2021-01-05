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
.spansty {
	font-weight: bold;
}
#chkspan {
	color: red;
	font-size: 7pt;
	font-weight: bold;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	
});

function funcearlyok() {
	
	var flag = true
	if(${sumsemcheck} == true){
		$("#span1").text("통과");
		$("#span1").css('color','#0066cc');
	}
	else{
		$("#span1").text("미통과");
		flag = false;
		$("#span1").css('color','red');
	}
	
	if(${fcheck} == true){
		$("#span2").text("통과");
		$("#span2").css('color','#0066cc');
	}
	else{
		$("#span2").text("미통과");
		$("#span2").css('color','red');
		flag = false;
	}
	
	if(${checkgrade} == true){
		$("#span3").text("통과");
		$("#span3").css('color','#0066cc');
	}
	else{
		$("#span3").text("미통과");
		$("#span3").css('color','red');
		flag = false;
	}
	
	if(${mustsub} == true){
		$("#span4").text("통과");
		$("#span4").css('color','#0066cc');
	}
	else{
		$("#span4").text("미통과");
		$("#span4").css('color','red');
		flag = false;
	}
	
	if(${sumcredit} == true){
		$("#span5").text("통과");
		$("#span5").css('color','#0066cc');
	}
	else{
		$("#span5").text("미통과");
		$("#span5").css('color','red');
		flag = false;
	}
	
	if(!flag){
		$("#chkspan").text("미통과 내역이 존재하므로 조기졸업을 할 수 없습니다.");
	}
	else{
		$("#chkspan").text("조기졸업 요건에 모두 만족하므로 조기졸업 신청이 가능합니다.");
		var html = "<button onclick='funcclick();' style='border:none; background-color: #4d4d4d; color: white; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px; border-radius: 3px;'>조기졸업신청하기</button>";
		$("#btndiv").html(html);
	}
}


function funcclick(){
	var size = ${size};
	if(size > 0){
		alert("이미 조기졸업을 신청하셨습니다. 승인여부를 기다려주세요.");
	}
	else {
	var check = confirm("조기졸업신청을 하시겠습니까?");
	if(check){
		var frm = document.earlyfrm;
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/earlyGraduateEnd.sky";
		frm.submit();	
	}
	}
}
function funcdel(index){
	

	var no = $("#no"+index).val();
	var check = confirm("조기졸업 신청을 취소하시겠습니까?");
	if(check){
		location.href="<%=ctxPath%>/delGraduateEarly.sky?seq="+no;
	}
	else{
		return;
	}
}
</script>
<div style="padding-left: 10px; padding-right: 10px;">
<div>
	<span style="font-size: 12pt; font-weight: bold;float: left;">학적정보</span>
</div>
<br><br>
<div style="border: solid 2px #cccccc; padding: 20px; border-radius: 6px;">
	<table>
		<tr class="info">
			<td>
				<label>학번:</label>
				<input type="text" value="${paraMap.deptName}" style="width: 100px;"/>
			</td>
			<td>
				<label>성명:</label>
				<input type="text" value="${paraMap.name}" style="width: 100px;"/></td>
			<td>
				<label>학과:</label>
				<input type="text" value="${paraMap.deptName}"/>
			</td>
			<td>
				<label>학적상태:</label>
				<input type="text" value="${paraMap.status}"/>
			</td>
			<td>
				<label>생년월일:</label>
				<input type="text" value="${paraMap.birth}"/>
			</td>
		</tr>
		<tr class="info">
			<td>
				<label>전화번호:</label>
				<input type="text" value="${paraMap.mobile}"/>
			</td>
			<td>
				<label>이메일:</label>
				<input type="text" value="${paraMap.email}"/>
			</td>
			<td>
				<label>학년:</label>
				<input type="text" value="${paraMap.grade}학년"/>
			</td>
			<td>
				<label>이수학기:</label>
				<input type="text" value="${paraMap.currentSemester}학기"/></td>
		</tr>
		<tr class="info">
			<td colspan="5">
				<label>주소:</label>
				<input type="text" value="${paraMap.address} ${paraMap.extraaddress}  ${paraMap.detailaddress}" style="width: 800px;"/>
			</td>
		</tr>
	</table>
</div>
<br>
<div>
	<span style="font-size: 12pt; font-weight: bold;float: left;">조기졸업 신청가능 여부</span>
</div>
<br><br>
<div style="border: solid 2px #cccccc; padding: 10px; border-radius: 6px;">
	<ul>
		<li>
			<label>등록학기 6학기 이상 확인: </label>
			<span id="span1" class="spansty"></span>
		</li>
		<li>
			<label>F학점 취득 여부 확인: </label>
			<span id="span2" class="spansty"></span>
		</li>
		<li>
			<label>평점 평균 4.0 이상 확인: </label>
			<span id="span3" class="spansty"></span>
		</li>
		<li>
			<label>교양 및 전공 필수과목 이수 확인: </label>
			<span id="span4" class="spansty"></span>
		</li>
		<li>
			<label>총 학점 100학점 이상 이수 확인: </label>
			<span id="span5" class="spansty"></span>
		</li>
		<br/> 
		<button onclick="funcearlyok();" style="border:none; background-color: #4d4d4d; color: white; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px; border-radius: 3px;">확인하기</button>
		&nbsp;&nbsp;&nbsp;<span id="chkspan"></span>
		<div id="btndiv" style="padding-top: 10px;"> 
			
		</div>
	</ul>
</div>
<br>
<form name="earlyfrm">
<input type="text" value="${sumsem}" name="sumSem" hidden="true"/>
<input type="text" value="${sumcredits}" name="sumCredit" hidden="true"/>
<input type="text" value="${sum}" name="avgGrade" hidden="true"/>
<input type="text" value="${paraMap.memberNo}" name="fk_memberno" hidden="true"/>
</form>
<div>
	<span style="font-size: 12pt; font-weight: bold;float: left;">조기졸업 신청내역</span>
</div>
<br><br>
<div style="border: solid 2px #cccccc;border-radius: 6px; height: 350px;">
	<table class="table table-striped" id="scroltbl">
		<thead id="scrolth">
			<tr id="subli">
				<td style="width: 200px;">신청일자</td>
				<td style="width: 100px;">총취득학점</td>
				<td style="width: 100px;">총이수학기</td>
				<td style="width: 100px;">평점평균</td>
				<td style="width: 200px;">승인여부</td>
				<td style="width: 200px;">승인일자</td>
				<td style="width: 100px;">불가사유</td>
				<td style="width: 100px;">취소</td>
			</tr>
		</thead>
		<tbody id="bodys">
			<c:forEach items="${earlylist}" var="vo" varStatus="status">
			<tr class='sublicl'>
				<td style="width: 200px;">${vo.regDate}</td>
				<td style="width: 100px;">${vo.sumCredit}</td>
				<td style="width: 100px;">${vo.sumSem}</td>
				<td style="width: 100px;">${vo.avgGrade}</td>
				<td style="width: 200px;">${vo.approve}</td>
				<td style="width: 200px;">${vo.approveDate}</td>
				<td style="width: 100px;">${vo.noreason}</td>				   
				<c:if test="${vo.approve == '승인전'}"> 
					<td style="width: 100px;"><button onclick="funcdel(${status.index})" style='border:none; background-color:#e6e6e6; color: #e62e00; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px; border-radius: 3px;'>취소</button>
					<input type="text" value="${vo.earlyNo}" id="no${status.index}" hidden="true"/>
					</td> 
				</c:if> 
				<c:if test="${vo.approve == '승인완료'}"> 
					<td style="width: 100px;"></td>
				</c:if>
			</tr> 
			</c:forEach>
		</tbody>
	</table>
</div>

</div>