<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<h2>자유게시판</h2>


<button type="button" class="go-write-button" id="go-write-button">작성하기</button>


<table style="border">
  <tr>
    <th>no</th>
    <th>제목</th>
    <th>작성자</th>
    <th>작성일</th>
  </tr>
  
  <c:forEach items="${list}" var="board">
  	<tr>
  		<td> <c:out value="${board.no}" /> </td>
  		<td>
  		 	<a href='/board/<c:out value="${board.no}" />'>
  				<c:out value="${board.title}" />
  			</a>
  		 </td>
  		<td> <c:out value="${board.writer}" /> </td>
  		<td> <c:out value="${board.regidate}" /> </td>
  	</tr>	
  </c:forEach>
  
  <tr>
    <th>no</th>
    <th>제목</th>
    <th>작성자</th>
    <th>작성일</th>
  </tr>
</table>



<%@include file="../includes/footer.jsp" %>

