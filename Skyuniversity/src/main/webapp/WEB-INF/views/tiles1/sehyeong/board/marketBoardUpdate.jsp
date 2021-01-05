<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();

%>
<style type="text/css">

	div.container {
		width: 80%;
		height: 1000px;
		border: solid 1px gray;
	}

	select#category {
		width: 30%;
	}

	input#subject {
		width: 85%;
	}


	ul {
		list-style: none;
	}
	
	ul > li:nth-child(4), li:nth-child(5) {
		margin-top: 20px;
	}
	
	span {
		color: red;
	}
	
	button {
		width: 80px;
		height: 30px;
		margin: 0 20px;
		border-radius: 5%;
		border: none;
		background-color: #0841ad;
		color: white;
	}
	
	button:hover {
		font-weight: bold;
	}
	div#register-div {
		line-height: 1.5;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		$("select#categoryNo").find("option[value=${boardvo.categoryNo}]").prop("selected", true);
		$("input#subject").val("${boardvo.subject}");
		$("input#price").val("${boardvo.price}".replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		
		
		
		
		//전역변수
	    var obj = [];
	    
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "content",
	        sSkinURI: "<%= ctxPath %>/resources/smarteditor/SmartEditor2Skin.html",
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,            
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : false,    
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : false,
	        }
	    });
	    
	    
	    $("#price").blur(function(){
	    	
	    	var priceVal = $("#price").val().trim();
	    	
	    	priceVal = priceVal.replace(/,/g,'');
	    	
	    	
			var regExp = /^[0-9]+$/g;
	 		
	 		var bool = regExp.test(priceVal);
	 		
	 		if (!bool) {
	 			
	 			// 가격이 숫자만 들어있지 않을 때 
	 			$("span#marketError").text(" * 가격은 숫자만 부탁");
		         return;
	 		} else {
	 			// 숫자만 있는경우
	 			
	 			// 앞에나오는 0을 모두 지우기
	 			$("span#marketError").text("");
	 			
	 			if(priceVal == "0") {
	 				$("#price").val("0");
	 				return;
	         	}
	 			
				priceVal = priceVal.replace(/(^0+)/, "");
	 			
				if(priceVal == "") {
	 				$("#price").val("0");
	 				return;
	         	}
				
				$("#price").val(priceVal.replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	 			
	 			
		        return;
	 		}
	    });
	    
	    
	    
	    //쓰기버튼
	    $("#marketBoardUdate").click(function(){
	    	
	        //id가 content인 textarea에 에디터에서 대입
	        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	        
           //스마트에디터 사용시 무의미하게 생기는 p태그 제거
	        var contentval = $("textarea#content").val();
	        // === 확인용 ===
	        // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
	        // "<p>&nbsp;</p>" 이라고 나온다.
	        
	        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
	        // 글내용 유효성 검사 
	        if(contentval == "" || contentval == "<p>&nbsp;</p>") {
	        	alert("글내용입력혀라~!!");
	        	return;
	        }
	        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
	        contentval = $("textarea#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
	    /*    
	              대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
	        ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
	                     그리고 뒤의 gi는 다음을 의미합니다.
	
	        	g : 전체 모든 문자열을 변경 global
	        	i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
	    */    
	        contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
	        contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환 
	        contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
	        $("textarea#content").val(contentval);
	     // alert(contentval);
	     
	      
	      	// 글제목 유효성 검사
	         var subjectVal = $("input#subject").val().trim();
	         if(subjectVal == "") {
	            alert("글제목을 입력부탁!!");
	            return;
	         }
     
	         
	         // 가격 유효성
	         var priceVal = $("input#price").val().trim();
	         if(priceVal == "") {
	            alert("가격을 입력부탁!");
	            return;
	         }
	         
	         
	         
	         var errorCheck = $("span#marketError").text().trim();
	         
	         if (errorCheck != "") {
	        	 return;
	         }
	         
	        
	 	   var frm = document.marketBoardUpdateForm;
	 	   frm.price.value = $("input#price").val().replace(/,/g,'');
	 	   frm.hi.value = $("#categoryNo option:selected").val();
	 	   frm.action = '<%= ctxPath%>/marketBoardEditEnd.sky';
	 	   frm.method = "POST";
	 	   frm.submit();
	    });
	   
	   
   });// end of $(document).ready(function() {});-------------------------------------

   
   function numberWithCommas(x) {
	   x = x.replace(/[^0-9]/g,'');   // 입력값이 숫자가 아니면 공백
	   x = x.replace(/,/g,'');          // ,값 공백처리
	   $("#price").val(x.replace(/\B(?=(\d{3})+(?!\d))/g, ",")); // 정규식을 이용해서 3자리 마다 , 추가 
	 }
  

</script>
    
<div class="container"  align="left" class="form-group">
	<form class="form-inline" name="marketBoardUpdateForm" enctype="multipart/form-data">		
		<ul>
			<li><h2 align="left">${tableInfo.boardName}</h2></li>
			<li><h3>작성자&nbsp;:&nbsp;<img src="<%= ctxPath %>/resources/images/levelimg/${boardvo.levelImg}" style="margin-bottom: 4px; width: 20px; height: 20px;" />&nbsp;${boardvo.nickname}</h3></li>
			<li>
				<select class="form-control" id="categoryNo" name="categoryNo">
					<c:forEach items="${categoryList}" var="category" varStatus="status">
						<option value="${category.categoryNo}">${category.categoryName}</option>
					</c:forEach>
				</select>
				<input class="form-control" type="text" id="subject" name="subject" placeholder="제목" autocomplete="off" maxlength="40"/>
			</li>
			<li>
				<input class="form-control" onkeyup="numberWithCommas(this.value);" type="text" id="price" name="price" placeholder="가격(숫자만)" autocomplete="off" maxlength="8" style="width: 20%; " value="0" />원
				
				<span id="marketError" style="color: red; font-weight: bold; margin-left: 30px;"></span>
			</li>
			
			<li>
				<textarea class="form-control" id="content" name="content" rows="30" style="width: 96%; resize: none;" placeholder="내용을 입력해주세요" >${boardvo.content}</textarea>
			</li>
			
			<li>
				<input class="form-control" type="file" name="attach" style="width: 40%;"  />
				<input type="hidden" name="boardNo" id="boardNo" value="${boardvo.boardNo}" />
				<input type="hidden" name="fk_boardKindNo" id="fk_boardKindNo" value="${boardvo.fk_boardKindNo}" />
				<input type="hidden" name="fk_commuMemberNo" id="fk_commuMemberNo" value="${boardvo.fk_commuMemberNo}" />
				<input type="hidden" name="writerIp" id="writerIp" value="${boardvo.writerIp}" />
				<input type="hidden" name="point" id="point" value="${boardvo.point}" />
				<input type="hidden" name="hi" id="hi" />
				<input type="hidden" name="gobackURL2" id="gobackURL2" value="${paraMap.gobackURL2}"/>
			</li>
			
		</ul>
		<br>
		<div align="center">
			<button type="button" id="marketBoardUdate" >수정</button>
			<button type="button" onclick="javascript:history.back()">취소</button>
		</div>
	</form>
	
</div>    
