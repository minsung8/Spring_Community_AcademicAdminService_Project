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
</style>
<script type="text/javascript">
$(function() {
	  $.datepicker.setDefaults({
		    dateFormat: 'yy-mm-dd',
		    prevText: '이전 달',
		    nextText: '다음 달',
		    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		    showMonthAfterYear: true,
		    yearSuffix: '년'
		  });

		  $(function() {
		    $("#datepicker1, #datepicker2").datepicker();
		  });
});

$(document).ready(function() {
	$("#infoarmy").hide();
});
var cnt = 0;

function funcCome(index){
	cnt = cnt + 1;
	var type = $("#type"+index).text();
	var comesemester = $("#comesemester"+index).text();
	
	if(type=="군휴학"){
		var start = $("#armystart"+index).val();
		var end = $("#armyend"+index).val();
		
		$("#comesem").val(comesemester);
		$("#armytype").val(type);
		$("#infoarmy").show();
		
		$("#datepicker1").prop('disabled', false);
		$("#datepicker2").prop('disabled', false);
		$("#armyfile").prop('disabled', false);
		$("#armyfile").focus();
		
		$("#datepicker1").val(start);
		$("#datepicker2").val(end);
		var bool = true;
		
		if($("#datepicker1").val().trim()=="" || $("#datepicker2").val().trim()==""){
			alert("일자를 입력해주세요.");
			bool = false;
			return;
		}
			if($("#armyfile").val() == ""){
				alert("군복학은 파일첨부(전역증)를 해주시기 바랍니다.");
				bool = false;
				return;
			}
		if(bool){
		    var check = confirm("복학신청을 하시겠습니까?");
		    if(check){
				var frm = document.addFrm;
				frm.method = "POST";
				frm.action = "<%= ctxPath%>/armyComeSchool.sky";
				frm.submit();
		    }
		    else{
		    	return;
		    }
		}
	}
	if(type=="일반휴학"){
		$.ajax({
			url: "<%= request.getContextPath() %>/comeSchoolajax.sky",
			data: {"type":type,
				   "comesemester":comesemester},
			type: "GET",
			dataType: "json",
			success: function(json) {
				if(json.result){
					alert("일반 복학신청 되었습니다.");
					location.reload();
				}
				else{
					if(json.checkbol){
						alert("이미 복학신청이 되었습니다. 승인을 기다려주세요.");
						return;
					}
				}
			},error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		}); 
	}
}

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
<div style="border: solid 2px #cccccc; padding: 20px; border-radius: 6px;">
	<span style="font-size: 6pt; color: red;" id="infoarmy">군복학일 경우 전역증을 첨부해주세요.</span>
	<form name="addFrm" enctype="multipart/form-data">
	<ul style="list-style: none;padding-left: 0px; font-size: 10pt;">
		<li>
			<label>복무기간:</label>
			<input type="text" id="datepicker1" name="armyStartDate" style="border:solid 1px #d9d9d9" disabled="disabled"/> ~
  				<input type="text" id="datepicker2" name="armyEndDate" style="border:solid 1px #d9d9d9" disabled="disabled"/>
		</li>
		<li>
			<label>전역증:</label>
			<input type="file" name="attach" id="armyfile" disabled="disabled"/>
		</li>
	</ul>
	<input type="text" id="comesem" name="comeSemester" hidden="true"/>
	<input type="text" id="armytype" name="type" hidden="true"/>
	</form>
</div>
<br><br>
<div >
	<span style="font-size: 12pt; font-weight: bold;float: left;">복학예정내역</span>
</div>
<br><br>
<div  style="border: solid 2px #cccccc; padding: 20px; border-radius: 6px;">
	<table class = "table table-hover" style="font-size: 10pt; text-align: center;">
		<thead>
			<tr>
				<td style="width: 200px;">신청학기</td>
				<td style="width: 100px;">신청일자</td>
				<td style="width: 100px;">휴학구분</td>
				<td style="width: 150px;">복학예정</td>
				<td style="width: 150px;">복학신청</td>				
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${comelist}" var="vo" varStatus="status">
				<tr> 
					<td>${vo.startSemester}</td>
					<td>${vo.regdate}</td>
					<td id="type${status.index}">${vo.type}</td>
					<td id="comesemester${status.index}">${vo.comeSemester}</td>
					<td><button onclick="funcCome(${status.index})" style='border:none; color: black; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px; border-radius: 3px;'>복학신청</button></td>
				</tr>
				<input type="text" value="${vo.armyStartDate}" id="armystart${status.index}" hidden="true"/>
				<input type="text" value="${vo.armyEndDate}" id="armyend${status.index}" hidden="true"/>
			</c:forEach>
		</tbody>
	</table>
</div>
<br>
<div>
	<span style="font-size: 12pt; font-weight: bold;float: left;">복학신청내역</span>
</div>
<br><br>
<div style="border: solid 2px #cccccc;border-radius: 6px; height: 350px;">
	<table class="table table-striped" id="scroltbl">
		<thead id="scrolth">
			<tr id="subli">
				<td style="width: 200px;">복학년도</td>
				<td style="width: 100px;">신청일자</td>
				<td style="width: 100px;">복학구분</td>
				<td style="width: 200px;">신청결과</td>
				<td style="width: 200px;">반려이유</td>
				<td style="width: 200px;">서류첨부</td>
				<td style="width: 100px;">취소</td>
			</tr>
		</thead>
		<tbody id="bodys">
			<c:forEach items="${list}" var="vo" varStatus="status">
			<tr class='sublicl'>
				<td style="width: 200px;">${vo.comeSemester}</td>
				<td style="width: 100px;">${vo.regDate}</td>
				<td style="width: 100px;" id="type${status.index}">${vo.type}</td>
				<td style="width: 200px;">${vo.approve}</td>
				<td style="width: 200px;">${vo.noReason}</td>
				<c:if test="${vo.fileName == null}">
				<td style="width: 200px;"></td>
				</c:if> 
				<c:if test="${vo.fileName != null}">
				<td style="width: 200px;"><a href='<%= request.getContextPath()%>/downloadComeSchoolInfo.sky?seq=+${vo.comeSeq}+'><img src='<%= request.getContextPath() %>/resources/images/disk.gif'/></a></td>
				</c:if>
				<c:if test="${vo.approve == '승인전'}"> 
					<td style="width: 100px;"><button onclick="funcdel(${status.index})" style='border:none; background-color:#e6e6e6; color: #e62e00; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px; border-radius: 3px;'>취소</button>
					<input type="text" value="${vo.comeSeq}" id="no${status.index}" hidden="true"/>
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