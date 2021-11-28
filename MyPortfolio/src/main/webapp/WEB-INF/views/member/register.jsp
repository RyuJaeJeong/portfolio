<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>



	<div style="">
		<h3>회원가입</h3>
	</div>
	<div style="">
		<form name="writeForm" method="post" >
			
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<label>아이디</label> <br>
			<div class="form-group" >
				<input type="text" id="form-controll" class="form-controll" name="userid">
				<label id="label_id"></label>
			</div>
			<div class="form-group">
			    <label>비밀번호</label> 
			    <input class="form-control" type="password" name="userpw" id="userpw">
			</div>
			<div class="form-group">
			    <label>비밀번호 확인</label> 
			    <input class="form-control"  type = "password" name="passcheck" id="passcheck">
			    <label id="label_pass"></label>
			</div>
			<div class="form-group">
			    <label>이름</label> 
			    <input class="form-control" name="userName"  id="userName">
			</div>		
			<input type="hidden" name="auth" value="ROLE_USER">
				<button type="button" onclick="goWrite()">가입하기</button>
				<button type="button" onclick="goList()">리스트</button>
		</form>	
	</div>

			
	  							
	  						
			
			

<%@include file="../includes/footer.jsp" %>
<script>

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}"

var number;

function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

var contextPath = getContextPath();



$("#form-controll").on("propertychange change keyup paste input", function() {
	id_check_div();
});

$("#passcheck").on("propertychange change keyup paste input", function() {
	pass_check_div();
});


function pass_check_div() {			//아이디 중복 체크 
		var userpw = $("#userpw").val();
		var passcheck = $("#passcheck").val();
		if(passcheck == '') {
			$("#label_pass").html (
				'비밀번호를 입력하세요');
			$("#label_pass").css (
				'color', 'green');
			$("#label_pass").css (
			'font-size', '8px');
			return
		}
		
		if(userpw == passcheck) {
			$("#label_pass").html("비밀번호가 일치합니다.");
			$("#label_pass").css('color', 'blue');
			$("#label_pass").css('font-size', '15px');
		}else if(userpw != passcheck ) {
			$("#label_pass").html("비밀번호가 일치하지 않습니다.");
			$("#label_pass").css('color', 'red');
			$("#label_pass").css('font-size', '15px');
		}
		
		
	
}


function goWrite() {
	var userid = $("#form-controll").val();
	var userpw = $("#userpw").val();
	var userName = $("#userName").val();
	var passcheck = $("#passcheck").val();
	
	if(!userid) {
		alert(userid);
		alert('아이디를 입력 해주세요.');
		return;
	}
	
	if(userid.length >= 25) {
		alert('아이디는 최대 25자 까지만 가능합니다.');
		return;
	}
	
	if(!userpw) {
		alert('비밀번호 입력해 주세요.');
		return;
	}
	
	if(userpw.length >= 50) {
		alert('비밀번호는 최대 50자 까지만 가능합니다.');
		return;
	}
	
	if(!passcheck) {
		alert('비밀번호 입력해 주세요.');
		return;
	}
	
	if(!userName) {
		alert('이름을 입력해 주세요.');
		return;
	}
	
	if(userName.length >= 50) {
		alert('이름은 최대 50자 까지만 가능합니다.');
		return;
	}
	
	alert('가입에 성공하였습니다.!');
	writeForm.action = contextPath+"/members/new"
	writeForm.submit();
}
	
	function goList() {
		location.href= contextPath+'/members';
	}
	var number; 
	 function id_check_div() {			//아이디 중복 체크 
		 var id = document.getElementById("form-controll").value;
	  
	    	if(id == '') {
	    		$("#label_id").html (
	    			'아이디를 입력하세요');
	    		$("#label_id").css (
	        		'color', 'green');
	    		$("#label_id").css (
	    		'font-size', '8px');
	    		return
	    		
	    	}
	    	
	    	 var param = "userid=" + id;
	    	    $.ajax({
	    	    	type: "post",
	    	    	data: param,
	    	    	dataType:'json',
	    	    	url: contextPath + "/members/new/checkuserid",
	    	    	beforeSend: function(xhr){
	 	            	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	 	            },
	    	    	success: function(result) {
	    	    		
	    	    		number = result;
	    	    		console.log(number);
	    	    		if(number>0) {
	    	    			$("#form-controll").val('');
	    	    			$("#label_id").html("사용할 수 없는 아이디입니다.");
	    	    			$("#label_id").css('color', 'red');
	    	    			$("#label_id").css('font-size', '15px');
	    	    		}else {
	    	    			$("#label_id").html("사용할 수 있는 아이디입니다.");
	    	    			$("#label_id").css('color', 'blue');
	    	    			$("#label_id").css('font-size', '15px');
	    	    		}
	    	    	} 	
	    });

	 }
	
</script>       