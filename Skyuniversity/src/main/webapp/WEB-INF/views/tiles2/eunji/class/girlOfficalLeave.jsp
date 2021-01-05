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
table#scroltbl {
	border-collapse:collapse; width:200px;
}

#scrolth {
	float:left; width:100%;
}

#bodys {
	overflow-y:auto; overflow-x:hidden; float:left; width:100%; height:270px;
}

#subli {
	display: table; width: 1000px;
	padding:10px;
}
.sublicl {
	display:table; width:100%;
} 
.sublicl > td {
	width:100px;
	font-size: 9pt;
	text-align: center;	
	padding-left:-10px;
}
#subli > td {
	width:280px;
	font-size: 9pt;
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
			if(parseInt(start) != parseInt(end)){
				alert("여학생 공결은 1일만 가능합니다. 기간을 다시 선택해주세요.");
				$("#datepicker1").focus();
				bool = false;
				return;
			}

			if(bool){
				// 폼(form) 을 전송(submit)
				confirm("여학생 공결신청하시겠습니까?");
				var frm = document.addFrm;
				frm.method = "POST";
				frm.action = "<%= ctxPath%>/girlOfficalLeaveEnd.sky";
				frm.submit(); 
			}
		});
});

function funcdel(index){
	var result = confirm("공결 신청을 취소하시겠습니까?");
	var seq = $("#seq"+index).val();
	if(result){
		location.href="<%=ctxPath%>/delGirlOfficialLeave.sky?seq="+seq;
	}
	else{
		return;
	}
}
</script>
<div style="padding-left: 10px; padding-right: 10px;">
<div>
<span style="font-size: 12pt; font-weight: bold;">여학생 공결신청</span>
	<br>
	<div>
	<form name="addFrm"> 
	<ul style="padding-top: 20px;">
		<li style="display: inline-block;">
			<label>● 공결일자</label>
			<input type="text" id="datepicker1" name="startDate" style="border: solid 1px #cccccc;"/> ~
  			<input type="text" id="datepicker2" name="endDate" style="border: solid 1px #cccccc;"/>
		</li>
		
		<li style="display: inline-block;">
			<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;● 전일여부</label>
			<input type="checkbox" id="alldaychk" name="alldaychk"/>
			<label>&nbsp;&nbsp;시간</label>
			<input type="time" id="starttime" name="startTime" style="border: solid 1px #cccccc;"/> ~ <input type="time" id="endtime" name="endTime" style="border: solid 1px #cccccc;"/>
		</li>
		<li style="display: inline-block; margin-left: 80px;"><button id="addbtn" style="border:none; background-color: #4d4d4d; color: white; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px; border-radius: 3px;" >신청</button></li>
	</ul>
	</form>
	</div>
</div>
<br/>
<br/>
<div>
<div>
<span style="font-size: 12pt; font-weight: bold;">여학생 공결신청 목록</span>
</div>
<br>
<div style="width: 1300px; text-align: center;">
	<table class="table table-striped"  id="scroltbl">
		<thead id="scrolth">
			<tr id="subli">
				<td>신청일자</td>
				<td>공결일자</td>
				<td>시간</td>
				<td>승인여부</td>
				<td>불가사유</td>
				<td>취소</td>
			</tr>
		</thead>
		<tbody id="bodys">
		<c:forEach items="${girllist}" var="glvo" varStatus="status">
			<tr class='sublicl'>
				<td>${glvo.regDate}</td>
				<td>${glvo.startDate}</td>
				<c:if test="${glvo.startTime == null}">
					<td>전일</td>
				</c:if>
				<c:if test="${glvo.startTime != null}">
					<td>${glvo.startTime}~${glvo.endTime}</td>
				</c:if>
				<td>${glvo.approve}</td>
				<td>${glvo.noreason}</td>
				<c:if test="${glvo.approve=='승인전'}">
					<td>
						<button id="delbtn${status.index}" onclick="funcdel(${status.index})" style='border:none; background-color:#e6e6e6; color: #e62e00; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px; border-radius: 3px;'>취소</button>
						<input id="seq${status.index}" type="text" value="${glvo.girlLeaveNo}" hidden="true">
					</td>
				</c:if>
				<c:if test="${glvo.approve=='승인완료'}">
					<td></td>
				</c:if>
			</tr>
	    </c:forEach>
		</tbody>
	</table>
</div>
</div> 
<br>
<div id="divbtn">
<span style="font-size: 12pt; font-weight: bold; color: #ff4000">여학생 공결신청 유의사항</span>
</div>
<div style="padding-top: 20px;">
<ul id="info" >
	<li>결석일 전후 7일 이내에만 가능하며, 반드시 결석일 이후 7일 이내에 신청을 해야 공결을 인정받을 수 있습니다.</li>
	<li>공결 사유 선택 후 그에 해당하는 증빙서류를 업로드하여 신청해주세요.</li>
	<li>공결 승인 여부는 최소 1일 ~ 최대 3일 소요됩니다. </li>
	<li>3개월 이상의 공결 조회는 '공결내역조회'에서 확인 가능합니다.</li>
	<li>승인 구분 상태가 '승인전'일 때에는 취소가 가능하지만 승인이 완료되면 취소가 불가합니다.</li>
</ul>
</div>
</div>