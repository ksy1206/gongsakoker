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
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
	<link rel="stylesheet" href="../css/swiper.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
	<script src="../js/swiper.min.js"></script>

<script type="text/javascript">
	function community_detail(data){
		
		$('#cm_no').val(data);
		$('#gubun_page').val('02');
		document.community_save.action = '/community/communityDetail.do';
		document.community_save.submit();
		
	}
	
	function update_go(data1,data2){
		$("#popupUpdate").popup("open");
		$('#community_content').val(data1);
		$('#community_no').val(data2);
	}
	
	function delete_go(data){
		$("#popupDelete").popup("open");
		$('#community_no').val(data);
	}
	
	function content_update(data){
		var cm_no = $('#community_no').val();
		//1일때 수정 2일때 삭제
		var cm_content = $('#community_content').val();
		
		$('#gubun_code').val(data);
		$('#gubun_page').val('02');
		$('#cm_no').val(cm_no);
		$('#cm_content').val(cm_content);
		
		document.community_save.action = '/community/communityUpdate.do';
		document.community_save.submit();
	}
	function call_back() {
		location.href = "<%=cp%>/community/community_main.do?start=0&end=5";
	}
</script>
</head>

<body style="background-color: #fff !important;">
<div data-role="page" class="koker_page" style="background-color:#fff !important;">
		
		<input type="hidden" id="community_no" name="community_no">
		
	<form name="community_save" id="community_save" method="get">
		<input type="hidden" id="begin" name="begin" value="0">
		<input type="hidden" id="end" name="end" value="5">
		<input type="hidden" id="cm_no" name="cm_no">
		<input type="hidden" id="member_no" name="member_no" value="${sessionScope.sessionData.memberInfo.getMember_no()}">
		<input type="hidden" id="gubun_code" name="gubun_code">
		<input type="hidden" id="gubun_page" name="gubun_page">
		<input type="hidden" id="cm_content" name="cm_content">
	</form>
	
	<div data-role="header" class="search_header">		
		<div class="back_btn">
			<a href="<%=cp%>/community/community_main.do?start=0&end=5" data-ajax="false" onclick="call_back()" class="relback_btn"><img src="../img/search/back_icon.gif"/></a>
		</div>
		<h1>커뮤니티</h1>
		<div class="ui-btn-right" style="padding-top:.1em;">
			<a href="<%=cp%>/appMain/appMain.do" id="reset" data-ajax="false"><img src="../img/header/home.png" style="width:2.5em;" /></a>
		</div>
	</div>
	
	<div data-role="content" class="list_content" style="width: 100%;">
	    
		<div style="padding:.3em; margin-bottom:3em;">
			
			<c:if test="${fn:length(myPageList) == 0}">
				<div style='padding-top:2em; text-align:center;'>
		    		<img src='<%=cp%>/img/board/no_search.gif' style='width:40%;'/>
		    		<p style='text-shadow:none; font-weight:normal !important; color:#666; font-size:14px; margin:0;'>쓴 글이 없습니다.</p>
	    		</div>
			</c:if>
			
			<c:forEach items="${myPageList}" var="myPage">
				
				<div style="border:solid 1px #e5e5e5; margin-bottom:.3em; padding:.5em; position:relative;">
					<div class="ui-grid-b" style="border-bottom:solid 1px #e5e5e5; padding-bottom:.3em;">
						<div class="ui-block-a" style="width:50% !important;" onclick="javascript:community_detail('${myPage.cm_no}');">
							<p style="margin:0; font-size:11px;">
								<c:if test="${myPage.logo_name != null && myPage.logo_name != '' }">
									<img src="../upload/img/${myPage.member_id}/${myPage.logo_name}" style="width:1.5em; vertical-align:middle; margin-right:.5em;" />${myPage.koker_name}
								</c:if>
								<c:if test="${myPage.logo_name == null || myPage.logo_name == '' }">
									<img src="<%=cp %>/img/community/name_icon.png" style="width:1.5em; vertical-align:middle; margin-right:.5em;" />${myPage.koker_name}
								</c:if>
							</p>
						</div>
						<div class="ui-block-b" style="width:46% !important; padding:0;">
							<p style="margin:0; font-size:11px; float:right; line-height: 18px;">
								${myPage.cm_insert_date}
							</p>
						</div>
						<div data-role="collapsible-set" data-theme="c" data-content-theme="d" class="ui-block-c" style="width:4% !important;">
							<div data-role="collapsible" data-collapsible="true" class="comunity_coll">
								<h3>
									<img src="<%=cp%>/img/community/update_insert.png" style="width:.3em; vertical-align: top;" />
								</h3>
								<p onclick="javascript:update_go('${myPage.cm_content}','${myPage.cm_no}');">수정</p>
								<p onclick="javascript:delete_go('${myPage.cm_no}');">삭제</p>
							</div>
						</div>
					</div>
					<p style="font-size:14px;" onclick="javascript:community_detail('${myPage.cm_no}');">${myPage.cm_content}</p>
					<p style="text-align:right; font-size:14px; margin:0;" onclick="javascript:community_detail('${myPage.cm_no}');">
						<img src="<%=cp %>/img/community/recommend_icon.png" style="width:1.5em; vertical-align:bottom; margin-right:.5em;">${myPage.recommend_count} 
						<img src="<%=cp %>/img/community/reply_icon.png" style="width:1.5em; vertical-align:bottom; margin:0 .5em;">${myPage.reply_count}
					</p>
				</div>
			</c:forEach>
		</div>
		
	</div>	
	
	<div id="popupCheck" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<p>로그인이 필요한 서비스입니다.</p>
	      	<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>
	  	</div>    
	</div>
	
	<div id="popupUpdate" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
    		<p style="border:solid 1px #888; margin:.5em 0 1.5em 0 !important;"><input type="text" id="community_content" name="community_content"></p>
      	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-ajax="false" onclick="javascript:content_update(1);">수정</a>   
      	  	<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">취소</a>
  	  	</div>
	</div>
	
	<div id="popupDelete" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
			<p id="dialog_txt">정말 삭제하시겠습니까?</p>	  
      	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-ajax="false" onclick="javascript:content_update(2);">삭제</a>   
      	  	<a style="background-color:#29A9C8;" href="#"  data-rel="back" data-ajax="false">취소</a>
  	  	</div>
	</div>
	
</div>

	
</body>
</html>