<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>
<div id="contents-block" >
	<h2>자유&nbsp;게시판</h2>
	
	
	<button type="button" onclick="goWriteForm()"  style="float: right; margin-bottom: 10px">작성하기</button>
	<table style="border" class="table">
	  <tr>
	    <th>no</th>
	    <th>제목</th>
	    <th>작성자</th>
	    <th>작성일</th>
	    <th>레벨</th>
	  </tr>
	  <c:set var="jj" value="${pageMaker.num}"></c:set>
	  <c:forEach items="${list}" var="board">
	  	
	  	<tr>
	  		<td> <c:out value="${jj}" /> </td>
	  		<td style="white-space: ">
	  			<!-- 계층화 처리 -->
	  			<c:forEach var="i" begin="2" end="${board.level}" step="1">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</c:forEach>
				<c:if test="${board.level > 1 }">
					<c:set var="reVar" value="[Re]" />
				</c:if>
				<c:if test="${board.level <= 1 }">
					<c:set var="reVar" value="" />
				</c:if>
	  		 	<a href='#' onclick='goRead(<c:out value="${board.bno}" />)'>
	  				${reVar}<c:out value="${board.title}" /> <b>[<c:out value="${board.replyCnt}" />]</b>
	  			</a>
	  		 </td>
	  		<td> <c:out value="${board.writer}" /> </td>
	  		<td> <c:out value="${board.regidate}" /> </td>
	  		<td>${board.level }</td>
	  	</tr>	
	  	<c:set var="jj" value="${jj-1}"></c:set>
	  </c:forEach>
	  
	  <tr>
	    <th>no</th>
	    <th>제목</th>
	    <th>작성자</th>
	    <th>작성일</th>
	    <th>레벨</th>
	  </tr>
	</table>
	
	<div class='row'>
      	<div class="col-lg-12">
      		<form id='searchForm' action="<%=request.getContextPath()%>/board" method='get'>
      			<select name='type'>
      				<option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/> >--</option>
      				<option value="T"<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
      				<option value="C"<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
      				<option value="W"<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
      				<option value="TC"<c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 OR 내용</option>
      				<option value="TW"<c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목 OR 작성자</option>
      				<option value="TWC"<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목 OR 작성자 OR 내용</option>
      			</select>
      			<input type="text" name='keyword' value='<c:out value="${pageMaker.cri.keyword}" />' />
      			<input type="hidden" name='pageNumber' value = '<c:out value="${pageMaker.cri.pageNumber}" />'>
      			<input type="hidden" name='amount' value = '<c:out value="${pageMaker.cri.amount}" />'>
      			<button class='btn btn-default'>Search</button>
      		</form>
      	</div>
     </div>
	 <div class='pull-right'>
     	<ul class="pagination">
           <c:if test='${pageMaker.prev}'>
               <li class="paginate_button previous"><a href="${pageMaker.startPage -1}">Previous</a> </li>
            </c:if>
                    		
            <c:forEach var='num' begin='${pageMaker.startPage}' end='${pageMaker.endPage}'>
             	<li class='paginate_button next'><a href='${num}'>${num}</a></li>
            </c:forEach>
                    		
            <c:if test="${pageMaker.next}">
                 <li class="paginate_button next"><a href="${pageMaker.endPage + 1}">Next</a> </li>
            </c:if>
         </ul>
        <!-- end pagenation -->
                            
	</div>
	<!-- 조회 페이지, 수정 페이지에서 리스트로 복귀시 검색내역과 페이지를 유지하기 위해 넘겨줘야할 값들 -->
	 <form id='actionForm' action="<%=request.getContextPath()%>/board" method='get'>
      	<input type="hidden" name='pageNumber' value = '${pageMaker.cri.pageNumber}'>
     	<input type="hidden" name='amount' value = '${pageMaker.cri.amount}'>
     	<input type="hidden" name='type' value='<c:out value="${pageMaker.cri.type}" />' />
        <input type="hidden" name='keyword' value='<c:out value="${pageMaker.cri.keyword}" />' />
    </form>
</div>

<%@include file="../includes/footer.jsp" %>

<script>

function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

var contextPath = getContextPath();


var actionForm = $("#actionForm");

function goRead(value1) {
	actionForm.attr("action", contextPath+"/board/"+value1);
	actionForm.submit();
}

function goWriteForm() {
	self.location= contextPath + "/board/new";
}

$(".paginate_button a").on("click", function(e) {
	e.preventDefault();
	console.log('click');
	actionForm.find("input[name='pageNumber']").val($(this).attr("href"));
	actionForm.submit();
});



var searchForm = $("#searchForm");
$("#searchForm button").on("click", function(e) {
	
	if(!searchForm.find("option:selected").val()) {
		alert("검색종류를 선택하세요.");
		return false;
	}
	
	if(!searchForm.find("input[name='keyword']").val()) {
		alert("키워드를 선택하세요.");
		return false;
	}
	
	searchForm.find("input[name='pageNumber']").val("1");
	e.preventDefault();
	
	searchForm.submit();
	
});
</script>