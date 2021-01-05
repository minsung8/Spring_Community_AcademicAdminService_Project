<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">

	div.container {
		width: 80%;
		height: 900px;
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
	
</style>

<script type="text/javascript">

   $(document).ready(function() {
      
	   
	   
   });// end of $(document).ready(function() {});-------------------------------------


</script>
    
<div class="container"  align="left" class="form-group">
	<form class="form-inline" name="registerForm" enctype="multipart/form-data">		
		<ul>
			<li><h2>oo게시판</h2></li>
			<li><h3>작성자&nbsp;:&nbsp;유저1</h3></li>
			<li>
				<select class="form-control" id="category" name="category" style="width: 10%;">
					<option>분류1</option>
					<option>분류2</option>
				</select>
				<input class="form-control" type="text" id="subject" name="subject" placeholder="제목" />
			</li>
			<li>
				<textarea class="form-control" rows="30" style="width: 95.4%; resize: none;">내용을 입력해 주세요.</textarea>
			</li>
			<li>
				<input class="form-control" type="file" name="attach1" style="width: 31.5%;" />
				<input class="form-control" type="file" name="attach2" style="width: 31.5%;" />
				<input class="form-control" type="file" name="attach3" style="width: 31.5%;" /><br>
				<span>&nbsp;&nbsp;&nbsp;파일은 최대 3개까지 첨부 가능합니다.</span>
			</li>
		</ul>
		<div align="center">
			<button id="btnRegister">등록</button>
			<button type="reset">취소</button>
		</div>
	</form>
	
</div>    
