<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	$(document).ready(function(){
		var count = '${count}'; 
		
		if(count <= 5){
			
			$('#display_button').css("display", "none");
			
		}else{
			
			$('#display_button').css("display", "");
			
		}
	});
	
	function list_content_plus(number1,number2){
		
		var start = $('#start').val();
		var cm_no = '${cm_no}';
		start = parseInt(start) + number1;
		$('#start').val(start);
		var str= 'start='+start+'&end='+number2 +'&cm_no='+cm_no;
		
		$.ajax({
		       type        : "POST"  
		     , async       : false 
		     , url         : "/community/communityReplyList.do"
		     , data        : str
		     , dataType    : "json" 
		     , timeout     : 30000   
		     , cache       : false     
		     , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		     , error       : function(request, status, error) {
				alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
		     }
		     , success     : function(data) {
		    	
		    	var html = "";
		    	var count = 0;
		    	
		    	if (data.communityReplyList != null) {
					
					$.each(data.communityReplyList, function(index, communityReplyList) {
						html+="<div class='ui-grid-a' style='padding: .5em 0; margin: 0 0 .3em 0; border-bottom: solid 1px #e5e5e5;'>";	
						html+="<div class='ui-block-a' style='width:15% !important;'>";
						
						if(communityReplyList.logo_name != null && communityReplyList.logo_name != '' ){
							html+= "<img src='../upload/img/"+communityReplyList.member_id+"/"+communityReplyList.logo_name+"' style='width:1.5em; vertical-align:middle; margin-right:.5em;' />";	
						}else{
							html+="<img src='../img/community/name_icon.png' style='width:1.5em; vertical-align:middle; margin-right:.5em;' >";	
						}
						
						html+="</div>";                  
						html+="<div class='ui-block-b' style='width:85% !important; padding:0 0 0 .5em;'>"	;					
						html+="<p style='margin:.3em 0; font-size:14px;'>"+communityReplyList.reply_content +"</p>";
						html+="<div class='ui-grid-a'>";
						html+="<div class='ui-block-a' style='width:90% !important;'>";
						html+="<p style='margin:.3em 0; font-size:12px;'>"+communityReplyList.koker_name+"<span style='font-size:8px; color:#888; padding-left:1em;'>"+(communityReplyList.reply_insert_date).substring(0,19)+"</span></p>";
						html+="</div>";
						html += '<div class="ui-block-b" style="width:10% !important; padding:0;">';
						if('${sessionScope.sessionData.memberInfo.getMember_no()}' == communityReplyList.member_no){
							html +=	'<div data-role="collapsible-set" data-theme="c" data-content-theme="d">'
							html +=	'<div data-role="collapsible" data-collapsible="true" class="comunity_coll comunity_coll_04">';
							html +=	'<h3>';
							html +=	'<img src="../img/community/update_insert.png" data-ajax="false" style="width:0.4em;" />';
							html +=	'</h3>';
							html +=	'<p onclick="javascript:reply_update_go('+communityReplyList.reply_no+','+communityReplyList.reply_content+');">수정</p>';
							html +=	'<p onclick="javascript:reply_delete_go('+communityReplyList.reply_no+');">삭제</p>';
							html +=	'</div>';
							html +=	'</div>';	
						}else if('${sessionScope.sessionData.memberInfo.getMember_no()}' != communityReplyList.member_no){
							html +=	'<img src="../img/community/report_icon.png" onclick="javascript:report_tag('+communityReplyList.reply_no+');" data-ajax="false" style="width:1em;" />';	
						}
						html+='</div>';
						html+="</div>";
						html+="</div>";	
						html+="</div>";						
						count++;
					});
					
					$("#community_plus").append(html).trigger("create");
				}
		    	
		    	if(count != 10){
		    		$('#display_button').css("display", "none");
				}
		    	
		     }
	    });
	
	}
	
	function community_reply_insert(){
		
		var session = $("#session_member_no").val();
		if(session == 'undefined' || session == undefined || session == 'null' || session == '' || session == null){
			$("#popupCheck").popup("open");
		}else {
			var content = $('#community_reply_content').val();
			var cm_no = $('#community_no').val()
			$('#reply_content').val(content);
			$('#cm_no').val(cm_no);
			$('#member_no').val(session);
			document.community_save.action = '/community/communityReplyInsert.do';
			document.community_save.submit();
		}
		
	}
	
	function update_go(){
		$("#popupUpdate").popup("open");
		$('#community_content').val($('#cm_content_pass').val());
	}
	
	function delete_go(){
		$("#popupDelete").popup("open");
	}
	
	function reply_update_go(reply_no,reply_content){
		$("#popupReplyUpdate").popup("open");
		$('#reply_content_update').val(reply_content);
		$('#reply_no').val(reply_no);
	}
	
	function reply_delete_go(data){
		$("#popupReplyDelete").popup("open");
		$('#reply_no').val(data);
	}
	
	function reply_update(data){
		
		var member_no = $("#session_member_no").val();
		var reply_no = $("#reply_no").val();
		var reply_content = $('#reply_content_update').val();
		var cm_no = $('#community_no').val();
		
		//reply_content=&cm_no=13&member_no=18&reply_no_update=&gubun_code=1&gubun_page=2&cm_content=헬로우
		var str = 'reply_content='+ reply_content +'&member_no=' + member_no+'&gubun_code='+data+'&gubun_page=2&reply_no='+reply_no+'&cm_no='+cm_no;
		location.href = '/community/communityUpdate.do?'+str+'';
		//document.community_save.action = '/community/communityUpdate.do?'+str+'';
		//document.community_save.submit();
	}
	
	function content_update(data){
		var cm_no = $('#community_no').val();
		//1일때 수정 2일때 삭제
		var cm_content = $('#community_content').val();
		
		$('#gubun_code').val(data);
		$('#gubun_page').val('2');
		$('#cm_no').val(cm_no);
		$('#cm_content').val(cm_content);
		$('#member_no').val($("#session_member_no").val());
		
		document.community_save.action = '/community/communityUpdate.do';
		document.community_save.submit();
	}
	
	//글 추천
	function recommend_confirm(data){
		
		var session = $("#session_member_no").val();
		if(session == 'undefined' || session == undefined || session == 'null' || session == '' || session == null){
			$("#popupCheck").popup("open");
		}else{
			
			var str = 'member_no='+session + '&cm_no='+data;
			$.ajax({
			       type        : "POST"  
			     , async       : false 
			     , url         : "/community/communityRecommend.do"
			     , data        : str
			     , dataType    : "json" 
			     , timeout     : 30000   
			     , cache       : false     
			     , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
			     , error       : function(request, status, error) {
					alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
			     }
			     , success     : function(data) {
			    	 
			    	 var recommend_count = data.recommend_count;
			    	 var recommend_confirm = data.recommend_confirm
			    	 
			    	 if(recommend_confirm == 0){
			    		 $("#popupRecommend").popup("open");
			    		 $('#recommend_text').text('추천되었습니다.');
			    		 $('#recommend_image_change').attr("src","../img/community/recommend_confirm_icon.png");
			    		 
			    	 }else if (recommend_confirm == 1){
			    		 $("#popupRecommend").popup("open");
			    		 $('#recommend_text').text('추천이 취소 되었습니다.');
			    		 $('#recommend_image_change').attr("src","../img/community/recommend_icon.png");
			    	 }
			    	 
			    	 var html = recommend_count;
			    	 $("#recommend_count").html(html).trigger("create");
			    	 
			    	
			     }
		    });
		}
		
	}
	
	//글 신고
	function report_go(){
		$('#report_grade').val('01');
		var session = $("#session_member_no").val();
		if(session == 'undefined' || session == undefined || session == 'null' || session == '' || session == null){
			$("#popupCheck").popup("open");
			return;
		}
		location.href="#sub";
		filterInit();
	}
	
	//댓글신고
	function report_tag(data){
		$('#report_grade').val('02');
		$('#reply_no').val(data);
		var session = $("#session_member_no").val();
		if(session == 'undefined' || session == undefined || session == 'null' || session == '' || session == null){
			$("#popupCheck").popup("open");
			return;
		}
		location.href="#sub";
		filterInit();
	}
	
	function filterReport(data){
		var report_text_area = $('#report_text_area').val();
		var report_category = $("input:radio[name='radio-choice-w-6']:checked").val();
		
		if(report_category==undefined){
			$("#popupClearCategory").popup("open");
			return;
		}
		
		if(report_text_area == null || report_text_area == '' || report_text_area == 'null' || report_text_area == 'undefinded'){
			$("#popupClearText").popup("open");
			return;
		}
		
		if(data==1){
			$("#popupReport").popup("open");
		}else if (data==2){
			
			var report_content = $('#report_text_area').val();
			var member_no =  $("#session_member_no").val();
			var cm_no = $('#community_no').val();
			var reply_no = $('#reply_no').val();
			var report_grade = $('#report_grade').val();
			var str = "report_content="+report_content + "&report_category="+ report_category + "&member_no="+member_no + "&cm_no="+cm_no +"&report_grade=" + report_grade+"&reply_no="+reply_no;
			
			$.ajax({
			       type        : "POST"  
			     , async       : false 
			     , url         : "/community/community_report.do"
			     , data        : str
			     , dataType    : "json" 
			     , timeout     : 30000   
			     , cache       : false     
			     , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
			     , error       : function(request, status, error) {
					alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
			     }
			     , success     : function(data) {
					$('#report_txt').text('신고되었습니다.');
					$('#report_ui_change1').css('display',"none");
					$('#report_ui_change2').css('display',"none");
					$('#report_ui_change3').css('display',"");
					$('#report_ui_change3').attr('href', '#main');
			     }
		    });
		}
	}
	
	
	
	function filterInit(){
		
		$("input:radio[name='radio-choice-w-6']:radio[value='불법 정보']").removeAttr("checked");
		$("input:radio[name='radio-choice-w-6']:radio[value='음란성 / 선정성']").removeAttr("checked");
		$("input:radio[name='radio-choice-w-6']:radio[value='욕설 / 인신공격']").removeAttr("checked");
		$("input:radio[name='radio-choice-w-6']:radio[value='같은 내용의 반복 게시 (도배)']").removeAttr("checked");
		$("input:radio[name='radio-choice-w-6']:radio[value='기타']").removeAttr("checked");
		$("input:radio[name='radio-choice-w-6']").prev().attr("class","ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-right ui-radio-off");
		
		$('#report_text_area').val('');

		$('#report_ui_change1').css('display',"");
		$('#report_ui_change2').css('display',"");
		$('#report_ui_change3').css('display',"none");
		
	}
	function call_back() {
		if('${gubun_page}' == '01') {
			location.href="<%=cp%>/community/community_main.do?start=0&end=5";
		}else if('${gubun_page}' == '02') {
			location.href="<%=cp%>/community/communityMypage.do?cm_content=&member_no=${sessionScope.sessionData.memberInfo.getMember_no()}";
		}
	}
</script>
</head>

<body>
<div data-role="page" id="main" class="koker_page" style="background-color:#e5e5e5 !important;">
	
	<form name="community_save" id="community_save" method="get">
		<input type="hidden" id="reply_content" name="reply_content">
		<input type="hidden" id="cm_no" name="cm_no">
		<input type="hidden" id="member_no" name="member_no">
		<input type="hidden" id="reply_no_update" name="reply_no_update">
		<input type="hidden" id="gubun_code" name="gubun_code">
		<input type="hidden" id="gubun_page" name="gubun_page" value="${gubun_page}">
		<input type="hidden" id="cm_content" name="cm_content">
	</form>
	
	<input type="hidden" id="init_type" name="init_type" value="불법 정보">
	<input type="hidden" id="report_grade" name="report_grade">
	<input type="hidden" id="reply_no" name="reply_no"/>
	
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="session_member_no">
	<input type="hidden" id="start" name="start" value="-5">
	
	<div data-role="header" class="search_header">		
		<div class="back_btn">
			<c:if test="${gubun_page == '01' }">
				<a href="#" data-ajax="false" onclick="call_back()" class="relback_btn"><img src="../img/search/back_icon.gif"/></a>
			</c:if>
			<c:if test="${gubun_page == '02' }">
				<a href="<%=cp%>/community/communityMypage.do?cm_content=&member_no=${sessionScope.sessionData.memberInfo.getMember_no()}" data-ajax="false" onclick="call_back()" class="relback_btn"><img src="../img/search/back_icon.gif"/></a>
			</c:if>
		</div>
		<h1 style="font-size: 16px !important;">커뮤니티</h1>
		<div class="ui-btn-right" style="padding-top:.1em;">
			<a href="<%=cp%>/appMain/appMain.do" id="reset" data-ajax="false"><img src="../img/header/home.png" style="width:2.5em;" /></a>
		</div>
	</div>
		
	<div data-role="content" class="list_content" style="padding:.3em !important; background-color:#e5e5e5;">
		<!-- 글 상세  -->
		<div style="background-color:#fff; padding:.3em; margin-bottom:3em;">
			<c:forEach items="${communityList}" var="community" varStatus="count">
				<!-- 글 번호 히든 -->
				<input type="hidden" value="${community.cm_no}" id="community_no" name="community_no">
				
				<div class="ui-grid-b" style="border:solid 1px #e5e5e5; padding:.3em;">
					<div class="ui-block-a" style="width:15% !important;">
						<c:if test="${community.logo_name != null && community.logo_name != '' }">
							<img src="../upload/img/${community.member_id}/${community.logo_name}" style="width:2.5em; vertical-align:middle; padding:.3em;" />
						</c:if>
						<c:if test="${community.logo_name == null || community.logo_name == '' }">
							<img src="<%=cp %>/img/community/name_icon.png" style="width:2.5em; vertical-align:middle; padding:.3em;" />
						</c:if>
					</div>
					<div class="ui-block-b" style="width:70% !important; padding: .5em 0;">
						<p style="margin:0; font-size:14px;">${community.koker_name}</p>   
						<p style="margin:0; font-size:11px;">${(community.cm_insert_date).substring(0,19)}</p>
					</div>
					<div class="ui-block-c" style="width:15% !important;">
						<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == community.member_no}">
							<div data-role="collapsible-set" data-theme="c" data-content-theme="d">
								<div data-role="collapsible" data-collapsible="true" class="comunity_coll comunity_coll_02">
									<h3>
										<img src="<%=cp%>/img/community/update_insert.png" style="width:.4em; vertical-align: middle; padding:.5em;" />
									</h3>
									<p onclick="javascript:update_go();">수정</p>
									<p onclick="javascript:delete_go();">삭제</p>
								</div>
							</div>
						</c:if>
						<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() != community.member_no}">
							<img src="<%=cp%>/img/community/report_icon.png" onclick="javascript:report_go();" style="width:1em; vertical-align:bottom; float:right; padding-right:.5em;" />
						</c:if>
					</div>
					
					<p style="margin:0; margin-top: 4em">
						<input type="hidden" id="cm_content_pass" name="cm_content_pass" value="${community.cm_content}" readonly="readonly">
						${community.cm_content}
					</p>
				</div>
				
				<p style="font-size:14px; border-top:solid 1px #e5e5e5; border-bottom:solid 1px #e5e5e5; padding:.5em 0; margin:.5em 0;">
					<c:if test="${member_recommend_count==0}">
						<img src="<%=cp %>/img/community/recommend_icon.png" onclick="javascript:recommend_confirm('${community.cm_no}');" style="width: 2em; vertical-align: bottom; margin-right:.3em;" id="recommend_image_change" />
						<span id="recommend_count">${community.recommend_count}</span>명이 추천합니다.
					</c:if>
					<!-- 회원이 추천했을경우  -->
					<c:if test="${member_recommend_count==1 }">
						<img src="<%=cp %>/img/community/recommend_confirm_icon.png" onclick="javascript:recommend_confirm('${community.cm_no}');" style="width: 2em; vertical-align: bottom; margin-right:.3em;" id="recommend_image_change" />
						<span id="recommend_count">${community.recommend_count}</span>명이 추천합니다.
					</c:if>
					<c:if test="${member_recommend_count==2 }">
						<img src="<%=cp %>/img/community/recommend_icon.png" onclick="javascript:recommend_confirm('${community.cm_no}');" style="width: 2em; vertical-align: bottom; margin-right:.3em;" id="recommend_image_change" />
						<span id="recommend_count">${community.recommend_count}</span>명이 추천합니다.
					</c:if>
				</p>
			</c:forEach>
		
			<!-- 댓글 리스트 -->
			<c:forEach items="${replyList}" var="reply" varStatus="count">
				<div style="position:relative;">
					<div class="ui-grid-a" style="padding: .5em 0; margin: 0 0 .3em 0; border-bottom: solid 1px #e5e5e5;">
						<div class="ui-block-a" style="width:15% !important;">
							
							<c:if test="${reply.logo_name != null && reply.logo_name != '' }">
								<img src="../upload/img/${reply.member_id}/${reply.logo_name}" style="width:1.5em; vertical-align:middle; margin-right:.5em;" />
							</c:if>
							<c:if test="${reply.logo_name == null || reply.logo_name == '' }">
								<img src="<%=cp %>/img/community/name_icon.png" style="width:1.5em; vertical-align:middle; margin-right:.5em;" />
							</c:if>
						</div>
						<div class="ui-block-b" style="width:85% !important; padding:0 0 0 .5em;">
							<p style="margin:.3em 0; font-size:14px;">
								${reply.reply_content}
							</p>
							<div class="ui-grid-a">
								<div class="ui-block-a" style="width:90% !important;">
									<p style="margin:.3em 0; font-size:12px;">
										${reply.koker_name}
										<span style=" font-size:8px; color:#888; padding-left:1em;">${(reply.reply_insert_date).substring(0,19)}</span>
									</p>
								</div>
								<div class="ui-block-b" style="width:10% !important; padding:0;">
									<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == reply.member_no}">
										<div data-role="collapsible-set" data-theme="c" data-content-theme="d">
											<div data-role="collapsible" data-collapsible="true" class="comunity_coll comunity_coll_04">
												<h3>
													<img src="<%=cp%>/img/community/update_insert.png" data-ajax="false" style="width:0.4em;" />
												</h3>
												<p onclick="javascript:reply_update_go('${reply.reply_no}','${reply.reply_content }');">수정</p>
												<p onclick="javascript:reply_delete_go('${reply.reply_no}');">삭제</p>
											</div>
										</div>
									</c:if>
									<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() != reply.member_no}">
										<img src="<%=cp %>/img/community/report_icon.png" onclick="javascript:report_tag('${reply.reply_no}');" data-ajax="false" style="width:1em;" />
									</c:if>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
			
			<!-- 더보기 뿌려주는곳 -->
			<div id="community_plus"  style="position:relative;">
			
			</div>
			
			<!-- 더보기 버튼 -->
			<div id="display_button">
				<p style="margin:1em 0 .5em 0; font-size:14px; text-align:center;" onclick ="javascript:list_content_plus(10,10);"><span style="padding-right:.3em;">∨</span>더보기</p>
			</div>
		</div>
	
	</div>

	<div data-role="footer" data-position="fixed" style="padding:.5em; background-color:#fff; boder:none !important;">
		<div class="ui-grid-b">
			<div class="ui-block-a" style="width:12% !important;">
				<img src="<%=cp %>/img/community/name_icon.png" style="width:2em; vertical-align:bottom;" />
			</div>
			<div class="ui-block-b" style="width:65% !important;">
				<input type="text" id="community_reply_content" name="community_reply_content" placeholder="댓글을 남겨주세요." style="background-color:#e5e5e5; color:#000; text-shadow:none; font-weight:normal;">
			</div>
			<div class="ui-block-c" style="width:20% !important; padding:0 0 0 .3em;">
				<p onclick="javascript:community_reply_insert();" style="font-weight:normal; text-shadow:none; font-size:14px; margin:0; text-align:center; color:#fff; background-color:#29A9C8; padding:.5em 0;">등록</p>
			</div>
		</div>
	</div>
	
	<!-- 팝업 -->
	<div id="popupCheck" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<p>로그인이 필요한 서비스입니다.</p>
	      	<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>   
	  	</div>    
	</div>
	
	<div id="popupUpdate" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
    		<p><input type="text" id="community_content" name="community_content"></p>
      	  	<a style="background-color:#29A9C8; margin-right:.5em;" href="#" data-ajax="false" onclick="javascript:content_update(1);">수정</a>   
      	  	<a style="background-color:#d7d7d7;" href="#" data-rel="back" data-ajax="false">취소</a>
  	  	</div>
	</div>
	
	<div id="popupDelete" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
			<p id="dialog_txt">정말 삭제하시겠습니까?</p>	  
      	  	<a style="background-color:#29A9C8; margin-right:.5em;" href="#" data-ajax="false" onclick="javascript:content_update(2);">삭제</a>   
      	  	<a style="background-color:#d7d7d7;" href="#"  data-rel="back" data-ajax="false">취소</a>
  	  	</div>
	</div>
	
	<div id="popupReplyUpdate" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
    		<p><input type="text" id="reply_content_update" name="reply_content_update"></p>
      	  	<a style="background-color:#29A9C8; margin-right:.5em;" href="#" data-ajax="false" onclick="javascript:reply_update(3);">수정</a>   
      	  	<a style="background-color:#d7d7d7;" href="#" data-rel="back" data-ajax="false">취소</a>
  	  	</div>
	</div>
	
	<div id="popupReplyDelete" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
    		<p id="dialog_txt">정말 삭제하시겠습니까?</p>
      	  	<a style="background-color:#29A9C8; margin-right:.5em;" href="#" data-ajax="false" onclick="javascript:reply_update(4);">삭제</a>   
      	  	<a style="background-color:#d7d7d7;" href="#" data-rel="back" data-ajax="false">취소</a>
  	  	</div>
	</div>
	
	<div id="popupRecommend" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<p id="recommend_text"></p>
	      	<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>   
	  	</div>    
	</div>
	
	<!-- 팝업 -->
	
</div>

<div data-role="page" id="sub" class="koker_page" style="background-color:#e5e5e5 !important;">

	<div data-role="header" class="search_header">		
		<div class="back_btn">
			<a href="#main" data-ajax="false" class="relback_btn"><img src="../img/search/back_icon.gif" onclick="javascript" /></a>
		</div>
		<h1 style="font-size: 16px !important;">신고 하기</h1>
	</div>
	
	<div data-role="content" class="singo_cont" style="padding:0 1em 1em 1em; background:#e9e9e9;">
		<p style="text-shadow: none; font-weight: normal; color:#444;">신고사유</p>
		<div style="border:solid #29A9C8 1px; padding:1em; background-color:#fff;">
			<fieldset data-role="controlgroup" data-iconpos="right" class="radio_set2">
		        <input type="radio" name="radio-choice-w-6" id="radio-choice-w-6a" value="불법 정보">
		        <label for="radio-choice-w-6a" style="border-bottom:solid 1px #e5e5e5 !important;">불법 정보</label>
		        
		        <input type="radio" name="radio-choice-w-6" id="radio-choice-w-6b" value="음란성 / 선정성">
		        <label for="radio-choice-w-6b" style="border-bottom:solid 1px #e5e5e5 !important;">음란성 / 선정성</label>
		        
		        <input type="radio" name="radio-choice-w-6" id="radio-choice-w-6c" value="욕설 / 인신공격">
		        <label for="radio-choice-w-6c" style="border-bottom:solid 1px #e5e5e5 !important;">욕설 / 인신공격</label>
		        
		        <input type="radio" name="radio-choice-w-6" id="radio-choice-w-6d" value="같은 내용의 반복 게시 (도배)">
		        <label for="radio-choice-w-6d" style="border-bottom:solid 1px #e5e5e5 !important;">같은 내용의 반복 게시 (도배)</label>
		        
		        <input type="radio" name="radio-choice-w-6" id="radio-choice-w-6e" value="기타">
		        <label for="radio-choice-w-6e" style="border-bottom:solid 1px #e5e5e5 !important;">기타</label>
		        <textarea id="report_text_area" placeholder="내용을 입력해 주세요." style="margin-top:.5em; resize:none; font-size: 14px; font-weight: normal; text-shadow: none !important; padding-left:1em;" data-ajax="false"></textarea>
		    </fieldset>
		</div>
	</div>
	
	<div data-role="footer" data-position="fixed" style="text-align: center; margin:0; border:none;" >
		<div class="ui-grid-a">
			<div class="ui-block-a" style="padding:1em .5em 1em 1em;">
				<p style="margin:0; padding:.5em 1em; background-color:#666; text-align: center; color:#fff; text-shadow:none !important; font-size:18px; font-weight:normal !important; cursor:pointer;" onclick="javascript:filterInit();" >리셋</p>
			</div>
			<div class="ui-block-b" style="padding:1em 1em 1em .5em;">
				<p style="margin:0; padding:.5em 1em; background-color:#29A9C8; text-align: center; color:#fff; text-shadow:none !important; font-size:18px; font-weight:normal !important; cusor:pointer;" onclick="javascript:filterReport('1');" >신고</p>
			</div>
		</div>
	</div>
	
	<!-- 팝업 -->
	
	<div id="popupReport" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
			<p id="report_txt">신고하시겠습니까?</p>	  
      	  	<a id="report_ui_change1" style="background-color:#29A9C8; margin-right:.5em;" href="#" data-ajax="false" onclick="javascript:filterReport('2');">신고</a>   
      	  	<a id="report_ui_change2" style="background-color:#d7d7d7;" href="#"  data-rel="back" data-ajax="false">취소</a>
      	  	<a id="report_ui_change3" style="display:none; background-color:#29A9C8;" href="#" data-ajax="false">확인</a>
  	  	</div>
	</div>
	
	<div id="popupClearText" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<p id="recommend_text">신고 내용이 입력되지 않았습니다.</p>
	      	<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>
	  	</div>    
	</div>
	
	<div id="popupClearCategory" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<p id="recommend_text">신고 종류를 선택해주세요.</p>
	      	<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>
	  	</div>    
	</div>
	
	<!-- 팝업 -->
</div>

	
</body>
</html>