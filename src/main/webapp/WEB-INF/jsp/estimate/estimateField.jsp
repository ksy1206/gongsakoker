<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%  
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=320, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript">

function estimateWrite(){
	document.estimatefield.action = '<%=cp%>/estimate/estimateWrite.do';
	document.estimatefield.submit();
}

function call_back(){
	history.go(-1);
}

</script>
</head>
<body>
<div data-role="page" class="board_page">
	<div data-role="header" data-position="fixed" class="board_header">
		<div class="back_btn">
			<a href="#" onclick="call_back()" data-ajax="false" class="relback_btn"><img src="../img/relback.gif"/></a>
		</div>
		<h1 style="font-weight:normal; font-size:14px;">시공분야</h1>
	</div>
	
	<div data-role="content" class="est_check_content" align="center">
		<p style="margin: .5em 0; font-size: 12px; text-align: center; color:#B8B8B8;">원하시는 분야를 선택해 주세요.(복수 선택 가능)</p>
		<form method="post" id="estimatefield" name="estimatefield">
			<div style="margin-bottom:3em;">
				<fieldset data-iconpos="right">
					<c:forEach var="list" items="${fieldList}">
							<label>${list.estimate_field_name}
								<input type="checkbox" name="${list.estimate_field_code}" value="y">
							</label>
					</c:forEach>	
				</fieldset>		
			</div>
			<input type="hidden" value="${estType01_code}" name="estType01_code">
		</form>
	</div>
	
	<div data-role="footer" onclick="javascript:estimateWrite();" style="position: fixed; bottom: 0; left: 0; background: none; background-color: #29A9C8; width: 100%; z-index: 999; border: 0; padding: .3em 0;">
		<p style="margin:0; color:#fff; font-size: 14px; font-weight:normal !important; text-shadow:none !important; text-align:center; padding:.7em 0;">다음으로</p>
	</div>
</div>

</body>
</html>