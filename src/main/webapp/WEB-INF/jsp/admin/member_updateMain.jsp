<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<link rel="stylesheet"href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.11.3.min.js" ></script >
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>   
<script type="text/javascript"  src="<%=cp%>/js/jquery.form.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- 파일 미리보기 -->
 <script> 
 
 	$.fn.setPreview = function(opt){
 		"use strict"   
 		var defaultOpt = {         
 				inputFile: $(this),
 				img: null,w:200,h: 200};
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
									img.style.width  = defaultOpt.w+'px';
									img.style.height = defaultOpt.h+'px';
									img.style.display = '';
									}
								reader.readAsDataURL(inputFile.files[0]);
							} catch (e) {
								// exception...  
								}        
							// img.filters (MSIE) 
					} else if (img.filters) {
						inputFile.select();             
						inputFile.blur(); 
						var imgSrc = document.selection.createRange().text; 
						img.style.width  = defaultOpt.w+'px';  
						img.style.height = defaultOpt.h+'px';  
						img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";
						img.style.display = '';  
						// no support         
					} else {
						// Safari5, ...       
					}     
				};      
					// onchange    
		$(this).change(function(){ 
			previewImage();
		}); 
	};   
	
	//이미지가 바뀔때마다 타는 함수
	$(document).ready(function(){    
		var opt1 = {img: $('#img_preview1'), w: 200, h: 200}; 
		var opt2 = {img: $('#img_preview2'), w: 200, h: 200};
		$('#company_paper1').setPreview(opt1); 
		$('#company_paper2').setPreview(opt2); 
	});
	
</script> 
<!--파일 미리보기 END  -->
<script type="text/javascript">
	
	
	
	/* $(function() {
		$("#start_date").datepicker({
			dateFormat : 'yy-mm-dd'
		});
		$("#end_date").datepicker({
			dateFormat : 'yy-mm-dd'
		});
	}); */
	
	
	//위도 경도 구하기
	var geocoder = new google.maps.Geocoder(); 
	function getLocation() {
		
		var address = $('#testAddr01').val() + " " + $('#testAddr02').val();
	
		geocoder.geocode({'address': address}, function(results, status) {
			
			if( status == google.maps.GeocoderStatus.OK ) {  
				
				if (results.length == 1) {
					
					var location = "" + results[0].geometry.location;
					
					location = location.substring(1, location.length-1);
					
					var array_data = location.split(", ");
				    
					var latitude = array_data[0];
					var longitude = array_data[1];
					
					$('#latitude').val(latitude);
					$('#longitude').val(longitude);
					
				} else {
					
					alert(results.length + "개의 결과를 찾았습니다.");
					
				}
				
			} else {
				
				alert('실패.');
				
			}
			
		}); 
		
	}
	
	$(document).ready(function(){
		
		var str = $("#classSelect option:selected").val();

		$.ajax({
			type        : "POST"
				, url         : "memberCodeList.do"
				, data        : "class_code=" + str
				, dataType    : "json" 
				, timeout     : 30000      
				, contentType : "application/x-www-form-urlencoded;charset=UTF-8"
				, error       : function(request, status, error) {
					alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
				}
				, success : function(data) {
					var html = "";
					html+="<div style='padding:1em; width:95%; height: 200px; margin-left:1%; border:solid 1px #666;'>";
					$.each(data.kokerCodeList, function(index, codeList) {

			    		//alert(codeList.category);

						html+="<div style='width:20%; float:left;'><input type='checkbox' class='caCode' id='code_ca"+(codeList.category)+"' value='"+(codeList.category)+"'/><label for='code_ca"+(codeList.category)+"'>"+codeList.code_name+"</label></div>";
						
					});
					html+="</div>";
					$("#code02_view").html(html).trigger("create");
					
					var chk_yn;
					for ( var i =1; i<41; i++ ) {
						if (i<10) {
							chk_yn = $('#ca0'+i).val();
							if (chk_yn == 'y' ) {
								$('#code_ca0'+i).prop('checked', true);
							}
						} else if (i>=10) {
							chk_yn = $('#ca'+i).val();
							if (chk_yn == 'y' ) {
								$('#code_ca'+i).prop('checked', true);
							}
						}
					}
					
					if(str==02 || str==04|| str==05|| str==06 || str == 07){
						
						$("#businessRegister").css("display", "");
						$("#register").css("display", "none");
						if(str==05 || str==06){
							
							$("#register").css("display", "");
							
						}
					
					}else{
						$("#businessRegister").css("display", "none");
						$("#register").css("display", "none");
					}
					
				}
				
		});
		
		//회원코드 바뀌면  카테고리도 바뀜
		$("#classSelect").change(function(){
			
			str = $("#classSelect option:selected").val();
			
			$.ajax({
				type        : "POST"
				, url         : "memberCodeList.do"
				, data        : "class_code=" + str
				, dataType    : "json" 
				, timeout     : 30000      
				, contentType : "application/x-www-form-urlencoded;charset=UTF-8"
				, error       : function(request, status, error) {
					alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
				}
				, success : function(data) {
					var html = "";
					resetCa();
					html+="<div style='padding:1em; width:95%; height: 200px; margin-left:1%; border:solid 1px #666;'>";
					$.each(data.kokerCodeList, function(index, codeList) {

						html+="<div style='width:20%; float:left;'><input type='checkbox' class='caCode' id='code_ca"+(codeList.category)+"' value='"+(codeList.category)+"'/><label for='code_ca"+(codeList.category)+"'>"+codeList.code_name+"</label></div>";
						
					});
					html+="</div>";
					$("#code02_view").html(html).trigger("create");
					
					if(str==02 || str==04|| str==05|| str==06 || str==07){
						
						$("#businessRegister").css("display", "");
						$("#register").css("display", "none");
						if(str==05 || str==06){
							
							$("#register").css("display", "");
							
						}
					
					}else{
						$("#businessRegister").css("display", "none");
						$("#register").css("display", "none");
					}
					
				}
			   		
			});

		});
		
		
		//유료회원 사용 유무 변경에 따른 기능
		$("#charge_yn").change(function(){
			
			var day = new Date();
			var start_date_default = $('#start_date_default').val();
			var end_date_default = $('#end_date_default').val();
			//alert(day.setDate(day.getDate() + 30));
			
			//자동 계산 들어갈시 시분초를 변수로 계산하여 적용 시킬 부분
			//시간 적용시 10시 미만일때 0 붙일것
			//alert(day.getHours() + ":" + day.getMinutes() + ":" + day.getSeconds());
			
			if($('#charge_yn').val() == 'y'){
				$("#date_picker").css("display", "");
				$("#date_check").css("display", "");
				if(start_date_default==''){
					if((day.getMonth()+1) < 10){
						if(day.getDate() < 10){
							$('#start_date').val(day.getFullYear()+'-'+'0' + (day.getMonth()+1)+'-'+'0'+(day.getDate()+1) + " 00:00:00.0");
						}else{
							$('#start_date').val(day.getFullYear()+ '-'+'0'+ (day.getMonth()+1)+'-'+(day.getDate()+1) + " 00:00:00.0");	
						}
					}else{
						if(day.getDate() < 10){
							$('#start_date').val(day.getFullYear()+'-' + (day.getMonth()+1)+'-'+'0'+(day.getDate()+1) + " 00:00:00.0");
						}else{
							$('#start_date').val(day.getFullYear()+ '-'+ (day.getMonth()+1)+'-'+(day.getDate()+1) + " 00:00:00.0");
						}
					}	
				}else{
					$('#start_date').val(start_date_default);
					$('#end_date').val(end_date_default);
				}
				
			}else if ($('#charge_yn').val() == 'n'){
				//$("#date_picker").css("display", "none");
				//$("#date_check").css("display", "none");
				$('#start_date').val('');
				$('#end_date').val('');
			}
			
		});
	
	});
	
	//유료회원 날짜 초기화
	function date_init(){
		var start_date_default = $('#start_date_default').val();
		var end_date_default = $('#end_date_default').val();
		if(start_date_default ==''){
			var day = new Date();
			$('#start_date').val(start_date_default);
			$('#end_date').val(end_date_default);
			if((day.getMonth()+1) < 10){
				if(day.getDate() < 10){
					$('#start_date').val(day.getFullYear()+'-'+'0' + (day.getMonth()+1)+'-'+'0'+(day.getDate()+1) + " 00:00:00.0");
				}else{
					$('#start_date').val(day.getFullYear()+ '-'+'0'+ (day.getMonth()+1)+'-'+(day.getDate()+1) + " 00:00:00.0");	
				}
			}else{
				if(day.getDate() < 10){
					$('#start_date').val(day.getFullYear()+'-' + (day.getMonth()+1)+'-'+'0'+(day.getDate()+1) + " 00:00:00.0");
				}else{
					$('#start_date').val(day.getFullYear()+ '-'+ (day.getMonth()+1)+'-'+(day.getDate()+1) + " 00:00:00.0");	
				}
			}	
		}else{
			$('#start_date').val(start_date_default);
			$('#end_date').val(end_date_default);
		}
		
	}
	
	//유료회원 날짜 자동 계산 기능
	function date_calculate(){
		
		var start_date = $('#start_date').val();
		var end_date = $('#end_date').val();
		var start_date_default = $('#start_date_default').val();
		var end_date_default = $('#end_date_default').val();
		var day = new Date();
		
		if(end_date == ''){
			
			var str = start_date.substr(0,10);
			
			str = str.replace(/-/gi, '/');
			var end_date_confirm = $('#end_date_confirm').val();
			day = new Date(str);
			day.setDate(day.getDate() + parseInt(end_date_confirm));
			
			if((day.getMonth()+1) < 10){
				if(day.getDate() < 10){
					$('#end_date').val(day.getFullYear()+ '-0'+ (day.getMonth()+1)+'-0'+day.getDate()+" 00:00:00.0"); 		
				}else{
					$('#end_date').val(day.getFullYear()+ '-0'+ (day.getMonth()+1)+'-'+(day.getDate())+" 00:00:00.0");	           
				}
			}else{
				if(day.getDate() < 10){
					$('#end_date').val(day.getFullYear()+ '-'+ (day.getMonth()+1)+'-0'+day.getDate() +" 00:00:00.0");		
				}else{
					$('#end_date').val(day.getFullYear()+ '-'+ (day.getMonth()+1)+'-'+(day.getDate()) +" 00:00:00.0");	
				}
			}
			
		}else if (end_date != ''){
			var str = end_date.substr(0,10);
			var time = end_date.substr(10,22);
			str = str.replace(/-/gi,'/');
			var end_date_confirm = $('#end_date_confirm').val();
			var day = new Date(str);
			day.setDate(day.getDate() + parseInt(end_date_confirm));
			
			if((day.getMonth()+1) < 10){
				if(day.getDate() < 10){
					$('#end_date').val(day.getFullYear()+ '-0'+ (day.getMonth()+1)+'-0'+day.getDate() + time);		
				}else{
					$('#end_date').val(day.getFullYear()+ '-0'+ (day.getMonth()+1)+'-'+(day.getDate()) + time);	
				}
			}else{
				if(day.getDate() < 10){
					$('#end_date').val(day.getFullYear()+ '-'+ (day.getMonth()+1)+'-0'+day.getDate() + time);		
				}else{
					$('#end_date').val(day.getFullYear()+ '-'+ (day.getMonth()+1)+'-'+(day.getDate()) + time);
				}
			}
		}
	}
	
	//폼 보내는곳
	function form_submit() { 

		var form = document.check_form;
		var member_code = $("#member_code").val();
		var use_yn = $("#use_yn").val();
		var charge_yn = $('#charge_yn').val();
		var start_date = $('#start_date').val();
		var end_date = $('#end_date').val();
		
		if(member_code == '03'){
			if(use_yn == 'y'){
				alert("탈퇴 회원은 사용유무를 바꾸셔야 합니다.");
				return;
			}
		}else if(member_code != '03'){
			if(use_yn == 'n'){
				alert("사용유무가 사용안함이면 탈퇴회원으로 변경하셔야 합니다.");
				return;
			}
		}
		if(charge_yn == 'y'){
			if(start_date == ''){
				alert("유료회원 시작 날짜가 비어있습니다.");
				return;
			}else if(end_date == ''){
				alert("유료회원 종료 날짜가 비어 있습니다.");
				return;
			}
		}
		if (checkform()) {
			//보내기 전 위도 경도 입력 확인
			if($('#classSelect').val() != '01'){
				if($('#latitude').val()!=''){
					var callTel = $('#call_tel01').val()+$('#call_tel02').val()+$('#call_tel03').val();
					if($('#callTellConfirm').val()!= callTel){
						$('#bizLinkConfirm').val('1');
					}else{
						$('#bizLinkConfirm').val('2');
					}
					form.action = 'member_Update.do';
					form.submit();
				}else{
					alert('위도 경도가 입력되지 않았습니다. 검색을 눌러주세요');
					return;
				}
			}else{
				form.action = 'member_Update.do';
				form.submit();	
			}
		}
		
		function checkform() {
				
			resetCa();
			
			var sort = [];
			
			$('.caCode:checked').each(function() {
				
				$('#ca'+$(this).val()).val('y');
				sort.push($(this).val());
		   	});
			
			sort.sort();
			
			$('#category').val(sort);
			
			return true;
			
		} 
		
	}

	//체크박스 리셋
	function resetCa() {
		
		for(var i =1;i<41;i++){
			if(i<10){
				$('#ca0'+i).val('n');	
			}else if(i>10){
				$('#ca'+i).val('n');
			}
		}
		
	}
	
</script>
<title>Insert title here</title>
</head>
<body>
	
	<jsp:include page="admin_header.jsp"/>
	
	<form method="POST" name="check_form" enctype="multipart/form-data" >
	<div class="div_style">
	<c:forEach items="${info}" var="info" >
		<input type="hidden" id="category"name="category">
		<input type="hidden" value="" id="bizLinkConfirm" name="bizLinkConfirm"/>
		<input type="hidden" value="${info.call_tel01}${info.call_tel02}${info.call_tel03}" id="callTellConfirm" name="callTellConfirm"/>
		<input type="hidden" value="${info.member_id}" id="" name="member_id" />
		<input type="hidden" value="${info.member_no}" id="" name="member_no" />
		<input type="hidden" value="${info.koker_no}" id="koker_no" name="koker_no"/>
		<input type="hidden" value="${admin_name}" id="" name="tptb" />
		<input type="hidden" value="${info.class_code}" id="class_code${info.class_code}" name="class_code${info.class_code}" />
		<input type="hidden" value="${info.ca01}" id="ca01" name="ca01" />
		<input type="hidden" value="${info.ca02}" id="ca02" name="ca02" />
		<input type="hidden" value="${info.ca03}" id="ca03" name="ca03" />
		<input type="hidden" value="${info.ca04}" id="ca04" name="ca04" />
		<input type="hidden" value="${info.ca05}" id="ca05" name="ca05" />
		<input type="hidden" value="${info.ca06}" id="ca06" name="ca06" />
		<input type="hidden" value="${info.ca07}" id="ca07" name="ca07" />
		<input type="hidden" value="${info.ca08}" id="ca08" name="ca08" />
		<input type="hidden" value="${info.ca09}" id="ca09" name="ca09" />
		<input type="hidden" value="${info.ca10}" id="ca10" name="ca10" />
		<input type="hidden" value="${info.ca11}" id="ca11" name="ca11" />
		<input type="hidden" value="${info.ca12}" id="ca12" name="ca12" />
		<input type="hidden" value="${info.ca13}" id="ca13" name="ca13" />
		<input type="hidden" value="${info.ca14}" id="ca14" name="ca14" />		
		<input type="hidden" value="${info.ca15}" id="ca15" name="ca15" />		
		<input type="hidden" value="${info.ca16}" id="ca16" name="ca16" />		
		<input type="hidden" value="${info.ca17}" id="ca17" name="ca17" />		
		<input type="hidden" value="${info.ca18}" id="ca18" name="ca18" />		
		<input type="hidden" value="${info.ca19}" id="ca19" name="ca19" />		
		<input type="hidden" value="${info.ca20}" id="ca20" name="ca20" />		
		<input type="hidden" value="${info.ca21}" id="ca21" name="ca21" />		
		<input type="hidden" value="${info.ca22}" id="ca22" name="ca22" />		
		<input type="hidden" value="${info.ca23}" id="ca23" name="ca23" />		
		<input type="hidden" value="${info.ca24}" id="ca24" name="ca24" />		
		<input type="hidden" value="${info.ca25}" id="ca25" name="ca25" />		
		<input type="hidden" value="${info.ca26}" id="ca26" name="ca26" />		
		<input type="hidden" value="${info.ca27}" id="ca27" name="ca27" />		
		<input type="hidden" value="${info.ca28}" id="ca28" name="ca28" />		
		<input type="hidden" value="${info.ca29}" id="ca29" name="ca29" />		
		<input type="hidden" value="${info.ca30}" id="ca30" name="ca30" />		
		<input type="hidden" value="${info.ca31}" id="ca31" name="ca31" />		
		<input type="hidden" value="${info.ca32}" id="ca32" name="ca32" />		
		<input type="hidden" value="${info.ca33}" id="ca33" name="ca33" />		
		<input type="hidden" value="${info.ca34}" id="ca34" name="ca34" />		
		<input type="hidden" value="${info.ca35}" id="ca35" name="ca35" />		
		<input type="hidden" value="${info.ca36}" id="ca36" name="ca36" />		
		<input type="hidden" value="${info.ca37}" id="ca37" name="ca37" />		
		<input type="hidden" value="${info.ca38}" id="ca38" name="ca38" />		
		<input type="hidden" value="${info.ca39}" id="ca39" name="ca39" />		
		<input type="hidden" value="${info.ca40}" id="ca40" name="ca40" />		
	
		<table>
			<tr>
				<td>
					ID
				</td>
				<td>
					${info.member_id}
				</td>
			</tr>
			<tr>
				<td>
					비밀번호
				</td>
				<td>
					<input type="password" value="${info.password}" name="password">
				</td>
			</tr>
			<tr>
				<td>
					이름
				</td>
				<td>
					<input type="text" value="${info.name}" name="name">
				</td>
			</tr>
			<tr>
				<td>
					회원코드
				</td>
				<td>
					<c:choose>
						<c:when test="${info.class_code == '01'}" >
							<select id="classSelect" name="class_code">
								<option value="01" selected="selected">01(일반)</option>
								<option value="02">02(자재)</option>
								<option value="03">03(기술자)</option>
								<option value="04">04(장비)</option>
								<option value="05">05(시공)</option>
								<option value="06">06(종합)</option>
								<option value="07">07(운송)</option>
							</select>
						</c:when>
						<c:when test="${info.class_code == '02'}" >
							<select id="classSelect" name="class_code">
								<option value="01">01(일반)</option>
								<option value="02" selected="selected">02(자재)</option>
								<option value="03">03(기술자)</option>
								<option value="04">04(장비)</option>
								<option value="05">05(시공)</option>
								<option value="06">06(종합)</option>
								<option value="07">07(운송)</option>
							</select>
						</c:when>
						<c:when test="${info.class_code == '03'}" >
							<select id="classSelect" name="class_code">
								<option value="01">01(일반)</option>
								<option value="02">02(자재)</option>
								<option value="03" selected="selected">03(기술자)</option>
								<option value="04">04(장비)</option>
								<option value="05">05(시공)</option>
								<option value="06">06(종합)</option>
								<option value="07">07(운송)</option>
							</select>
						</c:when>
						<c:when test="${info.class_code == '04'}" >
							<select id="classSelect" name="class_code">
								<option value="01">01(일반)</option>
								<option value="02">02(자재)</option>
								<option value="03">03(기술자)</option>
								<option value="04" selected="selected">04(장비)</option>
								<option value="05">05(시공)</option>
								<option value="06">06(종합)</option>
								<option value="07">07(운송)</option>
							</select>
						</c:when>
						<c:when test="${info.class_code == '05'}" >
							<select id="classSelect" name="class_code">
								<option value="01">01(일반)</option>
								<option value="02">02(자재)</option>
								<option value="03">03(기술자)</option>
								<option value="04">04(장비)</option>
								<option value="05" selected="selected">05(시공)</option>
								<option value="06">06(종합)</option>
								<option value="07">07(운송)</option>
							</select>
						</c:when>
						<c:when test="${info.class_code == '06'}" >
							<select id="classSelect" name="class_code">
								<option value="01">01(일반)</option>
								<option value="02">02(자재)</option>
								<option value="03">03(기술자)</option>
								<option value="04">04(장비)</option>
								<option value="05">05(시공)</option>
								<option value="06" selected="selected">06(종합)</option>
								<option value="07">07(운송)</option>
							</select>
						</c:when>
						<c:when test="${info.class_code == '07'}" >
							<select id="classSelect" name="class_code">
								<option value="01">01(일반)</option>
								<option value="02">02(자재)</option>
								<option value="03">03(기술자)</option>
								<option value="04">04(장비)</option>
								<option value="05">05(시공)</option>
								<option value="06">06(종합)</option>
								<option value="07" selected="selected">07(운송)</option>
							</select>
						</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td>회원승인</td>
				<td>
					<c:choose>
						<c:when test="${info.member_code =='01'}">
							<select id="member_code" name="member_code">
								<option value="01" selected="selected">승인</option>
								<option value="02">비승인</option>	
								<option value="03">탈퇴</option>											
							</select>
						</c:when>
						<c:when test="${info.member_code =='02'}">
							<select id="member_code" name="member_code">
								<option value="01">승인</option>
								<option value="02" selected="selected">비승인</option>
								<option value="03">탈퇴</option>												
							</select>
						</c:when>
						<c:when test="${info.member_code =='03'}">
							<select id="member_code" name="member_code">
								<option value="01">승인</option>
								<option value="02">비승인</option>
								<option value="03" selected="selected">탈퇴</option>												
							</select>
						</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td>승인코멘트</td>
				<td><textarea name="app_content" id="app_content" cols="50" rows="5">${info.app_content}</textarea></td>
			</tr>
			<tr>
				<td>사용유무</td>
				<td>
					<c:choose>
						<c:when test="${info.use_yn == 'y'}" >
							<select id="use_yn" name="use_yn">
								<option value="y" selected="selected">yes</option>
								<option value="n">no</option>
							</select>
						</c:when>
						<c:when test="${info.use_yn == 'n'}" >
							<select id="use_yn" name="use_yn">
								<option value="y">yes</option>
								<option value="n" selected="selected">no</option>
							</select>
						</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td>회원인증</td>
				<td>
					<c:choose>
						<c:when test="${info.koker_auth == 'y'}" >
							<select id="" name="koker_auth">
								<option value="y" selected="selected">yes</option>
								<option value="n">no</option>
							</select>
						</c:when>
						<c:when test="${info.koker_auth == 'n'}" >
							<select id="" name="koker_auth">
								<option value="y">yes</option>
								<option value="n" selected="selected">no</option>
							</select>
						</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td>핸드폰 번호</td>
				<td>
					<input type="text" value="${info.hp01}" size="5" id="" name="hp01"/>
					-<input type="text" value="${info.hp02}" size="5" id="" name="hp02"/>
					-<input type="text" value="${info.hp03}" size="5" id="" name="hp03"/>
				</td>
			</tr>
			<tr>
				<td>이용약관</td>
				<td>
					<c:choose>
						<c:when test="${info.click_wrap01 == 'y'}" >
							Yes
						</c:when>
						<c:when test="${info.click_wrap01 == 'n'}">
							No
						</c:when>
					</c:choose>	
				</td>
			</tr>
			<tr>
				<td>개인정보수집</td>
				<td>
					<c:choose>
						<c:when test="${info.click_wrap02 == 'y'}" >
							Yes
						</c:when>
						<c:when test="${info.click_wrap02 == 'n'}">
							No
						</c:when>
					</c:choose>	
				</td>
			</tr>
			<tr>
				<td>3자 공동</td>
				<td>
					<c:choose>
						<c:when test="${info.click_wrap03 == 'y'}" >
							Yes
						</c:when>
						<c:when test="${info.click_wrap03 == 'n'}">
							No
						</c:when>
					</c:choose>	
				</td>
			</tr>
			<tr>
				<td>위치정보 제공</td>
				<td>
					<c:choose>
						<c:when test="${info.click_wrap04 == 'y'}" >
							Yes
						</c:when>
						<c:when test="${info.click_wrap04 == 'n'}">
							No
						</c:when>
					</c:choose>	
				</td>
			</tr>
			<tr>
				<td>가입일자</td>
				<td>${info.insert_date}</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>
					<input type="text" value="${info.addr01}" id="testAddr01" name="addr01"/>
					<input type="text" value="${info.addr02}" id="testAddr02" name="addr02"/>
					<input type="button" value="검색" onclick="javascript:getLocation();"/>
				</td>
			</tr>
			<tr>
				<td>좌표</td>
				<td>
					<input type="text" value="${info.latitude}" id="latitude" name="latitude" readonly="readonly"/>
					<input type="text" value="${info.longitude}" id="longitude" name="longitude" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<td>주소 검색 </td>
				<td>
					<a href="http://www.juso.go.kr/support/AddressMainSearch.do" target="_blank">
						http://www.juso.go.kr/support/AddressMainSearch.do
					</a>
					
				</td>
			</tr>
			<tr>
				<td>업체번호</td>
				<td> 
					<input type="text" value="${info.call_tel01}" size="4" id="call_tel01" name="call_tel01"/>
					-<input type="text" value="${info.call_tel02}" size="4" id="call_tel02" name="call_tel02"/>
					-<input type="text" value="${info.call_tel03}" size="4" id="call_tel03" name="call_tel03"/>
				</td>
			</tr>
			<tr>
				<td>회사이름</td>
				<td>
					<input type="text" value="${info.koker_name}" id="" name="koker_name">
				</td>
			</tr>
			<tr>
				<td>담당자</td>
				<td>
					<input type="text" value="${info.tptb}" size="7" readonly="readonly" />
				</td>
			</tr>
			<tr style="display: none" id="businessRegister">
				<td>사업자 등록증</td>
				<td>
					<input type="file" id="company_paper1" name="file1" /> <br/>
					<c:if test="${info.business_file01_name!=''}">
						<img id="img_preview1" style="display:;height:200px;width:200px;" src="/upload/img/${info.member_id}/${info.business_file01_name}"/>
					</c:if>
					<c:if test="${info.business_file01_name ==''|| info.business_file02_name!= null || info.business_file02_name!='null'}">
						<img id="img_preview1"/>
					</c:if>
				</td>
			</tr>
			<tr style="display: none" id="register">
				<td>공사 면허증</td>
				<td>
					<input type="file" id="company_paper2" name="file2"/> <br/>
					<c:if test="${info.business_file02_name!='' || info.business_file02_name!= null || info.business_file02_name!='null'}">
						<img id="img_preview2" style="display:;height:200px;width:200px;" src="/upload/img/${info.member_id}/${info.business_file02_name}"/>
					</c:if>
					<c:if test="${info.business_file02_name ==''}">
						<img id="img_preview2"/>
					</c:if>
				</td>
			</tr>
		</table>
		
		<c:if test="${info.class_code != null }">
			
			<div style="float: left; width: 100%;line-height:32px;" >
				<div id="code02_view"></div>
			</div>
		
		</c:if>
	</c:forEach>
	
	<!-- 유료회원 -->
	<c:if test="${chargeSize !=0}">
		<c:forEach items="${chargeMember}" var="charge">
			<input type="hidden"  name="start_date_default" id="start_date_default" value="${charge.start_date}"/>
			<input type="hidden"  name="end_date_default" id="end_date_default" value="${charge.end_date}"/>
			<input type="hidden" name="charge_check" id="charge_check" value="1">
				<table>
					<tr>
						<td>유료회원 사용 유무</td>
						<td>
							<select id="charge_yn" name="charge_yn">
								<c:if test="${charge.charge_yn == 'y'}">
									<option value="y" selected="selected">YES</option>
									<option value="n">NO</option>
								</c:if>
								<c:if test="${charge.charge_yn == 'n'}">
									<option value="y">YES</option>
									<option value="n" selected="selected">NO</option>
								</c:if>
							</select>
						</td>
					</tr>
					<tr id="date_picker">
						<td>시작일 : <input type="text" name="start_date" id="start_date" value="${charge.start_date}" readonly="readonly"></td>
						<td>종료일 : <input type="text" name="end_date" id="end_date" value="${charge.end_date}" readonly="readonly"></td>
					</tr>
					<tr id="date_check">
						<td>
							<select id="end_date_confirm" name="end_date_confirm">
								<option value="3">3일</option>
								<option value="30">30일</option>
								<option value="60">60일</option>
								<option value="90">90일</option>
								<option value="180">180일</option>
								<option value="360">360일</option>
							</select>
						</td>
						<td><input type="button" value="적용" onclick="javascript:date_calculate();"/> <input type="button" value="초기화" onclick="javascript:date_init();"></td>
					</tr>
				</table>
		</c:forEach>
	</c:if>
	<c:if test="${chargeSize == 0}">
		<input type="hidden" name="charge_check" id="charge_check" value="2">
		<input type="hidden"  name="start_date_default" id="start_date_default" value=""/>
			<input type="hidden"  name="end_date_default" id="end_date_default" value=""/>
		<table>
			<tr>
				<td>유료회원 사용 유무</td>
				<td>
					<select id="charge_yn" name="charge_yn">
						<option value="y">YES</option>
						<option value="n" selected="selected">NO</option>
					</select>
				</td>
			</tr>
			<tr style='display:none;' id="date_picker">
				<td>시작일 : <input type="text" name="start_date" id="start_date" readonly="readonly"></td>
				<td>종료일 : <input type="text" name="end_date" id="end_date" readonly="readonly"></td>
			</tr>
			<tr style='display:none;' id="date_check">
				<td>
					<select id="end_date_confirm" name="end_date_confirm">
						<option value="3">3일</option>
						<option value="30">30일</option>
						<option value="60">60일</option>
						<option value="90">90일</option>
						<option value="180">180일</option>
						<option value="360">360일</option>
					</select>
				</td>
				<td><input type="button" value="적용" onclick="javascript:date_calculate();"/> <input type="button" value="초기화" onclick="javascript:date_init();"></td>
			</tr>
		</table>
	</c:if>
	<!-- 유료회원 끝 -->
	
	<!-- 추천업체 시작 -->
	<table>
		<tr>
			<td>추천업체 등록</td>
			<td>
				<c:if test="${count == '0' }">
					<select name="recommend" id="recommend">
						<option value="n" selected="selected">비등록</option>
						<option value="y">등록</option>
					</select>
				</c:if>
				<c:if test="${count == '1' }">
					<select name="recommend" id="recommend">
						<option value="n">비등록</option>
						<option value="y" selected="selected">등록</option>
					</select>
				</c:if>
			</td>
		</tr>
	</table>
	<!-- 추천업체 끝-->
	</div>
	</form>
	
	<div style="width:100%; text-align:center; margin:3em 0 5em 0; font-family:'GodoM'; font-size:14px;">
		<span onclick="javescript:form_submit();" style="padding:.5em 3em; margin-right:2em; background-color:#29A9C8; border-radius:5px; color:#fff; border:solid 1px #29A9C8;">수정</span>
		<span onclick="javascript:history.back()" style="padding:.5em 3em; border-radius:5px; color:#29A9C8; border:solid 1px #29A9C8;">취소</span>
	</div>
</body>
</html>