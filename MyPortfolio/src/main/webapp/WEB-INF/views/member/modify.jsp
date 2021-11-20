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
				<input class="form-control" name="userid" value='<c:out value="${dto.userid }" />'>
			</div>
			<div class="form-group">
			    <label>비밀번호</label> 
			    <input class="form-control" name="userpw">
			</div>
			<div class="form-group">
			    <label>이름</label> 
			    <input class="form-control" name="userName"  value='<c:out value="${dto.userName }" />'>
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
	function goList() {
		modifyForm.method = "get" 
			$("input:text[name=userid]").remove();
			$("input:hidden[name=_csrf]").remove();
			$("input:hidden[name=_method]").remove();
			$("input:text[name=userpw]").remove();
			$("input:text[name=userName]").remove();
			$("input:radio[name=auth]").remove();
			modifyForm.action = "/members";
			modifyForm.submit();
	}
	
	function goModify(value1) {
		modifyForm.method = "post" 
		$("input:hidden[name=_method]").val("put");
		modifyForm.action = "/members/"+value1;
		modifyForm.submit();
	}
	
	function goDelete(value1) {
		if(confirm('정말 삭제하시겠습니까?')) {
			modifyForm.method = "post" 
			$("input:hidden[name=_method]").val("delete");
			modifyForm.action = "/members/"+value1;
			modifyForm.submit();
		}
	}
	
</script>       