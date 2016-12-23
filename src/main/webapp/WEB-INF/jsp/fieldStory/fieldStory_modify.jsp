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
<!-- 세션 없으면 메인페이지로 강제 이동 -->
<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == null || sessionScope.sessionData.memberInfo.getMember_no() ==''}">
	<script>
		location.href="${pageContext.request.contextPath}/appMain/appMain.do";
	</script>
</c:if>
<script type="text/javascript">
$(document).ready(function (){
	$("#modify_fieldStroy").click(function(){
		var sido = $("#areaList").val();
		var gugun = $("#cityList").val();
		var title = $("#title").val();
		var content = $("#content").val();

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
				$("#dialog_txt").text("수정 하시겠습니까?");
				$("#popupDialog").popup("open");
		} 
		
	});

	$("#confirms").click(function(){
		document.fieldStoryModify.action = '<%=cp%>/fieldStory/fieldStory_dbModify.do';
		document.fieldStoryModify.submit();
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
                   var default_sido = $("#default_sido").val();
                    if(data.areaList!= null && data.areaList.length != 0){
                         var html = "<option value='"+default_sido+"'>"+default_sido+"</option>";
                        $.each(data.areaList, function (index, areaList) {
                             if(areaList.sido == default_sido){
                            	 
                             } else {
                            	 html+= " <option value='"+areaList.sido+ "'>"+areaList.sido+ "</option>" ;	 
                             }
                             
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
	
	//안드로이드 파일가져오기
	// str -> 첨부파일,사업자등록증인지 확인
	function getFile(str) {
		
		var useragent = navigator.userAgent;
		if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
			window.android.getFile(str);
		}
		else if(useragent.indexOf("Connect By iPhone OS") > -1) {
		} 	    
		else {
		    	 	
		}
	}
	function setAreaFilePath1(path, name, dest){
		//
		path = splitColon(path);
		dest = splitColon(dest);
		
		$("#android_version_chk").val("y");
		$("#fileUploadPath1").val(path);
		$("#fileNewName1").val(name);
		$("#destination1").val(dest);
	
		$("#img_preview1").attr("src","/upload/img/temp/"+ name);
		
	}
	function setAreaFilePath2(path, name, dest){
		//
		path = splitColon(path);
		dest = splitColon(dest);
		
		$("#android_version_chk").val("y");
		$("#fileUploadPath2").val(path);
		$("#fileNewName2").val(name);
		$("#destination2").val(dest);
	
		$("#img_preview2").attr("src","/upload/img/temp/"+ name);
		
	}
	function setAreaFilePath3(path, name, dest){
		//
		path = splitColon(path);
		dest = splitColon(dest);
		
		$("#android_version_chk").val("y");
		$("#fileUploadPath3").val(path);
		$("#fileNewName3").val(name);
		$("#destination3").val(dest);
	
		$("#img_preview3").attr("src","/upload/img/temp/"+ name);
		
	}
	//가라로 파일업로드 스플릿
	function splitColon(str){
		str_arr = str.split(":");
		str = str_arr[1];
	 	return str;
	}
	
	function del_img(file_no){
		var file = $("#"+file_no).val();
		var file_hidden = $("#"+file_no+"_hidden").val();
		var chk_file = "Y";
		if(file_hidden == ""){//초기이미지일 경우 hidden에 val 없음
			file_hidden = "../img/member_set/member_img_plus.jpg";
			chk_file = "N";
		}else{
			chk_file = "Y";
		}
		if(file!=""){//미리보기일 경우
			$("#img_preview"+(file_no).substring(9, 10)).attr("src", file_hidden);
			$("#area_img0"+(file_no).substring(9, 10)).val("");
			
		} else {//이미 저장된 파일일 경우
			if(chk_file=="Y"){
				
				var fs_no = $("#fs_no").val();
				
				params = "fs_no="+fs_no+"&file_no="+(file_no).substring(5, 10);

				$.ajax({
			            type        : "POST"  
			          , async       : true 
			          , url         : "/fieldStory/delCompanyFile.do"
			          , data        : params
			          , dataType    : "json" 
			          , timeout     : 30000   
			          , cache       : false
			          //, contentType : "application/x-www-form-urlencoded;charset=UTF-8"
			          , error       : function(request, status, error) {
			      	    $("#dialog_txt").text("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
						$("#popupDialog").popup("open");
			          }
			          , success     : function(data) {
			        		$("#img_preview"+(file_no).substring(9, 10)).attr("src", "../img/member_set/member_img_plus.jpg");
			  				$("#area_img0"+(file_no).substring(9, 10)).val("");
			  				$("#area_img0"+(file_no).substring(9, 10)+"_hidden").val("");
			          }
		    	});
						
			}else{
				
			}
		}
		
	}
	
</script>
</head>
<body>
<div data-role="page" class="board_page">
	<div data-role="header" data-position="fixed" class="join_header" style="background-color:#fff !important; border-bottom:solid 1px #29A9C8 !important;">
		<div class="back_btn">
			<a href="../appMain/appMain.do" data-ajax="false" class="relback_btn"><img src="../img/more/relback.gif"/></a>
		</div>
		<h1 style="background-color:#fff !important; color:#29A9C8 !important;">글쓰기</h1>
	</div>
	
	<form enctype="multipart/form-data" method="post" id="fieldStoryModify" name="fieldStoryModify">
	
	<input type="hidden" id="android_version_chk" name="android_version_chk" value="n" />	
	<div data-role="content" class="area_board_content">			
		<div class="ui-grid-b"> 
	    	<div class="ui-block-a">
				<p>지역</p> 
			</div>
	    	<div class="ui-block-b" style="width:40% !important; padding-right:.1em;">
				<select  id="areaList" name="sido" onchange="getZip_city()">
					<option value="${fieldStoryVo.sido}">${fieldStoryVo.sido}</option>
				</select>
			</div>
	    	<div class="ui-block-c" style="width:40% !important; padding-left:.1em;">
				<select id="cityList" name="gugun">
					<option value="${fieldStoryVo.gugun}">${fieldStoryVo.gugun}</option> 
				</select>
			</div>
		</div>
			
		<div class="ui-grid-a"> 
	    	<div class="ui-block-a">
				<p>제목</p> 
			</div>
	    	<div class="ui-block-b">
				<input type="text" id="title" name="title" value="${fieldStoryVo.title}">
			</div>
		</div>
			
		<div class="ui-grid-a" style="border:none;"> 
	    	<div class="ui-block-a">
				<p>내용</p> 
			</div>
	    	<div class="ui-block-b">
				 <textarea id="content" name="content" style="resize:none !important;">${fieldStoryVo.content}</textarea>
			</div>
		</div>
		
	</div>
		
	<div class="write_field" style="padding:.5em .7em;">
		<div class="ui-grid-b" style="border:solid 1px #29A9C8; background-color:#fff; padding: 0 .2em;"> 
			<p style="padding-left:.3em; font-size:14px; font-weight:normal; text-shadow:none; margin:1em 0 .5em 0;">사진첨부<span style="font-size:11px; padding-left:1em;">*최대3장 첨부가능*</span></p>
		    <div class="ui-block-a" style="text-align:center; padding:0 .3em; position:relative;">
		    	<input type="hidden" id="fileUploadPath1" name="fileUploadPath1" value=""/>
				<input type="hidden" id="fileNewName1" name="fileNewName1" value="" />
				<input type="hidden" id="destination1" name="destination1" value="" />		    
				<input type=file name="area_img_1" id="area_img01" style='display: none;'accept="image/*;capture=camera" onClick="getFile('area_img01')">
    			<c:if test="${fieldStoryVo.img01 == null || fieldStoryVo.img01 == ''}">
					<img src='../img/member_set/member_img_plus.jpg' border='0' id="img_preview1" onclick='document.getElementById("area_img01").click();' style="width:100%;">
				</c:if>
				<c:if test="${fieldStoryVo.img01 != null && fieldStoryVo.img01 != ''}">
					<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img01}" border='0' id="img_preview1" onclick='document.getElementById("area_img01").click();' style="width:100%;">
				</c:if>
				
				<div class="list_text_mark" onclick="del_img('area_img01');" style="right:6px; width: 1em;"> 
			   		<img src="../../img/del_btn.png" />
			   	</div>
		    </div> 
		    <div class="ui-block-b" style="text-align:center; padding:0 .3em; position:relative;">
		   		<input type="hidden" id="fileUploadPath2" name="fileUploadPath2" value=""/>
				<input type="hidden" id="fileNewName2" name="fileNewName2" value="" />
				<input type="hidden" id="destination2" name="destination2" value="" />		    
    			<input type=file name="area_img_2" id="area_img02" style='display: none;'accept="image/*;capture=camera" onClick="getFile('area_img02')"> 
    			<c:if test="${fieldStoryVo.img02 == null || fieldStoryVo.img02 == ''}">
					<img src='../img/member_set/member_img_plus.jpg' border='0' id="img_preview2" onclick='document.getElementById("area_img02").click();' style="width:100%;">
				</c:if>
				<c:if test="${fieldStoryVo.img02 != null && fieldStoryVo.img02 != ''}">
					<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img02}" border='0' id="img_preview2" onclick='document.getElementById("area_img02").click();' style="width:100%;">
				</c:if>
				
				<div class="list_text_mark" onclick="del_img('area_img02');" style="right:6px; width: 1em;"> 
			   		<img src="../../img/del_btn.png" />
			   	</div>
				
		    </div> 
		    <div class="ui-block-c" style="text-align:center; padding:0 .3em; position:relative;">
		   		<input type="hidden" id="fileUploadPath3" name="fileUploadPath3" value=""/>
				<input type="hidden" id="fileNewName3" name="fileNewName3" value="" />
				<input type="hidden" id="destination3" name="destination3" value="" />
    			<input type=file name="area_img_3" id="area_img03" style='display: none;'accept="image/*;capture=camera" onClick="getFile('area_img03')"> 
    			<c:if test="${fieldStoryVo.img03 == null || fieldStoryVo.img03 == ''}">
					<img src='../img/member_set/member_img_plus.jpg' border='0' id="img_preview3" onclick='document.getElementById("area_img03").click();' style="width:100%;">
				</c:if>
				<c:if test="${fieldStoryVo.img03 != null && fieldStoryVo.img03 != ''}">
					<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img03}" border='0' id="img_preview3" onclick='document.getElementById("area_img03").click();' style="width:100%;">
				</c:if>
				
				<div class="list_text_mark" onclick="del_img('area_img03');" style="right:6px; width: 1em;"> 
			   		<img src="../../img/del_btn.png" />
			   	</div>
		    </div> 
		</div>
	</div>	
	<div data-role=footer data-position="fixed" class="guide_footer">
		<div>
			<input type="button" value="수정하기" id="modify_fieldStroy">
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
    <input type="hidden" value="${fieldStoryVo.sido}" id="default_sido">
    <input type="hidden" value="${fieldStoryVo.fs_no}" name="fs_no" id="fs_no">
    
    <div>
	    <c:if test="${fieldStoryVo.img01 == null || fieldStoryVo.img01 == ''}">
			<input type="hidden" value="" id="area_img01_hidden">
		</c:if>
		<c:if test="${fieldStoryVo.img01 != null && fieldStoryVo.img01 != ''}">
			<input type="hidden" value="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img01}" id="area_img01_hidden">
		</c:if>
		
		<c:if test="${fieldStoryVo.img02 == null || fieldStoryVo.img02 == ''}">
			<input type="hidden" value="" id="area_img02_hidden">
		</c:if>
		<c:if test="${fieldStoryVo.img02 != null && fieldStoryVo.img02 != ''}">
			<input type="hidden" value="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img02}" id="area_img02_hidden">
		</c:if>
		
		<c:if test="${fieldStoryVo.img03 == null || fieldStoryVo.img03 == ''}">
			<input type="hidden" value="" id="area_img03_hidden">
		</c:if>
		<c:if test="${fieldStoryVo.img03 != null && fieldStoryVo.img03 != ''}">
			<input type="hidden" value="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img03}" id="area_img03_hidden">
		</c:if>
    </div>
    </form>
</div>
</body>
</html>