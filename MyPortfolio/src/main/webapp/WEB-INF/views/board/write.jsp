<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<div>
	<div style="">
		<h3>Read Page</h3>
	</div>
	<div style="">
		<form name="writeForm" method="post" >
			<input type="text" name="mgr" value='<c:out value="${board.no}" />'>
			<div class="form-group">
				<label>Title</label> 
				<input class="form-control" name="title" >
			</div>
			<div class="form-group">
			    <label>content</label> 
			    <textarea class="form-control"  name="content" rows="8" cols="85"><c:out value="${board.content}"></c:out></textarea>
			</div>	
			<div class="form-group">
			    <label>Writer</label> 
			    <input class="form-control" name="writer"/>
			</div>		
				<button type="button" onclick="goWrite()">작성하기</button>
				<button type="button" onclick="goList()">리스트</button>
		</form>	
	</div>
</div>		


<%@include file="../includes/footer.jsp" %>

<script>
function goWrite() {
	writeForm.action = "/board/write"
	writeForm.submit();
}

function goList() {
	location.href='/board';
}

</script>
    