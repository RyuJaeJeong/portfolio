<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<div>
	<div style="">
		<h3>modify Page</h3>
	</div>
	<div style="">
		<form name="modForm" method="post">
			<input type="hidden" id="method" name="_method"/>
			<input type="hidden" name="no" value='<c:out value="${dto.no}" />'>
			<div class="form-group">
				<label>Title</label> 
				<input class="form-control" name="title" value='<c:out value="${dto.title }" />'>
			</div>
			<div class="form-group">
			    <label>content</label> 
			    <textarea class="form-control"  name="content">
			    	<c:out value="${dto.content }" />
			    </textarea>
			</div>	
			<div class="form-group">
			    <label>Writer</label> 
			    <input class="form-control" name="writer"  value='<c:out value="${dto.writer }" />'>
			</div>		
			<button type="button" id="mod-button">수정하기</button>
			<button type="button" id="list-button">리스트</button>
		</form>	
	</div>
		
	
</div>		


<%@include file="../includes/footer.jsp" %>