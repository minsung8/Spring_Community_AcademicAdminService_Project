<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
   String ctxPath = request.getContextPath();
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">

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
	display: table; width: 1380px;
}
.sublicl {
	display:table; width:100%;
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
	
		
	});
	
	function funcdel(index) {
		var check = confirm("휴학신청을 취소하시겠습니까?");
		if(check){
			var no = $("#no"+index).val();
			$.ajax({
				url: "<%= request.getContextPath() %>/ajaxSchoolInfo.sky",
				data: {"no":no},
				type: "GET",
				dataType: "json",
				success: function(json) {
					if(json.result){
						alert("휴학신청이 취소되었습니다.");
						location.reload();
					}
					else{
						alert("휴학신청 취소가 취소되었습니다.");
						location.reload();
					}
				},
				error: function(request, status, error){
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			});	//------------------end of ajax
		}
		else{
			return;
		}
	}
	
	function funcupdate(index){
		var check = confirm("휴학신청 내역을 수정하시겠습니까?");
		if(check){
			var no = $("#no"+index).val();
			var type = $("#type"+index).text();
			location.href="<%=ctxPath%>/updateSchoolLeave.sky?seq="+no+"&type="+type;
		}
		else{
			return;
		}
	}
</script>
<div style="padding-left: 10px; padding-right: 10px;">
<br>
<div>
<span style="font-size: 12pt; font-weight: bold;">휴학신청 결과조회</span>
</div>
<br>
<div style="border: solid 1px #d9d9d9; height: 450px;">
	<table class="table table-striped" id="scroltbl">
		<thead id="scrolth">
			<tr id="subli">
				<td style="width: 200px;">신청학기</td>
				<td style="width: 100px;">신청일자</td>
				<td style="width: 100px;">휴학구분</td>
				<td style="width: 150px;">복학예정</td>
				<td style="width: 200px;">신청결과</td>
				<td style="width: 200px;">반려이유</td>
				<td style="width: 200px;">서류첨부</td>
				<td style="width: 100px;">취소</td>
				<td style="width: 100px;">수정</td>
			</tr>
		</thead>
		<tbody id="bodys">
			<c:forEach items="${list}" var="vo" varStatus="status">
			<tr class='sublicl'>
				<td style="width: 200px;">${vo.startSemester}</td>
				<td style="width: 100px;">${vo.regdate}</td>
				<td style="width: 100px;" id="type${status.index}">${vo.type}</td>
				<td style="width: 150px;">${vo.comeSemester}</td>
				<td style="width: 200px;">${vo.approve}</td>
				<td style="width: 200px;">${vo.noreason}</td>
				<c:if test="${vo.filename == null}">
				<td style="width: 200px;"></td>
				</c:if>
				<c:if test="${vo.filename != null}">
				<td style="width: 200px;"><a href='<%= request.getContextPath()%>/downloadSchoolLeaveInfo.sky?seq=+${vo.schoolLvNo}+'><img src='<%= request.getContextPath() %>/resources/images/disk.gif'/></a></td>
				</c:if>
				<c:if test="${vo.approve == '승인전'}"> 
					<td style="width: 100px;"><button onclick="funcdel(${status.index})" style='border:none; background-color:#e6e6e6; color: #e62e00; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px; border-radius: 3px;'>취소</button>
					<input type="text" value="${vo.schoolLvNo}" id="no${status.index}" hidden="true"/>
					</td>
				</c:if>
				<c:if test="${vo.approve == '승인완료'}">
					<td style="width: 100px;"></td> 
				</c:if>
				<c:if test="${vo.approve == '승인전'}">
					<td style="width: 100px;"><button onclick="funcupdate(${status.index})" style='border:none; background-color:#e6e6e6; color: black; font-size: 8pt; padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 5px; border-radius: 3px;'>수정</button></td>
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