<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true"%>
<%
	String cp = request.getContextPath();
%>
<!-- 현재페이지 게시글 수 -->
<c:set var="maxRow" value="20" />
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
<script src="//code.jquery.com/jquery-1.11.3.min.js" ></script >
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>   
<script type="text/javascript"  src="<%=cp%>/js/jquery.form.js"></script>

<script type="text/javascript">
	function pageMove(obj){
		
		var charge_day = $('#charge_day').val();
		location.href = 'admin_charge.do?pageNum='+obj+'&charge_day='+carge_day;
			
	}	
	
	function charge_day_count(data){
		location.href = 'admin_charge.do?pageNum=1&charge_day='+data;
	}
	
	function push_confirm(){

		var android = new Array();
		var ios = new Array();
		
		for (var i=0;i<'${maxRow}';i++){
			var oneCheck = '#oneCheck'+(i+1);
			if($(oneCheck).is(":checked") == true){
				
				var str = $(oneCheck).val() + "";
				var regId = str.substring(0,str.length-1);
				var gubun = str.charAt(str.length-1);
				
				if(gubun == 'A'){
					android.push(regId);
				}else if (gubun == 'I'){
					ios.push(regId);
				}
				
			}else{
				alert('선택 된 회원이 없습니다.');
				return;
			}
			
		}
		
		var charge_day = $('#charge_day').val();
		var message = '';
		if(charge_day == '6'){
			message = '유료회원이 7일 뒤 종료 됩니다.';
		}else if(charge_day == '2'){
			message = '유료회원이 3일 뒤 종료 됩니다';
		}else if(charge_day == '0'){
			message = '유료회원이 오늘 종료 됩니다.';
		}
		
		var list = "android="+android+"&ios="+ios+"&message="+message;
		
		 $.ajax({
		        type        : "POST"  
		      , async       : false 
		      , url         : "/admin/admin_charge_pushAlram.do"
		      , data        : list
		      , dataType    : "json" 
		      , timeout     : 30000   
		      , cache       : false     
		      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		      , error       : function(request, status, error) {
					alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
		      }
		      , success     : function(data) {
		    	  alert("푸쉬알림을 보냈습니다.");
		      }
		      
	    });	
		
	}
	
	$(document).ready(function(){
		$('#fullCheck').change(function(){
			if(this.checked) {
				for(var i=0;i<'${maxRow}';i++){
					$('input:checkbox[name="oneCheck'+i+'"]').prop("checked",true);	
				}
		    } else {
		    	for(var i=0;i<'${maxRow}';i++){
					$('input:checkbox[name="oneCheck'+i+'"]').prop("checked",false);	
				}
		    }
		});
	});
</script>
</head>
<body>

	<jsp:include page="admin_header.jsp"/>
	
	<input type="hidden" name="charge_day" id="charge_day" value="${charge_day}">
	
	<div class="select_div" style="text-align:left; width:980px; margin:0 auto; padding-top:1em;">
		<span style="font-family:'GodoM';">유료회원 관리</span>
		<c:if test="${charge_day == 6}">
			<span class="yn_btn y_btn" onclick="javascript:charge_day_count('6');">7일</span>
			<span class="yn_btn" onclick="javascript:charge_day_count('2');">3일</span>
			<span class="yn_btn" onclick="javascript:charge_day_count('0');">1일</span>
		</c:if>
		<c:if test="${charge_day == '2' }">
			<span class="yn_btn" onclick="javascript:charge_day_count('6');">7일</span>
			<span class="yn_btn y_btn" onclick="javascript:charge_day_count('2');">3일</span>
			<span class="yn_btn" onclick="javascript:charge_day_count('0');">1일</span>
		</c:if>
		<c:if test="${charge_day == '0' }">
			<span class="yn_btn" onclick="javascript:charge_day_count('6');">7일</span>
			<span class="yn_btn" onclick="javascript:charge_day_count('2');">3일</span>
			<span class="yn_btn y_btn" onclick="javascript:charge_day_count('0');">1일</span>
		</c:if>
	</div>
	
	<table class="member_table">
		<tr>
			<td style="color:#29A9C8;">회사이름</td>
			<td style="color:#29A9C8;">종료날짜</td>
			<!-- <td style="color:#29A9C8;">사용유무</td>
			<td style="color:#29A9C8;">코커no</td>
			<td style="color:#29A9C8;">멤버no</td> -->
			<td style="color:#29A9C8;"><input type="checkbox" name="fullCheck" id="fullCheck"/></td>
		</tr>
		<c:forEach var="list" items="${list}" begin="${startRow}" end="${endRow}" varStatus="count">
			<tr>
				<td>${list.koker_name}</td>
				<td>${list.end_date}</td>
				<%-- <td>${list.charge_yn}</td>
				<td>${list.koker_no}</td>
				<td>${list.member_no}</td> --%>
				<td><input type="checkbox" name="oneCheck${count.count}" id="oneCheck${count.count}" value="${list.hp_reg_id}${list.hp_kind}"/></td>
			</tr>
		</c:forEach>
	</table>
	
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
	
	<div style="width:980px; text-align:right; font-size:14px; font-family:'GodoM'; margin:0 auto;">
		<span onclick="javascript:push_confirm();" style="color:#fff; padding:.5em 2em; background-color:#29A9C8; border-radius:20px; cursor:pointer;">푸쉬 보내기</span>
	</div>	
		
</body>
</html>