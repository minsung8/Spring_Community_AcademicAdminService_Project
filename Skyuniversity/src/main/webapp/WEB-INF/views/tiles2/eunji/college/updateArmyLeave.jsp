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
		
		var arr = $("input:radio[name='armyType']");
		var type = "${slvo.armyType}";
		for(var i=0; i<9; i++){
			if($("#type"+i).val() == type){
				$("#type"+i).prop('checked', true); // 선택하기
			}
		}
		
		$("#datepicker1").val("${slvo.armyStartDate}");
		$("#datepicker2").val("${slvo.armyEndDate}");
		
		$("#regbtn").click(function() {
		
			var flag = true;
			
			if($('input:radio[name="armyType"]:checked').length < 1){
				alert("병종을 선택해주세요.");
				flag = false;
				return;
			}
			
			// 일자 유효성 검사
			if($("#datepicker1").val().trim()=="" || $("#datepicker2").val().trim()==""){
				alert("일자를 입력해주세요.");
				bool = false;
				return;
			}
			
			if(flag){
				// 폼(form) 을 전송(submit)
				var check = confirm("수정하시겠습니까?");
				if(check){
					var frm = document.addFrm;
					frm.method = "POST";
					frm.action = "<%= ctxPath%>/armyLeaveSchoolUpdate.sky";
					frm.submit();
					alert("수정되었습니다.");
				}
				else{
					return;
				}
			}
		});
	});
</script>
<div style="padding-left: 10px; padding-right: 10px;"	>
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
<br><br>
<div>
	<span style="font-size: 12pt; font-weight: bold;float: left;">군휴학신청 상세정보</span>
	<button id="regbtn" style="margin-left: 500px; border: none;">수정하기</button>
</div>
<br>
<div style="border: solid 2px #cccccc; padding: 15px; border-radius: 6px;">
	<form name="addFrm" enctype="multipart/form-data">
		<input type="text" value="${slvo.schoolLvNo}" name="schoolLvNo" hidden="true"/>
		<ul>
			<li>
				<label>병종</label>
					<label for="btype1" >육군</label>
					<input type="radio" name="armyType" value="육군" id="type0"/>
					<label for="btype2">해군</label>
					<input type="radio" name="armyType" value="해군" id="type1"/>
					<label for="btype3">공군</label>
					<input type="radio" name="armyType" value="공군" id="type2"/>
					<label for="btype4">해병</label>
					<input type="radio" name="armyType" value="해병" id="type3"/>
					<label for="btype4">의경</label>
					<input type="radio" name="armyType" value="의경" id="type4"/>
					<label for="btype4">전경</label>
					<input type="radio" name="armyType" value="전경" id="type5"/>
					<label for="btype4">공익근무요원</label>
					<input type="radio" name="armyType" value="공익근무요원" id="type6"/>
					<label for="btype4">산업체특별요원</label>
					<input type="radio" name="armyType" value="산업체특별요원" id="type7"/>
					<label for="btype4">기타</label>
					<input type="radio" name="armyType" value="기타" id="type8"/>
			</li>
			<li>
				<label>복무예정기간</label>
				<input type="text" id="datepicker1" name="armyStartDate" style="border:solid 1px #d9d9d9"/> ~
  				<input type="text" id="datepicker2" name="armyEndDate" style="border:solid 1px #d9d9d9"/>
				<button style="border:none;"><a href="http://soldiercal.lilysoul.pe.kr/">전역일 계산기</a></button>
			</li>
			<li>
				<label>입영통지서</label>
				<input type="file" name="attach" id="armyfile"/><span style="font-size: 7pt; color: red;">파일 수정시, 수정할 파일을 업로드 해주세요.</span>
			</li>
		</ul>
	</form>
</div>
<br>
<div id="divbtn">
<span style="font-size: 12pt; font-weight: bold; color: #ff4000">휴학 신청시 유의사항</span>
</div>
<br>
<div style="border: solid 2px #cccccc; padding: 15px; border-radius: 6px;">
<ul id="info" >
    <li>군입대 휴학은 입영통지서(소집통지서) 발급일로부터 신청 가능합니다.</li>
	<li>군입대 대기로 일반휴학을 신청한자는 군입대 휴학으로 다시 신청해야 합니다.</li>
	<li>군입대 휴학 신청 시 입영통지서(소집통지서)를 스캔하여 첨부해야 합니다.</li>
	<li>다른 문서가 첨부되었거나, 식별이 안되는 경우, 휴학처리가 불가하오니 반드시(휴학결과조회 >> 증빙서류)를 열어 해당 문서가 제대로 업로드 되었는지 확인부탁드립니다.</li>
	<li>재첨부가 필요할경우, (학적 >> 휴학결과조회 >> 수정)에서 가능합니다.</li>
</ul>
</div>
</div>