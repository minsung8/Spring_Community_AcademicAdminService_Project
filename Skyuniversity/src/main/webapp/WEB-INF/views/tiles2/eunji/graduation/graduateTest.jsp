<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
   String ctxPath = request.getContextPath();
%>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

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
	overflow-y:auto; overflow-x:hidden; float:left; width:100%; height:160px;
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
#tfval {
	border:none;
	color:red;
}
</style>
<script type="text/javascript">

$(document).ready(function() {
	var ok = ${graduok};
	if(ok == 1){   
		$("#tfval").val("졸업가능");
	}
	else{
		$("#tfval").val("졸업불가능");
	}
});

function funcdel(index){
	var no = $("#no"+index).val();
	var check = confirm("복학신청을 취소하시겠습니까?");
	if(check){
		location.href="<%=ctxPath%>/comeSchool.sky?seq="+no;
	}
	else{
		return;
	}
}

function funcmodal() {
	var gradu = $("#gradu").text();
	
	$.ajax({
		url: "<%= request.getContextPath() %>/graduateTestAjax.sky",
		data: {"gradu":gradu},
		type: "GET",
		dataType: "json",
		success: function(json) {
			if(json.check){
				$("#tfval").val("졸업가능");
			}
			else{
				$("#tfval").val("졸업불가능");
			}
		},
		error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	});
}

function funcclose(){
	alert("졸업적부심사가 완료되었습니다.");
	location.reload();
}
</script>

<div style="padding-left: 10px; padding-right: 10px;">
<div>
	<span style="font-size: 12pt; font-weight: bold;float: left;">학적정보</span>
</div>
<br><br>
<div style="border: solid 2px #cccccc; padding: 10px; border-radius: 6px;">
	<ul style="list-style: none; padding-left: 0px; padding-right: 0px;">
		<li>
			<label>총 이수학기: </label>
			<span style="color:#0066cc; font-weight: bold;">${sumsems}</span>학기
		</li>
		<li>
			<label>교양 총 이수학점: </label>
			<span style="color:#0066cc;font-weight: bold;">${sumculture}</span>학점
			&nbsp;&nbsp;
			<label>전공 총 이수학점: </label>
			<span style="color:#0066cc;font-weight: bold;">${summajor}</span>학점
			&nbsp;&nbsp;
			<label>총 이수학점: </label>
			<span style="color:#0066cc;font-weight: bold;">${sumcredits}</span>학점
		</li>
		<li>
			<label>심사여부:</label>
			<input type="text" id="tfval" style="border:none;"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<c:if test="${test == 'ok'}">
			<div id="ex1" class="modal" style="width:500px; text-align: center;">
				  <div style="margin: 0 auto;">
					  <h4 style="font-weight: bold;">졸업적부심사</h4>
					  <br>
					  <p>귀하께서는<span><span style="color: red; font-weight: bold;">총 교양이수학점 ${sumculture}학점</span> + <span style="color: red; font-weight: bold;">총 전공이수학점 ${summajor}학점</span><br><span style="color: red; font-weight: bold;">총 이수학점 ${sumcredits}학점</span>으로 졸업학점에 충족됩니다.</span></p>
					  <div>
					  	<p style="font-size: 8pt; font-weight: bold;">미이수과목 조회</p>
						<table class="table table-bordered">
							<thead >
								<tr>
									<td style="font-weight: bold; font-size: 8pt;">구분</td>
									<td style="font-weight: bold; font-size: 8pt;">과목명</td>
									<td style="font-weight: bold; font-size: 8pt;">이수여부</td>
								</tr>
							</thead>
							<tbody>
								<c:if test="${size != 0}">
								<c:forEach items="${nonelist}" var="map" varStatus="status">
								<tr>
									<c:if test="${map.deptseq == 23}">
										<td style="width: 200px;">교양필수</td>
									</c:if>
									<c:if test="${map.deptseq != 23}">
										<td style="width: 200px;">전공필수</td>
									</c:if>
									<td style="width: 200px;">${map.name}</td>
									<td style="width: 200px; color:red; font-weight: bold;">미이수</td>
								</tr>
								</c:forEach>
								</c:if>
							</tbody>
						</table>
					  </div>
					  <div>
					  	<p style="color:#0066cc;font-weight: bold;">필수과목을 모두 이수하셨습니다.</p>
					  	<p>심사결과: <span style="color:red;font-weight: bold;" id="gradu">졸업가능</span></p>
					  </div>
					  <a href="#" rel="modal:close" onclick="funcclose();">닫기</a>
				  </div>
			</div>
 			</c:if>
			<c:if test="${test == 'no'}">
			<div id="ex1" class="modal" style="width:500px; text-align: center;">
				  <div style="margin: 0 auto;">
					  <h4 style="font-weight: bold;">졸업적부심사</h4>
					  <br>
					  <p>귀하께서는<span><span style="color: #0066cc; font-weight: bold;">총 교양이수학점 ${sumculture}학점</span> + <span style="color: #0066cc; font-weight: bold;">총 전공이수학점 ${summajor}학점</span><br><span style="color: #0066cc; font-weight: bold;">총 이수학점 ${sumcredits}학점</span>으로 졸업학점에 		  
					  <c:if test="${sumcredits < 130}"><span style="color:red;">충족되지 않습니다.</span></c:if>
					  <c:if test="${sumcredits >= 130}"><span style="color:#0066cc;">충족됩니다.</span></c:if>
					  </span></p>
					  <div>
					  	<p style="font-size: 8pt; font-weight: bold;">미이수과목 조회</p>
						<table class="table table-bordered">
							<thead >
								<tr>
									<td style="font-weight: bold; font-size: 8pt;">구분</td>
									<td style="font-weight: bold; font-size: 8pt;">과목명</td>
									<td style="font-weight: bold; font-size: 8pt;">이수여부</td>
								</tr>
							</thead>
							<tbody>
								<c:if test="${size != 0}">
								<c:forEach items="${nonelist}" var="map" varStatus="status">
								<tr>
									<c:if test="${map.deptseq == 23}">
										<td style="width: 200px;">교양필수</td>
									</c:if>
									<c:if test="${map.deptseq != 23}">
										<td style="width: 200px;">전공필수</td>
									</c:if>
									<td style="width: 200px;">${map.name}</td>
									<td style="width: 200px; color:red; font-weight: bold;">미이수</td>
								</tr>
								</c:forEach>
								</c:if>
							</tbody>
						</table>
					  </div>
					  <div>
					  	<c:if test="${size == 0}">
					  	<p style="color:#0066cc;font-weight: bold;">필수과목을 모두 이수하셨습니다.</p>
					  	<p>심사결과: <span style="color:red;font-weight: bold;" id="gradu">졸업가능</span></p>
					  	</c:if>
					  	
					  	<c:if test="${size != 0}">
					  	<p style="color:#0066cc;font-weight: bold;">필수과목을 모두 이수하지 못하셨습니다.</p>
					  	<p>심사결과: <span style="color:red;font-weight: bold;" id="gradu">졸업불가능</span></p>
					  	</c:if>
					  </div>
					  <a href="#" rel="modal:close" onclick="funcclose();">닫기</a>
				  </div>
			</div>
 			</c:if>
 			<c:if test="${graduok == 0}"> 
			<p><a href="#ex1" rel="modal:open"  onclick="funcmodal();" style="font-weight: bold;">졸업적부 심사하기</a></p>
			</c:if>
			<c:if test="${graduok == 1}">
				<p><a>졸업적부 심사완료</a></p>
			</c:if>
		</li>
	</ul>
</div>

<br><br>
<div>
	<span style="font-size: 12pt; font-weight: bold;float: left;">교필 및 전필과목 내역</span>
</div>
<br><br>
<div style="border: solid 2px #cccccc;border-radius: 6px; height: 200px;">
	<table class="table table-bordered" id="scroltbl">
		<thead id="scrolth">
			<tr id="subli">
				<td style="width: 200px; font-weight: bold;">구분</td>
				<td style="width: 200px; font-weight: bold;">과목명</td>
				<td style="width: 200px; font-weight: bold;">이수여부</td>
			</tr>
		</thead>
		<tbody id="bodys">
			<c:forEach items="${reglist}" var="map" varStatus="status">
			<tr class='sublicl'>
				<c:if test="${map.deptseq == 23}">
					<td style="width: 200px;">교양필수</td>
				</c:if>
				<c:if test="${map.deptseq != 23}">
					<td style="width: 200px;">전공필수</td>
				</c:if>
				<td style="width: 200px;">${map.name}</td>
				<c:if test="${map.must == 'ok'}">
					<td style="width: 200px; color:red; font-weight: bold;">이수</td>
				</c:if>
				<c:if test="${map.must == 'no'}">
					<td style="width: 200px; color:red; font-weight: bold;">미이수</td>
				</c:if>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<br>
<div id="divbtn">
<span style="font-size: 12pt; font-weight: bold; color: #ff4000">졸업적부심사 유의사항</span>
</div>
<br>
<div style="border: solid 2px #cccccc; padding: 15px; border-radius: 6px;">
<ul id="info" >
	<li>졸업적부 심사버튼을 누른 후, '졸업가능'이 떠야 졸업이 가능합니다.</li>
    <li>졸업적부 심사 후, 심사결과: 졸업가능이 되어야 졸업연기가 가능합니다.</li>
	<li>본인의 필수과목들의 이수 현황을 확인해주세요.</li>
	<li>졸업학점은 교양 최소 35점 이상~ 최대 49점까지 인정  + 전공 (72점 이상)  = 총 130점 이상이여야 합니다.</li>
</ul>
</div>
</div>

