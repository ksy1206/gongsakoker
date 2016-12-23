<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true"%>
<%  
	String cp = request.getContextPath();
%>

<!-- 현재페이지 게시글 수 -->
<c:set var="maxRow" value="7" />
<!-- 현재페이지목록 수 -->
<c:set var="maxPageList" value="10" />

<c:set var="pageNum" value="${pageNum}"/>
<c:set var="totalRow" value="${fn:length(list)}" />
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
<link rel="stylesheet" href="../css/smoothness/jquery-ui.css">
<link rel="stylesheet" href="../css/smoothness/jquery-ui-1.10.4.custom.css">
<link rel="stylesheet" href="../css/smoothness/ui.jqgrid.css">
<link rel="stylesheet" href="../css/koker_admin.css">

<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script src="../js/grid/i18n/grid.locale-kr.js"></script>
<script src="../js/grid/jquery.jqGrid.min.js"></script>
<script src="../js/json2.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	var gugun = $("#est_gugun_hidden").val();
	var estType01_code = $("#estType01_code_hidden").val();
	var estType02_code = $("#estType02_code_hidden").val();
	getZip_area();
	if(gugun != "default"){
		getZip_city();
	}
	if(estType01_code != null && estType01_code != ""){
		area();
	}
	
	$("#search_estimate").click(function(){
		var est_sido = $("#areaList option:selected").val();
		var est_gugun = $("#cityList option:selected").val();
		var estType01_code = $("#area_1 option:selected").val();
		var estType02_code = $("#area_2 option:selected").val();
		var member_id = $("#member_id").val();
		var est_content = $("#est_content").val();
		
		params = "est_sido="+est_sido+"&est_gugun="+est_gugun+"&estType01_code="+estType01_code+
				"&estType02_code="+estType02_code+"&member_id="+member_id+"&est_content="+est_content;
		
		location.href="<%=cp%>/admin/admin_estimate.do?pageNum=1"+"&est_sido="+est_sido+"&est_gugun="+est_gugun+"&estType01_code="+estType01_code+
			"&estType02_code="+estType02_code+"&member_id="+member_id+"&est_content="+est_content;
	});
});
	
	function getZip_area(){		
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
	                   var sido = $("#est_sido_hidden").val();
	                    if(data.areaList!= null && data.areaList.length != 0){
	                    	if(sido == "default" || sido == null || sido == ""){
	                    		 var html = "<option value=''>도</option>";
	                    	} else {
	                    		 var html = "<option value='"+sido+"'>"+sido+"</option>";
	                    	}	                       
	                        $.each(data.areaList, function (index, areaList) {
	                        	if(areaList.sido == sido){
	                        		
	                        	} else {
	                        		html+= " <option value='"+areaList.sido+ "'>"+areaList.sido+ "</option>";	
	                        	}	                             
	                        });
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
	        	 	var gugun = $("#est_gugun_hidden").val();
	                if(data.cityList!= null && data.cityList.length != 0){
	                	if(gugun == "default" || gugun == null || gugun == ''){
	                		var html = "<option value=''>시/군/구</option>";	
	                	} else {
	                		var html = "<option value='"+gugun+"'>"+gugun+"</option>";
	                	}	                    
	                    $.each(data.cityList, function (index, cityList) {
	                    	if(cityList.gugun == gugun){
	                    		
	                    	} else {
	                    		html+= " <option value='"+cityList.gugun+ "'>"+cityList.gugun+ "</option>" ;	
	                    	}	                        
	                    });                        
	               $( "#cityList").html(html);
	               $( "#cityList-button span").html( "시/군/구");	               
	               } else{}
	         }
		});
	}
	
	function estimateDetail(data){
		$('$member_no').val(data);
	}
	
	function area(){
		var area_1 = $( "#area_1 option:selected").val();
		var value = $("#estType02_code_hidden").val();
		var html = "";
		if(area_1 == '1'){
			if(value == '01') {
				html = "<option value='01' selected='selected'>아파트</option>";
				html += "<option value='02'>주상복합</option>";
				html += "<option value='03'>오피스텔</option>";
				html += "<option value='04'>빌라/연립</option>";
				html += "<option value='05'>기타</option>";
			} else if (value == '02'){
				html = "<option value='01'>아파트</option>";
				html += "<option value='02' selected='selected'>주상복합</option>";
				html += "<option value='03'>오피스텔</option>";
				html += "<option value='04'>빌라/연립</option>";
				html += "<option value='05'>기타</option>";
			} else if (value == '03'){
				html = "<option value='01'>아파트</option>";
				html += "<option value='02'>주상복합</option>";
				html += "<option value='03' selected='selected'>오피스텔</option>";
				html += "<option value='04'>빌라/연립</option>";
				html += "<option value='05'>기타</option>";
			} else if (value == '04'){
				html = "<option value='01'>아파트</option>";
				html += "<option value='02'>주상복합</option>";
				html += "<option value='03'>오피스텔</option>";
				html += "<option value='04' selected='selected'>빌라/연립</option>";
				html += "<option value='05'>기타</option>";
			} else if (value == '05'){
				html = "<option value='01'>아파트</option>";
				html += "<option value='02'>주상복합</option>";
				html += "<option value='03'>오피스텔</option>";
				html += "<option value='04'>빌라/연립</option>";
				html += "<option value='05' selected='selected'>기타</option>";
			} else {
				html = "<option value='01'>아파트</option>";
				html += "<option value='02'>주상복합</option>";
				html += "<option value='03'>오피스텔</option>";
				html += "<option value='04'>빌라/연립</option>";
				html += "<option value='05'>기타</option>";
			}			
			$( "#area_2").html(html);
		} else if(area_1 == '2'){
			if(value == '01') {
				html = "<option value='01' selected='selected'>사무공간</option>";
				html += "<option value='02'>식당/요식</option>";
				html += "<option value='03'>학원/교육</option>";
				html += "<option value='04'>병원/의료</option>";
				html += "<option value='05'>매장/상업</option>";
				html += "<option value='05'>체육/기타</option>";
			} else if(value == '02') {
				html = "<option value='01'>사무공간</option>";
				html += "<option value='02' selected='selected'>식당/요식</option>";
				html += "<option value='03'>학원/교육</option>";
				html += "<option value='04'>병원/의료</option>";
				html += "<option value='05'>매장/상업</option>";
				html += "<option value='06'>체육/기타</option>";
			} else if(value == '03') {
				html = "<option value='01'>사무공간</option>";
				html += "<option value='02'>식당/요식</option>";
				html += "<option value='03' selected='selected'>학원/교육</option>";
				html += "<option value='04'>병원/의료</option>";
				html += "<option value='05'>매장/상업</option>";
				html += "<option value='06'>체육/기타</option>";
			} else if(value == '04') {
				html = "<option value='01'>사무공간</option>";
				html += "<option value='02'>식당/요식</option>";
				html += "<option value='03'>학원/교육</option>";
				html += "<option value='04' selected='selected'>병원/의료</option>";
				html += "<option value='05'>매장/상업</option>";
				html += "<option value='06'>체육/기타</option>";
			} else if(value == '05') {
				html = "<option value='01'>사무공간</option>";
				html += "<option value='02'>식당/요식</option>";
				html += "<option value='03'>학원/교육</option>";
				html += "<option value='04'>병원/의료</option>";
				html += "<option value='05' selected='selected'>매장/상업</option>";
				html += "<option value='06'>체육/기타</option>";
			} else if(value == '06'){
				html = "<option value='01'>사무공간</option>";
				html += "<option value='02'>식당/요식</option>";
				html += "<option value='03'>학원/교육</option>";
				html += "<option value='04'>병원/의료</option>";
				html += "<option value='05'>매장/상업</option>";
				html += "<option value='06' selected='selected'>체육/기타</option>";
			} else {
				html = "<option value='01'>사무공간</option>";
				html += "<option value='02'>식당/요식</option>";
				html += "<option value='03'>학원/교육</option>";
				html += "<option value='04'>병원/의료</option>";
				html += "<option value='05'>매장/상업</option>";
				html += "<option value='06' selected='selected'>체육/기타</option>";
			}
			
			$( "#area_2").html(html);
		}		
	}
	
	function estimateDetail(est_no){
		location.href="<%=cp%>/admin/admin_estimateDetails.do?est_no="+est_no;
	}

	function pageMove(obj){
		var est_sido = $("#areaList option:selected").val();
			$("#est_sido_hidden").val(est_sido);
		var est_gugun = $("#cityList option:selected").val();
			$("#est_gugun_hidden").val(est_gugun);
		var estType01_code = $("#area_1 option:selected").val();
			$("#estType01_code_hidden").val(estType01_code);
		var estType02_code = $("#area_2 option:selected").val();
			$("#estType02_code_hidden").val(estType02_code);
		var member_id = $("#member_id").val();
			$("#member_id_hidden").val(member_id);
		var est_content = $("#est_content").val();
			$("#eest_content_hidden").val(est_content);
		
		params = "est_sido="+est_sido+"&est_gugun="+est_gugun+"&estType01_code="+estType01_code+
				"&estType02_code="+estType02_code+"&member_id="+member_id+"&est_content="+est_content;
		
		location.href="<%=cp%>/admin/admin_estimate.do?pageNum="+obj+"&est_sido="+est_sido+"&est_gugun="+est_gugun+"&estType01_code="+estType01_code+
			"&estType02_code="+estType02_code+"&member_id="+member_id+"&est_content="+est_content;
			
	}	
	
</script>
</head>

<body>

	<jsp:include page="admin_header.jsp"/>
	
		<input type="hidden" id="est_sido_hidden" value="${est_sido_hidden}"/>
		<input type="hidden" id="est_gugun_hidden" value="${est_gugun_hidden}"/>
		<input type="hidden" id="estType01_code_hidden" value="${estType01_code_hidden}"/>
		<input type="hidden" id="estType02_code_hidden" value="${estType02_code_hidden}"/>
		<input type="hidden" id="member_id_hidden" value="${member_id_hidden}"/>
		<input type="hidden" id="est_content_hidden" value="${est_content_hidden}"/>
	
	<div style="width:980px; text-align:center; font-size:14px; font-family:'GodoM'; margin:0 auto; padding-top:5em;">
		<!-- <span onclick="javascript:bizURL();" style="color:#fff; margin:0 1em; padding:.5em 5em; background-color:#29A9C8; border-radius:20px; cursor:pointer;">biz(URL등록)</span> -->
		<div style="width:100%; margin:0 auto; overflow:auto; padding:0 0 2em 0;">	
			<div class="admin_grid_sec_6">
				도 : <select  id="areaList"  onchange="getZip_city()">
					</select>
			</div>
			<div class="admin_grid_sec_6">
				시/군/구 : <select id="cityList">
							<option value="">시/군/구</option>
						</select>
			</div>
			<div class="admin_grid_sec_6">
				공간 : 
				<c:if test="${estType01_code_hidden == null || estType01_code_hidden == ''}">
					<select id="area_1" onchange="area()">
						<option value="">선택해주세요.</option>
						<option value="1">주거공간</option>
						<option value="2">상업공간</option>
					</select>
				</c:if>
				<c:if test="${estType01_code_hidden == '1'}">
					<select id="area_1" onchange="area()">
						<option value="">선택해주세요.</option>
						<option value="1" selected="selected">주거공간</option>
						<option value="2">상업공간</option>
					</select>
				</c:if>
				<c:if test="${estType01_code_hidden == '2'}">
					<select id="area_1" onchange="area()">
						<option value="">선택해주세요.</option>
						<option value="1">주거공간</option>
						<option value="2" selected="selected">상업공간</option>
					</select>
				</c:if>
			</div>
			<div class="admin_grid_sec_6" style="width:25%;">
				시공대상 : 
				<select id="area_2">
					<option value="">공간을 선택해 주세요.</option>
				</select>
			</div>
			<div class="admin_grid_sec_6" style="width:20%;">
				<input type="text" id="member_id" placeholder="작성자 검색" value="${member_id_hidden}">
				<input type="text" id="est_content" placeholder="내용 검색" value="${est_content_hidden}">
			</div>
			
			<div class="admin_grid_sec_6" style="width:5%;">
				<input type="button" value="검색" id="search_estimate">
			</div>
			
		</div>
		
		<div style="border:solid 2px #e9e9e9; width:980px; margin:0 auto;">
		<c:forEach items="${list}" var="list" begin="${startRow}" end="${endRow}">
			<div onclick="estimateDetail(${list.est_no})" style="padding:1em; border-bottom:solid 1px #e9e9e9; overflow:auto; cursor:pointer;">
				<div class="admin_grid_sec_2" style="width:80%; text-align:left;">
					<c:if test="${list.estType01_code == 1}">
						<c:if test="${list.estType02_code == '01'}">
							<p>아파트 | ${list.est_area}m<sup>2</sup></p>
						</c:if>
						<c:if test="${list.estType02_code == '02'}">
							<p>주상복합 | ${list.est_area}m<sup>2</sup></p>
						</c:if>
						<c:if test="${list.estType02_code == '03'}">
							<p>오피스텔 | ${list.est_area}m<sup>2</sup></p>
						</c:if>
						<c:if test="${list.estType02_code == '04'}">
							<p>빌라/연립 | ${list.est_area}m<sup>2</sup></p>
						</c:if>
						<c:if test="${list.estType02_code == '05'}">
							<p>기타 | ${list.est_area}m<sup>2</sup></p>
						</c:if>					
					</c:if>
					<c:if test="${list.estType01_code == 2}">
						<c:if test="${list.estType02_code == '01'}">
							<p>사무공간 | ${list.est_area}m<sup>2</sup></p>
						</c:if>
						<c:if test="${list.estType02_code == '02'}">
							<p>식당/요리 | ${list.est_area}m<sup>2</sup></p>
						</c:if>
						<c:if test="${list.estType02_code == '03'}">
							<p>학원/교육 | ${list.est_area}m<sup>2</sup></p>
						</c:if>
						<c:if test="${list.estType02_code == '04'}">
							<p>병원/의료 | ${list.est_area}m<sup>2</sup></p>
						</c:if>
						<c:if test="${list.estType02_code == '05'}">
							<p>매장/상업 | ${list.est_area}m<sup>2</sup></p>
						</c:if>
						<c:if test="${list.estType02_code == '06'}">
							<p>체육기타 | ${list.est_area}m<sup>2</sup></p>
						</c:if>
					</c:if>
				</div>
				<div class="admin_grid_sec_2" style="width:20%; text-align:right;">
					<c:if test="${list.est_state == 'n'}">
						<p style="color:#29A9C8;">[진행중]</p>
					</c:if>
					<c:if test="${list.est_state == 'y'}">
						<p>[완료]</p>
					</c:if>
				</div>
				<div class="admin_grid_sec_2" style="width:80%; text-align:left;">
					<p>${list.est_sido} ${list.est_gugun}</p>
				</div>
				<div class="admin_grid_sec_2" style="width:20%; text-align:left;">
					<p>${list.member_id}</p>
				</div>
			</div>
		</c:forEach>
		</div>
	</div>	
	
	<div style="width:100%; margin:0 auto; text-align:center; margin-top:2em; font-family:'GodoM'; font-size:14px;">
		<c:if test="${startPage > 1}">
			<span onclick="javascript:pageMove(${prevPage});">
				<a href="#" style="color:#5EBED6;"><<</a>
			</span>
		</c:if>
		<c:forEach var="pageList" begin="${startPage}" end="${endPage}" varStatus="count">
			<c:choose>
				<c:when test="${pageList == pageNum}">
						<span style="color:#29A9C8; padding:0 .3em;">${pageList}</span>
				</c:when>
				<c:otherwise>
					<span onclick="javascript:pageMove(${pageList});" style="padding:0 .3em;">
						<a href="#">${pageList}</a>
					</span>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${endPage < totalPage}">
			<span onclick="javascript:pageMove(${nextPage});">
				<a href="#" style="color:#5EBED6;">>></a>
			</span>
		</c:if>
	</div>
</body>
</html>