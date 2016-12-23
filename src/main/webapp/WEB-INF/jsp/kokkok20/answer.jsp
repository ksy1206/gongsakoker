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
<!-- 세션 없으면 메인페이지로 강제 이동 -->
<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == null || sessionScope.sessionData.memberInfo.getMember_no() ==''}">
	<script>
		location.href="${pageContext.request.contextPath}/appMain/appMain.do";
	</script>
</c:if>

<script type="text/javascript">

//질문하기 -> 대답등록 
function answer(qa_no){
	$("#popupAnswer").popup("open");
	var koker_no = $("#koker_no").val();
	$("#confirm").click(function(){
		var qa_content = $("#qa_answer_content").val();
		var qa_name = $("#qa_name").val();
		var member_no = $("#member_no").val();
		var koker_no = $("#koker_no").val();		
		params = "qa_question_no="+qa_no+"&qa_name="+qa_name+"&qa_content="+qa_content+"&member_no="+member_no+"&koker_no="+koker_no;
		$.ajax({
	        type        : "POST"  
	      , async       : false 
	      , url         : "/kokkok20/add_answer.do"
	      , data        : params
	      , dataType    : "json" 
	      , timeout     : 30000   
	      , cache       : false     
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
				alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
	      }
	      , success     : function(data) {
	    	  var count = $("#backCount").val();		    	  		    	  
	    	  var backCount = Number(count)+1;
	    	  location.href="${pageContext.request.contextPath}/kokkok20/answer.do?koker_no="+koker_no+"&backCount="+backCount;
	      }
		});	
	});
	
}

//대답 -> 수정
function answer_modify(qa_content, qa_no){
	$("#qa_modify").val(qa_content);
	$("#popupModify").popup("open");
	$("#modify").click(function(){
		var qa_content = $("#qa_modify").val();
		var koker_no = $("#koker_no").val();
		params = "qa_content="+qa_content+"&qa_no="+qa_no;
		 $.ajax({
		        type        : "POST"  
		      , async       : false 
		      , url         : "/kokkok20/modify_qaQuestion.do"
		      , data        : params
		      , dataType    : "json" 
		      , timeout     : 30000   
		      , cache       : false     
		      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		      , error       : function(request, status, error) {
					alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
		      }
		      , success     : function(data) {
		    	  var count = $("#backCount").val();		    	  		    	  
		    	  var backCount = Number(count)+1;
		    	  location.href="${pageContext.request.contextPath}/kokkok20/answer.do?koker_no="+koker_no+"&backCount="+backCount;
		      }
	    	});			
	});
}

//대답 -> 삭제
function answer_delete(qa_no){
$("#popupDelete").popup("open");
$("#delete").click(function(){
	var koker_no = $("#koker_no").val();
	params = "qa_no="+qa_no;
	 $.ajax({
	        type        : "POST"  
	      , async       : false 
	      , url         : "/kokkok20/delete_qaQuestion.do"
	      , data        : params
	      , dataType    : "json" 
	      , timeout     : 30000   
	      , cache       : false     
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
				alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
	      }
	      , success     : function(data) {
	    	  var count = $("#backCount").val();		    	  		    	  
	    	  var backCount = Number(count)+1;
	    	  location.href="${pageContext.request.contextPath}/kokkok20/answer.do?koker_no="+koker_no+"&backCount="+backCount;
	      }
    	});	
});
}

function call_back(){
	var backCount = $("#backCount").val();
	backCount = Number(backCount);
	backCount = backCount*2-1
	history.go(-backCount);
}

</script>
</head>
<body>
<div data-role="page" class="koker_page" style="background-color:#E3E3E3 !important;">
	<div data-role="header" data-position="fixed" class="join_header" style="background-color:#fff !important; border-bottom:solid #29A9C8 1px !important;">
		<div class="back_btn">
			<a href="#" data-ajax="false" class="relback_btn" onclick="call_back()"><img src="../img/more/relback.gif"/></a>
		</div>
		<h1 style="background-color:#fff !important; color:#000 !important;">질문 답변</h1>		
	</div>
	
	<input type="hidden" value="${koker_no}" id="koker_no" >
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getName() }" id="qa_name" >
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no() }" id="member_no" >
	<input type="hidden" value="${backCount}" id=backCount>
	
	<div data-role="content" class="chat_content">
		<c:forEach var="data" items="${qa_question_list }">
			<c:if test="${data.qa_answer == 'N' }">
				<div class="ui-grid-a chat_group">
					<div class="ui-block-a chat_grid_a">
						<img src="../img/more/chat_icon.gif" width="100%" />
						<p>${data.qa_name}</p>
					</div>
					<div class="ui-block-b chat_grid_b">
						<div class="question">
							<div class="question_bg">
								<textarea readonly="readonly">${data.qa_content }</textarea>
							</div>
						</div>
						<div class="data_size">
							<p>${data.qa_date }</p>
							<p style="padding-top:1em; padding-right:2em;"><a href="#" onclick="answer('${data.qa_no }')">답변하기</a></p>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${data.qa_answer == 'Y' }">
				<div class="chat_group">
					<div class="answer">
						<div class="answer_bg">
							<textarea readonly="readonly">${data.qa_content }</textarea>						
						</div>	
					<div class="data_size">
						<p>${data.qa_date }</p>
						<div class="ui-grid-b" style=" padding-top:.5em; padding-right:0;">
							<p class="ui-block-a" style="width:50%;"></p>
							<a class="ui-block-b" onclick="answer_modify('${data.qa_content }','${data.qa_no }')" style="width:20%;">수정</a>
							<a class="ui-block-c" onclick="answer_delete('${data.qa_no }')" style="background-color:#29A9C8; color:#fff !important; border:solid #29A9C8 1px; width:20%;">삭제</a>	
						</div>
					</div>
					</div>
				</div>	
			</c:if>
		</c:forEach>	
	</div>
	
	 <div id="popupAnswer" style="max-width:400px;" data-role="popup" data-overlay-theme="b" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<textarea col="100" row="100" id="qa_answer_content"></textarea>   		
	      	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false" >취소</a>   
	      	<a style="background-color:#29A9C8;" href="#"  data-ajax="false" id="confirm">답변완료</a>    
	  	</div>    
	 </div> 
	 
	  	<div id="popupModify" style="max-width:400px;" data-role="popup" data-overlay-theme="b" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<textarea col="100" row="100" id="qa_modify"></textarea>   		
	      	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false" >취소</a>   
	      	<a style="background-color:#29A9C8;" href="#"  data-ajax="false" id="modify">수정</a>    
	  	</div>    
	 </div> 
	 
	 <div id="popupDelete" style="max-width:400px;" data-role="popup" data-overlay-theme="b" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<p>정말 삭제하시겠습니까?</p>  		
	      	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false" >취소</a>   
	      	<a style="background-color:#29A9C8;" href="#"  data-ajax="false" id="delete">삭제</a>    
	  	</div>    
	 </div>

</div>
</body>
</html>