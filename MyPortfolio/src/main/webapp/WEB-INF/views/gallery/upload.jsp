<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<div>
	<div style="">
		<h3>등록하기</h3>
	</div>
	<div style="">
		<form name="writeForm" method="post" >
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="uploadPath" id="uploadPath">
			<input type="hidden" name="uuid" id="uuid">
			<input type="hidden" name="fileName" id="fileName">
			<div class="form-group">
				<label>제목</label>  
				<input class="form-control" name="title" id="title" >
			</div>
			<div class="form-group">
			    <label>작성자</label> 
			    <input class="form-control" name="writer" id="writer" value='<sec:authentication property="principal.username"/>' readonly>
			</div>
			<div class="form-group">
			    <label>짧은 코멘트</label> 
			    <input class="form-control" name="comments" id="comments">
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
							<div class="panel-heading">사진</div>
							<div class="panel-body">
								<div class="form-group">
								    <input type="file" name="uploadFile"> 
								</div>
							</div>
					</div>
				</div>
			</div>
			
						
				<button type="button" onclick="upload()">저장</button>
		</form>	
	</div>
</div>		

<script>

function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

var contextPath = getContextPath();
var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
var maxSize = 5242880;
//빈 업로드 객체를 복사해둠 
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}"

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
		url:  contextPath + '/uploadAjax',
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

function upload() {
	
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
	
	
	var uploadPath = $("#uploadPath").val()
	if(uploadPath == "") {
		alert('사진을 업로드해 주세요!!');
		return;
	}
	
	writeForm.action = contextPath +  "/gallery/new"
	writeForm.submit();
}
</script>