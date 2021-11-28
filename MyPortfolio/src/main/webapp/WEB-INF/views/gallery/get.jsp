<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>


<div id="readPage">
	<div style="">
		<h3>상세보기</h3>
	</div>
		<br>
	<div style="">
		<form name="readForm" method="get" >
			<input type="hidden" id="method" name="_method"/>
			<input class="form-control" type="hidden" name="gno" value='<c:out value="${dto.gno}" />' readonly="readonly">
			<div class="form-group">
				<label>제목</label> 
				<input class="form-control" name="title" value='<c:out value="${dto.title }" />' readonly="readonly">
			</div>
			<div class="form-group">
			    <label>작성자</label> 
			    <input class="form-control" name="writer"  value='<c:out value="${dto.writer }" />' readonly="readonly">
			</div>	
			<div class="form-group">
			    <label>코멘트</label> 
			    <input class="form-control" name="comments"  value='<c:out value="${dto.comments }" />' readonly="readonly">
			</div>	
			<div class="form-group">
			    <label>사진</label> 
			    <div>
			  		<img src="${dto.totalUri}">
			  	</div>
			</div>	
				<button type="button" onclick="goList()">리스트</button>
				<sec:authentication property="principal" var="pinfo"/>
				<sec:authorize access="isAuthenticated()">
                       <c:if test="${pinfo.username eq dto.writer}">				
                         	<button type="button" onclick="goModifyForm('${dto.gno}')">수정하기</button>				
                       	</c:if>	
               </sec:authorize>
				
				
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

function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

var contextPath = getContextPath();


function goList() {
	operForm.action = contextPath + "/gallery";
	operForm.submit();
}

function goModifyForm(value1) {
	operForm.action = contextPath + "/gallery/"+value1+"/edit";
	operForm.submit();
}
</script>