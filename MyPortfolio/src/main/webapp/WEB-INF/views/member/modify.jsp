<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>


	<div style="">
		<h3>회원정보 수정하기</h3>
	</div>
	<div style="">
		<form name="modifyForm" method="get" >
			<input type="hidden" id="method" name="_method"/>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input class="form-control" type="hidden" name="mno" value='<c:out value="${dto.mno }" />'>
			<input type="hidden" name='pageNumber' value = '<c:out value="${cri.pageNumber}" />'>
   			<input type="hidden" name='amount' value = '<c:out value="${cri.amount}" />'>
   			<input type="hidden" name='type' value='<c:out value="${cri.type}" />' />
   			<input type="hidden" name='keyword' value='<c:out value="${cri.keyword}" />' />
			<div class="form-group">
				<label>아이디</label> 
				<input class="form-control" name="userid" id="form-controll" value='<c:out value="${dto.userid }" />'>
			</div>
			<div class="form-group">
			    <label>비밀번호</label> 
			    <input class="form-control" name="userpw" id="userpw">
			</div>
			<div class="form-group">
			    <label>이름</label> 
			    <input class="form-control" name="userName" id="userName"  value='<c:out value="${dto.userName }" />'>
			</div>		
			<div class="form-group">
			    <label>현재 권한 : </label> 
			    <c:forEach items="${dto.authList}" var="AuthDTO">
		  			 <span><c:out value="${AuthDTO.auth}" /></span>
		  		</c:forEach>
			</div>
			<label>권한</label><br>
			<div class="form-group" style="display:flex; background-color: white;" >
				 
			    <div style="width:33%; border: 1px solid black" align="center">
			    	<label>USER</label> <input type="radio" name="auth" value="ROLE_USER">	
			   	</div>
			   	 <div style="width:33%; border: 1px solid black" align="center">
			   		<label>MEMBER</label> <input type="radio" name="auth" value="ROLE_MEMBER">
			   	</div>
			   	 <div style="width:34%; border: 1px solid black" align="center">
			   		<label>ADMIN</label> <input type="radio" name="auth" value="ROLE_ADMIN">	
				</div>
			</div>		
				<button type="button" onclick="goList()">리스트</button>
				<button type="button" onclick="goModify('${dto.userid}')">수정하기</button>
				<button type="button" onclick="goDelete('${dto.userid}')">삭제하기</button>	
		</form>	
	</div>

			
	  							
	  						
			
			

<%@include file="../includes/footer.jsp" %>
<script>
	function getContextPath() {
		var hostIndex = location.href.indexOf( location.host ) + location.host.length;
		return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
	};
	
	var contextPath = getContextPath();

	function goList() {
		modifyForm.method = "get" 
			$("input:text[name=userid]").remove();
			$("input:hidden[name=_csrf]").remove();
			$("input:hidden[name=_method]").remove();
			$("input:text[name=userpw]").remove();
			$("input:text[name=userName]").remove();
			$("input:radio[name=auth]").remove();
			modifyForm.action = contextPath + "/members";
			modifyForm.submit();
	}
	
	function goModify(value1) {
		
		var userid = $("#form-controll").val();
		var userpw = $("#userpw").val();
		var userName = $("#userName").val();
		
		if(!userid) {
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
		
		if(!userName) {
			alert('이름을 입력해 주세요.');
			return;
		}
		
		if(userName.length >= 50) {
			alert('이름은 최대 50자 까지만 가능합니다.');
			return;
		}
		
		if(!$('input:radio[name=auth]').is(':checked')) {
			alert('권한을 선택하세요.!');
			return false;
		}
		
		modifyForm.method = "post" 
		$("input:hidden[name=_method]").val("put");
		modifyForm.action = contextPath + "/members/"+value1;
		modifyForm.submit();
	}
	
	function goDelete(value1) {
		if(confirm('정말 삭제하시겠습니까?')) {
			modifyForm.method = "post" 
			$("input:hidden[name=_method]").val("delete");
			modifyForm.action =contextPath+"/members/"+value1;
			modifyForm.submit();
		}
	}
	
</script>       