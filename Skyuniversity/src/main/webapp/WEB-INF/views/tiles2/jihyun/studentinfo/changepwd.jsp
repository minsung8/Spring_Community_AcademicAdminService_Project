<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>

 div.defaultInfo {
	 	margin-bottom: 30px;
	 }
	 
 input.defaultInput {
	 	width: 100px;
	 	margin-right: 20px;
	 	outline: none;
	 	}
	 	
 div#pwdChageContainer {
 	margin: 50px auto;
 	display: flex;
 	flex-direction: column;
 	align-items: center;
 	border: solid 2px #0843ad;
 	border-radius: 10px;
 	width: 60%;
 	padding: 50px;
 	font-size: 11pt;
 }
 
 .changeInput {
 	width: 50%;
 	
 }
 
 label.pcLabel {
 	margin-top: 10px;
 	width: 100px;
 }
 
 input.pcInput {
 	width: 100%;
 	outline: none;
 	border: none;
 	border-bottom: solid 1px lightgray;
 	margin-bottom: 10px;
 }

.btnChange {
	background-color: #0843ad; 
	/* border-color: #0843ad;  */
	/* -webkit-box-shadow: 0 3px 0 #088d74;  */
	/* box-shadow: 0 3px 0 #088d74; */
	color: white;
	border-radius: 20px;
	height: 30px;
	width: 50%;
}
.btnChange:hover {
	background-color:#2b79c2;
	outline: none;
}

.btnChange:active { 
	/* top: 3px;  */
	outline: none; 
	-webkit-box-shadow: none; 
	box-shadow: none;
}
.btnChange:focus {
	outline: none;
}

.errorMessage {
	color: red;
	font-weight: 300;
}

</style>

<script type="text/javascript">
	
	var boolNowPwd = false;
	var boolNewPwd = false;
	var boolCheckPwd = false;

	$(document).ready(function(){
		
		$("p.error").hide();
		
		$("input#nowPwd").blur(function(){
			
			$(this).next().hide();
			$(this).next().removeClass("errorMessage");
			
			// 입력된 비밀번호를 가져온다.
			var nowPwd = $(this).val().trim();
			
			if (nowPwd == "") {
				$(this).next().text("현재 비밀번호를 입력해주세요.");
				$(this).next().addClass("errorMessage");
				$(this).next().show();
			}
			else {
				$.ajax({
					url:"<%= request.getContextPath() %>/checkPwd.sky",
					data:{"memberNo":${loginuser.memberNo},"nowPwd":nowPwd},
					type:"POST",
					dataType:"json",
					success: function(json){
						//console.log(json.isEqualPwd);
						if(!json.isEqualPwd){
							
							$("input#nowPwd").next().text("비밀번호를 확인해주세요.");
							$("input#nowPwd").next().addClass("errorMessage");
							$("input#nowPwd").next().show();
						}
						else { // 비밀번호가 맞을때 => json.isEqualPwd == true일때
							boolNowPwd = true;
						} 
					},
					error: function(request, status, error){
			               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			           }
				});
			}
		});
		
		$("input#newPwd").blur(function(){
			
			$(this).next().hide();
			$(this).next().removeClass("errorMessage");
			
			var newPwd = $(this).val().trim();

            if (newPwd == "") {
                $(this).next().text("새비밀번호를 입력해주세요.");
                $(this).next().addClass("errorMessage");
                $(this).next().show();
            } else {
            	$.ajax({
            		url:"<%= request.getContextPath() %>/checkNewPwd.sky",
					data:{"memberNo":${loginuser.memberNo}, "newPwd":newPwd},
					type:"POST",
					dataType:"JSON",
					success: function(json){
						//console.log(json.isEqualPwd);
						if(json.isEqualPwd){
							$("input#newPwd").next().text("현재와 같은 비밀번호는 사용하실 수 없습니다.");
			                $("input#newPwd").next().addClass("errorMessage");
			                $("input#newPwd").next().show();
						} else { // json.isEqualPwd == false일때// 현재 사용중인 비밀번호랑 일치하지 않을 때
							var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
			                // 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성

			                var bool = regExp.test(newPwd);

			                if (!bool) {
			                    $("input#newPwd").next().text("비밀번호는 영문자,숫자,특수기호가 혼합된 8~15 글자로 입력하세요.");
			                    $("input#newPwd").next().addClass("errorMessage");
			                    $("input#newPwd").next().show();
			                } else {
			                	boolNewPwd = true;
			                }
						}
					},
					error: function(request, status, error){
			               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			           }
            	});
            }
		});
		
		$("input#CheckPwd").blur(function(){
			$(this).next().hide();
			$(this).next().removeClass("errorMessage");
			
			var newPwd = $("input#newPwd").val();
			var checkPwd = $(this).val().trim();

			if (checkPwd == "") {
                 $(this).next().text("새비밀번호 확인을 진행해주세요.");
                 $(this).next().addClass("errorMessage");
                 $(this).next().show();
            } else {
                 if (newPwd != checkPwd) {
                     $(this).next().text("비밀번호가 일치하지 않습니다.");
                     $(this).next().addClass("errorMessage");
                     $(this).next().show();
                     $("input#newPwd").focus();
                 } else {
                	 boolCheckPwd = true;
                 }
             }
		});
		
		$("input#CheckPwd").keyup(function(){
			if(event.keyCode == 13) {
				goChangePwd();
			}
		});
	});
	
	function goChangePwd() {
		if(boolNowPwd && boolNewPwd && boolCheckPwd ){
			console.log("비밀번호변경");
			var frm = document.pwdChangeFrm;
			
			frm.action = "<%=request.getContextPath()%>/pwdChangeEndhs.sky";
			frm.method = "POST";
			frm.submit();
		}
		else {
			
			var error = "";
			var cnt = 0;
			if(!boolNowPwd){
				error += "<현재 비밀번호>";
				cnt += 1;
			}
			
			if(!boolNewPwd){
				error += " <새 비밀번호>";
				cnt += 1;
			}
			
			if(!boolCheckPwd){
				error += " <비밀번호 확인란>";
				cnt += 1;
			}
			
			alert(error+"을(를) 확인해주세요.");
		}
		
	}
</script>

<div id="pwdChageContainer">

	<div class="defaultInfo">
		<label style="width: 35px;">학번</label><input type="text" class="defaultInput" value="${loginuser.memberNo}" readonly/>
		<label style="width: 35px;">이름</label><input type="text" class="defaultInput" value="${loginuser.name}" readonly/>
	</div>
	<form name="pwdChangeFrm" class="changeInput">
		<label class="pcLabel">현재 비밀번호</label><br>
		<input id="nowPwd"class="pcInput" type="password"/>
		<p class="error"></p>    	
		<label class="pcLabel">새 비밀번호</label><br>
		<input id="newPwd" class="pcInput" type="password" name="pwd"/>
		<p class="error"></p>    	
		<label class="pcLabel">비밀번호 확인</label><br>
		<input id="CheckPwd" class="pcInput" type="password" />
		<p class="error"></p>
		<input type="hidden" value="${loginuser.memberNo}" name="memberNo"/>
	</form>  	
	<button type="button" class="btnChange" onclick="goChangePwd();">비밀번호 변경</button>
</div>