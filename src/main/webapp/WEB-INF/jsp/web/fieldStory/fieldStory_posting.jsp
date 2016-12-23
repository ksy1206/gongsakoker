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
<link rel="stylesheet" href="../css/field_posting.css">
<link rel="stylesheet" href="../css/alertify.core.css" />
<link rel="stylesheet" href="../css/alertify.default.css" id="toggleCSS" />
<script src="../js/web/alertify.min.js"></script>

<title>공사 KOKER</title>

<link rel="stylesheet" href="../css/alertify.default.css"/>


<script type="text/javascript">
$(document).ready(function (){
	$("#write_fieldStroy").click(function(){
		var sido = $("#areaList").val();
		var gugun = $("#cityList").val();
		var title = $("#title").val();
		var content = $("#content").val();
		
		if(sido ==null||sido ==""||sido == 'default'){
			alertify.alert("지역을 선택해 주세요.");
			return false;			
		}
		if(gugun ==null||gugun ==""||gugun == 'default'){
			alertify.alert("세부 지역을 선택해 주세요.");
			return false;			
		}
		if(title ==null||title ==""||title == undefined||title =="제목을 입력해주세요."){
			alertify.alert("제목을 입력해주세요.");
			return false;			
		}
		if(content ==null||content ==""||content == undefined||content =="내용을 입력해주세요."){
			alertify.alert("내용을 입력해 주세요");
			return false;			
		} else {    
			alertify.confirm("등록 하시겠습니까?", function (e) {
				if (e) {
					alertify.success("확인");
					document.fieldStoryWrite.action = '<%=cp%>/fieldStory_web/fieldStory_web_write.do';
					document.fieldStoryWrite.submit();
				} else {
					alertify.error("취소");
				}
			});
			return false;
		};	
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
                        $( "#areaList").html(html);
                   } else{}
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

<style type="text/css">
#write_fieldStroy alert {
background-color:#000;}
</style>

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
	
	<div class="board_content">
		<div class="field_posting">
			<div class="field_posting_title">
				<h1>현장스토리 글 쓰기</h1>
			</div>
			
			<form enctype="multipart/form-data" method="post" id="fieldStoryWrite" name="fieldStoryWrite">
						
			<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="session_member_no" name="member_no">
		    <input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_id()}" id="session_member_id" name="member_id">
			
			<div class="board_sub_title">
				<h2 style="float:left;">지역</h2> 
			    <p style="line-height: 48px;">
				<select  id="areaList" id="sido" name="sido" onchange="getZip_city()"  >
					<option value="default">시 / 도를 선택해주세요.</option>			  
				</select>
				<select id="cityList" id="gugun" name="gugun">
					<option value="default">구 / 군을 선택해주세요.</option> 
				</select>
				</p> 
			</div>
						
			<div class="field_posting_posttitle">
				<h2 style="float:left;">제목</h2>
				<input type="text" placeholder="제목을 입력해주세요." id="title" name="title" >
			</div>
			<div class="field_posting_content">
				<h2>내용</h2>
<!-- 				<input type="text" placeholder="내용을 입력해주세요." id="content" name="content"> -->
				<textarea id="content" name="content" style="">내용을 입력해주세요.</textarea>
			</div>
			<div class="field_posting_photo">
				<h2>사진 첨부<span>*최대 3장 첨부 가능*</span></h2>
				<div>
					<input type=file name="area_img_1" id="area_img01" style='display: none;'accept="image/*;capture=camera">
					<img src="<%=cp %>/img/local/photo_appending.png" id="img_preview1" accept="image/*" capture="camera" onclick='document.getElementById("area_img01").click();'>
					<input type=file name="area_img_2" id="area_img02" style='display: none;'accept="image/*;capture=camera"> 
					<img src="<%=cp %>/img/local/photo_appending.png" id="img_preview2" onclick='document.getElementById("area_img02").click();'>
					<input type=file name="area_img_3" id="area_img03" style='display: none;'accept="image/*;capture=camera" > 
					<img src="<%=cp %>/img/local/photo_appending.png" id="img_preview3" onclick='document.getElementById("area_img03").click();'>
				</div>
			</div>
			
			</form>
			
			<div class="field_posting_btn">
				<span>취소</span>
				<span id="write_fieldStroy">등록</span>
			</div>
		</div>
	</div>
	
	<div class="footer_wrap">
			<jsp:include page="../../web/include/footer.jsp"/>
	</div>
	
	
</body>
</html>