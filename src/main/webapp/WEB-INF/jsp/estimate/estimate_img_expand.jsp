<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%  
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=5.0, minimum-scale=1.0, user-scalable=yes">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript">
function call_back(){
	history.go(-1);
	
}
</script>
</head>
<body>
<div data-role="page" class="board_page area_board_page" id="mainPage" style="background-color:#000 !important;">
	<div data-role="content" style="padding:0;">
        <div class="img_vertical">
			<p style="margin:0; text-align:right; padding:0 .3em; width: 100%; position: absolute; top: 0; right: 0;">
				<a href="#" onclick="call_back()" data-ajax="false" style="font-size:36px; float:right; color:#666; text-decoration:none;">×</a>
			</p>
			<c:if test="${img01 != null && img01 != ''}">
				<c:if test="${img02 == null || img02 == ''}">
					<c:if test="${img03 == null || img03 == ''}">
						<div class="swiper-slide"><img src="../upload/img_estimate/${member_no}/${img01}" width="100%" id="cm" class="hc vc"/></div>
					</c:if>
					<c:if test="${img03 != null && img03 != ''}">
						<div class="swiper-slide"><img src="../upload/img_estimate/${member_no}/${img01}" width="100%" id="cm" class="hc vc"/></div>
						<div class="swiper-slide"><img src="../upload/img_estimate/${member_no}/${img03}" width="100%" id="cm" class="hc vc"/></div>
					</c:if>
				</c:if>
				<c:if test="${img03 == null || img03 == ''}">
					<c:if test="${img02 != null && img02 != ''}">
						<div class="swiper-slide"><img src="../upload/img_estimate/${member_no}/${img01}" width="100%" id="cm" class="hc vc"/></div>
						<div class="swiper-slide"><img src="../upload/img_estimate/${member_no}/${img02}" width="100%" id="cm" class="hc vc"/></div>
					</c:if>
				</c:if>
				<c:if test="${img03 != null && img03 != ''}">
					<c:if test="${img02 != null && img02 != ''}">
						<div class="swiper-slide"><img src="../upload/img_estimate/${member_no}/${img01}" width="100%" id="cm" class="hc vc"/></div>
						<div class="swiper-slide"><img src="../upload/img_estimate/${member_no}/${img02}" width="100%" id="cm" class="hc vc"/></div>
						<div class="swiper-slide"><img src="../upload/img_estimate/${member_no}/${img03}" width="100%" id="cm" class="hc vc"/></div>
					</c:if>
				</c:if>
			</c:if>
			
			<c:if test="${img01 == null || img01 == ''}">
				<c:if test="${img02 != null && img02 != ''}">
					<c:if test="${img03 == null || img03 == ''}">
						<div class="swiper-slide"><img src="../upload/img_estimate/${member_no}/${img02}" width="100%" id="cm" class="hc vc"/></div>
					</c:if>
					<c:if test="${img03 != null && img03 != ''}">
						<div class="swiper-slide"><img src="../upload/img_estimate/${member_no}/${img02}" width="100%" id="cm" class="hc vc"/></div>
						<div class="swiper-slide"><img src="../upload/img_estimate/${member_no}/${img03}" width="100%" id="cm" class="hc vc"/></div>
					</c:if>
				</c:if>
				<c:if test="${img02 == null || img02 == ''}">
					<c:if test="${img03 != null && img03 != ''}">
						<div class="swiper-slide"><img src="../upload/img_estimate/${member_no}/${img03}" width="100%" id="cm" class="hc vc"/></div>
					</c:if>
				</c:if>
			</c:if>
        </div>
	</div>
</div>
</body>
</html>