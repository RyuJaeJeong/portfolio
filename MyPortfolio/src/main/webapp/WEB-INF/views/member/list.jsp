<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<div id="contents-block" >
	<h2>회원관리</h2>
	
	
	<button type="button" onclick="goWriteForm()"  style="float: right; margin-bottom: 10px">회원추가</button>
	<table style="border">
	  <tr>
	    <th>회원번호</th>
	    <th>회원 아이디</th>
	    <th>회원 이름</th>
	    <th>가입 날짜</th>
	    <th>회원 등급</th>
	  </tr>
	  <c:forEach items="${list}" var="member">
	  	
	  	<tr>
	  		<td> <c:out value="${member.mno}" /> </td>
	  		<td>
	  		 	<a href='#' onclick='goRead("<c:out value="${member.userid}" />")'>
	  				<c:out value="${member.userid}" /> 
	  			</a>
	  		 </td>
	  		<td> <c:out value="${member.userName}" /> </td>
	  		<td> 
	  			<fmt:formatDate value="${member.regiDate}" pattern="yyyy.MM.dd" />
	  		 </td>
	  		<td>
		  		<c:forEach items="${member.authList}" var="AuthDTO">
		  			 <c:out value="${AuthDTO.auth}" />
		  		</c:forEach>
	  		</td>
	  	</tr>	
	  </c:forEach>
	  
	  <tr>
	   	<th>회원 일련번호</th>
	    <th>회원 아이디</th>
	    <th>회원 이름</th>
	    <th>가입 날짜</th>
	    <th>회원 등급</th>
	  </tr>
	</table>
	
	<div class='row'>
      	<div class="col-lg-12">
      		<form id='searchForm' action="/members" method='get'>
      			<select name='type'>
      				<option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/> >--</option>
      				<option value="I"<c:out value="${pageMaker.cri.type eq 'I'?'selected':''}"/>>아이디</option>
      				<option value="N"<c:out value="${pageMaker.cri.type eq 'N'?'selected':''}"/>>이름</option>
      				<option value="IN"<c:out value="${pageMaker.cri.type eq 'IN'?'selected':''}"/>>아이디 OR 이름</option>
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
	 <form id='actionForm' action="/members" method='get'>
      	<input type="hidden" name='pageNumber' value = '${pageMaker.cri.pageNumber}'>
     	<input type="hidden" name='amount' value = '${pageMaker.cri.amount}'>
     	<input type="hidden" name='type' value='<c:out value="${pageMaker.cri.type}" />' />
        <input type="hidden" name='keyword' value='<c:out value="${pageMaker.cri.keyword}" />' />
    </form>
</div>

<%@include file="../includes/footer.jsp" %>

<script>

var actionForm = $("#actionForm");

function goRead(value1) {
	actionForm.attr("action", "/members/"+value1);
	actionForm.submit();
}

function goWriteForm() {
	self.location="/members/new";
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