<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<div>
	<div style="">
		<h3>수정 페이지</h3>
	</div>
	<div style="">
		<form name="modifyForm" id='modifyForm'>
			<input type="hidden" id="method" name="_method"/>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input class="form-control" type="hidden" name="no" value='<c:out value="${dto.bno}" />'>
			<input type="hidden" name='pageNumber' value = '<c:out value="${cri.pageNumber}" />'>
   			<input type="hidden" name='amount' value = '<c:out value="${cri.amount}" />'>
   			<input type="hidden" name='type' value='<c:out value="${cri.type}" />' />
   			<input type="hidden" name='keyword' value='<c:out value="${cri.keyword}" />' />
			<div class="form-group">
				<label>Title</label> 
				<input class="form-control" name="title" value='<c:out value="${dto.title }" />'>
			</div>
			<div class="form-group" id="contentBox">
			    <label>content</label> 
			    <textarea class="form-control"  name="content" id=content rows="8" cols="85"><c:out value="${dto.content }" /></textarea>
			</div>	
			<div class="form-group">
			    <label>Writer</label> 
			    <input class="form-control" name="writer"  value='<c:out value="${dto.writer }" />'>
			</div>		
			<button type="button" onclick="goList()">리스트</button>
			<sec:authentication property="principal" var="pinfo"/>
				<sec:authorize access="isAuthenticated()">
                       <c:if test="${pinfo.username eq dto.writer}">				
                         	<button type="button" onclick="goModify('${dto.bno}')">수정하기</button>
							<button type="button" onclick="goDelete('${dto.bno}')">삭제하기</button>			
                       	</c:if>	
               </sec:authorize>
			
		</form>	
	</div>
	
		
	
</div>		


<%@include file="../includes/footer.jsp" %>
<script>
	function goList() {
		
		modifyForm.method = "get" 
		$("input:text[name=title]").remove();
		$("#contentBox").remove();
		$("input:text[name=writer]").remove();
		modifyForm.action = "/board";
		modifyForm.submit();
	}
	
	function goModify(value1) {
		modifyForm.method = "post" 
		$("input:hidden[name=_method]").val("put");
		modifyForm.action = "/board/"+value1
		modifyForm.submit();
	}
	
	function goDelete(value1) {
		if(confirm('정말 삭제하시겠습니까?')) {
			modifyForm.method = "post" 
			$("input:hidden[name=_method]").val("delete");
			modifyForm.action = "/board/"+value1;
			modifyForm.submit();
		}
	}
	
</script>