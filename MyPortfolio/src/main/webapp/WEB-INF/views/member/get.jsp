<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<div id="readPage">
	<div style="">
		<h3>회원정보 상세보기</h3>
	</div>
	<div style="">
		<form name="readForm" method="get" >
			<input type="hidden" id="method" name="_method"/>
			<input class="form-control" type="hidden" name="mno" value='<c:out value="${dto.mno }" />' readonly="readonly">
			<div class="form-group">
				<label>아이디</label> 
				<input class="form-control" name="userid" value='<c:out value="${dto.userid }" />' readonly="readonly">
			</div>
			<div class="form-group">
			    <label>이름</label> 
			    <input class="form-control" name="userName"  value='<c:out value="${dto.userName }" />' readonly="readonly">
			</div>	
			<div class="form-group">
			    <label>권한</label> 
			    <c:forEach items="${dto.authList}" var="AuthDTO">
		  			 <input class="form-control" name="auth"  value=' <c:out value="${AuthDTO.auth}" />' readonly="readonly">
		  		</c:forEach>
			</div>	
			<div class="form-group">
			    <label>가입일자</label>
			    <input class="form-control" name="regiDate"  value='<fmt:formatDate value="${dto.regiDate}" pattern="yyyy.MM.dd" />' readonly="readonly">
			</div>	
				<button type="button" onclick="goList()">리스트</button>
				<button type="button" onclick="goModifyForm('${dto.userid}')">수정하기</button>
		</form>	
		<form id='operForm' method="get">
  			<input type="hidden" name='pageNumber' value = '<c:out value="${cri.pageNumber}" />'>
   			<input type="hidden" name='amount' value = '<c:out value="${cri.amount}" />'>
   			<input type="hidden" name='type' value='<c:out value="${cri.type}" />' />
   			<input type="hidden" name='keyword' value='<c:out value="${cri.keyword}" />' />
  		</form>
	</div>
</div>		

			
	  							
	  						
			
			

<%@include file="../includes/footer.jsp" %>
<script>
	function goList() {
		operForm.action = "/members";
		operForm.submit();
	}
	
	
	function goModifyForm(value1) {
		operForm.action = "/members/"+value1+"/edit";
		operForm.submit();
	}
	
</script>       