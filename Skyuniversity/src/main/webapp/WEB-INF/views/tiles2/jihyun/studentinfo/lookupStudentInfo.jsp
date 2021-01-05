<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>

<style>

  div#stundentInfoContainer {
 	padding: 20px 80px;
 	display: flex;
 	flex-direction: row;
 	justify-content: space-between;
 } 
 
 #sPhoto {
 	width: 20%;
 }
 
 #block1, #block2 {
 	width: 39%;
 }
 

.btnChange {
	font-family: 'Lato', sans-serif;
	box-sizing: border-box;
	margin: 5px;
	color: white;
	padding: 10px 30px;
	position: relative;
	border: 1px solid rgba(0,0,0,0.21);
	border-bottom: 4px solid rgba(0,0,0,0.21);
	border-radius: 4px;
	text-shadow: 0 1px 0 rgba(0,0,0,0.15);
	text-decoration: none;
	display: block;
	width: 60%;
	margin-left: auto;
	margin-right: auto;
	text-align: center;
	background: linear-gradient(to bottom, rgba(102,152,203,1) 0%, rgba(92,138,184,1) 100%);
 }

	
	.mybtn {
		background-color: #2b79c2;
		color: white;
		font-weight: bold;
		width: 90%;
	}
	
	.mybtn:hover {
		background-color: #1d85e6;
		color: white;
	}
	
	.mybtn:focus {
		outline: none;
		color: white;
	}
	
	.yourbtn:focus {
		outline: none;
	}
	
	table.type09 {
		border-collapse: collapse;
		text-align: left;
		line-height: 1.5;
		margin-top: 30px;
		margin-bottom: 10px;
	}
	
	table.type09 thead th {
		padding: 10px;
		font-weight: bold;
		vertical-align: top;
		color: #369;
		border-bottom: 3px solid #036;
	}
	
	table.type09 tbody th {
		width: 150px;
		padding: 10px;
		font-weight: bold;
		vertical-align: top;
		border-bottom: 1px solid #ccc;
		background: #f3f6f7;
	}
	
	table.type09 td {
		width: 350px;
		padding: 10px;
		vertical-align: top;
		border-bottom: 1px solid #ccc;
	}
	
	#sPhoto {
		/* border: solid 1px gray; */
		padding: 100px 50px;
	}

	.require {
		color: red;
		font-weight: bold;
	}

</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		$("input#mobile").keyup(function() { 
            $(this).val( $(this).val().replace(/[^\d]/g, "").replace(/(\d{3})(\d{4})(\d{4})/,"$1-$2-$3"));
            
            var mobile = $(this).val();
            if(mobile == ""){
                  
            }
            else{
                 // 010-7681-0219
                 $(this).blur(function () {
                    mobile = $(this).val();
                    if(mobile.length != 13){
                          $(this).val("");
                    }
                 });
            }
         });
		
		$("input#email").blur(function(){
			var email = $(this).val().trim();
			if(email == ""){
			}
			else {
				var regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
	            var bool = regExp.test(email);
	            if(!bool){
	            	$(this).val("");
	         	}
          }
		});
		
		$("input#engName").keyup(function(){
			$(this).val( $(this).val().replace(/[^a-zA-Z]/, ""));
			var engName = $(this).val().trim();
			if(engName == ""){
			}
			else {
			 	var regExp = new RegExp(/^[a-zA-Z]*$/);
	            var bool = regExp.test(engName);
	            if(!bool){
	            	$(this).val(""); 
	         	}
          }
		});
		
		$("input#chinaName").keyup(function(){
			$(this).val( $(this).val().replace(/[^가-힇ㄱ-ㅎㅏ-ㅣ一-龥]/, ""));
			var chinaName = $(this).val().trim();
			if(chinaName == ""){
			}
			else {
			 	var regExp = new RegExp(/[가-힇ㄱ-ㅎㅏ-ㅣ一-龥]/);
	            var bool = regExp.test(chinaName);
	            if(!bool){
	            	$(this).val(""); 
	         	}
          }
		});
		
		$("button#searchAddress").click(function () {
            new daum.Postcode({
                oncomplete: function (data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ""; // 주소 변수
                    var extraAddr = ""; // 참고항목 변수

                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === "R") {
                        // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else {
                        // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if (data.userSelectedType === "R") {
                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                        if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
                            extraAddr += data.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if (data.buildingName !== "" && data.apartment === "Y") {
                            extraAddr += extraAddr !== "" ? ", " + data.buildingName : data.buildingName;
                        }
                        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if (extraAddr !== "") {
                            extraAddr = " (" + extraAddr + ")";
                        }
                        // 조합된 참고항목을 해당 필드에 넣는다.
                        document.getElementById("extraAddress").value = extraAddr;
                    } else {
                        document.getElementById("extraAddress").value = "";
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById("postcode").value = data.zonecode;
                    document.getElementById("address").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("detailAddress").focus();
                },
            }).open();
            
            
        });
		
		
	}); // end of $(document).ready(function(){});-------------------------------------------

	function goUpdateAddress(){
		
		var postcode = $("input#postcode").val();
		var address = $("input#address").val();
		var detailAddress = $("input#detailAddress").val();
		var extraAddress = $("input#extraAddress").val();
		
		if(postcode == ""){
			postcode = "${loginuser.postcode}";
			console.log(postcode);
		}
		
		if(address == ""){
			address = "${loginuser.address}";
			console.log(address);
		}
		
		if(detailAddress == ""){
			detailAddress = "${loginuser.detailAddress}";
			console.log(detailAddress);
		}
		
		if(extraAddress == ""){
			extraAddress = "${loginuser.extraAddress}";
			console.log(extraAddress);
		}
		
		$.ajax({
			url:"<%=request.getContextPath()%>/sAddressUpdate.sky",
			data: {"memberNo":${loginuser.memberNo}, "postcode":postcode, "address":address, "detailAddress":detailAddress, "extraAddress":extraAddress},
			type:"post",
			dataType:"text",
			success: function(text){
				alert(text);
			},error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
		});
		
	}

	function goUpdateSInfo(){
		
		var mobile = $("input#mobile").val();
		var email = $("input#email").val();
		var chinaName = $("input#chinaName").val();
		var engName = $("input#engName").val();
		
		if(mobile == ""){
			mobile = "${loginuser.mobile}";
		}
		
		if(email == ""){
			email = "${loginuser.email}";
			console.log(email);
		}
		
		if(chinaName == ""){
			chinaName = "${loginuser.chinaName}";
			console.log(chinaName);
		}
		
		if(engName == ""){
			engName = "${loginuser.engName}";
			console.log(engName);
		}
		
		$.ajax({
			url:"<%=request.getContextPath()%>/sInfoUpdate.sky",
			data: {"memberNo":${loginuser.memberNo}, "email":email, "mobile":mobile, "chinaName":chinaName, "engName":engName},
			type:"post",
			dataType:"text",
			success: function(text){
				alert(text);
			},error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
		});
	}

</script>

<div id="stundentInfoContainer">
	
	<div id="sPhoto">
		<img src="<%=ctxPath%>/resources/images/studentImg/imgtest_jh.png" width="170px;"/><br><br>
		<p>※ 사진변경은 소속학과 사무실에 방문하여 변경해야 합니다.</p>
		<p>※ 성명(국문)변경은 소속학과 사무실에 방문하여 변경해야 합니다.</p>
		<p>※ 필수입력사항칸을 비워두고 저장할 경우 해당 사항은 변경되지 않습니다.</p>
	</div>
	<div id="block1">
		<table class="type09">
			<thead>
				<tr>
					<th scope="col" colspan="2">기본정보</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th scope="row">학번</th>
					<td>${loginuser.memberNo}</td>
				</tr>
				<tr>
					<th scope="row">성별</th>
					<td>${loginuser.gender}</td>
				</tr>
				<tr>
					<th scope="row">성명(국문)</th>
					<td>${loginuser.name}</td>
				</tr>
				<tr>
					<th scope="row">성명(영문)</th>
					<td>${loginuser.engName}</td>
				</tr>
				<tr>
					<th scope="row">성명(한문)</th>
					<td>${loginuser.chinaName}</td>
				</tr>
				<tr>
					<th scope="row">생년월일</th>
					<td>${loginuser.birth}</td>
				</tr>
				<tr>
					<th scope="row">입학일자</th>
					<td>${loginuser.enterDay}</td>
				</tr>
				<tr>
					<th scope="row">소속학부(과)</th>
					<td>${loginuser.deptName}</td>
				</tr>
				<tr>
					<th scope="row">현재 재학학년</th>
					<td>${loginuser.grade}학년</td>
				</tr>
				<tr>
					<th scope="row">현재 학적상태</th>
					<td>${loginuser.status}</td>
				</tr>
				<tr>
					<th scope="row">졸업일자</th>
					<td>
						<c:if test="${empty loginuser.graduateDay}">
							졸업전
						</c:if>
						<c:if test="${not empty loginuser.graduateDay}">
							${lginuser.graduateDay}
						</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row">휴학가능학기수</th>
					<td>${loginuser.absenceCnt}학기</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div id="block2">
		<div id="changeAdd">
			<table class="type09">
				<thead>
					<tr>
						<th scope="col" colspan="2">기본정보 변경</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row">연락처&nbsp;<span class="require">*</span></th>
						<td>
							<input type="text" class="caInput" id="mobile" value="${loginuser.mobile}" maxlength="13"/>
						</td>
					</tr>
					<tr>
						<th scope="row">이메일&nbsp;<span class="require">*</span></th>
						<td>
							<input type="text" class="caInput" id="email" value="${loginuser.email}"/>
						</td>
					</tr>
					<tr>
						<th scope="row">성명(한문)&nbsp;<span class="require">*</span></th>
						<td>
							<input type="text" class="caInput" id="chinaName" value="${loginuser.chinaName}"/>
						</td>
					</tr>
					<tr>
						<th scope="row">성명(영문)&nbsp;<span class="require">*</span></th>
						<td>
							<input type="text" class="caInput" id="engName" value="${loginuser.engName}"/>
						</td>
					</tr>
				</tbody>
			</table>
			<button type="button" onclick="goUpdateSInfo();" class="btn mybtn">저장</button>
			
			<table class="type09">
				<thead>
					<tr>
						<th colspan="2">주소 확인 및 변경</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row">우편번호&nbsp;<span class="require">*</span></th>
						<td>
							<input type="text" class="caInput" id="postcode" value="${loginuser.postcode}"/>
							<button type="button" id="searchAddress" class="btn btn-default yourbtn" style="margin: 0 10px;">주소찾기</button>
						</td>
					</tr>
					<tr>
						<th scope="row">주소&nbsp;<span class="require">*</span></th>
						<td>
							<input type="text" class="caInput" id="address" value="${loginuser.address}"/>
						</td>
					</tr>
					<tr>
						<th scope="row">상세주소&nbsp;<span class="require">*</span></th>
						<td>
							<input type="text" class="caInput" id="detailAddress" value="${loginuser.detailAddress}"/>
						</td>
					</tr>
					<tr>
						<th scope="row">참고주소</th>
						<td>
							<input type="text" class="caInput" id="extraAddress" value="${loginuser.extraAddress}"/>
						</td>
					</tr>
				</tbody>
			</table>
			<button type="button" onclick="goUpdateAddress();" class="btn mybtn">저장</button>
		</div>
	</div>
	
</div>