<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>


<div id="readPage">
	<div style="">
		<h3>수정하기</h3>
	</div>
		<br>
	<div style="">
		<form name="modifyForm" method="get" >
			<input type="hidden" id="method" name="_method"/>
			<input class="form-control" type="hidden" name="gno" value='<c:out value="${dto.gno}" />'>
			<!-- 스프링 시큐리티를 위한 csrf토큰 -->
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<!-- 페이징 처리와 검색결과를 유지하기 위한 -->
			<input type="hidden" name='pageNumber' value = '<c:out value="${cri.pageNumber}" />'>
   			<input type="hidden" name='amount' value = '<c:out value="${cri.amount}" />'>
   			<input type="hidden" name='type' value='<c:out value="${cri.type}" />' />
   			<input type="hidden" name='keyword' value='<c:out value="${cri.keyword}" />' />
			<!-- 파일 이름 -->
			<input type="hidden" name="uploadPath" id="uploadPath" value="${dto.uploadPath}">
			<input type="hidden" name="uuid" id="uuid" value="${dto.uuid}">
			<input type="hidden" name="fileName" id="fileName" value="${dto.fileName}">
			<div class="form-group">
				<label>제목</label> 
				<input class="form-control" name="title" id="title" value='<c:out value="${dto.title }" />'>
			</div>
			<div class="form-group">
			    <label>작성자</label> 
			    <input class="form-control" name="writer"   value='<c:out value="${dto.writer }" />' readonly >
			</div>	
			<div class="form-group">
			    <label>코멘트</label> 
			    <input class="form-control" name="comments" id="comments"  value='<c:out value="${dto.comments }" />'>
			</div>	
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
							<div class="panel-heading">사진<b>(반드시 기존 사진을 삭제후 추가)</b></div>
							<div class="panel-body">
								<div class="deleteFile">
									<img src="${dto.totalUri}" style="width:30px; height:30px;"> <c:out value="${dto.fileName }" />
									<a href="#" onclick="deleteFile()"> [x] </a>
								</div>
								<div class="form-group">
								    <input type="file" name="uploadFile"> 
								</div>
							</div>
					</div>
				</div>
			</div>
				<button type="button" onclick="goList()">리스트</button>
				<sec:authentication property="principal" var="pinfo"/>
				<sec:authorize access="isAuthenticated()">
                       <c:if test="${pinfo.username eq dto.writer}">				
                         	<button type="button" onclick="goModify('${dto.gno}')">수정하기</button>
							<button type="button" onclick="goDelete('${dto.gno}')">삭제하기</button>				
                       	</c:if>	
               </sec:authorize>
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
	modifyForm.method = "get" 
	$("input:hidden[name=_method]").remove();
	$("input:hidden[name=gno]").remove();
	$("input:hidden[name=${_csrf.parameterName}]").remove();
	$("input:hidden[name=uploadPath]").remove();
	$("input:hidden[name=uuid]").remove();
	$("input:hidden[name=fileName]").remove();
	$("input:text[name=title]").remove();
	$("input:text[name=comments]").remove();
	$("input:text[name=writer]").remove();
	modifyForm.action = contextPath +  "/gallery";
	modifyForm.submit();
}

function goModify(value1) {
	
	var title = $("#title").val();
	var comments = $("#comments").val();
	
	if(!title) {
		alert('제목을 입력 해주세요.');
		return;
	}
	
	if(title.length >= 500) {
		alert('제목은 최대 500자 까지만 가능합니다.');
		return;
	}
	
	if(!comments) {
		alert('코멘트를 입력해 주세요.');
		return;
	}
	
	if(comments.length >= 500) {
		alert('제목은 최대 500자 까지만 가능합니다.');
		return;
	}
	
	if(uploadPath == "") {
		alert('사진을 업로드해 주세요!!');
		return;
	}
	
	modifyForm.method = "post" 
	$("input:hidden[name=_method]").val("put");
	modifyForm.action = contextPath +  "/gallery/"+value1
	modifyForm.submit();
}

function goDelete(value1) {
	if(confirm('정말 삭제하시겠습니까?')) {
		modifyForm.method = "post" 
		$("input:hidden[name=_method]").val("delete");
		modifyForm.action = contextPath +  "/gallery/"+value1;
		modifyForm.submit();
	}
}

var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
var maxSize = 5242880;
//빈 업로드 객체를 복사해둠 
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}"
var uploadPath = $("#uploadPath").val()

function checkExtension(fileName, fileSize){
	if(fileSize >= maxSize){
		alert("파일 사이즈 초과");
		return false;
	}
	
	if(regex.test(fileName)){
		alert("해당 종류의 파일은 업로드 할 수 없습니다.");
		return false;
	}	
	return true;
}//end checkExtension, 파일 사이즈와 이미지 타입인지를 체크함

$("input[type='file']").change(function(e){
	var formData = new FormData();
	var inputFile = $("input[name='uploadFile']");
	var files = inputFile[0].files;
	
	
	for (var i = 0; i < files.length; i++) {
		
		var typeIndex = files[i].type.lastIndexOf('/');
		
		if(files[i].type.substring(0, typeIndex) !== 'image') {
			alert('이미지 타입의 파일만 업로드가 가능합니다');
			return false;
		}
		
		formData.append("uploadFile", files[i]);
	} 

	$.ajax({
		url: contextPath +  '/uploadAjax',
		processData: false,
		contentType: false,
		data: formData,
		dataType: 'json',
		type: 'POST',
		beforeSend: function(xhr){
        	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        },
		success: function(result) {
			$("#uploadPath").val(result.uploadPath);
			$("#uuid").val(result.uuid);
			$("#fileName").val(result.fileName);
		},error : function(xhr, status, error){
			alert('error'+error );
		}
	});	//end ajax
});//end function


function deleteFile() {
	var fileName = $("#fileName").val();
	var uuid = $("#uuid").val();
	var uploadPath = $("#uploadPath").val();
	var param = {
    		"fileName" : fileName,
    		"uuid" : uuid,
    		"uploadPath" :uploadPath    			
    	}
	
	$.ajax({
		type: 'POST',
		url: contextPath +  '/deleteAjax',
		data: {fileName: fileName, uuid: uuid, uploadPath:uploadPath},
		dataType: 'text',
		beforeSend: function(xhr){
        	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        },
		success: function(result) {
			$("#uploadPath").val("");
			$("#uuid").val("");
			$("#fileName").val("");
			$(".deleteFile").hide();
		}
	});
}

</script>