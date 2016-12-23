<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Map" %>
<%@page import="gongsakoker.vo.MemberVO"%>
<%
	String cp = request.getContextPath();	

    Map sessionData = null;
  
    boolean isSession = true;
    MemberVO memberVO = null;
    String member_no=null;
    String push_yn="";
    String class_code="";
    String member_id = "";
    String member_code="";
    String name = "";
    String hp01="";
    String hp02="";
    String hp03="";
    
	String app_version = "";//현재앱버전
	String current_version = "1.0";//현재서버버전
	String str_version = "";//출력될버전정보

	//app_version = request.getParameter("app_version");
	//app_version = session.getAttribute("androidData").toString();
	if (app_version.equals(current_version)) {
		str_version = "최신버전입니다.";
	} else {
		str_version = "최신버전이아닙니다.";
	}
	
    if (session.getAttribute("sessionData") != null) {
        sessionData = (Map)session.getAttribute("sessionData");
        memberVO = (MemberVO)sessionData.get("memberInfo");
        member_no = memberVO.getMember_no();
        push_yn = memberVO.getPush_yn();
    	class_code = memberVO.getClass_code();
    	member_id =  memberVO.getMember_id();
   	  	member_code= memberVO.getMember_code();
    	name = memberVO.getName();
   	 	hp01= memberVO.getHp01();
   	  	hp02= memberVO.getHp02();
    	hp03= memberVO.getHp03();
    } else {
        isSession = false;
        session.removeAttribute("sessionData");
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/like/like.js"></script>
<script type="text/javascript" src="<%=cp %>/js//koker_public.js"></script>
<script type="text/javascript">

	var chk_sms = '1';
	var all_click = '1';
	
	function check_control() {
		$('input:checkbox[name="all_chk"]').prop("checked",false);
		$('input:checkbox[name="sms_chk"]').prop("checked",false);
		
		if (chk_sms == '1') {
			$("[name='sms_hidden']").css("display", "");
			$("#all_chk_div").css("display", "");
			
			chk_sms = '2';
		} else {
			$("[name='sms_hidden']").css("display", "none");
			$("#all_chk_div").css("display", "none");
			
			chk_sms = '1';
		}
	}
	
	$(document).ready(function(){
		$('input:checkbox[name="all_chk"]').click(function(){
			$("[name='all_click']").trigger("click");
			if($('input:checkbox[name="all_chk"]').prop("checked")){
				$('input:checkbox[name="sms_chk"]').prop("checked",true);
			} else {
				$('input:checkbox[name="sms_chk"]').prop("checked",false);
			}
		});
	});
	
	function getCheckbox() {
		
		var cnt = $('input:checkbox[name="sms_chk"]:checked').length;
	    
	    if (cnt == 0) {
	    	
	    	alert('메세지 발송할 업체를 선택해주세요.');
	    	
	    } else {  
	    	$("#sendSms").popup("open");
	    	$("#smsCnt").html(cnt);
	    }
		
	}
	
	function send_sms() {
		
	    var telNum = "";  
    	$('input:checkbox[name="sms_chk"]:checked').each(function (index) {
    		//alert($(this).val());
    		telNum += "," + $(this).val();
        });
    	location.href="sms:"+telNum;
	}
	
	//뒤로가기
	function callMain() {
		
		//location.href="${pageContext.request.contextPath}/appMain/appMain.do";
		history.go(-1)();
		
	}
	
		$( document ).on( "pagecreate", "#list_page", function() {

			// Swipe to remove list item
			$( document ).on( "swipeleft swiperight", "#list li", function( event ) {
				var listitem = $( this ),
					// These are the classnames used for the CSS transition
					dir = event.type === "swipeleft" ? "left" : "right",
					// Check if the browser supports the transform (3D) CSS transition
					transition = $.support.cssTransform3d ? dir : false;

					confirmAndDelete( listitem, transition );
			});

			// If it's not a touch device...
			if ( ! $.mobile.support.touch ) {

				// Remove the class that is used to hide the delete button on touch devices
				$( "#list" ).removeClass( "touch" );

				// Click delete split-button to remove list item
				$( ".delete" ).on( "click", function() {
					var listitem = $( this ).parent( "li" );

					confirmAndDelete( listitem );
				});
			}

			function confirmAndDelete( listitem, transition ) {
				// Highlight the list item that will be removed
				listitem.children( ".ui-btn" ).addClass( "ui-btn-active" );
				// Inject topic in confirmation popup after removing any previous injected topics
				$( "#confirm .topic" ).remove();
				listitem.find( ".topic" ).clone().insertAfter( "#question" );
				// Show the confirmation popup
				$( "#confirm" ).popup( "open" );
				// Proceed when the user confirms
				$( "#confirm #yes" ).on( "click", function() {
					// Remove with a transition
					if ( transition ) {

						listitem
							// Add the class for the transition direction
							.addClass( transition )
							// When the transition is done...
							.on( "webkitTransitionEnd transitionend otransitionend", function() {
								// ...the list item will be removed
								listitem.remove();
								// ...the list will be refreshed and the temporary class for border styling removed
								$( "#list" ).listview( "refresh" ).find( ".border-bottom" ).removeClass( "border-bottom" );
							})
							// During the transition the previous button gets bottom border
							.prev( "li" ).children( "a" ).addClass( "border-bottom" )
							// Remove the highlight
							.end().end().children( ".ui-btn" ).removeClass( "ui-btn-active" );
					}
					// If it's not a touch device or the CSS transition isn't supported just remove the list item and refresh the list
					else {
						listitem.remove();
						$( "#list" ).listview( "refresh" );
					}
				});
				// Remove active state and unbind when the cancel button is clicked
				$( "#confirm #cancel" ).on( "click", function() {
					listitem.children( ".ui-btn" ).removeClass( "ui-btn-active" );
					$( "#confirm #yes" ).off();
				});
			}
		});
		
		function mapPut(){
			document.mapList.action = "mapList.do";
			document.mapList.submit();
		}
		
		//전화,문자 연결		
		function connect(data){
				location.href=data;
		}
		//좋아요insert
		function insertBookmark(koker_no,cnt){
			var member_no = $("#session_member_no").val();

			if(member_no == "" || member_no == null || member_no == undefined  || member_no == 'null'){
				$("#popupCheck").popup("open");   
				return false;
			}
			
			var params = "member_no="+member_no+"&koker_no="+koker_no;
			
			
		 	$.ajax({
		        type        : "POST"  
		      , async       : false 
		      , url         : "/like/insertBookMark.do"
		      , data        : params
		      , dataType    : "json" 
		      , timeout     : 30000   
		      , cache       : false     
		      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		      , error       : function(request, status, error) {
		  	    $("#dialog_txt").text("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
				$("#popupDialog").popup("open");   
		      }
		      , success     : function(data) {
					
					if(data.result_code == 1){
						
						$("#bookmark_"+cnt).attr("onclick","deleteBookmark('"+koker_no+"','"+cnt+"');");
						$("#bookmark_"+cnt).html("<p><img src='../../img/list/list_zzim_on.png'/>찜</p>");
					}else{
						
					}
		      }
			});
			
		}
		//좋아요delete
		function deleteBookmark(koker_no,cnt){
			
			var member_no = $("#session_member_no").val();
			if(member_no == "" || member_no == null || member_no == undefined  || member_no == 'null'){
				$("#popupCheck").popup("open");   
				return false;
			}
			
			var params = "member_no="+member_no+"&koker_no="+koker_no;
			
			
		 	$.ajax({
		        type        : "POST"  
		      , async       : false 
		      , url         : "/like/deleteBookMark.do"
		      , data        : params
		      , dataType    : "json" 
		      , timeout     : 30000   
		      , cache       : false     
		      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		      , error       : function(request, status, error) {
		  	    $("#dialog_txt").text("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
				$("#popupDialog").popup("open");   
		      }
		      , success     : function(data) {
					
					if(data.result_code == 1){
						$("#bookmark_"+cnt).attr("onclick","insertBookmark('"+koker_no+"','"+cnt+"');");
						$("#bookmark_"+cnt).html("<p><img src='../../img/list/list_zzim_off.png'/>찜</p>");
					}else{
						
					}
		      }
			});
			
		}
		
    </script>
</head>

<body>
	<form id="mapList" name="mapList" method="get">
		<input type="hidden" id="latitude" name="latitude" value="${latitude }" />
		<input type="hidden" id="longitude" name="longitude" value="${longitude }" />
		<input type="hidden" id="adius" name="adius" value="${adius }" />
		<input type="hidden" id="class_code" name="class_code" value="${class_code }" />
		<input type="hidden" id="category" name="category" value="${category }" />
		<input type="hidden" id="member_no" name="member_no" value="<%=member_no%>" />
		<input type="hidden" id="chk_code" name="chk_code" value="${chk_code}"/>
		<input type="hidden" id="member_no" name="member_no" value="${member_no}"/>		
		<input type="hidden" id="session_member_no" name="session_member_no" value="<%=member_no%>" />
	</form>
	
<div data-role="page" id="list_page" class="koker_page list_page msg_list">
	<div data-role="header" class="search_header" data-position="fixed" style="border:0 !important; background-color:#21B4D6 !important;">		
		<div class="back_btn">
			<a href="#" data-ajax="false" class="relback_btn" onclick="javascript:callMain();">
				<img src="../img/relback.gif" />
			</a>
		</div>
		<h1 style="text-align:center; background-color:#21B4D6 !important; color:#fff !important; text-shadow:none !important;">내주변</h1>
		<div class="ui-btn-right" style="margin-top:-.1em;">
			<a href="<%=cp%>/appMain/appMain.do" style="text-decoration:none; color:#21B4D6; margin-right:.5em;" data-ajax="false">
				<img src="../img/header/reset.png" class="header_icon" style="width:2.2em; vertical-align:top;" />
			</a>
			<c:if test="${'03' ne class_code}">
			<a href="" data-ajax="false" onclick="javascript:mapPut();">
				<img src="../img/list/list_map_icon.gif" class="header_icon" style="width:1.8em; vertical-align:top;" />
			</a>
			</c:if>
		</div>
	</div>
	
	<!-- 검색결과가 없을때 리스트가 없을때 -->
	<c:if test="${empty kokerSpecList && empty kokerList}">
		<div class="kok_list_none" id="none_list" >
			<img src="../../img/list/list_none_cha.gif" />
			<c:if test="${'03' ne class_code}">
				<h3>내 주변에 업체가 검색되지 않습니다.</h3>
				<div class="search_guide">
					<p>검색하는 방법!</p>
					<p>1.반경을 넓혀주세요.</p>
					<p>2.지역으로 검색해 보세요.</p>
				</div>
			</c:if>
			<c:if test="${'03' == class_code}">
				<h3>내 주변에 기술자가 검색되지 않습니다.</h3>
				<div class="search_guide">
					<p>검색하는 방법!</p>
					<p>1.반경을 넓혀주세요.</p>
					<p>2.지역으로 검색해 보세요.</p>
				</div>
			</c:if>
		</div>
	</c:if>	
	<!-- 나의콕 리스트가 있을때 -->
	
	<c:if test="${not empty kokerSpecList}">
	
		<div class="list_count">
			<p><img src="../../img/list/list_cap.gif" width="1em" />추천</p>
		</div>
		
		<c:forEach var="kokerSpec" items="${kokerSpecList}" varStatus="count">
		
		<div data-role="content" class="list_content">
			<div class="list_big_group">
				<div class="ui-grid-a" onclick="location.href='/kokkok20/kokkok20_details.do?koker_no=${kokerSpec.koker_no }&backCount=1'"> 
				    <div class="ui-block-a list_stats_img">
		    			<c:if test="${kokerSpec.logo_name == '' || kokerSpec.logo_name == null || kokerSpec.logo_name == undefined}">
				    		<img src="../../img/list/list_bg.jpg" />
				    	</c:if>
			    		<c:if test="${kokerSpec.logo_name != '' && kokerSpec.logo_name != null && kokerSpec.logo_name != undefined}">
				    		<img src="../upload/img/${kokerSpec.member_id}/${kokerSpec.logo_name}" style="min-height:135px;"/>
				    	</c:if>	
				    	
						<div class="list_text_mark">
						    <c:if test="${'0' ne kokerSpec.special_no}">
				    			<img src="../../img/list/list_kok.gif" />
						    </c:if>
				    	</div>
						<div class="list_text_mark02">
							<c:if test="${kokerSpec.koker_auth == 'y'}">
			    				<img src="../../img/inzng_mark.png" />
			    			</c:if>
				    	</div>
				    </div> 
				    <div class="ui-block-b list_stats_group" style="padding: .3em 0 0 .5em !important;">
				    	<h6>${kokerSpec.koker_name }
						    <c:if test="${'03' eq kokerSpec.class_code}">
							    <c:if test="${'1' eq kokerSpec.state}">
							    	<img src="../../img/list/list_wait.gif" />
							    </c:if>
							    <c:if test="${'0' eq kokerSpec.state}">
							    	<img src="../../img/list/list_wark.gif" />
							    </c:if>
						    </c:if>
				    	</h6>
				    	<div class="ui-grid-a list_stats"> 
						    <div class="ui-block-a review_list" style="width:65% !important;">		
								<form>
									<label for="slider-2"></label>
									<input name="slider-2" id="slider-2" type="range" min="0" max="10" value="${kokerSpec.review_avg}" step="1" data-highlight="true" disabled='disabled'>
								</form>
						    </div> 
						    <div class="ui-block-b" style="width:35% !important; padding-right: .3em;">
							    <c:if test="${'0' ne kokerSpec.ranking}">
						    		<p style="background-color:#e0000d; color:#fff; text-align:center; border-radius:25px; padding:.5em 0; text-shadow:none; font-weight:normal; margin:0;">콕콕! ${kokerSpec.ranking }위</p>
							    </c:if>
						    </div>
						    						    
							<%-- <div class="ui-grid-a list_stats_text"> 
				   				<div class="ui-block-a" style="width:25% !important;">
				   					<p>전화번호 : </p>
				   				</div>
				    			<div class="ui-block-b" style="width:75% !important;">
				    				<p>${koker.call_tel01}-${koker.call_tel02}-${koker.call_tel03}</p>
				    			</div>
			    			</div> --%>
						</div>
				    </div>
				    <div class="ui-block-b list_stats_text" style="margin: 0 !important; padding: .3em 0 0 .5em !important; width:60%;">
  							<p style="margin:.5em; font-size:14px;">${kokerSpec.addr01}</p>
				    </div>
				    
				    <div class="ui-block-b">
				    	<div class="ui-grid-a" style="width:100%;"> 
				   			<div class="ui-block-a" style="width:50%;">
				    			<img src="../../img/list/list_review.gif" style="width:1.2em; vertical-align:middle;" /><span style="font-size:14px; padding-left:.3em;">${kokerSpec.review_count }</span>
				    		</div>
				   			<div class="ui-block-b" style="padding:0;">
					    		<img src="../../img/list/list_mark.gif" style="width:.8em; vertical-align:middle;" /><span style="font-size:14px; padding-left:.3em;">${kokerSpec.distance }km</span>
					    	</div>
				    	</div>
				    </div> 
				</div>
				<%-- <div class="ui-grid-a cont_font" style="padding:.3em 0;"> 
					<div class="ui-block-a" style="width:85% !important; margin:0; line-height:8px;">
						<p style="margin:0;"><span>에어컨 ㅣ 공조 ㅣ 닥트</span><span>주방 ㅣ 가구</span><span>에어컨 ㅣ 공조 ㅣ 닥트</span></p>
					</div>
					<<div class="ui-block-b" style="width:15% !important; padding:0;">
						<p style="color:#6e6c6c; margin:0; font-size:8px;" onclick="location.href='/kokkok20/kokkok20_details.do?koker_no=${data.koker_no }&backCount=1'">그외 3</p>
					</div>
	   			</div>  --%>
	   			<div class="ui-grid-b cont_box"> 
				   <div class="ui-block-a" style="width: 33.333% !important; padding:0;"><p onclick="doMapping('tel','${kokerSpec.call_tel01}${kokerSpec.call_tel02}${kokerSpec.call_tel03}','${kokerSpec.koker_no}');"><img src="../img/more/call_icon.gif" style="width:1em;"/>통화</p></div> 
				  
				    <div class="ui-block-b" style="width: 33.333% !important; padding:0 .3em;"><p  onclick="doMapping('sms','${kokerSpec.call_tel01}${kokerSpec.call_tel02}${kokerSpec.call_tel03}','${kokerSpec.koker_no}');"><img src="../img/list/list_msg_icon.gif" />문자</p></div> 
				  <c:if test="${'0' ne kokerSpec.bookmark_no}">
					    <div id="bookmark_${count.count}" class="ui-block-c" onclick="deleteBookmark('${kokerSpec.koker_no}','${count.count}');" style="width: 33.333% !important; padding:0;">
					    	<p>  	
						    	<img src="../img/list/list_zzim_on.png" />찜
							</p>
				    	</div> 
			    	</c:if>
			    	<c:if test="${'0' eq kokerSpec.bookmark_no}">
					    <div id="bookmark_${count.count}" class="ui-block-c" onclick="insertBookmark('${kokerSpec.koker_no}','${count.count}');" style="width: 33.333% !important; padding:0;">
					    	<p>
						    	<img src="../../img/list/list_zzim_off.png"/>찜 
						    </p>
				    	</div> 
			    	</c:if>
				</div>
			</div>
		</div>
		</c:forEach>
	</c:if>	
	
	
	<c:if test="${not empty kokerList}">
	
		<div class="list_count">
			<p><img src="../../img/list/list_area.gif" width="1em" />내주변</p>
		</div>
		
		<c:forEach var="koker" items="${kokerList}" varStatus="count">
		
		<div data-role="content" class="list_content">
			<div class="list_big_group">
				<div class="ui-grid-a" onclick="location.href='/kokkok20/kokkok20_details.do?koker_no=${koker.koker_no }&backCount=1'"> 
				    <div class="ui-block-a list_stats_img">
		    			<c:if test="${koker.logo_name == '' || koker.logo_name == null || koker.logo_name == undefined}">
				    		<img src="../../img/list/list_bg.jpg" />
				    	</c:if>
			    		<c:if test="${koker.logo_name != '' && koker.logo_name != null && koker.logo_name != undefined}">	
				    		<img src="../upload/img/${koker.member_id}/${koker.logo_name}" style="min-height:135px;"/>
				    	</c:if>	
				    	
						<div class="list_text_mark">
						    <c:if test="${'0' ne koker.special_no}">
				    			<img src="../../img/list/list_kok.gif" />
						    </c:if>
				    	</div>
						<div class="list_text_mark02">
							<c:if test="${koker.koker_auth == 'y'}">
			    				<img src="../../img/inzng_mark.png" />
			    			</c:if>
				    	</div>
				    </div> 
				    <div class="ui-block-b list_stats_group" style="padding: .3em 0 0 .5em !important;">
				    	<h6>${koker.koker_name }
						    <c:if test="${'03' eq koker.class_code}">
							    <c:if test="${'1' eq koker.state}">
							    	<img src="../../img/list/list_wait.gif" />
							    </c:if>
							    <c:if test="${'0' eq koker.state}">
							    	<img src="../../img/list/list_wark.gif" />
							    </c:if>
						    </c:if>
				    	</h6>
				    	<div class="ui-grid-a list_stats"> 
						    <div class="ui-block-a review_list" style="width:65% !important;">		
								<form>
									<label for="slider-2"></label>
									<input name="slider-2" id="slider-2" type="range" min="0" max="10" value="${koker.review_avg}" step="1" data-highlight="true" disabled='disabled'>
								</form>
						    </div> 
						    <div class="ui-block-b" style="width:35% !important; padding-right: .3em;">
							    <c:if test="${'0' ne koker.ranking}">
						    		<p style="background-color:#e0000d; color:#fff; text-align:center; border-radius:25px; padding:.5em 0; text-shadow:none; font-weight:normal; margin:0;">콕콕! ${koker.ranking }위</p>
							    </c:if>
						    </div>
						    						    
							<%-- <div class="ui-grid-a list_stats_text"> 
				   				<div class="ui-block-a" style="width:25% !important;">
				   					<p>전화번호 : </p>
				   				</div>
				    			<div class="ui-block-b" style="width:75% !important;">
				    				<p>${koker.call_tel01}-${koker.call_tel02}-${koker.call_tel03}</p>
				    			</div>
			    			</div> --%>
						</div>
				    </div>
				    <div class="ui-block-b list_stats_text" style="margin: 0 !important; padding: .3em 0 0 .5em !important; width:60%;">
  							<p style="margin:.5em; font-size:14px;">${koker.addr01}</p>
				    </div>
				    
				    <div class="ui-block-b">
				    	<div class="ui-grid-a" style="width:100%;"> 
				   			<div class="ui-block-a" style="width:50%;">
				    			<img src="../../img/list/list_review.gif" style="width:1.2em; vertical-align:middle;" /><span style="font-size:14px; padding-left:.3em;">${koker.review_count }</span>
				    		</div>
				   			<div class="ui-block-b" style="padding:0;">
					    		<img src="../../img/list/list_mark.gif" style="width:.8em; vertical-align:middle;" /><span style="font-size:14px; padding-left:.3em;">${koker.distance }km</span>
					    	</div>
				    	</div>
				    </div> 
				</div>
				<%-- <div class="cont_font"> 
					<p><span>인테리어</span><span>주방 ㅣ 가구</span><span>설비</span><span style="">에어컨 ㅣ 공조 ㅣ 닥트</span><span style="float:right; line-height:24px; color:#6e6c6c; margin-right:0; padding-right:.5em;" onclick="location.href='/kokkok20/kokkok20_details.do?koker_no=${koker.koker_no }&backCount=1'">그외 3</span></p>
	   			</div>  --%>
	   			<div class="ui-grid-b cont_box"> 
				   <div class="ui-block-a" style="width: 33.333% !important; padding:0;"><p onclick="doMapping('tel','${koker.call_tel01}${koker.call_tel02}${koker.call_tel03}','${koker.koker_no}');"><img src="../img/more/call_icon.gif" style="width:1em;"/>통화</p></div> 
				  
				    <div class="ui-block-b" style="width: 33.333% !important; padding:0 .3em;"><p  onclick="doMapping('sms','${koker.call_tel01}${koker.call_tel02}${koker.call_tel03}','${koker.koker_no}');"><img src="../img/list/list_msg_icon.gif" />문자</p></div> 
				  <c:if test="${'0' ne koker.bookmark_no}">
					    <div id="bookmark_${count.count}" class="ui-block-c" onclick="deleteBookmark('${koker.koker_no}','${count.count}');" style="width: 33.333% !important; padding:0;">
					    	<p>  	
						    	<img src="../img/list/list_zzim_on.png" />찜
							</p>
				    	</div> 
			    	</c:if>
			    	<c:if test="${'0' eq koker.bookmark_no}">
					    <div id="bookmark_${count.count}" class="ui-block-c" onclick="insertBookmark('${koker.koker_no}','${count.count}');" style="width: 33.333% !important; padding:0;">
					    	<p>
						    	<img src="../../img/list/list_zzim_off.png"/>찜 
						    </p>
				    	</div> 
			    	</c:if>
				</div><!-- /grid-b -->
			</div>
		</div>
		
<%-- 		<c:if test="${count.count%3 == 0}"> --%>
	
<!-- 		        <ul id="list" class="touch list_banner" data-role="listview" data-icon="false" data-split-icon="delete"> -->
<!-- 		            <li> -->
<!-- 		                <a href="#"> -->
<!-- 		                	<p class="delete_guide">밀어서 안보기 >></p> -->
<!-- 		                    <h3>'공사콕커' 런칭 이벤트</h3>  -->
<!-- 		                    <p><span style="background-color:#F0C71F; color:#fff;">혜택1</span> 업체 회원가입 <span style="color:red;">무료</span></p> -->
<!-- 		                    <p><span style="background-color:#E79526; color:#fff;">혜택2</span> 추천업체 선정시 메인배너 <span style="color:red;">무료</span></p> -->
<!-- 		                    <p style="padding-left:1em;">※ 2016년 1월부터 유료화 전환됩니다. ※<br />※ 서비스 종료일을 확인하세요! ※</p> -->
<!-- 		                </a> -->
<!-- 		                삭제버튼 
<!-- 		                <a href="#" class="delete">Delete</a> -->
<!-- 		                --> 
<!-- 		            </li> -->
<!-- 		        </ul> -->
	    
<%--     	</c:if> --%>
		
		</c:forEach>
	</c:if>	
	
	
	<!-- /content -->

    <div id="confirm" class="ui-content delete_pop_wrap" data-role="popup" data-theme="a">

        <p id="question">정말 광고를 그만 보시겠습니까?</p>

        <div class="ui-grid-a delete_pop">
            <div class="ui-block-a">
                <a id="cancel" class="ui-btn ui-corner-all ui-mini ui-btn-a" data-rel="back">취소</a>
            </div>
            <div class="ui-block-b">
                <a id="yes" class="ui-btn ui-corner-all ui-mini ui-btn-a" data-rel="back" style="background-color:#29A9C8 !important;">확인</a>
            </div>
        </div>

	</div><!-- /popup -->
	
	<div id="sendSms" class="ui-content delete_pop_wrap" data-role="popup" data-theme="a">

        <p id="question" style="color:#000 !important; margin:1em 0 2em 0; font-size:12px;">
        	<span id="smsCnt" style="color:#29A9C8 !important; font-weight:bold !important;"></span>
       	 개의 업체에 문자를 발송하시겠습니까?</p>

        <div class="ui-grid-a delete_pop">
            <div class="ui-block-a">
                <a id="cancel" class="ui-btn ui-corner-all ui-mini ui-btn-a" data-rel="back">취소</a>
            </div>
            <div class="ui-block-b">
                <a id="yes" class="ui-btn ui-corner-all ui-mini ui-btn-a" style="background-color:#29A9C8 !important;" onclick="javascrip:send_sms();">확인</a>
            </div>
        </div>

	</div><!-- /popup -->
	
	 <div id="popupAddBookmark" data-role="popup" data-transition="pop" class="kok_pop"  data-ajax="false">
	    <div class="ui-content" role="main">
	    	<img src="../img/more/kok_on.gif" />
	  	</div>    
	 </div>	

	 <div id="popupDeleteBookmark" data-role="popup" data-transition="pop" class="kok_pop"  data-ajax="false">
	    <div class="ui-content" role="main">
	    	<img src="../img/more/kok_off.gif" />
	  	</div>    
	 </div>	
	 
	 <div id="popupCheck" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<p>로그인이 필요한 서비스입니다.</p>
	      	<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>   
	  	</div>    
	 </div>	
	 
</div>  
<script src="../dist/js/swiper.min.js"></script>
<script>
	var swiper = new Swiper('.swiper-container', {
	    pagination: '.swiper-pagination',
	    nextButton: '.swiper-button-next',
	    prevButton: '.swiper-button-prev',
	    slidesPerView: 1,
	    paginationClickable: true,
	    spaceBetween: 30,
	    loop: true
	});
</script>
</body>
</html>