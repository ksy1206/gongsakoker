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
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<link rel="stylesheet" href="../css/layout.css" />
<link rel="stylesheet" href="../css/main.css" />
<link rel="stylesheet" href="../css/swiper.min.css">
<link rel="stylesheet" href="../css/field_details.css">
<link rel="stylesheet" href="../css/alertify.core.css" />
<link rel="stylesheet" href="../css/alertify.default.css" id="toggleCSS" />
<script src="../js/web/alertify.min.js"></script>
<style> 
	/* 마스크 뛰우기 */
	#mask {  
		position:absolute;  
		z-index:9000;  
		background-color:#000;  
		display:none;  
		left:0;
		top:0;
		background-color: rgba(0,0,0, .6);
	}
	/*
	 팝업으로 뜨는 윈도우 css  
	*/ 
	.window{
		display: none;
		position:relative;  
		width:100%;  
	}
	</style>
	<script>
	function wrapWindowByMask(){
		//화면의 높이와 너비를 구한다.
		var maskHeight = $(document).height();  
		var maskWidth = $(window).width();  
		    
		//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
		$('#mask').css({'width':maskWidth,'height':maskHeight});  
		//애니메이션 효과 - 일단 0초동안 까맣게 됐다가 60% 불투명도로 간다.
		$('#mask').fadeIn(0);      
		//$('#mask').fadeTo("slow",0.6);    
		//윈도우 같은 거 띄운다.
		$('.window').show();
	}
	
	var os = "";
	var appExist = "";
	
	// 아래는 OS 구분에 대한 부분은 예시 코드다.  모바일이 아닌 경우도 고려해야 한다. 
	var useragent = navigator.userAgent;
	if(navigator.userAgent.toLocaleLowerCase().search("iphone") > -1){
		os = "ios";
	}else if(navigator.userAgent.toLocaleLowerCase().search("android") > -1){
		os = "android";
	}else {
		os = "else";
	}
	
	function goAppStoreOrPlayStore() {
		if(os == "android") {
			var storeURL = "market://details?id=com.gonggan.koker&hl=ko";
			location.replace(storeURL);
		} 
		else if (os == "ios") {
			var storeURL = "https://itunes.apple.com/kr/app/id1092395847?mt=8";
			location.replace(storeURL);
		} else {
			
		}
	}
	/*앱을 실행하는 코드
	 동일한 uri scheme을 Android 앱이나 iOS 앱에 적용을 시켜야 한다.
	 uri scheme 은 목적에 맞게 정의한다.
	 uri 값에 따라서 분기 목적이 다를 수 있으나, 여기에서는 단순히 샘플정도로만 이해 할 것!
	 uri scheme이 정의되어 있다면 OS에 따른 구분을 별도로 할 필요가 없다.
	 */
	function executeApp() {
		if(os == "android") {
			
			var appUriScheme = "koker000001://gongsakokerlink?" + ";;;" + "fieldstory=" + $("#fs_no").val();
			location.href = appUriScheme;
			
		}else if(os == "ios") {
			
			var type = "type=" + "fieldstory";
			var koker_no = "fs_no=" + $("#fs_no").val();
			location.href="kokerscheme://kokerhost?" + type + "&" + koker_no;
		}else {
			
		}
	
	}
	// 이 코드는 대부분 사용하는 코드다. 
	function executeAppOrGoStore() {
		if(window.confirm("공사콕커로 이동합니다. \n앱 버전이 낮거나 앱이 설치되어 있지 않을 시 설치페이지로 이동합니다.")) {
			var openAt = new Date;
		 	setTimeout( function() {
	 			if (new Date - openAt < 2000){
	 				goAppStoreOrPlayStore();
	 			}
	 		}, 1500);
			executeApp();
		}
	}

	</script>
	<script>
    $(document).ready(function() {
    	$('.fielddetail_content').on( 'keyup', 'textarea', function (e){
        	$(this).css('height', 'auto' );
        	$(this).height( this.scrollHeight );
      	});
      	$('.fielddetail_content').find( 'textarea' ).keyup();
      	
      	$('.window .close').click(function() {
			$(this).hide();
			$('.window').hide();
			$('#mask').hide();    
			
		});
		$('.openitem').click(function() {
			executeAppOrGoStore();
		});
    });
	</script>
	<script>
    $(document).ready(function() {
     	 $('.fielddetail_content').on( 'keyup', 'textarea', function (e){
        	$(this).css('height', 'auto' );
        	$(this).height( this.scrollHeight );
     	 });
      	$('.fielddetail_content').find( 'textarea' ).keyup();
    });
	</script>
	
<title>공사 KOKER</title>

<script type="text/javascript">

//댓글 쓰기
function answer_wrtie(){
	var fs_no = $("#fs_no").val();
	var member_id = $("#session_member_id").val();
	var member_no = $("#session_member_no").val();
	var ans_content = $("#ans_content").val();
	
	var check_session = $("#session_member_no").val();
	if(check_session == null || check_session == "" || check_session == undefined){
		alertify.alert("로그인 후 이용가능합니다.");
		return false;			
	} else {
		if(ans_content == "" | ans_content == null | ans_content == "댓글쓰기"){
			alertify.alert("댓글을 입력해 주세요.");
		} else {
			location.href="<%=cp%>/fieldStory_web/fieldStory_addAnswer.do?fs_no="+fs_no+"&member_id="+member_id+"&member_no="+member_no+"&ans_content="+ans_content;
		}
	}
}

//추천하기
function add_recommend(){
	
	var fs_no = $("#fs_no").val();
	var member_no = $("#session_member_no").val();
	var member_id = $("#session_member_id").val();
	params = "fs_no="+fs_no+"&member_no="+member_no+"&member_id="+member_id;
	
	if(member_no == null || member_no==''){
		alertify.alert("로그인 후 이용가능합니다.");
		return false;
	} else {
		 $.ajax({
		        type        : "POST" 
		      , async       : false
		      , url         : "/fieldStory/add_recommend_fieldStory.do"
		      , data        : params
		      , dataType    : "json"
		      , timeout     : 30000  
		      , cache       : false    
		      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		      , error       : function(request, status, error) {
		       	alertify.alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );
		                   
		      }
		      , success     : function(data) {
		    	  html = "";
		    	  if(data.recommend_check == 'y'){		    		  
		    		  html += "<img src='../img/fieldStory/recommendRed_icon.png' onclick='add_recommend()'/><br><p>"+data.recommend_count+"명이 추천합니다.</p>";
		    		  $("#recommend_div").html(html).trigger("create");
		    		  alertify.alert("추천이 되었습니다.");		    		  
		    	  } else if(data.recommend_check == 'n'){
		    		  html += "<img src='../img/fieldStory/recommend_icon.png' onclick='add_recommend()'/><br><p>"+data.recommend_count+"명이 추천합니다.</p>";
		    		  $("#recommend_div").html(html).trigger("create");
		    		  alertify.alert("추천이 취소되었습니다.");
		    	  }
				
		      }
			});
	}   
}

jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
    return this;
}

showPopup = function() {
	$("#popLayer").show();
	$("#popLayer").center();
	}

closePopup = function() {
	$("#popLayer").hide();
	}

function check_code(code, ans_no){	
	var check_session = $("#session_member_no").val();
	if(check_session == null || check_session == "" || check_session == undefined){
		alertify.alert("로그인 후 이용 가능 합니다.");
		return false;			
	} else {
		$("#check_code").val(code);
		$("#ans_no").val(ans_no);
		showPopup();
	}	
}

//신고하기 팝업
function singo(){
	var report_category = $("input:radio[name='radio-choice-w-6']:checked").val();
	var report_content = $("#sigoTextarea").val();
	
	if(report_category ==null||report_category ==""||report_category == 'default'){
		alertify.alert("신고사유를 선택해 주세요.");
		return false;			
	}
	if(report_content ==null||report_content ==""||report_content == '내용을 입력해 주세요.'){
		alertify.alert("내용을 입력해 주세요.");
		return false;			
	}else {		
		if(confirm("신고 하시겠습니까?")){
			add_singo();
		} else {}
	}
}

//신고하기 db등록
function add_singo(){	
	var fs_no = $("#fs_no").val();
	var member_no = $("#session_member_no").val();
	var report_category = $("input:radio[name='radio-choice-w-6']:checked").val();
	var report_content = $("#sigoTextarea").val();
	var report_grade = $("#check_code").val();
	var ans_no = $("#ans_no").val();
	params = "fs_no="+fs_no+"&member_no="+member_no+"&report_category="+report_category+"&report_content="+report_content+"&report_grade="+report_grade+"&ans_no="+ans_no;
    $.ajax({
        type        : "POST" 
      , async       : false
      , url         : "/fieldStory/add_fieldStorySingo.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
       	$( "#dialog_txt").text( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );
        $( "#popupDialog").popup( "open");                
      }
      , success     : function(data) {
    	  alertify.alert("신고가 완료 되었습니다.");
    	  closePopup();
      	
      }
	});
}

//댓글 수정하는 DIV열기
function answer_modify(ans_no){
	html = "";
	html2 = "";
	var ans_content = $("#ans_content_"+ans_no).val();
	html += "<p>";
	html += "<input type='text' value="+ans_content+" id='ans_content_"+ans_no+"'>";	
	html += "<input type='button' value='수정완료' onclick='answer_modify_result("+ans_no+")'>"
	html += "</p>";
	$("#modeify_"+ans_no).html(html).trigger("create");
}

//댓글 수정하기
function answer_modify_result(ans_no){
	var fs_no = $("#fs_no").val();
	var ans_content = $("#ans_content_"+ans_no).val();
	location.href="<%=cp%>/fieldStory_web/fieldStory_modifyAnswer.do?ans_no="+ans_no+"&ans_content="+ans_content+"&fs_no="+fs_no;
}

//댓글 삭제하기
function answer_delete(ans_no){
	var fs_no = $("#fs_no").val();
	location.href="<%=cp%>/fieldStory_web/fieldStory_deleteAnswer.do?ans_no="+ans_no+"&fs_no="+fs_no;
}

//글 수정
function modify_fieldStory(){
	var fs_no = $("#fs_no").val();
	location.href="<%=cp%>/fieldStory_web/modify_fieldStory.do?fs_no="+fs_no;
}

//글 삭제
function delete_fieldStory(){
	var fs_no = $("#fs_no").val();
	var member_no = $("#session_member_no").val();
	location.href="<%=cp%>/fieldStory_web/delete_fieldStory.do?fs_no="+fs_no+"&member_no="+member_no;
}

</script>

</head>
<body>
<div>
	<div>
		<div class="board_header">
			<jsp:include page="../../web/include/header.jsp"/>
				<div class="board_title">
						<h1><img src="<%=cp%>/img/local/banner_img.png"></h1>
				</div>
			</div>
	</div>
</div>

	<input type="hidden" value="${fieldStoryVo.fs_no}" id="fs_no">
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="session_member_no">
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_id()}" id="session_member_id">
	<input type="hidden" id="ans_no">
	<input type="hidden" id="check_code">
	
<div class="field_container">
	<div class="fielddetail_title">
		<c:if test="${fieldStoryVo.logo_name == null || fieldStoryVo.logo_name == '' }">
			<img src="<%=cp %>/img/local/tikok_writer_ico.png" style="margin-right:10px;">
		</c:if>
		<c:if test="${fieldStoryVo.logo_name != null && fieldStoryVo.logo_name != '' }">
			<img src="<%=cp %>/upload/img/${fieldStoryVo.member_id}/${fieldStoryVo.logo_name}" style="margin-right:10px;">
		</c:if>
		<span><h2>${fieldStoryVo.title}</h2></span>
		<span>${fieldStoryVo.koker_name}</span><span style="margin:0 10px;">|</span><span>${fieldStoryVo.sido} ${fieldStoryVo.gugun}</span>
		<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() != fieldStoryVo.member_no}">
			<a href="javascript:;"onclick="javascript:check_code('01')"><img src="<%=cp %>/img/local/report_ico.png" ></a>
		</c:if>
		<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == fieldStoryVo.member_no}">
		<div>
			<div style="float:right;">
				<a href="javascript:;"onclick="modify_fieldStory()">수정</a> | <a href="javascript:;"onclick="delete_fieldStory()">삭제</a>	
			</div>
		</div>
		</c:if>
	</div>
	<div class="fielddetail_content">
		<p><textarea readonly="readonly" style="width:100%;border:none;resize:none;font-family:'나눔바른고딕';">${fieldStoryVo.content}</textarea></p>
		<div class="fielddetail_photobox">
			<c:if test="${fieldStoryVo.img01 != null && fieldStoryVo.img01 != ''}">
				<c:if test="${fieldStoryVo.img02 == null || fieldStoryVo.img02 == ''}">
					<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img01}" width="100%"/>
				</c:if>
				<c:if test="${fieldStoryVo.img03 == null || fieldStoryVo.img03 == ''}">
					<c:if test="${fieldStoryVo.img02 != null && fieldStoryVo.img02 != ''}">
						<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img01}" width="49%"/>
						<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img02}" width="49%"/>
					</c:if>
				</c:if>
				<c:if test="${fieldStoryVo.img03 != null && fieldStoryVo.img03 != ''}">
					<c:if test="${fieldStoryVo.img02 != null && fieldStoryVo.img02 != ''}">
						<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img01}" width="30%"/>
						<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img02}" width="30%"/>
						<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img03}" width="30%"/>
					</c:if>
				</c:if>
			</c:if>
		</div>
	</div>
	<div class="fielddetail_ico">
		<span class="fielddetail_ico_good">
			<div id="recommend_div">
				<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == null || sessionScope.sessionData.memberInfo.getMember_no() == ''}">
						<img src="../img/fieldStory/recommend_icon.png" onclick="add_recommend()"/>
				</c:if>
				<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() != null && sessionScope.sessionData.memberInfo.getMember_no() != ''}">
					<c:if test="${recommend_check == 'y'}">
						<img src="../img/fieldStory/recommend_icon.png" onclick="add_recommend()"/>
					</c:if>
					<c:if test="${recommend_check == 'n'}">
						<img src="../img/fieldStory/recommendRed_icon.png" onclick="add_recommend()"/>
					</c:if>
				</c:if>
				<br>
				<p>${fieldStoryVo.recommend_count}명이 추천합니다.</p>
			</div>
		</span>
<!-- 		<span class="fielddetail_ico_share"> -->
<%-- 			<a href="#" target="_blank"><img src="<%=cp %>/img/local/kakaotalk_ico.png"></a> --%>
<%-- 			<a href="#" target="_blank"><img src="<%=cp %>/img/local/kakaostory_ico.png"></a> --%>
<%-- 			<a href="#" target="_blank"><img src="<%=cp %>/img/local/facebook_ico.png"></a> --%>
<%-- 			<a href="#" target="_blank"><img src="<%=cp %>/img/local/naverband_ico.png"></a> --%>
<%-- 			<a href="#" target="_blank"><img src="<%=cp %>/img/local/naverblog_ico.png"></a> --%>
<%-- 			<a href="#" target="_blank"><img src="<%=cp %>/img/local/daumblog_ico.png"></a> --%>
<!-- 		</span> -->
	</div>
	<div class="fielddetail_comment">
		<div class="fielddetail_comment_area">
			<p>댓글 <span style="color:red;">${fieldStoryVo.answer_count}</span></p>
				<div class="comment_area">
					<input type="text" placeholder="댓글쓰기" id="ans_content">
					<span class="comment_ok" onclick="answer_wrtie()">등록</span>
				</div>
		</div>
		<div class="fielddetail_comment_list">
			<c:forEach var="answer" items="${fieldStoryAnswer}">
				<div class="fielddetail_comment_list_01">
					<div>
						<c:if test="${answer.logo_name == null || answer.logo_name == '' }">
							<img src="<%=cp %>/img/local/tikok_writer_ico.png" style="margin-right:15px;">						
						</c:if>
						<c:if test="${answer.logo_name != null && answer.logo_name != '' }">
							<img src="<%=cp %>/upload/img/${answer.member_id}/${answer.logo_name}" style="margin-right:15px;">
						</c:if>
						<span style="font-size:11pt;margin-right:20px;">${answer.koker_name}</span>
						<span style="color:#969696;">${answer.ans_insertDate}</span>
						<span style="vertical-align:top;float:right;">
						<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == answer.member_no}">
						<a href="javascript:;" onclick="answer_modify('${answer.ans_no}')">수정</a> | <a href="javascript:;" onclick="answer_delete('${answer.ans_no}')">삭제</a>
						</c:if>
						<a href="javascript:;"onclick="javascript:check_code('02', '${answer.ans_no}')"><img src="<%=cp %>/img/local/report_ico.png" style="width:15px;"></a></span>
					</div>
					<div id="modeify_${answer.ans_no}">
						<input type="hidden" value="${answer.ans_content}" id="ans_content_${answer.ans_no}">
						<p>${answer.ans_content}</p>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>

<div id="popLayer" class="reportPopup" style="display:none; background-color: #fff;">
	<div style="border:solid #29A9C8 1px; padding:1em; background-color:#fff;">
		<div class="popTitle">
			<p>
				신고하기
				<a href="javascript:;"onclick="javascript:closePopup()" style="color:#bababa;float:right;">
			 	x
				</a>
			</p>
		</div>
		<div class="reportChoice">
			<p><input type="radio" name="radio-choice-w-6" id="radio-choice-w-6a" value="불법 정보"><label for="radio-choice-w-6a">불법 정보<span style="text-align:right;"><img src="<%=cp%>/img/web/report_check_ico.png"></span></label></p>
			<p><input type="radio" name="radio-choice-w-6" id="radio-choice-w-6b" value="음란성 / 선정성"><label for="radio-choice-w-6b">음란성 / 선정성<span style="text-align:right;"><img src="<%=cp%>/img/web/report_check_ico.png"></span></label></p>
			<p><input type="radio" name="radio-choice-w-6" id="radio-choice-w-6c" value="욕설 / 인신공격"><label for="radio-choice-w-6c">욕설 / 인신공격<span style="text-align:right;"><img src="<%=cp%>/img/web/report_check_ico.png"></span></label></p>
			<p><input type="radio" name="radio-choice-w-6" id="radio-choice-w-6d" value="같은 내용의 반복 게시 (도배)"><label for="radio-choice-w-6d">같은 내용의 반복 게시 (도배)<span style="text-align:right;"><img src="<%=cp%>/img/web/report_check_ico.png"></span></label></p>
			<p><input type="radio" name="radio-choice-w-6" id="radio-choice-w-6e" value="기타"><label for="radio-choice-w-6e">기타<span style="text-align:right;"><img src="<%=cp%>/img/web/report_check_ico.png"></span></label></p>
		    <textarea placeholder="내용을 입력해 주세요." id="sigoTextarea" style="resize:none;"></textarea>
		    <p style="text-align:center;">
		    	<input type="button" value="취소" onclick="javascript:closePopup()" style="background-color:#636363;border:#636363 5px solid;">
		    	<input type="button" value="신고" onclick="singo()" style="background-color:#21b4d6;border:#21b4d6 5px solid;">
		    </p>
		</div>
		
	</div>
	
</div>
	<!-- 위에 앱으로 실행할지 아닐지 묻는 팝업 -->
	<div id="mask" style="position:absolute; top:0; left:0; width:100%; z-index:9999;">
		<div class="window" style="z-index:10000;">
			<p class="close" style="position:absolute; top:1.0em; right:0.0em; width:2.0em; height:2.0em;">X</p>
			<img width="100%" src="<%=cp %>/img/more/popuptop.png" style="position:absolute; top:6.0em; left:0;">
			<a href="#" class="openitem"><img width="100%" src="<%=cp %>/img/more/popupbottom.png" style="position:absolute; top:20.0em; left:0;"></a>
		</div>
	</div>

	<div class="footer_wrap">
			<jsp:include page="../../web/include/footer.jsp"/>
	</div>
</body>

<script type="text/javascript">
	//아래는 OS 구분에 대한 부분은 예시 코드다.  모바일이 아닌 경우도 고려해야 한다. 
	//모바일이면 씌우고 아니면 패스
	var useragent = navigator.userAgent;
	if(navigator.userAgent.toLocaleLowerCase().search("android") > -1){
		wrapWindowByMask();
	}else if(navigator.userAgent.toLocaleLowerCase().search("iphone") > -1){
		wrapWindowByMask();
	}else {
		//wrapWindowByMask();
	}
</script>
</html>