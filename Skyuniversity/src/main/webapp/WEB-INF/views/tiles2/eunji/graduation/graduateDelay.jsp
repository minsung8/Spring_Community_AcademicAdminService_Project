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
#info {
	color: #737373;
	font-size: 9.5pt;
	padding-left: 5px;
}
#info > li {
	padding-bottom: 10px;
}
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

$(document).ready(function() {
	// 학년도 날짜 구하기
	var now = new Date();
	var year = now.getFullYear();
	var month = now.getMonth()+1;

	var sthtml = "";
	var html = "<option>년도</option>";
	
	if(month < 3 || month >= 9){
		sthtml = "<option>"+(year+1)+"</option>";
		stsem = "<option>1</option>";
		if(month >= 1){
			sthtml = "<option>"+year+"</option>";
		}
		$("#startyear").html(sthtml);
		$("#endyear").html(sthtml);
		$("#startsem").html(stsem);
	}
	if(month < 9 && month >= 3){
		sthtml = "<option>"+(year)+"</option>";
		stsem = "<option>2</option>";
		if(month >= 1){
			sthtml = "<option>"+year+"</option>";
		}
		$("#startyear").html(sthtml);
		$("#endyear").html(sthtml);
		$("#startsem").html(stsem);
	}
	 
});

function funcreg() {
	
	var ok = ${paraMap.graduateok};
	var bool = true;

	if(ok == 0){
		alert("졸업 -> 졸업적부심사에서 졸업적부심사 승인 후, 졸업연기를 신청하실 수 있습니다.");
		bool = false;
		return;
	}
	
	if($("#reason").val().trim().length<50){
		alert("휴학 사유는 50자 이상 작성해주셔야 합니다.")
		bool = false;
		return;
	}

	if(bool){
		var frm = document.delayfrm;
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/graduateDelayEnd.sky";
		frm.submit();		
	}
	
}

function funcdel(index){
	var no = $("#no"+index).val();
	var check = confirm("졸업연기신청을 취소하시겠습니까?");
	if(check){
		location.href="<%=ctxPath%>/graduateDelayDel.sky?seq="+no;
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
	</table>
</div>
<br>
<div>
	<span style="font-size: 12pt; font-weight: bold;float: left;">졸업연기신청</span>
</div>
<br><br>
<div style="border: solid 2px #cccccc; padding: 20px; border-radius: 6px; float: left; width: 49%; height: 350px;">
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
		<br/>
		<form name="delayfrm">
		<li>
			<label>신청년도: </label>
			<select name="startyear" id="startyear" style="border: solid 1px #cccccc;"> 
			</select>
			/
			<select name="startsem" id="startsem" style="border: solid 1px #cccccc;">
			</select>
			&nbsp;~&nbsp;
			<select name="endyear" id="endyear" style="border: solid 1px #cccccc;">
							<option>학년도</option>
							<option>1</option>
							<option>2</option>
							<option>3</option>
							<option>4</option>
			</select>
			/
			<select name="endsem" id="endsem" style="border: solid 1px #cccccc;">
							<option>학기</option>
							<option>1</option>
							<option>2</option>
			</select>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<span style="font-size: 5pt; color: red;">졸엽연기 신청 시, 최대 1년까지 신청가능합니다.</span>
		</li>
		
		<li>
			<label>신청사유:</label>
			<textarea rows="8" cols="80" placeholder="최소 50자 이상 작성해주세요." name="reason" style="border: solid 1px #cccccc;" id="reason"></textarea>
		</li>
		</form>
		<li>
			<button style="margin-left: 550px;" onclick="funcreg();">신청</button>
		</li>
	</ul>
</div>
<div style="border: solid 2px #cccccc; padding: 20px; border-radius: 6px;  float: right; width: 49%; height: 350px; margin-bottom: 10px;">
	<div style="color:red; font-weight: bold;">졸업연기 신청시 유의사항</div>
	<br>
	<ul id="info">
		<li>졸업연기는 졸업적부심사에서 졸업적부심사 완료 후, 졸업가능조건일때 신청이 가능합니다.</li>
	    <li>졸업연기 신청은 1학기 ~ 2학기 까지 신청이 가능합니다. </li>
		<li>졸업연기는 최대 기한 없이 연기가 가능합니다.</li>
		<li>졸업연기 사유는 최소 50자 이상 작성해주시기 바랍니다.</li>
		<li>졸업연기 신청 후 승인여부는 최소 1 ~ 최대 3일 후에 승인여부를 확인 부탁드립니다.</li>
		<li>졸업연기 신청 후 취소는 승인 완료 이전에 취소가 가능합니다.</li>
	</ul>
</div>
<br><br>
<div style="clear: both;">
	<span style="font-size: 12pt; font-weight: bold;float: left;">졸업연기 신청내역</span>
</div>
<br><br>
<div style="border: solid 2px #cccccc;border-radius: 6px; height: 350px;">
	<table class="table table-striped" id="scroltbl">
		<thead id="scrolth">
			<tr id="subli">
				<td style="width: 200px;">신청일자</td>
				<td style="width: 100px;">연기일자</td>
				<td style="width: 100px;">승인여부</td>
				<td style="width: 200px;">반려이유</td>
				<td style="width: 200px;">취소</td>
			</tr>
		</thead>
		<tbody id="bodys">
			<c:forEach items="${volist}" var="vo" varStatus="status">
			<tr class='sublicl'>
				<td style="width: 200px;">${vo.regDate}</td>
				<td style="width: 100px;">${vo.startSem}~${vo.endSem}</td>
				<td style="width: 100px;">${vo.approve}</td>
				<td style="width: 200px;">${vo.noreason}</td>
				<c:if test="${vo.approve == '승인전'}">
					<td style="width: 200px;"><button onclick="funcdel(${status.index})"  style='border:none; background-color:#e6e6e6; color: #e62e00; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px; border-radius: 3px;'>취소</button>
					<input type="text" value="${vo.delayNo}" id="no${status.index}" hidden="true"/>
					</td>
				</c:if>
				<c:if test="${vo.approve == '승인완료'}">
					<td style="width: 200px;"></td>
				</c:if>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

</div>