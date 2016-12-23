<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true"%>

<!-- 현재페이지 게시글 수 -->
<c:set var="maxRow" value="7" />
<!-- 현재페이지목록 수 -->
<c:set var="maxPageList" value="10" />

<c:set var="pageNum" value="${pageNum}"/>
<c:set var="totalRow" value="${fn:length(localList)}" />
<c:set var="totalPage" value="${(totalRow / maxRow) + ((1 - ((totalRow / maxRow) % 1 )) % 1) }" />


<c:set var="startRow" value="${ (maxRow * pageNum) - maxRow }" />
<c:set var="endRow" value="${ (maxRow * pageNum) - 1 }" />
<c:set var="endPage" value="${ ((pageNum / maxPageList) + ((1 - ((pageNum / maxPageList) % 1)) % 1)) * maxPageList }" />
<c:set var="startPage" value="${ endPage - maxPageList + 1 }" />
<fmt:formatNumber var="nextPage" value="${ endPage + 1 }" />
<fmt:formatNumber var="prevPage" value="${ startPage - 1 }" />


<c:if test="${endPage > totalPage}">
	<c:set var="endPage" value="${totalPage}" />
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />

<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<c:if test="${result == 1}">
<script>

	alert("수정 되었습니다!!");
	location.href = 'areaBoard_updateMain.do?board_no='+${board_no};

</script>
</c:if>
<c:if test="${result == 2}">
<script>

	alert("등록 되었습니다!!");

</script>
</c:if>
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
	                        
	                        var sido = $('#sido').val();
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
	                   
	                   var gugun = $('#gugun').val();
	                   var category = $('#category').val();
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
	
	function search(){
		var sido = $("#areaList").val();
		var gugun = $("#cityList").val();
		var category = $("#categoryList").val();
		if(sido!=0){
			$('#sido').val(sido);	
		}else if(sido==0){
			$('#sido').val('');
		}
		if(gugun!=0){
			$('#gugun').val(gugun);
		}else if(gugun==0){
			$('#gugun').val('');
		}
		if(category!=0){
			$('#category').val(category);	
		}else if(category==0){
			$('#category').val('');
		}
		
		document.admin_areaBoard_list.submit();
		
	}
	
	function pageMove(obj){
		
		document.getElementById('pageNum').value = obj;
		document.admin_areaBoard_list.submit();
	
	}
	
	function onKey_down() {
		var keycode = event.keyCode;
		if ( keycode == 116 || keycode == 82){
			location.href='admin_areaBoard.do?pageNum=1'	
		}
	}
	
</script>
</head>
<body onkeyup="onKey_down()">
	
	<jsp:include page="admin_header.jsp"/>	
	
	<form accept-charset="UTF-8" method="post" name="admin_areaBoard_list" id="admin_areaBoard_list" action="admin_areaBoard.do">
		<input type="hidden" name="pageNum" id="pageNum" value="1">
		<input type="hidden" name="sido" id="sido" value="${sido}">
		<input type="hidden" name="gugun" id="gugun" value="${gugun}">
		<input type="hidden" name="category" id="category" value="${category}">
	</form>
	
	<div class="select_div" style="width:980px; margin:0 auto; text-align:left; font-family:'GodoM'; padding-top:1em;">
		<span>지역게시판 관리</span>
		<select  id="areaList"  onchange="getZip_city()">
		</select>
		<select id="cityList"  >
			<option value="0">시/군/구</option> 
		</select>	
		<select id="categoryList">
			<option value="0">카테고리</option>
			<option value="1">자재업체 홍보</option>
			<option value="2">기술자 스토리</option>
			<option value="3">R&D자제홍보</option>
			<option value="4">문화체험 및 교육</option>
		</select>	
		<input type="button" value="검색" onclick="search()">
	</div>
	
	<div class="member_table" style="text-align:left;">
		<c:if test="${not empty localList}">
			<c:forEach var="List" items="${localList}" begin="${startRow}" end="${endRow}" varStatus="count">
				<c:if test="${List.category == 1}">
					<a href="areaBoard_updateMain.do?board_no=${List.board_no}"><p style="margin:0; padding:1em 0; border-bottom:dashed #666 1px;">(자재업체 홍보)${List.title}</p></a>
				</c:if>
				<c:if test="${List.category == 2}">
					<a href="areaBoard_updateMain.do?board_no=${List.board_no}"><p style="margin:0; padding:1em 0; border-bottom:dashed #666 1px;">(기술자 스토리)${List.title}</p></a>
				</c:if>
				<c:if test="${List.category == 3}">
					<a href="areaBoard_updateMain.do?board_no=${List.board_no}"><p style="margin:0; padding:1em 0; border-bottom:dashed #666 1px;">(R&D 자재홍보)${List.title}</p></a>
				</c:if>
				<c:if test="${List.category == 4}">
					<a href="areaBoard_updateMain.do?board_no=${List.board_no}"><p style="margin:0; padding:1em 0; border-bottom:dashed #666 1px;">(문화체험 및 교육)${List.title}</p></a>
				</c:if>
			</c:forEach>
		</c:if>
	</div>
	
	<!-- 페이징처리 -->
	<div style="width:100%; margin:0 auto; text-align:center; margin-top:2em; font-family:'GodoM'; font-size:14px;">
		<c:if test="${startPage > 1}">
			<span onclick="javascript:pageMove(${prevPage});">
				<a href="#" style="color:#5EBED6;"><<</a>
			</span>
		</c:if>
		<c:forEach var="pageList" begin="${startPage}" end="${endPage}" varStatus="count">
			<c:choose>
				<c:when test="${pageList == pageNum}">
					<span style="color:#29A9C8;">${pageList}</span>
				</c:when>
				<c:otherwise>
					<span onclick="javascript:pageMove(${pageList});">
							<a href="#" style="color:#666;">${pageList}</a>
					</span>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${endPage < totalPage}">
			<span  onclick="javascript:pageMove(${nextPage});">
				<a href="#" style="color:#5EBED6;">>></a>
			</span>
		</c:if>
	</div>
	
</body>
</html>