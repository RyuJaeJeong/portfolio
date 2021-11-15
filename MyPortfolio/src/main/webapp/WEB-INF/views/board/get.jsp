<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<div>
	<div style="">
		<h3>Read Page</h3>
	</div>
	<div style="">
		<form name="Frm" method="post" >
			<input type="hidden" id="method" name="_method"/>
			<div class="form-group">
				 <label>no</label> 
				 <input class="form-control" type="hidden" name="no" value='<c:out value="${dto.no }" />' readonly="readonly">
			</div>
			<div class="form-group">
				<label>Title</label> 
				<input class="form-control" name="title" value='<c:out value="${dto.title }" />' readonly="readonly">
			</div>
			<div class="form-group">
			    <label>content</label> 
			    <textarea class="form-control"  name="content" readonly="readonly">
			    	<c:out value="${dto.content}" />
			    </textarea>
			</div>	
			<div class="form-group">
			    <label>Writer</label> 
			    <input class="form-control" name="writer"  value='<c:out value="${dto.writer }" />' readonly="readonly">
			</div>		
				<button type="button" class="go-mod-button" id="go-mod-button">수정하기</button>
				<button type="button" id="delete-button">삭제하기</button>
				<button type="button" id="list-button" class="list-button">리스트</button>
		</form>	
	</div>
</div>		


<%@include file="../includes/footer.jsp" %>
    