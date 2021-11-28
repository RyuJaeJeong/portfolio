<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<div id="contents-block" >
	<h2>통계(차트)</h2>
	<br>
     <div id="chart-area"></div>
	
<%@include file="../includes/footer.jsp" %>


<script>

function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

var contextPath = getContextPath();


$(document).ready(function() {
	 const el = document.getElementById('chart-area');
	 var board = [];
	 var member = [];
	 var gallery = [];
	 var regidate = [];
	
	 
	    const options = {
	            chart: { title: '게시판 사용률', width: 1000, height: 500 },
	            xAxis: {
	              title: '날짜',
	            },
	            yAxis: {
	              title: '갯수',
	            },
	            legend: {
	              align: 'bottom',
	            },
	          };
	      
	
	 $.ajax({
         type : 'get',
         url : contextPath + '/api/statistics',
         dataType : 'JSON',
         success : function(result){
					for (var i = result.length-1; i >= 0; i--) {
						board.push(result[i].board)
						member.push(result[i].member)
						gallery.push(result[i].gallery)
						regidate.push(result[i].regdate)
					}
					
					const data = {
					        categories: regidate,
					        series: [
					          {
					            name: 'board',
					            data: board,
					          },
					          {
					            name: 'member',
					            data: member,
					          },
					          {
					            name: 'gallery',
					            data: gallery,
					          },
					        ],
					      };
					
					const chart = toastui.Chart.lineChart({ el, data, options });
					
         }
	 
	 	
    	});
	 
   
});


</script>