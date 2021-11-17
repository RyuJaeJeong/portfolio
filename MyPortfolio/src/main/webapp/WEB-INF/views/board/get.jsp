<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<div id="readPage">
	<div style="">
		<h3>상세보기</h3>
	</div>
	<div style="">
		<form name="readForm" method="get" >
			<input type="hidden" id="method" name="_method"/>
			<input class="form-control" type="hidden" name="no" value='<c:out value="${dto.no }" />' readonly="readonly">
			<div class="form-group">
				<label>제목</label> 
				<input class="form-control" name="title" value='<c:out value="${dto.title }" />' readonly="readonly">
			</div>
			<div class="form-group">
			    <label>작성자</label> 
			    <input class="form-control" name="writer"  value='<c:out value="${dto.writer }" />' readonly="readonly">
			</div>	
			<div class="form-group">
			    <label>내용</label> 
			    <textarea class="form-control" rows="8" cols="85" name="content" readonly><c:out value="${dto.content}" /></textarea>
			</div>	
				<button type="button" onclick="goList()">리스트</button>
				<button type="button" onclick="goRewrite('${dto.no}')">답변하기</button>
				<button type="button" onclick="goModifyForm('${dto.no}')">수정하기</button>
		</form>	
		<form id='operForm' method="get">
  			<input type="hidden" name='pageNumber' value = '<c:out value="${cri.pageNumber}" />'>
   			<input type="hidden" name='amount' value = '<c:out value="${cri.amount}" />'>
   			<input type="hidden" name='type' value='<c:out value="${cri.type}" />' />
   			<input type="hidden" name='keyword' value='<c:out value="${cri.keyword}" />' />
  		</form>
	</div>
</div>		
			<div style=" background-color: #F5F5F5; border: 1px solid black;">
 				<form name="replyForm" id="replyForm">
 					<input type="hidden" name="board_no" value='<c:out value="${dto.no }" />'>
	  				<div style="padding:5px">
	  					<label>댓글</label><br />
	  				</div>
	  				<div style="padding:5px" align="right">
	  					<label>작성자</label> <input type="text" name="replyer" id="replyer">
	  				</div>	
	  					<textarea rows="4" cols="42" style="width: 100%; height: 80px; padding: 10px; box-sizing: border-box; border: 2px solid #EEEEE; box-sizing: border-box; border-radius: 6px; font-size: 16px;resize: both;" name="reply" id="reply"></textarea>
	  				<div align="right">
	  					<button type="button" onclick="add()" style="margin: 5px">등록하기</button>
	  				</div>
 				</form>	
	         </div>
			
            <div class="row">
            	<div class="col-lg-12">
            		<div class="panel panel-default">
            			
	            			
            			
            			<div class="panel-heading">
            				<i class="fa fa-comments fa-fw"></i> Reply
            			</div>
            			<div class="panel-body">
            			 	<ul class="chat">
            			 		<li class="left clearfix" data-rno='12'>
            			 			<div>
            			 				<div class="header" style="display: flex;">
            			 					<div style='width : 50%;'>
            			 						<strong class="primary-font">관리자</strong>
            			 						<small>(2021-11-17 00:00)</small>
            			 					</div>
            			 					<div style='width:50%;' align='right'>
            			 						<a href="#">수정하기</a>&nbsp; <a href="#">삭제하기</a>
            			 					</div>
            			 				</div>
            			 				<p>작성된 댓글이 없습니다.</p>
            			 			</div>
            			 		</li>
            			 	</ul>
            			</div>
            			<div class="panel-footer"></div>
            		</div>
            	</div>
            </div>

<%@include file="../includes/footer.jsp" %>
<script>
	function goList() {
		operForm.action = "/board";
		operForm.submit();
	}
	
	function goRewrite(value1) {
		location.href = "/board/write/"+value1;
	}
	
	function goModifyForm(value1) {
		operForm.action = "/board/modify/"+value1;
		operForm.submit();
	}
	/*----------------------댓글 관련 처리들--------------------------------*/
	
	//게시글 pk
	var board_no = '<c:out value="${dto.no}"/>';
	//댓글 리스트 부분
	var replyUL = $(".chat");
	//댓글 페이져 부분 
	var replyPageFooter = $(".panel-footer");
	//댓글 폼
	var replyForm = $("#replyForm");
	var pageNumber = 1;
	
	
	
	$(document).ready(function(){
		getList(board_no, pageNumber)
	});
	
	//댓글 리스트 불러오기
	function getList(value1, value2) {
	    var param = {
	    	"bno" : value1,
	    	"page" : value2
	    }
		var url = "/replies/pages/"+value1+"/"+value2;
		
	   $.ajax({
				type: "get",
				data: param,
				dataType:'json',
				url: url,	
				success: function(data){ 
					var str="";															
					if(data.list == null||data.list.length == 0){
						return;
					}
					
					//댓글 출력
					for(var i = 0, len = data.list.length || 0; i < len; i++) {
						str+="<li class='left clearfix'>"; 
						str+="	<div  id='p-false"+data.list[i].no+"'><div class='header' style='display: flex;'><div style='width : 50%;'><strong class'primary-font'>"+data.list[i].replyer+"</strong>";
						str+="		<small>("+displayTime(data.list[i].replyDate)+")</small></div>";
						str+="<div style='width:50%;' align='right'><a href='#' onclick='replyGet("+data.list[i].no+")'>수정하기</a>&nbsp; <a href='#' onclick='replydelete("+data.list[i].no+")'>삭제하기</a></div></div>"
						str+="			<p>"+data.list[i].reply+"</p></div>";
						str+="<div id='p-input"+data.list[i].no+"'  style='display:none;'>"
						str+="	<form name='replyModifyForm' id='replyModifyForm'>"
						str+="		<div style='padding:5px'>"
						str+="			<label>댓글수정</label><br />"
						str+="		</div>"
						str+="		<div style='padding:5px' align='right'>"
						str+="			<label>작성자</label> <input type='text' class='replyer"+data.list[i].no+"' name='replyer' id='replyer'>"
						str+="		</div>"
						str+="		<textarea class='reply"+data.list[i].no+"' rows='4' cols='42' style='width: 100%; height: 80px; padding: 10px; box-sizing: border-box; border: 2px solid #EEEEE; box-sizing: border-box; border-radius: 6px; font-size: 16px;resize: both;' name='reply' id='reply'></textarea>"
						str+="		<div align='right'>"
						str+=" 			<button type='button' onclick='replyModify("+data.list[i].no+")' style='margin: 5px'>등록하기</button>"
						str+="		</div>"	
						str+="	</form>"
						str+="</div>"
						str+="</li>"
					}
					replyUL.html(str);
					
					
					//댓글 페이징 처리
					str = "";
					
					str += "<ul class='pagination'>";
					str += "	<c:if test='" + ${data.dto.prev} + "'>";
			        str += "		<li><a href='#' onclick = 'getList({bno:bnoValue, page: " + ${data.dto.startPage -1} + "})'>Previous</a> </li>"   
			        str += "	</c:if>" 			        			
			        for(var i = data.dto.startPage; i<= data.dto.endPage; i++) {
			    		str += "<li><a href='#' onclick = 'getList({bno:bnoValue, page: " + i + "})'>"+i+"</a></li>"
			    	}
			        str += "	<c:if test='" + ${data.dto.next}+ "'>"    
				    str += "		<li><a href='#' onclick = 'getList({bno:bnoValue, page: " + ${data.dto.endPage + 1}+ "})'>Next</a> </li>";    	
				    str += "	</c:if>"   
			        str += "</ul>"            					      
			        replyPageFooter.html(str);   
			         
					
					
				}			
		});
	}
	
	//댓글 추가하기
	function add() {
		 $.ajax({
	            type : 'post',
	            url : '/replies/new',
	            data: $('#replyForm').serialize(),
	            success : function(data){
	            	$("#replyer").val("");
					$("#reply").val("");
					getList(board_no, pageNumber);
	            }
	       	});
	}
	
	//시간 출력
	function displayTime(timeValue) {
        var today = new Date();

        var gap = today.getTime() - timeValue;
        
        var dateObj = new Date(timeValue);
        var str = "";

        if(gap < (1000 * 60 * 60 * 24)) {

            var hh = dateObj.getHours();
            var mi = dateObj.getMinutes();
            var ss = dateObj.getSeconds();

            return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss].join('');

        } else {
            var yy = dateObj.getFullYear();
            var mm = dateObj.getMonth() + 1;
            var dd = dateObj.getDate();

            return [yy, '/', (mm > 9 ? '': '0') + mm, '/', (dd > 9 ? '' : '0') + dd].join('');
        }
    };
    
    //댓글 가져오기
    function replyGet(value1) {
    	document.querySelector('#p-false'+value1).style.display = 'none';
    	document.querySelector('#p-input'+value1).style.display = 'block';
    	var url = "/replies/"+value1;
    	 $.ajax({
				type: "get",
				data: value1,
				dataType:'json',
				url: url,	
    			success: function(data) {
    				console.log(data);	
    				$(".replyer"+value1).val(data.replyer);
    				$(".reply"+value1).val(data.reply);
    			}
    	 });
    }
    
    //댓글 수정하기 
    function replyModify(value1){
    	var url = "/replies/"+value1;
    	
    	
    	var param = {
    		"no" : value1,
    		"replyer" : $(".replyer"+value1).val(),
    		"reply" : $(".reply"+value1).val()    			
    	}
    	
    	$.ajax({
            type : 'put',
            url : '/replies/'+value1,
            data:JSON.stringify(param),
            contentType : "application/json; charset=utf-8",
            success : function(data){
            	alert('수정되었습니다.!');
				getList(board_no, pageNumber);
            }
       	});
    	 
    }
    
    function replydelete(value1) {
    	$.ajax({
            type : 'delete',
            url : '/replies/'+value1,
            data: value1,
            success : function(data){
            	alert('삭제되었습니다.!');
				getList(board_no, pageNumber);
            }
       	});
    }
    
</script>       