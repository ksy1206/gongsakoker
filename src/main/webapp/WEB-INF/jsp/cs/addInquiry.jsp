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
<script type="text/javascript" src="<%=cp %>/js/member/memberJoin.js"></script>
<script type="text/javascript"  src="<%=cp%>/js/jquery.form.js"></script>

<!-- 세션 없으면 메인페이지로 강제 이동 -->
<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == null || sessionScope.sessionData.memberInfo.getMember_no() ==''}">
	<script>
		location.href="${pageContext.request.contextPath}/appMain/appMain.do";
	</script>
</c:if>
<script type="text/javascript">

	$(document).ready(function (){		
		$("#add_Inquiry").click(function(){
			var board_content = $("#board_content").val();
				var board_phone01 = $("#board_phone01").val();
				var board_phone02 = $("#board_phone02").val();
				var board_phone03 = $("#board_phone03").val();
			var board_phone = board_phone01+board_phone02+board_phone03;
			if(board_content == null||board_content == ""||board_content == undefined||board_content=="문의하실 내용을 입력해주세요."){
				$("#popupCheck_txt").text("문의하실 내용을 입력해주세요.");
				$("#popupCheck_space").popup("open");
				$("#name").focus();
				return false;
		    }
			if(board_phone01==null||board_phone01==""||board_phone01== undefined){
				$("#popupCheck_txt").text("연락 받으실 번호를 남겨주세요.");
				$("#popupCheck_space").popup("open");
				$("#hp").focus();
				return false;			
	   		}
			if(board_phone02==null||board_phone02==""||board_phone02== undefined){
				$("#popupCheck_txt").text("연락 받으실 번호를 남겨주세요.");
				$("#popupCheck_space").popup("open");
				$("#hp").focus();
				return false;			
	   		}
			if(board_phone03==null||board_phone03==""||board_phone03== undefined){
				$("#popupCheck_txt").text("연락 받으실 번호를 남겨주세요.");
				$("#popupCheck_space").popup("open");
				$("#hp").focus();
				return false;			
	   		}else{
   				$("#dialog_txt").text("문의를 등록 하시겠습니까?");
   				$("#popupDialog").popup("open");	   			
	   		}						
		});		
		$("#confirm").click(function(){			
			var board_content = $("#board_content").val();
				var board_phone01 = $("#board_phone01").val();
				var board_phone02 = $("#board_phone02").val();
				var board_phone03 = $("#board_phone03").val();
			var board_phone = board_phone01+board_phone02+board_phone03;
			var board_write = $("#board_write").val();
			var member_no = $("#member_no").val();
			var params = "board_phone="+board_phone+"&board_content="+board_content+"&member_no="+member_no+"&board_write="+board_write;
			$.ajax({
		        type        : "POST"  
		      , async       : false
		      , url         : "/cs/inquiry_addDb.do"
		      , data        : params
		      , dataType    : "json" 
		      , timeout     : 30000   
		      , cache       : false     
		      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		      , error       : function(request, status, error) {
					alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
		      }
		      , success     : function(data) {
		    	  location.href="${pageContext.request.contextPath}/cs/inquiry_main.do?member_no="+member_no;
		      }
	    	});
		});		
	});
</script> 
</head>

<body>
<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no() }" id="member_no">
<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_id() }" id="board_write">
<div data-role="page" class="board_page">
	<div data-role="header" data-position="fixed" class="board_header">
		<div class="back_btn">
			<a href="#" data-ajax="false" data-rel="back" class="relback_btn"><img src="../img/relback.gif"/></a>
		</div>
		<h1>1:1문의</h1>
	</div>
    
	<div data-role="content" class="board_wright_content">
		<h6>문의 내용</h6>
		<textarea id="board_content" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}">문의하실 내용을 입력해주세요.</textarea>		
		<p>빠른 답변을 받고 싶으신 분은 휴대폰 번호를 입력해주세요.</p>
		<p>1:1 문의에서 수집된 정보는 문의 답변 완료 후 자동으로 삭제됩니다.</p>
		<div class="ui-grid-a advertise_wright_tel"> 
		    <div class="ui-block-a">
				<p style="color:#000;">연락처</p>
		    </div> 
		    <div class="ui-block-b">
				<div class="ui-grid-d input_align"> 
				    <div class="ui-block-a" style="width:20% !important; padding:0;">
						<input type="tel" id="board_phone01" maxlength="4" value="" onKeyUp="next_focus('board_phone01','board_phone02',3);" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
								onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" style="padding:.2em .4em .4em .4em;">
    					</div> 
				    <div class="ui-block-b" style="width:5% !important; padding:0;">
				    	<p style="margin:1.2em 0 0 0;">-</p>
				    </div> 
				    <div class="ui-block-c" style="width:20% !important; padding:0;">
						<input type="tel" id="board_phone02" maxlength="4" value="" onKeyUp="next_focus('board_phone02','board_phone03',4);" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
								onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}">
			    	</div> 
				    <div class="ui-block-d" style="width:5% !important; padding:0;">
				    	<p style="margin:1.4em 0 0 0;">-</p>
			    	</div> 
				    <div class="ui-block-e" style="width:20% !important; padding:0;">
						<input type="tel" id="board_phone03" maxlength="4" value="" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
								onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}">
			    	</div> 
				</div>
		    </div> 
		</div>
		<p>1:1문의하기 운영시간 평일 오전 09 ~ 오후 06시입니다.</p>
		<p>운영시간 외 문의는 다음 업무일 내에 빠르게 답변드리겠습니다.</p>    
	</div>
    
	<div id="footer" data-position="fixed" class="board_footer_wright">
		<p style="font-size:14px; font-weight:normal; text-shadow:none; font-family:'godom'; margin:0; color:#fff;"id="add_Inquiry">문의 등록</p>
	</div><!-- /footer -->
	
	<div id="popupDialog" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
			<p id="dialog_txt"></p>	      		
      	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">취소</a>   
      	  	<a style="background-color:#29A9C8;" href="#"  data-ajax="false" id="confirm">확인</a>    
  	  	</div>    
    </div>
    
   <div id="popupCheck_space" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
			<p id="popupCheck_txt"></p>	      		
      	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">확인</a>   
  	  	</div>    
    </div>	
</div>
</body>
</html>