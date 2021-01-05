<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
   String ctxPath = request.getContextPath();
%>
<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<style type="text/css">
#divbtn {
	margin-right: 20px;
}
.centr > td {
	text-align: center;
}
#info {
	color: #737373;
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

	$("#alldaychk").click(function() {
		if ($("#alldaychk").is(":checked") == true){
			$("#starttime").attr('disabled', 'disabled');
			$("#endtime").attr('disabled', 'disabled');
		}
		else{
			$('#starttime').removeAttr("disabled");
			$('#endtime').removeAttr("disabled");
		}
	});
	
	$("#addbtn").click(function() {
		
		
		var date1 = $("#datepicker1").val().substring(8);
		var date2 = $("#datepicker2").val().substring(8);
		var min = parseInt(date2)-parseInt(date1);
		var bool = true;
		// 일자 유효성 검사
		if($("#datepicker1").val().trim()=="" || $("#datepicker1").val().trim()==""){
			alert("일자를 입력해주세요.");
			bool = false;
			return;
		}
		
		// 시간 유효성 검사
		if ($("#alldaychk").is(":checked") == false){
			if($("#starttime").val().trim()=="" || $("#endtime").val().trim()==""){
				alert("시간을 입력해주세요.");
				bool = false;
				return;
			}
		}
		
		// 사유 유효성 검사
		var str = $("#reason option:selected").val();
		if(str == "전체"){
			alert("공결 사유를 선택해주세요.");
			bool = false;
			return;
		}
		else if(str == "본인 및 형제자매 결혼[허용기간:1일]"){
			if(min >= 1){
				alert("선택하신 일자는 해당 사유의 허용기간을 초과했습니다. 다시 선택해주세요.");
				bool = false;
				$("#datepicker1").focus();
				return;
			}
		}
		else if(str == "형제, 부모, 조부모, 외조부모의 사망[허용기간:5일]"){
			if(min >= 5){
				alert("선택하신 일자는 해당 사유의 허용기간을 초과했습니다. 다시 선택해주세요.");
				bool = false;
				$("#datepicker1").focus();
				return;
			}
		}
		else if(str == "수술, 중병으로 인한 입원[허용기간:2주]" || str == "전염성 질병으로 인한 격리[허용기간:2주]"){
			if(min >= 14){
				alert("선택하신 일자는 해당 사유의 허용기간을 초과했습니다. 다시 선택해주세요.");
				bool = false;
				$("#datepicker1").focus();
				return;
			}
		}
		
		var startdate = $("#datepicker1").val();
		var enddate = $("#datepicker2").val();
		var syear = startdate.substring(0,4);
		var smonth = startdate.substring(5,7);
		var sday = startdate.substring(8);
		var eyear = enddate.substring(0,4);
		var emonth = enddate.substring(5,7);
		var eday = enddate.substring(8);
		
		var start = syear+smonth+sday;
		var end = eyear+emonth+eday;
		if(parseInt(start)>parseInt(end)){
			alert("시작일자와 종료일자를 명확히 해주세요");
			$("#datepicker1").focus();
			bool = false;
			return;
		}
	
		if(bool){
			// 폼(form) 을 전송(submit)
			confirm("공결신청하시겠습니까?");
			var frm = document.addFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/officalLeaveEnd.sky";
			frm.submit(); 
			
		}
	});
});	

function funcdel(index){
	var result = confirm("공결 신청을 취소하시겠습니까?");
	var seq = $("#seq"+index).val();
	if(result){
		$.ajax({
			url: "<%= request.getContextPath() %>/delOfficialLeave.sky",
			data: {"seq":seq},
			type: "GET",
			dataType: "json",
			success: function(json) {
				if(json.result){
					alert("삭제가 완료되었습니다.");
					location.reload();
				}
			},error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		}); 
	}
}
</script>

<div style="padding-left: 10px; padding-right: 10px;">

<div id="divbtn">
	<span style="font-size: 12pt; font-weight: bold;float: left;">공결신청 내역</span>
	
</div>
<br>
<div style="clear: both; padding-top: 20px;">
	<table class="table table-bordered" id="scroltbl">
		<tr class="centr">
			<td>신청일자</td>
			<td>시작일자</td>
			<td>종료일자</td>
			<td>사유</td>
			<td>승인구분</td>
			<td>승인/반려일자</td>
			<td>반려이유</td>
			<td>취소</td>
		</tr>
		<c:forEach items="${leavelist}" var="vo" varStatus="status">
		<tr class="centr">
			<td>${vo.regdate}</td>
			<td>${vo.startDate}</td>
			<td>${vo.endDate}</td>
			<td>${vo.reason}</td>
			<td>${vo.approve}</td>
			<c:if test="${vo.approveDate == null}">
			<td></td>
			</c:if>
			<c:if test="${vo.approveDate != null}">
			<td>${vo.approveDate}</td>
			</c:if>
			<c:if test="${vo.noReason == null}">
			<td> </td>
			</c:if>
			<c:if test="${vo.noReason != null}">
			<td>${vo.noReason}</td>
			</c:if>
			<c:if test="${vo.approve == '승인전'}">
			<td>
				<button id="delbtn${status.index}" onclick="funcdel(${status.index})" style='border:none; background-color:#e6e6e6; color: #e62e00; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px; border-radius: 3px;'>취소</button>
				<input value="${vo.leaveNo}" type="text" id="seq${status.index}" hidden="true"/>
			</td>
			</c:if>
			<c:if test="${vo.approve == '승인완료' || vo.approve == '승인불가'}">
			<td>
			</td>
			</c:if>
		</tr>
		</c:forEach>
	</table>
</div>
<div id="divbtn">
<span style="font-size: 12pt; font-weight: bold;">공결신청</span>
<button id="addbtn" style="float: right; border:none; background-color: #4d4d4d; color: white; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px; border-radius: 3px;" >신청</button>
</div>
<div style="padding-top: 20px;">
 <form name="addFrm" enctype="multipart/form-data"> 
	<table class="table table-bordered" style="border:none;">
		<tr>
			<td style="text-align: center;">일자</td>
			<td>
			<input type="text" id="datepicker1" name="startDate" style="border: solid 1px #cccccc;"/> ~
  			<input type="text" id="datepicker2" name="endDate" style="border: solid 1px #cccccc;"/>
  			</td>
		</tr>
		<tr>
			<td style="text-align: center;">전일 &nbsp;
			<input type="checkbox" id="alldaychk" name="alldaychk" style="border: solid 1px #cccccc;"/>
			</td>
			<td>
			 시간 &nbsp;
			<input type="time" id="starttime" name="startTime" style="border: solid 1px #cccccc;"/> ~ <input type="time" id="endtime" name="endTime" style="border: solid 1px #cccccc;"/>
			</td>
		</tr>
		<tr>
			<td style="text-align: center;" >사유</td>
			<td>
				<select name="reason" id="reason" style="border: solid 1px #cccccc;">
					<option>전체</option>
					<option>본인 및 형제자매 결혼[허용기간:1일]</option>
					<option>형제, 부모, 조부모, 외조부모의 사망[허용기간:5일]</option>
					<option>수술, 중병으로 인한 입원[허용기간:2주]</option>
					<option>전염성 질병으로 인한 격리[허용기간:2주]</option>
					<option>징병검사 등 병무[통지서에 명시된 일수]</option>
					<option>교육실습 등으로 인한 경우[실습기간]</option>
					<option>기타 총장이 부득이하다고 인정하는 경우</option>				
				</select>
			</td>
		</tr>
		<tr>
			<td style="text-align: center;" >파일첨부</td>
			<td><input type="file" name="attach" style="border: none;"/></td>
		</tr>
	</table> 
</form>
</div>
<br>
<div id="divbtn">
<span style="font-size: 12pt; font-weight: bold; color: #ff4000">공결신청 유의사항</span>
</div>
<div style="padding-top: 20px;">
<ul id="info" >
    <li>공결일자는 선택 후 전일, 또는 교시를 지정하여 신청하고 신청결과에 서 승인여부를 확인하시기를 바랍니다.</li>
	<li>결석일 전후 7일 이내에만 가능하며, 반드시 결석일 이후 7일 이내에 신청을 해야 공결을 인정받을 수 있습니다.</li>
	<li>여학생 공결은 월 1회 가능합니다.</li>
	<li>공결 승인 여부는 최소 1일 ~ 최대 3일 소요됩니다. </li>
	<li>여학생 공결내역은 현재 날짜로부터 1년 이상의 내역만 조회 가능합니다.</li>
	<li>승인 구분 상태가 '승인전'일 때에는 취소가 가능하지만 승인이 완료되면 취소가 불가합니다.</li>
</ul>
</div>
</div>