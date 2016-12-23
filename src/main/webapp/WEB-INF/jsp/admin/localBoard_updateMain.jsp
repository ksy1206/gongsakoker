<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<link rel="stylesheet"href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
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
	                    	if(data.areaList)
	                        var html = "<option value='0'>도</option>";
	                        $.each(data.areaList, function (index, areaList) {
	                             
	                             html+= " <option value='"+areaList.sido+ "'>"+areaList.sido+ "</option>" ;
	                        });
	                        $( "#areaList").html(html);
	                        
	                        var sido = '${sido}';
	            			if(sido!=''){
	            				
	            				$("#areaList > option[value='"+sido+"']").attr("selected","true");
	            				getZip_city();
	            				
	            			};
	                        
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
                         var html = "<option value='0'>시/군/구</option>";
                        $.each(data.cityList, function (index, cityList) {
                             html+= " <option value='"+cityList.gugun+ "'>"+cityList.gugun+ "</option>" ;
                        });                        
                   $( "#cityList").html(html);
                   $( "#cityList-button span").html( "시/군/구");  
                   
                   var gugun = "${gugun}";
                   var category = "${category}";
					if(gugun!=''){
          				
          					$("#cityList > option[value='"+gugun+"']").attr("selected","true");
          					if(category!=''){
          						$("#categoryList > option[value='"+category+"']").attr("selected","true");
          					}
          				
          				};
                   
                   
                   } else{
                	   
                   }
	         }
		});
	}
	
	$(function() {
		$("#start_date").datepicker({
			dateFormat : 'yy-mm-dd'
		});
		$("#end_date").datepicker({
			dateFormat : 'yy-mm-dd'
		});
	});

	function areaBoardHidden(){
		var sido = $( "#areaList option:selected").val();
		var gugun = $( "#cityList option:selected").val();
		var category = $( "#categoryList option:selected").val();
		
		$('#sido').val(sido);
		$('#gugun').val(gugun);
		$('#category').val(category);
		
		document.areaBoardForm.action="areaBoard_update.do";
		document.areaBoardForm.submit();
	}
	
</script>
<title>Insert title here</title>
</head>
<body>
	
	<jsp:include page="admin_header.jsp"/>
	
	<form method="post" id="areaBoardForm" name="areaBoardForm">
		
		<input type="hidden" id="sido" name="sido">
		<input type="hidden" id="gugun" name="gugun">
		<input type="hidden" id="category" name="category">
		
		<c:forEach items="${localOne}" var="one">
			
		<input type="hidden" id="board_no" name="board_no" value="${one.board_no}">
			<p style="font-family:'GodoM'; font-size:18px; width:980px; margin:0 auto; padding-top:1em;">지역게시판 수정</p>
			<table class="member_table" style="text-align:left;">
				<tr>
					<td>지역</td>
					<td>
						도 : <select  id="areaList"  onchange="getZip_city()">
							</select>
					</td>
					<td>
						시/군/구 : <select id="cityList">
								</select>	
					</td>
					<td>
						카테고리 : <select id="categoryList">
								<option value="1">자재업체 홍보</option>
								<option value="2">기술자 스토리</option>
								<option value="3">R&D자제홍보</option>
								<option value="4">문화체험 및 교육</option>
							</select>
					</td>
				</tr>
				<tr>
					<td>주최</td>
					<td colspan="3"><input type="text" id="sponsor" name="sponsor" value="${one.sponsor}"></td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3"><input type="text" id="title" name="title" value="${one.title}"></td>
				</tr>
				<tr>
					<td>장소</td>
					<td colspan="3"><input type="text" id="place" name="place" value="${one.place}"></td>
				</tr>
				<tr>
					<td>기간</td>
					<td><input type="text" id="start_date" name="start_date" value="${one.start_date}"></td>
					<td style="text-align:center;">~</td>
					<td><input type="text" id="end_date" name="end_date" value="${one.end_date}"></td>
				</tr>
				<tr>
					<td>연락처</td>
					<td colspan="3"><input type="text" id="tel" name="tel" value="${one.tel}"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3"><textarea id="content" name="content" style="width:100%;">${one.content}</textarea></td>
				</tr>
				<tr>
					<td>사용유무</td>
					<td colspan="3">
						<c:if test="${one.use_yn=='y'}">
							<select id="use_yn" name="use_yn">
								<option value="y" selected="selected">yes</option>
								<option value="n">no</option>
							</select>
						</c:if>
						<c:if test="${one.use_yn=='n'}">
							<select id="use_yn" name="use_yn">
								<option value="y">yes</option>
								<option value="n" selected="selected">no</option>
							</select>
						</c:if>
					</td>
				</tr>
			</table>
			
			<div style="width:980px; margin:0 auto; text-align:center; padding:2em 0 5em 0;">
				<input type="submit" value="수정" onclick="javascript:areaBoardHidden();" style="padding:.5em 2em; border:solid 2px #29A9C8; background-color:#29A9C8; color:#fff; font-family:'GodoM'; border-radius:5px; margin-right:1em;"/>
				<input type="button" value="취소" onclick="location.href='admin_areaBoard.do?pageNum=1'" style="padding:.5em 2em; border:solid 2px #29A9C8; background-color:#fff; color:#29A9C8; font-family:'GodoM'; border-radius:5px;" />
			</div>
		</c:forEach>
		
	</form>
</body>
</html>