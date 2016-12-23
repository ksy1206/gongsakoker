<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="css/koker_mobile.css">
  <link rel="stylesheet" href="css/jquery.mobile-1.4.5.min.css">
  <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
  <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
	<script type="text/javascript">
		alert('1111');
	</script>
</head>
<body style="#fff;">

<div data-role="page" id="list">
<div data-role="panel" id="myPanel" data-display="overlay"> 
	<div data-role="header">
		<a href="#pageone" data-rel="close" class="ui-btn ui-btn-inline ui-shadow ui-corner-all ui-btn-a ui-icon-delete ui-btn-icon-left">Close panel</a>
		<h2>Panel Header</h2>
		<a href="#" class="ui-btn ui-corner-all ui-shadow ui-icon-home">Home</a>
	</div>
</div>

	<div data-role="header" class="list_header">
		<a href="#myPanel" class="ui-btn ui-corner-all"><img src="img/header/list_my_menu.gif" class="header_icon list_color" style="width: 2.6em;"/></a>
		<h3 class="my_area">지역게시판</h3>
		<div class="ui-btn-right">
			<a href="#" class="ui-btn ui-corner-all"><img src="img/header/my_menu_ms.gif" class="header_icon list_color" style="width:2.7em; padding:0.3em 1em 0 0 !important;"/></a>
			<a href="#" class="ui-btn ui-corner-all"><img src="img/header/my_menu_map.gif" class="header_icon list_color" style="width: 2em; padding:0.3em 0.5em 0 0 !important;"/></a>
		</div>
	</div>
	
	<div data-role="main">
		
	</div>
</div>  
</body>
</html>

