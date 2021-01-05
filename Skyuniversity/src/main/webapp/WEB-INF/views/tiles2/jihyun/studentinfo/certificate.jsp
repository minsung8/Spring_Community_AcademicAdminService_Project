<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<style>

	div#certificateWrapper {
		padding: 30px;
	}
	
	div#block0 {
		display: flex;
		flex-direction: row;
		justify-content: space-between;
	}

	#block1, #block2 {
		/* border: solid 1px gray; */
		height: 700px;
	}
	
	#block1 {
		width: 54%;
	}
	
	#block2 {
		width: 44%;
	}

 	input.defaultInput {
	 	width: 85px;
	 	margin-right: 30px;
	 	outline: none;
	 }
	 
	 div.defaultInfo {
	 	margin-bottom: 50px;
	 }
	 
	 .sumInput, #totalFee {
	 	width: 50px;
	 	outline: none;
	 	text-align: right;
	 	/* border: none; */
	 }
	 
	 .spinnerInput{
	 	width: 30px;
	 	outline: none;
	 }
	
 .bordered {
	    *border-collapse: collapse; /* IE7 and lower */
	    border-spacing: 0;
	    width: 100%;
	    border: solid #ccc 1px;
	    -moz-border-radius: 6px;
	    -webkit-border-radius: 6px;
	    border-radius: 6px;
	    -webkit-box-shadow: 0 1px 1px #ccc;
	    -moz-box-shadow: 0 1px 1px #ccc;
	    box-shadow: 0 1px 1px #ccc;
	}
	 
	.bordered tr:hover {
	    background: #fbf8e9;
	    -o-transition: all 0.1s ease-in-out;
	    -webkit-transition: all 0.1s ease-in-out;
	    -moz-transition: all 0.1s ease-in-out;
	    -ms-transition: all 0.1s ease-in-out;
	    transition: all 0.1s ease-in-out;
	}
	 
	.bordered td, .bordered th {
	    border-left: 1px solid #ccc;
	    border-top: 1px solid #ccc;
	    padding: 10px;
	    text-align: center;
	}
	 
	.bordered th {
	    background-color: #dce9f9;
	    background-image: -webkit-gradient(linear, left top, left bottom, from(#ebf3fc), to(#dce9f9));
	    background-image: -webkit-linear-gradient(top, #ebf3fc, #dce9f9);
	    background-image:    -moz-linear-gradient(top, #ebf3fc, #dce9f9);
	    background-image:     -ms-linear-gradient(top, #ebf3fc, #dce9f9);
	    background-image:      -o-linear-gradient(top, #ebf3fc, #dce9f9);
	    background-image:         linear-gradient(top, #ebf3fc, #dce9f9);
	    -webkit-box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;
	    -moz-box-shadow:0 1px 0 rgba(255,255,255,.8) inset;
	    box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;
	    border-top: none;
	    text-shadow: 0 1px 0 rgba(255,255,255,.5);
	}
	 
	.bordered td:first-child, .bordered th:first-child {
	    border-left: none;
	}
	 
	.bordered th:first-child {
	    -moz-border-radius: 6px 0 0 0;
	    -webkit-border-radius: 6px 0 0 0;
	    border-radius: 6px 0 0 0;
	}
	 
	.bordered th:last-child {
	    -moz-border-radius: 0 6px 0 0;
	    -webkit-border-radius: 0 6px 0 0;
	    border-radius: 0 6px 0 0;
	}
	 
	.bordered th:only-child{
	    -moz-border-radius: 6px 6px 0 0;
	    -webkit-border-radius: 6px 6px 0 0;
	    border-radius: 6px 6px 0 0;
	}
	 
	.bordered tr:last-child td:first-child {
	    -moz-border-radius: 0 0 0 6px;
	    -webkit-border-radius: 0 0 0 6px;
	    border-radius: 0 0 0 6px;
	}
	 
	.bordered tr:last-child td:last-child {
	    -moz-border-radius: 0 0 6px 0;
	    -webkit-border-radius: 0 0 6px 0;
	    border-radius: 0 0 6px 0;
	}
	
	/* #applicationRecord, #application {
		border: 1px solid #c5c5c5;
		border-radius: 5px;
		padding: 10px;
	} */
	
	.mybtn {
		width: 100%;
		background-color: #2b79c2;
		color: white;
		font-weight: bold;
		margin-top: 20px;
	}
	
	.mybtn:hover {
		background-color: #1d85e6;
		color: white;
	}
	
	.mybtn:focus {
		outline: none;
		color: white;
	}
	
	
</style>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">

	 $(document).ready(function(){
		
		lookupApplicationList(); 
		 
		var spinner = $("input.spinnerInput").spinner();
		
		spinner.val(0);
		spinner.spinner({
			min:0,
			max:10,
			step:1,
			spin:function(event,ui){
				var count = 0;
				
				count = ui.value;
				// 스피너가 작동한 곳의 value값을 가져온다.
				
				$(this).parent().siblings(".sipnnerVal").val(count);
				
				// 스피너 이벤트가 일어난 태그의 형제 태그중 ".charge"의 값을 가져온다.
				// 스피너 이벤트가 일어난 태그의 값 * ".charge" 값 을 
				// 형제태그중 ".sumInput"에 넣어주기
				
				// 스피너가 돌아간 라인의 수수료칸의 값 가져오기
				var charge = $(this).parent().parent().siblings(".charge").text();
				//console.log($(this).parent().parent().siblings(".charge").text());
				
				var fee = Number(count) * Number(charge);
				//console.log(fee);
				
				$(this).parent().parent().siblings(".sum").children().val(fee);
				//console.log($(this).parent().parent().siblings(".sum").children().val());
				
				
				//console.log($(".sumInput").val());
				//var arrFee = $(".sumInput").val();
				//console.log("arrFee=>"+arrFee);
			/* 	$.each(arrFee, function(index, item){
					
				});
				$("#totalFee").val(totalFee); */
			}
		});
		
		$('.ui-spinner-button').click(function(){
			//console.log($("input.sumInput").val());
			
			var arrFee = [];
			var totalFee = 0;
			
			// ".sumInput" 태그들 값 확인해서 arrFee배열에 넣어주기
			$(".sumInput").each(function(index, item){
				arrFee.push(item.value);
				//console.log(item.value);
			});
			//console.log(arrFee);
			
			// arrFee 배열에 있는 값들 서로 더해주기
			$.each(arrFee, function(index, item){
				totalFee += Number(item);
			});
			//console.log(totalFee);
			
			$("#totalFee").val(totalFee);
			
		});
		
	});// end of $(document).ready(function(){});------------------------
	 
	function goApplication(){
		
		// certificateKindList의 길이를 추출
		var kindNum = "${certificateKindList}".split("}").length-1;
		
		// 증명서 발급신청란의 한 줄 한 줄을 배열로 가져옴
		var line = $(".line").get();
		//console.log(line);
		
		// 사용할 변수 만들어놓기
		var lang, count, recieveWay, certificateKindSeq, memberNo;
		var jobj, jArray;
		var totalInfo = new Object(); // jArray를 담을 곳
		jArray = new Array(); //jobj를 담을 배열생성

		// 증명서 발급신청란의 한 줄을 반복문으로 돌림
		$.each(line, function(index,item){
			//console.log(item);
			// 한 줄에서 넘겨줘야할 정보를 가져옴
			certificateKindSeq = $(item).find(".certificateKindSeq").val();
			memberNo = $(item).find(".memberNo").val();
			lang = $(item).find(".lang").val();
			count = $(item).find(".sipnnerVal").val();
			recieveWay = $(item).find(".recieveWay").val();
			
			
			if(lang==""||count==0||recieveWay==""){
				//사용자가 국/영문, 발급부수, 수령방법중 하나라도 선택하지 않았다면	
			}
			else {
				//사용자가 국/영문, 발급부수, 수령방법을 모두 선택한 경우
				// 그 줄의 정보를 json형식으로 만들어 배열에 담아줌
				//console.log(lang, count, recieveWay, certificateKindSeq, memberNo);
				
	            jobj = new Object(); //정보를 담을 object를 만들어줌
	            
	            // 정보를 넣음
	            jobj.memberNo = memberNo;
		        jobj.certificateKindSeq = certificateKindSeq;
		        jobj.lang = lang;
		        jobj.count = count;
		        jobj.recieveWay = recieveWay;
		        
		        jArray.push(jobj); // jArray 배열에 담아줌
			}
		});
		
		sjArray = JSON.stringify(jArray); // jArray를 string형식으로 변환해줌
	    console.log(sjArray);
		
		$.ajax({
			url:"<%=request.getContextPath()%>/certificateApplicate.sky",
			data: {"cList":sjArray},
			type:"post",
			dataType:"text",
			success: function(text){
				switch (text){
			      case "1" :
			    	  alert("증명서 신청 완료");
					  location.reload();
			          break;
			      case "2" :
			    	  alert("증명서 신청 실패");
			          break;
			      case "3" :
			    	  alert("신청할 내용을 확인해주세요.");
			          break;
				}
				
			},error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
		});
		
	
	}
	
	function lookupApplicationList(){
		$.ajax({
			url:"<%= request.getContextPath() %>/lookupApplicationList.sky",
			data:{"memberNo":"${loginuser.memberNo}"},
			type:"POST",
			dataType:"json",
			success: function(json){
				
				var html = "";
				
				//console.log(Object.keys(json).length);
				
				if(Object.keys(json).length <= 0){
					html += '<tr>'+
						'<td colspan="9">신청내역이 없습니다.</td>'+
					'<tr>';
				}
				else{
					$.each(json, function(index, item){
						html += '<tr>'+
									'<td>'+item.rno+'</td>'+
									'<td>'+item.name+'</td>'+
									'<td>'+item.certificateName+'</td>'+
									'<td>'+item.lang+'</td>'+
									'<td>'+item.count+'</td>'+
									'<td>'+item.applicationDate+'</td>'+
									'<td>'+item.grantStatus+'</td>';
									if(item.grantDate != null){
										html += '<td>'+item.grantDate+'</td>';
									}
									else{
										html += '<td>-</td>';
									}
									html += '<td>'+item.recieveWay+'</td>'+
								'</tr>';
					});
				}
	
				$("#applicationList").html(html);
			},
			error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	           }
			
		});
	}
</script>


<div id="certificateWrapper">
	<div class="defaultInfo">
		<label style="width: 30px;">학번</label><input type="text" class="defaultInput" value="${loginuser.memberNo}" readonly />
		<label style="width: 30px;">성명</label><input type="text" class="defaultInput" value="${loginuser.name}"  readonly />
	</div>
	<div id="block0">
		<div id="block1">
			<h4>증명서 발급 신청내역</h4>
			<div id="applicationRecord">
				<table class="bordered">
					<thead>
						<tr>
							<th>No</th>
							<th>신청자</th>
							<th>증명서종류</th>
							<th>국문/영문</th>
							<th>발급부수</th>
							<th>신청일자</th>
							<th>상태</th>
							<th>발급일자</th>
							<th>수령방법</th>
						</tr>
					</thead>
					<tbody id="applicationList"></tbody>
				</table>
			</div>
		</div>
		
		<div id="block2">
			<h4>증명서 발급 신청</h4>
			<div id="application">
				<table class="bordered">
					<thead>
						<tr>
							<th>No</th>
							<th>증명서종류</th>
							<th>수수료</th>
							<th>국문/영문</th>
							<th>발급부수</th>
							<th>수령방법</th>
							<th>금액</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${not empty certificateKindList}">
						<form name="applicationForm" class="appForm">
							<c:forEach var="ck" items="${certificateKindList}" varStatus="status">
									<tr class="line">
										<td>${status.count}</td>
										<td>
											${ck.certificateName}
											<input type="hidden" class="certificateKindSeq" name="certificateKindSeq" value="${ck.certificateKindSeq}"/>
											<input type="hidden" class="memberNo" value="${loginuser.memberNo}" name="memberNo"/>
										</td>
										<td class="charge">${ck.charge}</td>
										<td>
											<select class="lang" name="lang">
												<c:if test="${ck.lang eq '1'}">
						                               <option value="" selected>선택</option>
						                               <option value="0">국문</option>
						                               <option value="1">영문</option>
												</c:if>
												<c:if test="${ck.lang ne '1' }">
													   <option value="" selected>선택</option>
						                               <option value="0">국문</option>
												</c:if>
				                            </select>
										</td>
										<td class="spinner">
											<input class="spinnerInput" readonly/>
											<input type="hidden" class="sipnnerVal" name="count"/>	
										</td>
										<td>
											<select class="recieveWay" name="recieveWay">
												<option value="" selected>선택</option>
												<option value="0">직접수령</option>
												<option value="1">등기수령</option>
											</select>
										</td>
										<td class="sum">
											<input class="sumInput" value="0" readonly/>
										</td>
									</tr>
							</c:forEach>
						</form>
					</c:if>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="6" style="font-weight: bold;">총액</td>
							<td><input id="totalFee" value="0" readonly></td>
						</tr>
					</tfoot>
				</table>
				<button type="button" onclick="goApplication();" class="btn mybtn">발급신청</button>
			</div>
		</div>
	</div>
</div>