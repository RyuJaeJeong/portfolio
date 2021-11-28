<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<div id="contents-block" >
	<h2>통계(그리드)</h2>
	<br>
	
	
	
	 <div id="grid"></div>
	
<%@include file="../includes/footer.jsp" %>


<script>

function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

var contextPath = getContextPath();

$(document).ready(function() {
	var grid = new tui.Grid({
	    el: document.getElementById('grid'),
	    //data: gridData,
	    scrollX: false,
	    scrollY: false,
	    columns: [
	      {
	        header: '날짜',
	        name: 'regdate'
	      },
	      {
	        header: '게시판',
	        name: 'board'
	      },
	      {
	        header: '회원관리',
	        name: 'member'
	      },
	      {
	        header: '갤러리',
	        name: 'gallery'
	      }
	    ],
		
	 summary: {
	        height: 40,
	        position: 'bottom', // or 'top'
	        columnContent: {
	          board: {
	            template: function(valueMap) {
	              console.log(valueMap)
	        
	              return '<b>total : ' + valueMap.sum +'<br> avg : '+valueMap.avg.toFixed(2)+'</b>';
	            }
	          },
	          member: {
	            template: function(valueMap) {
	            	return '<b>total : ' + valueMap.sum +'<br> avg : '+valueMap.avg.toFixed(2)+'</b>';
	            }
	          },
	          gallery: {
		            template: function(valueMap) {
		            	return '<b>total : ' + valueMap.sum +'<br> avg : '+valueMap.avg.toFixed(2)+'</b>';
		            }
		      }
	          
	        }
	 }
	
	  });
	
	
	      
	
	 $.ajax({
         type : 'get',
         url : contextPath + '/api/statistics',
         dataType : 'JSON',
         success : function(data){
				grid.resetData(data);
				
         }
    	});
   
});


</script>