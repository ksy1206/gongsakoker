<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript">
function call_back(){
	var koker_no = $("#return_koker_no").val();
	location.href="${pageContext.request.contextPath}/kokkok20/kokkok20_details.do?koker_no="+koker_no+"&backCount=3";
}
</script>
</head>
<body>
<!-- 리뷰 더보기 페이지 -->
<div data-role="page" class="koker_page member_set_page more_menu" style="background-color:#E3E3E3 !important;">
	<div data-role="header" data-position="fixed" class="join_header">
		<div class="back_btn">
			<a href="#" data-ajax="false" class="relback_btn" onclick="call_back()"><img src="../img/relback.gif"/></a>
		</div>
		<h1>리뷰</h1>		
	</div>
	
	<div data-role="content" class="join_content" style="padding:1em !important;">
		<div class="more_btn_icon" style="background-color:#fff; border:solid #29A9C8 1px;">
			<div id="review" class="review_star">
				<c:forEach var="data" items="${reviewLists }">
					<div class="review_list">
						<p><span class='review_name'>${data.member_id }</span>${data.insert_date }</p>
						<form>
							<label for="slider-2"><p></p></label>
							<input name="slider-2" id="slider-2" type="range" min="0" max="10" value="${data.review }" step="1" data-highlight="true" disabled='disabled'>
						</form>			
						<p>${data.comment }</p>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
<%-- 	<c:set var="koker_no" value="${koker_no }" /> --%>
	<input type="hidden" value=${koker_no } id="return_koker_no" >
</div>
</body>
</html>