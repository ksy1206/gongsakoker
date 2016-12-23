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
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/member/memberJoin.js"></script>
<script type="text/javascript"  src="<%=cp%>/js/jquery.form.js"></script>


<script type="text/javascript">
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
                         var html = "<option value='default' >도</option>";
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
                         var html = "<option value='default'  id='default_option'>시/군/구</option>";
                        $.each(data.cityList, function (index, cityList) {
                             html+= " <option value='"+cityList.gugun+ "'>"+cityList.gugun+ "</option>" ;
                        });                        
                   $( "#cityList").html(html);
                   $( "#cityList-button span").html( "시/군/구");                        
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
                           
//                            img.style.width  = defaultOpt.w+'px';
//                            img.style.height = defaultOpt.h+'px';
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
      $('#est_img01').setPreview(opt); 
      var opt = {img: $('#img_preview2')}; 
      $('#est_img02').setPreview(opt);
      var opt = {img: $('#img_preview3')}; 
      $('#est_img03').setPreview(opt);
   });


   function insert_submit(){
      var estType02_code = $("#estType02_code").val()
      var est_sido = $("#areaList").val();
      var est_gugun = $("#cityList").val();
      var est_area = $("#est_area_1").val();
      var est_startDate = $("#est_startDate").val();
      var est_endDate = $("#est_endDate").val();
      var est_cost = $("#est_cost").val();
      var est_content = $("#estimate_content").val();
      var est_agreement = $("input:checkbox[id='est_agreement']").is(":checked") == true;
      
      if(estType02_code ==null||estType02_code ==""||estType02_code == 'undefiend'){
    	 $("#popupCheck_txt").text("시공대상을 선택해 주세요.");
    	 $("#popupCheck_space").popup("open");
         return false;
      } else if(est_sido ==null||est_sido ==""||est_sido == 'default'){
         $("#popupCheck_txt").text("지역을 선택해 주세요.");
         $("#popupCheck_space").popup("open");
         return false;
      } else if(est_gugun ==null||est_gugun ==""||est_gugun == 'default'){
         $("#popupCheck_txt").text("지역을 선택해 주세요.");
         $("#popupCheck_space").popup("open");
         return false;
      } else if(est_area ==null||est_area ==""||est_area == 'default'){
         $("#popupCheck_txt").text("시공면적을 입력해 주세요.");
         $("#popupCheck_space").popup("open");
         return false;
      } else if(est_startDate ==null||est_startDate ==""||est_startDate == 'default'){
    	  $("#popupCheck_txt").text("시공일자를 입력해 주세요.");
         $("#popupCheck_space").popup("open");
         return false;
      } else if(est_endDate ==null||est_endDate ==""||est_endDate == 'default'){
    	  $("#popupCheck_txt").text("시공일자를 입력해 주세요.");
         $("#popupCheck_space").popup("open");
         return false;
      }  else if(est_cost ==null||est_cost ==""||est_cost == 'default'){
    	  $("#popupCheck_txt").text("예상비용을 입력해 주세요.");
         $("#popupCheck_space").popup("open");
         return false;
      } else if(est_content ==null||est_content ==""||est_content == 'default'){
    	  $("#popupCheck_txt").text("상세설명을 입력해 주세요.");
         $("#popupCheck_space").popup("open");
         return false;
      } else if(est_agreement != true){
    	  $("#popupCheck_txt").text("이용약관을 동의해 주세요.");
         $("#popupCheck_space").popup("open");
         return false;
      } else {
         $("#popup_txt").text("등록하시겠습니까?");
         $("#popupCheck").popup("open");
      }
      
   }
   function confirm(){
      document.estimateWrite.action = '<%=cp%>/estimate/estimateInsert.do';
      document.estimateWrite.submit();   
   }
   
   function change_area1(){
      var area = $("#est_area_1").val();
      var area_pung = Math.ceil(area*0.3025);
      $("#est_area_2").val(area_pung);
   }
   
   function change_area2(){
      var area = $("#est_area_2").val();
      var area_pung = Math.ceil(area*3.3058);
      $("#est_area_1").val(area_pung);
   }
   
   $(function() {
	    $( "#est_startDate" ).datepicker({
	    	dateFormat : 'yy-mm-dd'
	    });
	});
   $(function() {
	    $( "#est_endDate" ).datepicker({
	    	dateFormat : 'yy-mm-dd'
	    });
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
  function setEstFilePath1(path, name, dest){
	   
		//logo
		path = splitColon(path);
		dest = splitColon(dest);
		
		$("#android_version_chk").val("y");
		$("#fileUploadPath1").val(path);
		$("#fileNewName1").val(name);
		$("#destination1").val(dest);
	
		$("#img_preview1").attr("src","/upload/img/temp/"+ name);
		
	}
  function setEstFilePath2(path, name, dest){
		//logo
		path = splitColon(path);
		dest = splitColon(dest);
		
		$("#android_version_chk").val("y");
		$("#fileUploadPath2").val(path);
		$("#fileNewName2").val(name);
		$("#destination2").val(dest);
	
		$("#img_preview2").attr("src","/upload/img/temp/"+ name);
		
	}
	function setEstFilePath3(path, name, dest){
		//logo
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
		var file_src = "../img/member_set/member_img_plus.jpg";
		if(file!=""){//미리보기일 경우
			$("#img_preview"+(file_no).substring(8, 9)).attr("src", file_src);
			$("#est_img0"+(file_no).substring(8, 9)).val("");			
		}
		
	}
	
	function est_cost_check(){
		var est_cost = $("#est_cost").val();
		if (est_cost == 0 ){
			$("#est_cost").val(0);
		} else {
			
		}
	}

</script> 
<!--파일 미리보기 END  -->
<script type="text/javascript">
function call_back(){
	location.href="<%=cp%>/estimate/mainList.do?estType01_code=1&type01=1&type02=all";	
}

</script>
</head>
<body>
<c:set var="estimate" value="${estimateVo}"/>
<div data-role="page" class="board_page" id="main">
   <div data-role="header" data-position="fixed" class="board_header" style="min-height: 36px;">
      <div class="back_btn">
         <a href="#" onclick="call_back()" data-ajax="false" class="relback_btn"><img src="../img/relback.gif"/></a>
      </div>
      <c:if test="${estimate.estType01_code == 1}">
         <h1 style="font-weight:normal; text-shadow:none; font-size:14px;">주거공간 견적의뢰</h1>
      </c:if>
      <c:if test="${estimate.estType01_code == 2}">
         <h1 style="font-weight:normal; text-shadow:none; font-size:14px;">상업공간 견적의뢰</h1>
      </c:if>
   </div>   
   
   <div data-role="content" class="est_write_content">
	   <form  enctype="multipart/form-data" method="post" id="estimateWrite" name="estimateWrite">
	   <input type="hidden" id="android_version_chk" name="android_version_chk" value="n" />	
	   	<p style="margin:0 0 .5em 0; padding-left: .3em;">시공정보</p>
	   	<div style="border:solid 1px #29A9C8; padding:0 0 .5em 0;">
	      <div class="ui-grid-a est_write_box">
	      
	      	<div style="width: 95%; border-bottom: solid #e5e5e5 1px; overflow: auto; padding:.5em;">
		         <div class="ui-block-a">
		            <p style="padding-left: .3em;">시공대상</p>
		         </div>
		         <div class="ui-block-b">
		            <c:if test="${estimate.estType01_code == 1}">
		               <select id="estType02_code" name="estType02_code">
		                  <option value="">선택해주세요</option>
		                  <option value="01">아파트</option>
		                  <option value="02">주상복합</option>
		                  <option value="03">오피스텔</option>
		                  <option value="04">빌라/연립</option>
		                  <option value="05">기타</option>
		               </select>
		            </c:if>
		            <c:if test="${estimate.estType01_code == 2}">
		               <select id="estType02_code" name="estType02_code">
		                  <option value="">선택해주세요</option>
		                  <option value="01">사무공간</option>
		                  <option value="02">식당/요리</option>
		                  <option value="03">학원/교육</option>
		                  <option value="04">병원/의료</option>
		                  <option value="05">매장/상업</option>
		                  <option value="06">체육기타</option>
		               </select>
		            </c:if>
		         </div>
	         </div>
	         
	      	<div style="width: 95%; border-bottom: solid #e5e5e5 1px; overflow: auto; padding:.5em;">
		         <div class="ui-block-a">
		            <p style="padding-left: .3em;">시공주소</p>
		         </div>
		         <div class="ui-block-b">
		         	<div class="ui-grid-a select_width_span">
		         		<div class="ui-block-a" style="width:50% !important;">
				            <select  id="areaList" name="est_sido" onchange="getZip_city()">
				               <option value="default">선택해주세요</option>           
				            </select>
		         		</div>
		         		<div class="ui-block-b" style="width:50% !important;">
				            <select id="cityList" name="est_gugun">
				               <option value="default">선택해주세요</option> 
				            </select>
		         		</div>
		         	</div>
		         </div>
	         </div>
	         
	      	<div style="width: 95%; border-bottom: solid #e5e5e5 1px; overflow: auto; padding:.5em;">
		         <div class="ui-block-a">
		            <p style="padding-left: .3em;">시공면적</p>
		         </div>
		         <div class="ui-block-b">
		         	<div class="ui-grid-b">
		        		<div class="ui-block-a" style="width:45% !important;">
				         	<div class="ui-grid-a">
				        		<div class="ui-block-a" style="width:80% !important;">
			         	  			<input type="number" name="est_area" id="est_area_1" onchange="change_area1()">
					            </div>
				        		<div class="ui-block-b" style="width:20% !important;">
				        			<p style="text-align:center;">m<sup>2</sup></p>
					            </div>
				            </div>
			            </div>
		        		<div class="ui-block-b" style="width:10% !important; padding-top:1em;">
			          	  <img src="../img/estimate/arrow.gif" style="width:100%; vertical-align:middle;" />
			            </div>
		        		<div class="ui-block-c" style="width:45% !important;">
				         	<div class="ui-grid-a">
				        		<div class="ui-block-a" style="width:80% !important;">
			            			<input type="number" name="est_area_2" id="est_area_2" onchange="change_area2()">
					            </div>
				        		<div class="ui-block-b" style="width:20% !important;">
				        			<p style="text-align:center;">평</p>
					            </div>
				            </div>
			            </div>
		            </div>
		         </div>
	         </div>
	         
	      	<div style="width: 95%; border-bottom: solid #e5e5e5 1px; overflow: auto; padding:.5em;">
		         <div class="ui-block-a">
		            <p style="padding-left: .3em;">시공일자</p>
		         </div>
		         <div class="ui-block-b">
		         	<div class="ui-grid-b">
		        		<div class="ui-block-a" style="width:45% !important;">
<!-- 		           			<input type="date" name="est_startDate" id="est_startDate"> -->
		           			<input type="text" name="est_startDate" id="est_startDate" readonly="readonly">
			            </div>
		        		<div class="ui-block-b" style="width:10% !important;">
		        			<p style="text-align:center;">~</p>
			            </div>
		        		<div class="ui-block-c" style="width:45% !important;">
<!-- 		            		<input type="date" name="est_endDate" id="est_endDate"> -->
		            		<input type="text" name="est_endDate" id="est_endDate" readonly="readonly">
			            </div>
		            </div>
		         </div>
			</div>
			
	      	<div style="width: 95%; border-bottom: solid #e5e5e5 1px; overflow: auto; padding:.5em;">
		         <div class="ui-block-a">
		            <p style="padding-left: .3em;">예상비용</p>
		         </div>
		         <div class="ui-block-b">
		         	<div class="ui-grid-a">
		        		<div class="ui-block-a" style="width:80% !important;">
		            		<input type="number" name="est_cost" id="est_cost" onchange="est_cost_check()">
			            </div>
		        		<div class="ui-block-b" style="width:20% !important;">
		        			<p style="text-align:center;">만원</p>
			            </div>
		            </div>
		         </div>
	         </div>
	         
	      	<div style="width: 95%; border-bottom: solid #e5e5e5 1px; overflow: auto; padding:.5em;">
		         <div class="ui-block-a">
		            <p style="padding-left: .3em;">상세설명</p>
		         </div>
		         <div class="ui-block-b">
		           <textarea name="estimate_content" id="estimate_content"></textarea>
		         </div>
		      </div>
	      </div>
	    
      	<div style="width: 95%; overflow: auto; padding:.5em;"> 
		    <div class="ui-grid-b">
		    	<p style="margin:0; padding-left: .3em;">사진첨부<span style="font-size:8px; margin-left:1em;">* 부적절한 이미지 업로드시 삭제될 수 있습니다.</span></p>  
		    	
			    <div class="ui-block-a" style="text-align:center; padding:0 .1em; position:relative;">
				    <input type="hidden" id="fileUploadPath1" name="fileUploadPath1" value=""/>
					<input type="hidden" id="fileNewName1" name="fileNewName1" value="" />
					<input type="hidden" id="destination1" name="destination1" value="" />
					<input type=file name="est_img_1" id="est_img01" style='display: none;'accept="image/*;capture=camera" onClick="getFile('est_img01')">
					<img src='../img/member_set/member_img_plus.jpg' style="width:100%;" border='0' id="img_preview1" onclick='document.getElementById("est_img01").click();'>
					
					<div class="list_text_mark" onclick="del_img('est_img01');" style="right:6px; width: 1em; margin-top: 0.8em;"> 
				   		<img src="../../img/del_btn.png" />
				   	</div>
					
			    </div> 
			    
			    <div class="ui-block-b" style="text-align:center; padding:0 .1em; position:relative;">
				    <input type="hidden" id="fileUploadPath2" name="fileUploadPath2" value=""/>
					<input type="hidden" id="fileNewName2" name="fileNewName2" value="" />
					<input type="hidden" id="destination2" name="destination2" value="" />
	    			<input type=file name="est_img_2" id="est_img02" style='display: none;'accept="image/*;capture=camera" onClick="getFile('est_img02')"> 
					<img src='../img/member_set/member_img_plus.jpg' style="width:100%;" border='0' id="img_preview2" onclick='document.getElementById("est_img02").click();'>
					
					<div class="list_text_mark" onclick="del_img('est_img02');" style="right:6px; width: 1em; margin-top: 0.8em;"> 
				   		<img src="../../img/del_btn.png" />
				   	</div>
					
			    </div> 
			    
			    <div class="ui-block-c" style="text-align:center; padding:0 .1em; position:relative;">
	    			<input type="hidden" id="fileUploadPath3" name="fileUploadPath3" value=""/>
					<input type="hidden" id="fileNewName3" name="fileNewName3" value="" />
					<input type="hidden" id="destination3" name="destination3" value="" />
					<input type=file name="est_img_3" id="est_img03" style='display: none;'accept="image/*;capture=camera" onClick="getFile('est_img03')"> 
	    			<img src='../img/member_set/member_img_plus.jpg' style="width:100%;" border='0' id="img_preview3" onclick='document.getElementById("est_img03").click();'>
					
					<div class="list_text_mark" onclick="del_img('est_img03');" style="right:6px; width: 1em; margin-top: 0.8em;"> 
				   		<img src="../../img/del_btn.png" />
				   	</div>
					
			    </div> 
			</div>
   	    </div>
   	      
	      <input type="hidden" name="member_no" value="${sessionScope.sessionData.memberInfo.getMember_no()}">
	      <input type="hidden" name="member_id" value="${sessionScope.sessionData.memberInfo.getMember_id()}">
	      <input type="hidden" value="${estimate.estType01_code}" name="estType01_code">
	      <input type="hidden" value="${estimate.field01}" name="field01">
	      <input type="hidden" value="${estimate.field02}" name="field02">
	      <input type="hidden" value="${estimate.field03}" name="field03">
	      <input type="hidden" value="${estimate.field04}" name="field04">
	      <input type="hidden" value="${estimate.field05}" name="field05">
	      <input type="hidden" value="${estimate.field06}" name="field06">
	      <input type="hidden" value="${estimate.field07}" name="field07">
	      <input type="hidden" value="${estimate.field08}" name="field08">
	      <input type="hidden" value="${estimate.field09}" name="field09">
	      <input type="hidden" value="${estimate.field10}" name="field10">
	      <input type="hidden" value="${estimate.field11}" name="field11">
	      <input type="hidden" value="${estimate.field12}" name="field12">
	      <input type="hidden" value="${estimate.field13}" name="field13">
	      <input type="hidden" value="${estimate.field14}" name="field14">
	      <input type="hidden" value="${estimate.field15}" name="field15">
	      <input type="hidden" value="${estimate.field16}" name="field16">
	      <input type="hidden" value="${estimate.field17}" name="field17">
	      <input type="hidden" value="${estimate.field18}" name="field18">
	      <input type="hidden" value="${estimate.field19}" name="field19">
	      <input type="hidden" value="${estimate.field20}" name="field20">
	      <input type="hidden" value="${estimate.field21}" name="field21">
	      <input type="hidden" value="${estimate.field22}" name="field22">
	      <input type="hidden" value="${estimate.field23}" name="field23">
	      
	      </div>      
	   </form>
   </div>
   
   <div style="padding:0 1em;">      
     <input type="checkbox" name="est_agreement" id="est_agreement" value="y" style="margin-top: 0;" />
		<p style="margin:0 0 0 3em; font-size: 12px; line-height: 24px;"><a href="#sub">서비스 이용약관</a>에 대해 동의합니다.</p>
     	<p style="margin: .5em 0 0 1em; font-size: 8px;">※ 콕커는 '마케팅서비스'이므로 시공에 관련된 하자는 책임지지 않습니다.</p>
   </div>
   
   <div id="popupCheck_space" class="board_footer_popup" style="max-width: 400px;" data-role="popup" data-dismissible="false" data-overlay-theme="b">
       <div class="ui-content" role="main">
         <p id="popupCheck_txt"></p>               
              <a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">확인</a>   
          </div>    
    </div>
    
    <div id="popupCheck" class="board_footer_popup" style="max-width: 400px;" data-role="popup" data-dismissible="false" data-overlay-theme="b">
       <div class="ui-content" role="main">
         <p id="popup_txt"></p>
         <a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">취소</a>
         <a style="background-color:#29A9C8;" href="#"  data-ajax="false" onclick="confirm()">완료</a>  
          </div>    
    </div>
   
   <div id="footer" data-position="fixed" class="board_footer_wright02">
      <a href="#" class="" onclick="javascript:insert_submit();" style="padding: 1em 35%;">견적의뢰</a>
   </div>
</div>

<!-- 필터 Page -->
<div data-role="page" id="sub">
	<div data-role="header" class="board_header" style="min-height: 36px;">
		<div class="back_btn">
        	<a href="#main" data-ajax="false" class="relback_btn"><img src="../img/relback.gif"/></a>
     	</div>
     	<h1 style="font-weight:normal; text-shadow:none; font-size:14px;">이용약관</h1>
	</div>

	<div data-role="content" class="est_write_content">
		<img src="../img/clause/terms1_n.png" style="width:100%;" border='0'>
	</div>
</div>
</body>
</html>