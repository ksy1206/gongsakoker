<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script>
	<link rel="stylesheet" href="css/main.css" />
</head>
<script type="text/javascript">
	$(document).ready(function(){
		$('input:checkbox[name="noView"]').click(function(){
			if($('input:checkbox[name="noView"]').prop("checked")){
				opener.set_noView('1');
			} else {
				opener.set_noView('0');
			}
		});
	});
	
	function closePage() {
		opener.chk_noView();
		
	}
</script>
<BODY onbeforeunload="closePage()">
<div onclick="window.open('https://play.google.com/store/apps/details?id=com.gonggan.koker')" style="width: 100%; background: url('../img/web/popup_banner_02.png') no-repeat; height: 100%; background-size: 100%; cursor:pointer;">
	<div style="position:fixed; top:0; right:0;">
		<span onclick="javascript:window.close();" style="font-size:2.5em; margin-right:.3em; line-height:1em; cursor:pointer;">x</span>
	</div>
	<div style="position:fixed; bottom:0; right:0;color:#fff; background-color:rgba(0, 0, 0, .6);">
		<input type="checkbox" name="noView" id="noView" style="vertical-align:middle;"><span style="font-family:'godom'; margin0 :1em 0 0;">1일간 보지 않음</span> 
	</div>
</div>
</body>
</html>