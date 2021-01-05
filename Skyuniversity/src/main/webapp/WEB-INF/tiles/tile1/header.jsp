<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.InetAddress"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>




<%-- ======= #27. tile1 중 header 페이지 만들기  ======= --%>
<%
   String ctxPath = request.getContextPath();

   // === #165. (웹채팅관련3) === 
   // === 서버 IP 주소 알아오기(사용중인 IP주소가 유동IP 이라면 IP주소를 알아와야 한다.) ===
   InetAddress inet = InetAddress.getLocalHost(); 
   String serverIP = inet.getHostAddress();
   
   //System.out.println("serverIP : " + serverIP);
   // serverIP : 192.168.56.65
   
   // String serverIP = "192.168.50.65"; 만약에 사용중인 IP주소가 고정IP 이라면 IP주소를 직접입력해주면 된다.
   
   // === 서버 포트번호 알아오기   ===
   int portnumber = request.getServerPort();
   //System.out.println("portnumber : " + portnumber);
   // portnumber : 9090
   
   String serverName = "http://"+serverIP+":"+portnumber; 
   
   String getMsgListSize = (String) session.getAttribute("getMsgListSize");
   
   
%>

<style type="text/css">

label#update-nickname:hover {
	cursor: pointer;
	font-weight: bold;
}

.modalAn {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 4; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0,0,0); /* Fallback color */
	background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}
    
        /* Modal Content/Box */
.modal-contentAn {
    background-color: #fefefe;
    margin: 15% auto; /* 15% from the top and centered */
    padding: 20px;
    border: 1px solid #888;
    width: 30%; /* Could be more or less, depending on screen size */          
    min-width: 500px;
}

.superSearchMan:hover {
	cursor: pointer;
	font-weight: bold;
}
.superSearchMan {
	padding: 3px;
}

#kakaoTalk:hover {
	cursor: pointer;
}



</style>

<script type="text/javascript">
	$(document).ready(function() {
		
		lenBoardList = 10;
		
		$("input#pwd").keydown(function(event){
           if(event.keyCode == 13) { 
              goLogin();
           }
        });
		
		
		$("input#search").keydown(function(event){
	           if(event.keyCode == 13) { 
	        	   goAnSearch();
	           }
	    });
		
		$("button#btnMoreHIT").click(function(){
				displayHIT($(this).val()); 
			
		});
		
		
		
		
		
	});
	
	
	function goLogin() {
		var id = $("input#id").val().trim();
		var pwd = $("input#pwd").val().trim();
		
		
		if(id == "") {
        	alert("아이디를 입력하세요!!");
        	$("#id").val(""); 
        	$("#id").focus();
        	return;
       }
      
       if(pwd == "") {
          alert("비밀번호를 입력하세요!!");
          $("#pwd").val(""); 
          $("#pwd").focus();
          return;
       }
		
		
		var frm = document.loginFrm;
		frm.action = "<%=ctxPath%>/login.sky";
		frm.method = "POST";
		frm.submit();
		
	}
	
	
	var lenBoardList = 10;
	
	
	function goAnSearch() {
		
		var searchVal = $("input#search").val().trim();
		
		var loginuser = "${sessionScope.loginuser.fk_memberNo}";
		
		if(loginuser == null || loginuser == "") {
			alert("NO 로그인 => NO 검색 :)");
			$("input#search").val("");
			return;
		}
		
		if(searchVal == "") {
			alert("NO 검색어 => NO 검색 :)");
			$("input#search").val("");
			return;
		}
		
		$.ajax({
			
			url: "<%= ctxPath%>/getAnSearchList.sky",
			type: "POST",
			data:{"searchWord": searchVal,
				"start": 1,
				"len": lenBoardList},
			dataType: "JSON",
			success:function(json) {
				
				$('#myModalAn').show();
				

				$("span#totalHITCount").hide();
				$("span#countHIT").hide();
				$("input#search").val("");
				$("input#hideSearchWord").val(searchVal);
				$('input#search:focus').blur();  
				
				html = "";
				if(json.length == 0) {
        			html += "<p style='font-size: 15pt; font-weight: bold; color: red;'>"+
        					"검색기록이 없습니다!!ㅋㅋ" +
        					"</p>" +
        					"<br>";
        					
        			$("div#displayHIT").html(html);
        			$("button#btnMoreHIT").hide();
        		}
				else if(json.length > 0) {
					// 데이터가 존재하는 경우
					// !!!!**** 중요 **** !!!! //
					// 더보기 ... 버튼의 value속성의 값을 지정해 주어야 한다.
					// 맨처음 start에 1이 들어오고 lenHIT가 더해져서 버튼의 밸류값은 9가 되어진다.
					// 더보기 버튼의 value값이 9로 변경되어 진다. 
					var totalHitCount = "";
					$.ajax({
			
						url: "<%= ctxPath%>/getAnTotalHitCount.sky",
						type: "POST",
						data:{"searchWord": searchVal},
						dataType: "JSON",
						success:function(json2) {
							totalHitCount = json2.totalHitCount;
							
							$("span#totalHITCount").text(totalHitCount);
							
							$("button#btnMoreHIT").val(	1 + lenBoardList );
							
							html +=  
								"<table style='width: 80% '>" +
								"<thead>" +
									"<tr style='padding: 5px; border-bottom: solid 1px black;'>" +
									"<th style='width: 38%; padding-left: 10px;'>카테고리</th>" +
									"<th style='width: 61%;'>글 제목</th>" +
									"</tr>" +
									"</thead>" +
									"<tbody id='addHere'>";
									
							// 제이쿼리 내의 반복문 $.each(json, function(index, item){});
							$.each(json, function(index, item){
								
								var subject = "";
								if (item.subject.length > 20) {
									subject = item.subject.substr(0,20) + "...";
								} else {
									subject = item.subject;
								}
								
								html += "<tr class='superSearchMan' onclick='javascript:goViewDetailLetsGo(this);'>" +
										"<td>" + item.boardName + "</td>" +
										"<td>" + subject + "</td>" +
										"<td style='display: none;' class='boardNo'>" + item.boardNo + "</td>" +
										"<td style='display: none;' class='boardKindNo'>" + item.fk_boardKindNo + "</td>";
										"</tr>";
								
							});
							
							html +=	"</tbody>" +
									"</table>";
									
							
							$("div#displayHIT").html(html);
							
							$("span#countHIT").text("0")
							
							
							var totototal = Number($("span#totalHITCount").text());
							
							
							$("span#countHIT").text((Number)($("span#countHIT").text())  +  json.length );
							
							
							if(json.length < totototal) {
								$("button#btnMoreHIT").text("더보기...");
								$("button#btnMoreHIT").show();
							}
							else if (json.length == totototal) {
								$("button#btnMoreHIT").hide();
							} else {
								$("button#btnMoreHIT").hide();								
							}
							
							
							
							/* if($("span#countHIT").text() == totototal) {
								$("span#end").html("더이상 검색기록이 없다~~");
								$("button#btnMoreHIT").show();
								$("button#btnMoreHIT").text("처음으로....");
								$("span#countHIT").text("0");
							} */
							
						},  error: function(request, status, error){
			                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			            }
						
					});
		
				} 
				
				
				
			},  error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
		});
		
		
		
		
		
		
	}
	
	 function close_pop(flag) {
        $('#myModalAn').hide();
		$("input#search").val("");
     };

     
     function displayHIT(start) {
    	 
    	 var searchVal = $("input#hideSearchWord").val();
    	 $.ajax({
 			
				url: "<%= ctxPath%>/getAnSearchList.sky",
				type: "POST",
				data:{"searchWord": searchVal,
					"start": start,
					"len": lenBoardList},
				dataType: "JSON",
				success:function(json) {
					
					
					$("button#btnMoreHIT").val(	Number(start) + lenBoardList );
					
					
					html = "";
					
					// 제이쿼리 내의 반복문 $.each(json, function(index, item){});
					$.each(json, function(index, item){
						
						var subject = "";
						if (item.subject.length > 20) {
							subject = item.subject.substr(0,20) + "...";
						} else {
							subject = item.subject;
						}
						
						html += "<tr class='superSearchMan' onclick='javascript:goViewDetailLetsGo(this);'>" +
								"<td>" + item.boardName + "</td>" +
								"<td>" + subject + "</td>" +
								"<td style='display: none;' class='boardNo'>" + item.boardNo + "</td>" +
								"<td style='display: none;' class='boardKindNo'>" + item.fk_boardKindNo + "</td>";
								"</tr>";
						
					});
					
					
							
					
					$("tbody#addHere").append(html);
					
					
					
					var totototal = Number($("span#totalHITCount").text());
					
					
					$("span#countHIT").text((Number)($("span#countHIT").text())  +  json.length );
					
					
					if(Number($("span#countHIT").text()) < totototal) {
						$("button#btnMoreHIT").text("더보기...");
						$("button#btnMoreHIT").show();
					}
					else if (Number($("span#countHIT").text()) >= totototal) {
						$("button#btnMoreHIT").hide();
					}
				},  error: function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
				
			});
     }
     
     
     function goViewDetailLetsGo(obj) {
    	
		var frm = document.headerViewForm;
		
		var boardKindNo = Number( $(obj).find('td.boardKindNo').text());
	
	
		
		if (boardKindNo <= 6 || (18 <= boardKindNo && boardKindNo <= 22)) {
			frm.action = "<%= ctxPath%>/minsungBoardView.sky";
		} else if (23 <= boardKindNo){
			frm.action = "<%= ctxPath%>/marketBoardDetail.sky";
		} else if (boardKindNo != 7){
	          frm.action = "<%=request.getContextPath()%>/boardDetail.sky";
	       } else{
	          frm.action = "<%=request.getContextPath()%>/boardDetail2.sky";
	       }
		
		frm.boardKindNo.value = boardKindNo;
		frm.boardNo.value = $(obj).find('td.boardNo').text();
		frm.method = "GET";
		frm.submit();
		
		
     }
	

</script>

<div id="header-content" align="center" class="hanna">
	<div id="logo-div" class="header-content-detail" >
		<img src="<%= ctxPath %>/resources/images/logo_size.jpg" style="cursor: pointer; width:90%; height: 90%;" onclick="javascript:location.href='<%= ctxPath%>/index.sky'">
	</div>

	<div id="menu-div" class="header-content-detail">
		<div class="menu-list-div">
			<label>학교</label>
			<ul>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/minsungBoardList.sky?boardKindNo=1'">공지사항</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/minsungBoardList.sky?boardKindNo=2'">학생회 게시판</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/minsungBoardList.sky?boardKindNo=3'">전공 게시판</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/minsungBoardList.sky?boardKindNo=4'">동아리 게시판</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/minsungBoardList.sky?boardKindNo=5'">졸업생 게시판</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/minsungBoardList.sky?boardKindNo=6'">학교 비판 게시판</li>
			</ul>
		</div>
		<div class="menu-list-div">
			<label>커뮤니티</label>
			<ul>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/boardList.sky?boardKindNo=7'">익명 게시판</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/boardList.sky?boardKindNo=8'">자유 게시판(반말)</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/boardList.sky?boardKindNo=9'">자유 게시판(존대)</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/boardList.sky?boardKindNo=10'">유머 게시판</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/boardList.sky?boardKindNo=11'">정치 사회 이슈</li>
			</ul>
		</div>
		<div class="menu-list-div">
			<label>관심사</label>
			<ul>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/boardList.sky?boardKindNo=12'">mbti</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/boardList.sky?boardKindNo=13'">맛집</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/boardList.sky?boardKindNo=14'">연애</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/boardList.sky?boardKindNo=15'">취미</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/boardList.sky?boardKindNo=16'">헬스</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/boardList.sky?boardKindNo=17'">다이어트</li>
			</ul>
		</div>
		<div class="menu-list-div">
			<label>정보</label>
			<ul> 
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/minsungBoardList.sky?boardKindNo=18'">스터디 게시판</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/minsungBoardList.sky?boardKindNo=19'">자격증 정보</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/minsungBoardList.sky?boardKindNo=20'">취업 게시판</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/minsungBoardList.sky?boardKindNo=21'">구인/구직</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/minsungBoardList.sky?boardKindNo=22'">분실물 게시판</li>
			</ul>
		</div>
		<div class="menu-list-div">
			<label>장터</label>
			<ul>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/marketboardList.sky?boardKindNo=23'">복덕복덕방</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/marketboardList.sky?boardKindNo=24'">중고서점</li>
				<li class="boardList" onclick="javascript:location.href='<%= ctxPath%>/marketboardList.sky?boardKindNo=25'">중고거래</li>
				
			</ul>
			<label id="kakaoTalk" onclick="javascript:location.href='<%= serverName%><%=ctxPath%>/chatting.sky'">채팅방으로</label>
			
			
		</div>
		
	
	</div>

	<div id="mypage-div" class="header-content-detail" >
	
		<div style="height: 70px;">
			<c:if test="${sessionScope.loginuser == null}">
				<form name="loginFrm" style="margin-top: 30px; text-align: left; line">
					<label style="width: 30px; margin-bottom: 5px;" >ID</label><input type="text" name="id" id="id" maxlength="20" placeholder="아이디" style="width: 70%; margin-bottom: 5px;" />
					<br>
					<label style="width: 30px;" >PW</label><input type="password" name="pwd" id="pwd" maxlength="20" placeholder="비밀번호" style="width: 70%;" />	
				</form>
			</c:if>
			 
			<c:if test="${sessionScope.loginuser != null}">
	          	
	          	<div style="margin-top: 30px;">
	          	
		          	<c:if test="${empty loginuser.nickname}">
		          		<span>설정된 닉네임이 없어요!</span>
		          		<br>
		          		<label id="update-nickname" onclick="javascript:location.href='<%=ctxPath%>/updateNicknameStart.sky'">닉네임 설정하러 가기</label>
		          	</c:if>
		          	
		          	<c:if test="${not empty loginuser.nickname}">
			          	<c:if test="${loginuser.fk_memberNo == 0 }">
			        		<span id="nickname" style="font-size: 15pt; color: blue; cursor:pointer;" onclick="javascript:location.href='<%=ctxPath%>/checkALlNotice.sky'">${loginuser.nickname}</span>&nbsp;<span></span>
			          	</c:if>
			          	<c:if test="${loginuser.fk_memberNo != 0 }">
			        		<span id="nickname" style="font-size: 15pt; color: blue; cursor:pointer;" onclick="javascript:location.href='<%=ctxPath%>/checkMyList.sky'">${loginuser.nickname}</span>&nbsp;<span></span>
			          	</c:if>
		        		<br>
		          		<label id="update-nickname" onclick="javascript:location.href='<%=ctxPath%>/updateNicknameStart.sky'">닉네임 재설정</label>
		          	</c:if>
		        	<br>
		        	<span id=""><img src="<%= ctxPath %>/resources/images/levelimg/${loginuser.levelvo.levelImg}" style="width: 20px; height: 20px;" />&nbsp;${loginuser.levelvo.levelName}</span>
	          	</div>
			</c:if>
		</div>
		
		
		<ul style="margin-top: 10px;">
			<c:if test="${sessionScope.loginuser == null}">
				<li onclick="goLogin();">로그인</li>
			</c:if>
			<c:if test="${sessionScope.loginuser != null}">
				<li onclick="javascript:location.href='<%=ctxPath%>/logout.sky'">로그아웃</li>
				<li onclick="javascript:location.href='<%= ctxPath%>/messageLetsGetIt.sky'">쪽지[<%=getMsgListSize%>]</li>
			</c:if>
			<li onclick="javascript:location.href='<%= ctxPath%>/hsindex.sky'">학사행정</li>
		</ul>
		<input type="text" name="search" id="search" placeholder="Search.." autocomplete="off"  maxlength="8" />
		<input type="text" style="display: none;" id="hideSearchWord">
		<button type="button"  style="width: 40px; background-color: #0843ad; color: white; padding: 2px; border-radius: 7px; border: none;" onclick="goAnSearch();">검색</button>
		
		<div id="myModalAn" class="modalAn">
			
			
			
			<!-- Modal content -->
			<div class="modal-contentAn">
				<a href="javascript:close_pop();" class="close">&times;</a>
				<p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">검색결과</span></b></span></p>
				<div id="displayHIT" style="overflow: auto; max-height: 300px;" ></div>
		
				<div style="margin: 20px 0;">
					<span id="end" style="font-size: 16pt; font-weight: bold; color: red;"></span>
					<br />
					<button type="button" id="btnMoreHIT" value="">더보기....</button>
					<span id="totalHITCount"></span>
					<span id="countHIT">0</span>
				</div>
				<p><br /></p>
				<div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
				<span class="pop_bt" style="font-size: 13pt;" >
				         닫기
				</span>
				</div>
				
				
			</div>
		
		</div>
		 <!-- The Modal -->
		<form name="headerViewForm">
			<input type="hidden" name="boardKindNo" />
			<input type="hidden" name="boardNo" />
		</form>
	</div>
	
	
</div>



