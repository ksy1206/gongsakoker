<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=320, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
</head>
<body>
<div data-role="page" class="board_page">
	<div data-role="header" data-position="fixed" class="board_header">
		<div class="back_btn">
			<a href="#" data-ajax="false" data-rel="back" class="relback_btn"><img src="../img/relback.gif"/></a>
		</div>
		<h1>약관보기</h1>
	</div>
	
	<div data-role="collapsible-set">		
	    <div data-role="collapsible" data-collapsible="true" class="board_list clause_list">
			<h3>
				<p style="font-size: 18px !important;">이용약관</p>				
			</h3>
				<p>
					<img src="../img/clause/terms1_n.png" width="100%"/>
				</p>				
	    </div>
	    
	     <div data-role="collapsible" data-collapsible="true" class="board_list clause_list">				
			<h3>
				<p style="font-size: 18px !important;">위치기반서비스 이용약관</p>					
			</h3>
				<p>
					<img src="../img/clause/terms2.png" width="100%"/>
				</p>			
	    </div>
	    
	     <div data-role="collapsible" data-collapsible="true" class="board_list clause_list">				
			<h3>
				<p style="font-size: 18px !important;">개인정보 취급방침</p>					
			</h3>
				<p>
					<img src="../img/clause/terms4.png" width="100%"/>
				</p>				
	    </div>
	    
	     <div data-role="collapsible" data-collapsible="true" class="board_list clause_list">				
			<h3>
				<p style="font-size: 18px !important;">제3자 제공동의</p>					
			</h3>
				<p>
					<img src="../img/clause/terms3.png" width="100%"/>
				</p>					
	    </div>		
	</div>	
</div>
</body>
</html>