<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<div>
	<div style="">
		<h3>'<c:out value="${board.writer }"/>' 님의 글에 대한 답변</h3>
		<br>
	</div>
	<div style="">
		<form name="answerForm" method="post" >
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<div class="form-group">
				<label>Title</label>  
				<input class="form-control" name="title"  id="title">
			</div>
			<div class="form-group">
			    <label>content</label>
			    <textarea class="form-control"  name="content" id="content" rows="8" cols="85"><c:out value="${board.content}" /></textarea>
			</div>	
			<div class="form-group">
			    <label>Writer</label> 
			    <input class="form-control" name="writer" value="<sec:authentication property="principal.username"/>" readonly/>
			</div>		
				<input type="hidden" name="mgr" value='<c:out value="${board.bno}" />'>
				<button type="button" onclick="goWrite()">작성하기</button>
				<button type="button" onclick="goList()">리스트</button>
		</form>	
	</div>
</div>		


<%@include file="../includes/footer.jsp" %>

<script>

function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

var contextPath = getContextPath();

function goWrite() {
	var title = $("#title").val();
	var content = $("#content").val();
	
	if(!title) {
		alert('제목을 입력 해주세요.');
		return;
	}
	
	if(title.length >= 500) {
		alert('제목은 최대 500자 까지만 가능합니다.');
		return;
	}
	
	if(!content) {
		alert('내용을 입력해 주세요.');
		return;
	}
	
	
	answerForm.action = contextPath + "/board/new"
	answerForm.submit();
}

function goList() {
	location.href= contextPath + '/board';
}

</script>
    