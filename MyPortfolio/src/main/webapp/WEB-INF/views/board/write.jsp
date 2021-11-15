<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<div>
	<div style="">
		<h3>Read Page</h3>
	</div>
	<div style="">
		<form name="Frm" method="post" >
			<div class="form-group">
				<label>Title</label> 
				<input class="form-control" name="title" value='<c:out value="${dto.title }" />' >
			</div>
			<div class="form-group">
			    <label>content</label> 
			    <textarea class="form-control"  name="content" >
			    	<c:out value="${dto.content}" />
			    </textarea>
			</div>	
			<div class="form-group">
			    <label>Writer</label> 
			    <input class="form-control" name="writer"  value='<c:out value="${dto.writer }" />' >
			</div>		
				<button type="button" id="write-button">작성하기</button>
				<button type="button" id="list-button" class="list-button">리스트</button>
		</form>	
	</div>
</div>		


<%@include file="../includes/footer.jsp" %>
    