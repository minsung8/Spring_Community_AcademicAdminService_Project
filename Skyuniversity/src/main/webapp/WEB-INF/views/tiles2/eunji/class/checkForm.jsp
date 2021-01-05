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

.olnone {
	list-style: none;
}
.olnone >li {
	display: inline-block;
}

</style>

<script type="text/javascript">

$(document).ready(function() {

	for(var i=1; i<=8; i++){
		$("#error"+i).hide();
	}
	
	$("#submit").click(function() {
		
		for(var i=1; i<=8; i++){
			$("#error"+i).hide();
		}
		
		var flag = true;
		
		if($('input:radio[name="firstQs"]:checked').length < 1){
			$("#error1").show();
			flag = false;
		}
		if($('input:radio[name="secondQs"]:checked').length < 1){
			$("#error2").show();
			flag = false;
		}
		if($('input:radio[name="thirdQs"]:checked').length < 1){
			$("#error3").show();
			flag = false;
		}
		if($('input:radio[name="fourQs"]:checked').length < 1){
			$("#error4").show();
			flag = false;
		}
		if($('input:radio[name="fiveQs"]:checked').length < 1){
			$("#error5").show();
			flag = false;
		}
		if($('input:radio[name="sixQs"]:checked').length < 1){
			$("#error6").show();
			flag = false;
		}
		if($('input:radio[name="sevenQs"]:checked').length < 1){
			$("#error7").show();
			flag = false;
		}
		if($('input:radio[name="eightQs"]:checked').length < 1){
			$("#error8").show();
			flag = false;
		}
		
		if(flag){
			alert("강의평가가 등록되었습니다.");
			var frm = document.regfrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/classCheckEnd.sky";
			frm.submit(); 
		}
		
	});
});
</script>
<div>
<div style="border: solid 2px #0843ad; width: 750px; margin: 0 auto; padding: 30px; background-color:#e6eeff;border-radius: 10px;">
<div>
	<span style="font-size: 12pt; font-weight: bold;float: left; padding-bottom: 10px;">강의평가</span>
</div>
<br>
<div id="classinfo">
	<table style="border-radius: 10px; background-color:white; width: 700px;">
		<tr style="height: 60px;">
			<td style="font-weight: bold; text-align: center; padding-top: 5px;">과목명:&nbsp;${subname}</td>
			<td style="padding-right: 50px; font-weight: bold;text-align: center; padding-top: 5px;">교수명:&nbsp;${proname}</td>
		</tr>
	</table> 
</div>

<br><br>
<div>
<form style="font-weight: bold;" name="regfrm">
	<div>
			<div>{1} 수업진행은 체계적이다.</div>
			<div><span id="error1" style="color: red">해당 항목을 선택해주세요.</span></div>
			<br>
			<ol class="olnone" id="firstol">
				<li>
					<label for="btype1">1</label>
					<input type="radio" name="firstQs" id="a" value="1"/>
				</li>
				<li>
					<label for="btype2">2</label>
					<input type="radio" name="firstQs" id="b" value="2"/>
				</li>
				<li>
					<label for="btype3">3</label>
					<input type="radio" name="firstQs" id="c" value="3"/>
				</li>
				<li>
					<label for="btype4">4</label>
					<input type="radio" name="firstQs" id="d" value="4"/>
				</li>
				<li>
					<label for="btype4">5</label>
					<input type="radio" name="firstQs" id="e" value="5"/>
				</li>
			</ol>
	</div>
	
	<div>
			<div>{2} 수업진도는 적절하다.</div>
			<div><span id="error2" style="color: red">해당 항목을 선택해주세요.</span></div>
			<br>
			<ol class="olnone">
				<li>
					<label for="btype1">1</label>
					<input type="radio" name="secondQs" id="a" value="1"/>
				</li>
				<li>
					<label for="btype2">2</label>
					<input type="radio" name="secondQs" id="b" value="2"/>
				</li>
				<li>
					<label for="btype3">3</label>
					<input type="radio" name="secondQs" id="c" value="3"/>
				</li>
				<li>
					<label for="btype4">4</label>
					<input type="radio" name="secondQs" id="d" value="4"/>
				</li>
				<li>
					<label for="btype4">5</label>
					<input type="radio" name="secondQs" id="e" value="5"/>
				</li>
			</ol>
	</div>
	
	<div>
			<div>{3} 수업 난이도는 적절하다.</div>
			<div><span id="error3" style="color: red">해당 항목을 선택해주세요.</span></div>
			<br>
			<ol class="olnone">
				<li>
					<label for="btype1">1</label>
					<input type="radio" name="thirdQs" id="a" value="1"/>
				</li>
				<li>
					<label for="btype2">2</label>
					<input type="radio" name="thirdQs" id="b" value="2"/>
				</li>
				<li>
					<label for="btype3">3</label>
					<input type="radio" name="thirdQs" id="c" value="3"/>
				</li>
				<li>
					<label for="btype4">4</label>
					<input type="radio" name="thirdQs" id="d" value="4"/>
				</li>
				<li>
					<label for="btype4">5</label>
					<input type="radio" name="thirdQs" id="e" value="5"/>
				</li>
			</ol>
	</div>
	
	<div>
			<div>{4} 이 수업을 다른 사람에게 추천해주고 싶다.</div>
			<div><span id="error4" style="color: red">해당 항목을 선택해주세요.</span></div>
			<br>
			<ol class="olnone">
				<li>
					<label for="btype1">1</label>
					<input type="radio" name="fourQs" id="a" value="1"/>
				</li>
				<li>
					<label for="btype2">2</label>
					<input type="radio" name="fourQs" id="b" value="2"/>
				</li>
				<li>
					<label for="btype3">3</label>
					<input type="radio" name="fourQs" id="c" value="3"/>
				</li>
				<li>
					<label for="btype4">4</label>
					<input type="radio" name="fourQs" id="d" value="4"/>
				</li>
				<li>
					<label for="btype4">5</label>
					<input type="radio" name="fourQs" id="e" value="5"/>
				</li>
			</ol>
	</div>
	
	<div>
			<div>{5} 강의자료가 적절히 활용되어 학습에 도움이 되었다.</div>
			<div><span id="error5" style="color: red">해당 항목을 선택해주세요.</span></div>
			<br>
			<ol class="olnone">
				<li>
					<label for="btype1">1</label>
					<input type="radio" name="fiveQs" id="a" value="1"/>
				</li>
				<li>
					<label for="btype2">2</label>
					<input type="radio" name="fiveQs" id="b" value="2"/>
				</li>
				<li>
					<label for="btype3">3</label>
					<input type="radio" name="fiveQs" id="c" value="3"/>
				</li>
				<li>
					<label for="btype4">4</label>
					<input type="radio" name="fiveQs" id="d" value="4"/>
				</li>
				<li>
					<label for="btype4">5</label>
					<input type="radio" name="fiveQs" id="e" value="5"/>
				</li>
			</ol>
	</div>
	
	<div>
			<div>{6} 시험, 과제 등 성적평가의 기준이 적절하며 공정하였다.</div>
			<div><span id="error6" style="color: red">해당 항목을 선택해주세요.</span></div>
			<br>
			<ol class="olnone">
				<li>
					<label for="btype1">1</label>
					<input type="radio" name="sixQs" id="a" value="1"/>
				</li>
				<li>
					<label for="btype2">2</label>
					<input type="radio" name="sixQs" id="b" value="2"/>
				</li>
				<li>
					<label for="btype3">3</label>
					<input type="radio" name="sixQs" id="c" value="3"/>
				</li>
				<li>
					<label for="btype4">4</label>
					<input type="radio" name="sixQs" id="d" value="4"/>
				</li>
				<li>
					<label for="btype4">5</label>
					<input type="radio" name="sixQs" id="e" value="5"/>
				</li>
			</ol>
	</div>
	
	<div>
			<div>{7} 교수는 열성을 갖고 수업을 진행하였다. </div>
			<div><span id="error7" style="color: red">해당 항목을 선택해주세요.</span></div>
			<br>
			<ol class="olnone">
				<li>
					<label for="btype1">1</label>
					<input type="radio" name="sevenQs" id="a" value="1"/>
				</li>
				<li>
					<label for="btype2">2</label>
					<input type="radio" name="sevenQs" id="b" value="2"/>
				</li>
				<li>
					<label for="btype3">3</label>
					<input type="radio" name="sevenQs" id="c" value="3"/>
				</li>
				<li>
					<label for="btype4">4</label>
					<input type="radio" name="sevenQs" id="d" value="4"/>
				</li>
				<li>
					<label for="btype4">5</label>
					<input type="radio" name="sevenQs" id="e" value="5"/>
				</li>
			</ol>
	</div>
	
	<div>
			<div>{8} 전체적으로 본 강의에 만족하였다. </div>
			<div><span id="error8" style="color: red">해당 항목을 선택해주세요.</span></div>
			<br>
			<ol class="olnone">
				<li>
					<label for="btype1">1</label>
					<input type="radio" name="eightQs" id="a" value="1"/>
				</li>
				<li>
					<label for="btype2">2</label>
					<input type="radio" name="eightQs" id="b" value="2"/>
				</li>
				<li>
					<label for="btype3">3</label>
					<input type="radio" name="eightQs" id="c" value="3"/>
				</li>
				<li>
					<label for="btype4">4</label>
					<input type="radio" name="eightQs" id="d" value="4"/>
				</li>
				<li>
					<label for="btype4">5</label>
					<input type="radio" name="eightQs" id="e" value="5"/>
				</li>
			</ol>
	</div>
	<br>
	<div>
		<div> - 수업 및 교수님께 전하고 싶은 말 - </div>
		<div>
			<textarea rows="7" cols="80" placeholder="작성해주시면 강의평가에 많은 도움이 됩니다." name="etc"></textarea>
			<input type="text" value="${semester}" name="semester" hidden="true"/>
			<input type="text" value="${no}" name="fk_courseno" hidden="true"/>
		</div>
	</div>
	<br>

	<br>
</form>

<div>
	<button style="float: right;" id="submit">제출하기</button>
</div>
</div>
</div>
</div>