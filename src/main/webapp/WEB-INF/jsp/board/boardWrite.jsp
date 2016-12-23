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
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/member/memberJoin.js"></script>
<script type="text/javascript"  src="<%=cp%>/js/jquery.form.js"></script>



<script type="text/javascript">
$(document).ready(function (){
	$("#add_areaBoard").click(function(){
		var category = $("#category").val();
		var sido = $("#areaList").val();
		var gugun = $("#cityList").val();
		var title = $("#title").val();
		var content = $("#content").val();		

		if(category==null||category==""){
			$("#popupCheck_txt").text("말머리를 입력해주세요.");
			$("#popupCheck_space").popup("open");
			$("#category").focus();
			return false;			
		}
		if(sido ==null||sido ==""||sido == 'default'){
			$("#popupCheck_txt").text("지역을 선택해 주세요.");
			$("#popupCheck_space").popup("open");
			$("#company_addr").focus();
			return false;			
		}
		if(gugun ==null||gugun ==""||gugun == 'default'){
			$("#popupCheck_txt").text("세부 지역을 선택해 주세요.");
			$("#popupCheck_space").popup("open");
			$("#company_addr").focus();
			return false;			
		}
		if(title ==null||title ==""||title == undefined||title =="제목을 입력해주세요."){
			$("#popupCheck_txt").text("제목을 입력해주세요.");
			$("#popupCheck_space").popup("open");
			$("#company_addr").focus();
			return false;			
		}
		if(content ==null||content ==""||content == undefined||content =="내용을 입력해주세요."){
			$("#popupCheck_txt").text("내용을 입력해주세요.");
			$("#popupCheck_space").popup("open");
			$("#company_reason").focus();
			return false;			
		} else {
				$("#dialog_txt").text("등록 하시겠습니까?");
				$("#popupDialog").popup("open");
		} 
		
	});

	$("#confirms").click(function(){
		alert("123");
		document.boardWrite.action = '<%=cp%>/areaBoard/add_areaBoard.do';
		document.boardWrite.submit();
	});
});

window.onload=function getZip_area(){
    $.ajax({
           type        : "POST" 
         , async       : false
         , url         : "/member/getZip_area.do"
        
         , dataType    : "json"
         , timeout     : 30000  
         , cache       : false    
         , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
         , error       : function(request, status, error) {
          $( "#dialog_txt").text( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );
                   $( "#popupDialog").popup( "open");
             
         }
         , success     : function(data) {
                   
                    if(data.areaList!= null && data.areaList.length != 0){
                         var html = "<option value='default' >시 / 도를 선택해주세요.</option>";
                        $.each(data.areaList, function (index, areaList) {
                             
                             html+= " <option value='"+areaList.sido+ "'>"+areaList.sido+ "</option>" ;
                        });
                         //alert(html );
                        $( "#areaList").html(html);
                   } else{
                   }
         }
  });
   
}

function getZip_city(){
var sido = $( "#areaList option:selected").val();
    $.ajax({
           type        : "POST" 
         , async       : false
         , url         : "/member/getZip_city.do"
         , data        : "sido=" + sido
         , dataType    : "json"
         , timeout     : 30000  
         , cache       : false    
         , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
         , error       : function(request, status, error) {
          $( "#dialog_txt").text( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );
                   $( "#popupDialog").popup( "open");
                   
         }
         , success     : function(data) {                   
                    if(data.cityList!= null && data.cityList.length != 0){
                         var html = "<option value='default'  id='default_option'>구 / 군을 선택해주세요.</option>";
                        $.each(data.cityList, function (index, cityList) {
                             html+= " <option value='"+cityList.gugun+ "'>"+cityList.gugun+ "</option>" ;
                        });                        
                   $( "#cityList").html(html);
                   $( "#cityList-button span").html( "구 / 군을 선택해주세요.");                        
                   } else{
                	   
                   }
         }
  });
}
</script>

<!-- 파일 미리보기 -->
 <script type="text/javascript"> 
 
	$.fn.setPreview = function(opt){
	
 		"use strict"   
 		var defaultOpt = {         
 				inputFile: $(this),img: null};
				$.extend(defaultOpt, opt);
				var previewImage = function(){         
					if (!defaultOpt.inputFile || !defaultOpt.img) return;
					
					var inputFile = defaultOpt.inputFile.get(0);
					var img = defaultOpt.img.get(0);
					// FileReader
					if (window.FileReader) {
						
						// image 파일만 
						if (!inputFile.files[0].type.match(/image\//)) return;
						// preview             
							try { 
								var reader = new FileReader();
								reader.onload = function(e){
									img.src = e.target.result;
									
// 									img.style.width  = defaultOpt.w+'px';
// 									img.style.height = defaultOpt.h+'px';
									img.style.display = '';
									}
								reader.readAsDataURL(inputFile.files[0]);
							} catch (e) {
								// exception...  
								}        
							// img.filters (MSIE) 
					}   
				};      
					// onchange    
		$(this).change(function(){ 
			previewImage();
		});
					
	};  //end 이미지 미리보기
	
	//이미지가 바뀔때마다 타는 함수
	$(document).ready(function(){		
		var opt = {img: $('#img_preview1')}; 
		$('#area_img01').setPreview(opt); 
		var opt = {img: $('#img_preview2')}; 
		$('#area_img02').setPreview(opt);
		var opt = {img: $('#img_preview3')}; 
		$('#area_img03').setPreview(opt);
	});
</script>
</head>
<body>
<div data-role="page" class="board_page">
	<div data-role="header" data-position="fixed" class="join_header" style="background-color:#fff !important; border-bottom:solid 1px #29A9C8 !important;">
		<div class="back_btn">
			<a href="../appMain/appMain.do" data-ajax="false" class="relback_btn"><img src="../img/more/relback.gif"/></a>
		</div>
		<h1 style="background-color:#fff !important; color:#29A9C8 !important;">글쓰기</h1>
		<div>
			<input type="button" value="등록하기" id="add_areaBoard">
		</div>
	</div>
	
	<form enctype="multipart/form-data" method="post" id="boardWrite" name="boardWrite">
	
	<div data-role="content" class="area_board_content">
		<div class="ui-grid-a"> 
	    	<div class="ui-block-a">
				<p>말머리</p>	
			</div>	
	    	<div class="ui-block-b">
				<select id="category" name="category">
					<option value="">카테고리를 선택해주세요</option>
					<option value="1">현장스토리</option>
					<option value="2">스터디모임</option>
				</select>
			</div>
		</div>
			
		<div class="ui-grid-b"> 
	    	<div class="ui-block-a">
				<p>지역</p> 
			</div>
	    	<div class="ui-block-b" style="width:40% !important; padding-right:.1em;">
				<select  id="areaList" name="sido" onchange="getZip_city()">
					<option value="default">시 / 도를 선택해주세요.</option>			  
				</select>
			</div>
	    	<div class="ui-block-c" style="width:40% !important; padding-left:.1em;">
				<select id="cityList" name="gugun">
					<option value="default">구 / 군을 선택해주세요.</option> 
				</select>
			</div>
		</div>
			
		<div class="ui-grid-a"> 
	    	<div class="ui-block-a">
				<p>제목</p> 
			</div>
	    	<div class="ui-block-b">
				<input type="text" id="title" name="title" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="제목을 입력해주세요.">
			</div>
		</div>
			
		<div class="ui-grid-a" style="border:none;"> 
	    	<div class="ui-block-a">
				<p>내용</p> 
			</div>
	    	<div class="ui-block-b">
				 <textarea id="content" name="content" style="resize:none !important;" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}"></textarea>
			</div>
		</div>
		
	</div>

<!-- 		<table> -->
<!-- 			<tr> -->
<!-- 				<td colspan="3">사진첨부</td> -->
<!-- 			</tr> -->
<!-- 			<tr>	 -->
<!-- 				<td style="width:33%;"> -->
<!-- 					<input type="file" name="area_img_1" id="area_img01"/> -->
<!-- 					<img id="img_preview1" style="display:none;" /> -->
<!-- 				</td> -->
<!-- 				<td style="width:33%;"> -->
<!-- 					<input type="file" name="area_img_2" id="area_img02"/> -->
<!-- 					<img id="img_preview2" style="display:none;" /> -->
<!-- 				</td> -->
<!-- 				<td style="width:33%;"> -->
<!-- 					<input type="file" name="area_img_3" id="area_img03"/> -->
<!-- 					<img id="img_preview3" style="display:none;" /> -->
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 		</table> -->
		
		<div class="ui-grid-b"> 
			    <div class="ui-block-a" style="text-align:center;">
					<input type=file name="area_img_1" id="area_img01" style='display: none;'accept="image/*;capture=camera">
					<img src='../img/member_set/member_img_plus.jpg' border='0' id="img_preview1" accept="image/*" capture="camera" onclick='document.getElementById("area_img01").click();'>
			    </div> 
			    <div class="ui-block-b" style="text-align:center;">
	    			<input type=file name="area_img_2" id="area_img02" style='display: none;'accept="image/*;capture=camera"> 
					<img src='../img/member_set/member_img_plus.jpg' border='0' id="img_preview2" onclick='document.getElementById("area_img02").click();'>
			    </div> 
			    <div class="ui-block-c" style="text-align:center;">
	    			<input type=file name="area_img_3" id="area_img03" style='display: none;'accept="image/*;capture=camera" > 
					<img src='../img/member_set/member_img_plus.jpg' border='0' id="img_preview3" onclick='document.getElementById("area_img03").click();'>
			    </div> 
			</div>
	
	<div id="popupDialog" class="board_footer_popup" style="max-width: 400px; box-shadow:0 0 0 #fff !important;" data-role="popup" data-overlay-theme="b" data-dismissible="false">
	    <div class="ui-content" role="main">
			<p id="dialog_txt"></p>	      		
     	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">취소</a>   
     	  	<a style="background-color:#29A9C8;" href="#"  data-ajax="false" id="confirms">완료</a>    
	   	</div>    
	 </div>	

	
	<div id="popupCheck_space" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
			<p id="popupCheck_txt"></p>	      		
      	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">확인</a>   
  	  	</div>    
    </div>
    
    <input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="session_member_no" name="member_no">
    <input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_id()}" id="session_member_id" name="member_id">
    </form>
</div>
</body>
</html>