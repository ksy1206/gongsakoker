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
		$("#add_company").click(function(){
			var company_name =$("#company_name").val();
			var company_addr =$("#company_addr").val();
				var company_tel01 = $("#company_tel01").val();
				var company_tel02 = $("#company_tel02").val();
				var company_tel03 = $("#company_tel03").val();
			var company_tel = company_tel01+company_tel02+company_tel03;
			var company_reason = $("#company_reason").val();

			if(company_name==null||company_name==""||company_name== undefined||company_name=="업체명 또는 기술자 이름을 입력해주세요."){
				$("#popupCheck_txt").text("업체명 또는 기술자 이름을 입력해주세요.");
				$("#popupCheck_space").popup("open");
				$("#company_name").focus();
				return false;			
	   		}
			if(company_addr==null||company_addr==""||company_addr== undefined||company_addr=="업체 주소를 입력해주세요."){
				$("#popupCheck_txt").text("업체 주소를 입력해주세요.");
				$("#popupCheck_space").popup("open");
				$("#company_addr").focus();
				return false;			
	   		}
			if(company_tel01==null||company_tel01==""||company_tel01== undefined){
				$("#popupCheck_txt").text("업체 전화번호를 입력해주세요.");
				$("#popupCheck_space").popup("open");
				$("#company_tel").focus();
				return false;	   	
	   		}
			if(company_tel02==null||company_tel02==""||company_tel02== undefined){
				$("#popupCheck_txt").text("업체 전화번호를 입력해주세요.");
				$("#popupCheck_space").popup("open");
				$("#company_tel").focus();
				return false;	   	
	   		}
			if(company_tel03==null||company_tel03==""||company_tel03== undefined){
				$("#popupCheck_txt").text("업체 전화번호를 입력해주세요.");
				$("#popupCheck_space").popup("open");
				$("#company_tel").focus();
				return false;	   	
	   		}
			if(company_reason==null||company_reason==""||company_reason== undefined||company_reason=="ex)사장님이 너무 친절해요.시공 후 깔끔하게 뒷처리까지 잘해주셨어요."){
				$("#popupCheck_txt").text("추천 내용을 입력해 주세요.");
				$("#popupCheck_space").popup("open");
				$("#company_reason").focus();
				return false;			
	   		} else {
   				$("#dialog_txt").text("등록 하시겠습니까?");
   				$("#popupDialog").popup("open");
   			} 
		});
		
		$("#confirm").click(function(){
			var company_name =$("#company_name").val();
			var company_addr =$("#company_addr").val();
			var company_tel01 = $("#company_tel01").val();
			var company_tel02 = $("#company_tel02").val();
			var company_tel03 = $("#company_tel03").val();
		var company_tel = company_tel01+company_tel02+company_tel03;
			var company_reason = $("#company_reason").val();
			var member_no = $("#sessionMember_no").val();
			var member_id = $("#sessionMember_id").val();
			var params = "company_name="+company_name+"&company_addr="+company_addr+"&company_tel="+company_tel+"&company_reason="+company_reason+"&member_no="+member_no+"&company_recommender="+member_id;			
			$.ajax({
		        type        : "POST"  
		      , async       : false 
		      , url         : "<%=cp%>/addController/addCompanyDb.do"
		      , data        : params
		      , dataType    : "json" 
		      , timeout     : 30000   
		      , cache       : false     
		      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		      , error       : function(request, status, error) {
					alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
		      }
		      , success     : function(data) {
		    	  location.href="${pageContext.request.contextPath}/addController/add_company_complete.do";
		      }
	    	});
		});		
	});
	
</script> 
</head>
<body>

<div data-role="page" class="board_page add_company_page">
	<div data-role="header" data-position="fixed" class="board_header">
		<div class="back_btn">
			<a href="#" data-ajax="false" data-rel="back" class="relback_btn"><img src="../img/relback.gif"/></a>
		</div>
		<h1>업체등록요청</h1>
	</div>
	
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no() }" id="sessionMember_no">
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_id() }" id="sessionMember_id">
	<div data-role="content" class="add_company_content">
		<img src="../../img/board/add_company_img.gif" width="100%" />
		<div class="add_company_content_table">
			<div class="ui-grid-a">
		    	<div class="ui-block-a">
					<p>업체명 </p>
				</div>
		    	<div class="ui-block-b">
					<input type="text" id="company_name" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="업체명 또는 기술자 이름을 입력해주세요.">
				</div>
			</div>
			<div class="ui-grid-a">
		    	<div class="ui-block-a">
					<p>업체주소</p> 
				</div>
		    	<div class="ui-block-b">
					<input type="text" id="company_addr" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="업체 주소를 입력해주세요.">
				</div>
			</div>
			<div class="ui-grid-a">
		    	<div class="ui-block-a">
					<p>전화번호</p> 
				</div>
			     <div class="ui-grid-d input_align"> 
				    <div class="ui-block-a" style="width:20% !important; padding:0;">
						<input type="tel" id="company_tel01" maxlength="4" value="" onKeyUp="next_focus('company_tel01','company_tel02',3);" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
								onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" style="padding:.2em .4em .4em .4em;">
    					</div> 
				    <div class="ui-block-b" style="width:5% !important; padding:0;">
				    	<p style="margin:1.2em 0 0 0;">-</p>
				    </div> 
				    <div class="ui-block-c" style="width:20% !important; padding:0;">
						<input type="tel" id="company_tel02" maxlength="4" value="" onKeyUp="next_focus('company_tel02','company_tel03',4);" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
								onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}">
			    	</div> 
				    <div class="ui-block-d" style="width:5% !important; padding:0;">
				    	<p style="margin:1.4em 0 0 0;">-</p>
			    	</div> 
				    <div class="ui-block-e" style="width:20% !important; padding:0;">
						<input type="tel" id="company_tel03" maxlength="4" value="" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
								onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}">
			    	</div> 
				</div>
			</div>
			<div class="ui-grid-a" style="border:0;">
		    	<div class="ui-block-a">
					<p>추천내용</p> 
				</div>
		    	<div class="ui-block-b">
					<textarea id="company_reason" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}">ex)사장님이 너무 친절해요.
																														시공 후 깔끔하게 뒷처리까지 잘해주셨어요.</textarea>
				</div>
			</div>
		</div>
		<p style="font-size:11px; text-shadow:none !important;">※ 요청 접수 후 섭외까지 약간의 시간이 소요됩니다. </p>
	</div>	
	
	<div data-role=footer data-position="fixed" class="guide_footer">
		<input type="button" value="등록하기" id="add_company">
	</div>
	
	<div id="popupDialog" class="board_footer_popup" data-position-to="window" style="max-width: 400px; box-shadow:0 0 0 #fff !important;" data-role="popup" data-overlay-theme="b" data-dismissible="false">
	    <div class="ui-content" role="main">
			<p id="dialog_txt"></p>	      		
     	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">취소</a>   
     	  	<a style="background-color:#29A9C8;" href="#"  data-ajax="false" id="confirm">완료</a>    
	   	</div>    
	 </div>
	 
	 <div id="popupCheck_space" class="board_footer_popup" data-position-to="window" style="max-width: 400px; box-shadow:0 0 0 #fff !important;" data-role="popup" data-overlay-theme="b" data-dismissible="false">
    	<div class="ui-content" role="main">
			<p id="popupCheck_txt"></p>	      		
      	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">확인</a>   
  	  	</div>    
    </div>
</div>
</body>
</html>