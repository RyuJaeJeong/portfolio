<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@include file="../includes/header.jsp" %>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div id="conctentsBlock" style="width:1200">	
	<h1>갤러리</h1><br><br>	 
	 <c:set var="cell_counter" value="4"></c:set>
	 <c:set var="k" value="0"></c:set>	
	
	<table  width="1200">
	 	<tr>
	 		<th width="300">&nbsp;</th>
	 		<th width="300">&nbsp;</th>
	 		<th width="300">&nbsp;</th>
	 		<th align="right" width="300"><button type="button" onclick="goWriteForm()">작성하기</button></th>
	 	</tr>
		<c:forEach var="board" items="${list}"> 
			<c:set var="k" value="${k=k+1}" />	
			<c:if test="${k mod cell_counter == 1 }">					<%--k 가 1이면 tr 열어준다. --%>
				<c:set var="imsi_counter" value="0"></c:set>	
				<tr>
			</c:if>
							
			<td align="center" onclick="goRead('${board.gno}')">
				<c:set var="imsi_counter" value="${imsi_counter = imsi_counter + 1}"></c:set>
				<table border="1" width="300" height="300">
					<tr>
						<td>
							<img  src="${board.totalUri}">
						</td>
					</tr>
					<tr>
		 				 <td> <b>제목 : </b>${board.title}</td>
				 	</tr>
				</table>		 		
			</td>
			<c:if test="${k mod cell_counter == 0 }">
				</tr>		<%--k 가 0이면 tr 닫아준다. --%>
			</c:if>
		</c:forEach>
		<c:if test = "${imsi_counter < cell_counter }">
			<c:forEach var="i" begin="${imsi_counter+1 }" end ="${cell_counter }" step="1">
				<td>&nbsp;</td>
			</c:forEach>
		</c:if>
	</table>
	<div class='row'>
      	<div class="col-lg-12">
      		<form id='searchForm' action="<%=request.getContextPath()%>/gallery" method='get'>
      			<select name='type'>
      				<option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/> >--</option>
      				<option value="T"<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
      				<option value="C"<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>사진이름</option>
      				<option value="W"<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
      				<option value="TC"<c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 OR 사진이름</option>
      				<option value="TW"<c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목 OR 작성자</option>
      				<option value="TWC"<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목 OR 작성자 OR 사진이름</option>
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
	 <form id='actionForm' action="<%=request.getContextPath()%>/gallery" method='get'>
      	<input type="hidden" name='pageNumber' value = '${pageMaker.cri.pageNumber}'>
     	<input type="hidden" name='amount' value = '${pageMaker.cri.amount}'>
     	<input type="hidden" name='type' value='<c:out value="${pageMaker.cri.type}" />' />
        <input type="hidden" name='keyword' value='<c:out value="${pageMaker.cri.keyword}" />' />
    </form>
</div>

<%@include file="../includes/footer.jsp" %>
<script>
var actionForm = $("#actionForm");
function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

var contextPath = getContextPath();
	
	function goRead(value1) {
		actionForm.attr("action", contextPath + "/gallery/"+value1);
		actionForm.submit();
	}
	
	function goWriteForm() {
		self.location= contextPath + "/gallery/new";
	}
	
	
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
	
	$(".paginate_button a").on("click", function(e) {
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNumber']").val($(this).attr("href"));
		actionForm.submit();
	});
</script>
</body>
</html>