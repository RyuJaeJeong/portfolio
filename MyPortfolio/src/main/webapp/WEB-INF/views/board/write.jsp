<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<div>
	<div style="">
		<h3>write Page</h3>
	</div>
	<div style="">
		<form name="writeForm" method="post" >
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<div class="form-group">
				<label>Title</label>  
				<input class="form-control" name="title" >
			</div>
			<div class="form-group">
			    <label>content</label>
			    <textarea class="form-control"  name="content" rows="8" cols="85"></textarea>
			</div>	
			<div class="form-group">
			    <label>Writer</label> 
			    <input class="form-control" name="writer" value='<sec:authentication property="principal.username"/>' readonly>
			</div>		
				<button type="button" onclick="goWrite()">작성하기</button>
				<button type="button" onclick="goList()">리스트</button>
		</form>	
	</div>
</div>		


<%@include file="../includes/footer.jsp" %>

<script>
function goWrite() {
	writeForm.action = "/board/new"
	writeForm.submit();
}

function goList() {
	location.href='/board';
}

</script>
    