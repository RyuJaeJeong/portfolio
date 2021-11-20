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
			<input class="form-control" type="hidden" name="bno" value='<c:out value="${dto.bno }" />' readonly="readonly">
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
				<button type="button" onclick="goAnswer('${dto.bno}')">답변하기</button>
				
				<sec:authentication property="principal" var="pinfo"/>
				<sec:authorize access="isAuthenticated()">
                       <c:if test="${pinfo.username eq dto.writer}">				
                         	<button type="button" onclick="goModifyForm('${dto.bno}')">수정하기</button>				
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

			
	  							
	  						
			<div style=" background-color: #F5F5F5; border: 1px solid black;">
 				<form name="replyForm" id="replyForm">
 					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
 					<input type="hidden" name="bno" value='<c:out value="${dto.bno }" />'>
	  				<div style="padding:5px">
	  					<label>댓글</label><br />
	  				</div>
	  				<div style="padding:5px" align="right">
	  					<label>작성자</label> 
	  						<sec:authorize access="isAnonymous()">
	  							<input type="text" name="replyer" id="replyer" value='' readonly>
	  						</sec:authorize>
	  						<sec:authorize access="isAuthenticated()">
	  							<input type="text" name="replyer" id="replyer" value='${pinfo.username}' readonly>
	  						</sec:authorize>
	  				</div>	
	  					<textarea rows="4" cols="42" class="replyarea" name="reply" id="reply"></textarea>
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
$(document).ready(function(){
	
	if (typeof jQuery == 'undefined') {

		alert("없음");

		}else{

		alert("있음");

		}
	
});

	function goList() {
		operForm.action = "/board";
		operForm.submit();
	}
	
	function goAnswer(value1) {
		location.href = "/board/"+value1 +"/answer";
	}
	
	function goModifyForm(value1) {
		operForm.action = "/board/"+value1+"/edit";
		operForm.submit();
	}
	/*----------------------댓글 관련 처리들--------------------------------*/
	
	//게시글 pk
	var bno = '<c:out value="${dto.bno}"/>';
	//댓글 리스트 부분
	var replyUL = $(".chat");
	//댓글 페이져 부분 
	var replyPageFooter = $(".panel-footer");
	//댓글 폼
	var replyForm = $("#replyForm");
	var pageNumber = 1;
	<sec:authorize access="isAuthenticated()">
		replyer = '<sec:authentication property="principal.username" />';
	</sec:authorize>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}"
	
	$(document).ready(function(){
		getList(bno, pageNumber)
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
						str+="	<div  id='p-false"+data.list[i].rno+"'><div class='header' style='display: flex;'><div style='width : 50%;'><strong class'primary-font'>"+data.list[i].replyer+"</strong>";
						str+="		<small>("+displayTime(data.list[i].replyDate)+")</small></div>";
						str+="<div style='width:50%;' align='right'>"
						
						//내 댓글 일 경우만 수정하기, 삭제하기 버튼 활성화
						if(replyer==data.list[i].replyer){
							str += "<a href='#' onclick='replyGet("+data.list[i].rno+"); return false;'>수정하기</a>&nbsp; <a href='#' onclick='replydelete("+data.list[i].rno+");'>삭제하기</a>"
						}
						str+="</div></div>"
						str+="			<p>"+data.list[i].reply+"</p></div>";
						str+="<div id='p-input"+data.list[i].rno+"'  style='display:none;'>"
						
						//댓글 수정폼 display none
						str+="		<form name='replyModifyForm' id='replyModifyForm'>"
						str+="			<div style='padding:5px'>"
						str+="				<label>댓글수정</label><br />"
						str+="			</div>"
						str+="			<div style='padding:5px' align='right'>"
						str+="				<label>작성자</label> <input type='text' id='replyer"+data.list[i].rno+"' name='replyer' class='replyerarea'>"
						str+="			</div>"
						str+="			<textarea class='replyarea' id ='reply"+data.list[i].rno+"' rows='4' cols='42'name='reply'></textarea>"
						str+="			<div align='right'>"
						str+=" 				<button type='button' onclick='replyModify("+data.list[i].rno+")' style='margin: 5px'>등록하기</button>"
						str+="			</div>"	
						str+="		</form>"
						str+="	</div>"
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
		console.log(replyer)
		if(!replyer) {
			alert("로그인 후 이용하세요");
			return false;
		}
		
		
		 $.ajax({
	            type : 'post',
	            url : '/replies/new',
	            data: $('#replyForm').serialize(),
	            beforeSend: function(xhr){
	            	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	            },
	            success : function(data){
	            	$("#replyer").val("");
					$("#reply").val("");
					getList(bno, pageNumber);
	            }
	       	});
	}
	    
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
    				$("#replyer"+value1).val(data.replyer);
    				$("#reply"+value1).val(data.reply);
    			}
    	 });
    }
    
    //댓글 수정하기 
    function replyModify(value1){
    	var url = "/replies/"+value1;
    	
    	
    	var param = {
    		"rno" : value1,
    		"replyer" : $("#replyer"+value1).val(),
    		"reply" : $("#reply"+value1).val()    			
    	}
    	
    	$.ajax({
            type : 'put',
            url : '/replies/'+value1,
            data:JSON.stringify(param),
            beforeSend: function(xhr){
            	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            contentType : "application/json; charset=utf-8",
            success : function(data){
            	alert('수정되었습니다.!');
				getList(bno, pageNumber);
            }
       	});
    	 
    }
    
    function replydelete(value1) {
    	$.ajax({
            type : 'delete',
            url : '/replies/'+value1,
            data: value1,
            beforeSend: function(xhr){
            	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            success : function(data){
            	alert('삭제되었습니다.!');
				getList(bno, pageNumber);
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
    
</script>       