<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- DataTables JavaScript -->
    <script src="/resources/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="/resources/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="/resources/vendor/datatables-responsive/dataTables.responsive.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="/resources/dist/js/sb-admin-2.js"></script>

    <!-- Page-Level Demo Scripts - Tables - Use for reference -->
    <script>
    $(document).ready(function() {
    	$("#mod-button").on("click", function(){
			$("input:hidden[name=_method]").val("put");
			modForm.action = "/board/modify/"+$("input:hidden[name=no]").val();
			modForm.submit();
		});
    	$("#list-button").on("click", function(){
			location.href="/board"
		});
    	$("#go-mod-button").on("click", function(){
			location.href="/board/modify/"+$("input:hidden[name=no]").val();
		});
    	$("#delete-button").on("click", function(){
    		alert('삭제합니다.');
			$("input:hidden[name=_method]").val("delete");
			Frm.action = "/board/"+$("input:hidden[name=no]").val();
			Frm.submit();
		});
    	$("#write-button").on("click", function(){
			alert('입력합니다');
    		Frm.action = "/board/write"
			Frm.submit();
		});
    	$("#go-write-button").on("click", function(){
			location.href="/board/write";
		});
       
    });
    
    
    </script>

</body>

</html>
