<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="stylesheet" href="../css/smoothness/jquery-ui.css">
<link rel="stylesheet" href="../css/smoothness/jquery-ui-1.10.4.custom.css">
<link rel="stylesheet" href="../css/smoothness/ui.jqgrid.css">

<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script src="../js/grid/i18n/grid.locale-kr.js"></script>
<script src="../js/grid/jquery.jqGrid.min.js"></script>
<script src="../js/json2.js"></script>
<script type="text/javascript">
	/* function bizURL(){
		$.ajax({
			  type        : "POST"
			, url         : "../bizlink/reg_svr_url.do"
			, dataType    : "json"
			, timeout     : 30000      
			, contentType : "application/x-www-form-urlencoded;charset=UTF-8"
			, error       : function(request, status, error) {
			 alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
			}
			, success     : function(data) {
				alert("정상적으로 URL이 등록 되었습니다.");
			}
		});
		
	} */
	function bizVnList(){
		
		$.ajax({
			  type        : "POST"
			, url         : "../bizlink/get_vns.do"
			, dataType    : "json" 
			, timeout     : 30000      
			, contentType : "application/x-www-form-urlencoded;charset=UTF-8"
			, error       : function(request, status, error) {
			 alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
			}
			, success     : function(data) {
				alert("정상적으로 리스트 요청이 되었습니다.");
			}
		});
		
	}
</script>
</head>

<body>

	<jsp:include page="admin_header.jsp"/>
	
	<div style="width:100%; text-align:center; font-size:14px; font-family:'GodoM'; margin:0 auto; padding-top:5em;">
		<!-- <span onclick="javascript:bizURL();" style="color:#fff; margin:0 1em; padding:.5em 5em; background-color:#29A9C8; border-radius:20px; cursor:pointer;">biz(URL등록)</span> -->
		<span onclick="javascript:bizVnList();" style="color:#fff; margin:0 1em; padding:.5em 5em; background-color:#29A9C8; border-radius:20px; cursor:pointer;">가상번호 리스트 요청</span>
	</div>	
</body>
</html>