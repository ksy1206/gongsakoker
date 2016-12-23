<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<script src="//code.jquery.com/jquery-1.11.3.min.js" ></script >
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>   
<script type="text/javascript"  src="<%=cp%>/js/jquery.form.js"></script>
<c:if test="${result == 1}">
<script>

	alert("수정되었습니다!!");

</script>
</c:if>
<script type="text/javascript">
	function cm_board_update(data){
		
		var cm_use_yn = $('#cm_use_yn').val();
		var str = 'cm_use_yn='+cm_use_yn+'&cm_no='+data;
		
		$.ajax({
		       type        : "POST"  
		     , async       : false 
		     , url         : "/admin/community_update.do"
		     , data        : str
		     , dataType    : "json" 
		     , timeout     : 30000   
		     , cache       : false     
		     , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		     , error       : function(request, status, error) {
				alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
		     }
		     , success     : function(data) {
		    	
		    	 alert('수정되었습니다.');
		    	
		     }
	    });	
		
	}
	function reply_board_update(data){
		
		var reply_use_yn = $('#reply_use_yn').val();
		var str = 'reply_use_yn='+reply_use_yn+'&reply_no='+data;
		
		$.ajax({
		       type        : "POST"  
		     , async       : false 
		     , url         : "/admin/reply_update.do"
		     , data        : str
		     , dataType    : "json" 
		     , timeout     : 30000   
		     , cache       : false     
		     , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		     , error       : function(request, status, error) {
				alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
		     }
		     , success     : function(data) {
		    	
		    	 alert('수정되었습니다.');
		    	
		     }
	    });	
	}
</script>

<title>Insert title here</title>
</head>
<body>
	
	<jsp:include page="admin_header.jsp"/>
	<div style="width:980px; margin:0 auto; border:double 4px #29A9C8; margin-top:2em; padding:1em; border-radius:5px; font-family:'GodoM'; font-size:14px; color:#666;">

		<c:forEach items="${list}" var="list">
		
			<input type="hidden" name="c_s_no" id="c_s_no" value="${list.cm_no}">
		
			<table style="width:100%;">	
				<tr>
					<td style="width:20%;">내용</td>
					<td>${list.cm_content}</td>
					<c:choose>
						<c:when test="${gubun=='1'}">
							<c:if test="${list.cm_no == cm_no}">
								<td rowspan="5"><img src="${cp}/img/admin/admin_report.png"></td>
							</c:if>
						</c:when>
						<c:otherwise>
							<td rowspan="5"></td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<td>작성날짜</td>
					<td>${list.cm_insert_date}</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td>${list.name}</td>
				</tr>
				<tr>
					<td style="width:20%;">추천수</td>
					<td>${list.recommend_count}</td>
				</tr>
				<tr>
					<td>사용유무</td>
					<td>
						<select id="cm_use_yn" name="cm_use_yn">
							<c:if test="${list.cm_use_yn == 'y'}">
								<option value="y" selected="selected">yes</option>
								<option value="n">no</option>
							</c:if>
							<c:if test="${list.cm_use_yn == 'n'}">
								<option value="y">yes</option>
								<option value="n" selected="selected">no</option>
							</c:if>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="3" style="text-align:center; padding:3em 0 1em 0;">
						<input type="button" value="수정"  onclick="javascript:cm_board_update('${list.cm_no}');" style="font-family:'GodoM'; font-size:14px; color:#fff; border:solid #29A9C8 1px; background-color:#29A9C8; border-radius:5px; padding:.5em 2em; margin-right:1em;"/>
						<input type="button" value="취소"  onclick="location.href='admin_community.do?pageNum=1'" style="font-family:'GodoM'; font-size:14px; color:#29A9C8; border:solid #29A9C8 1px; background-color:#fff; border-radius:5px; padding:.5em 2em;"/>
					</td>
				</tr>
			</table>
		</c:forEach>
		
		<c:forEach items="${reply_list}" var="replyList">
			<table style="width:100%;" class="member_table">
				
				<tr>
					<td style="width:20%;">내용</td>
					<td>${replyList.reply_content}</td>
					<c:choose>
						<c:when test="${gubun=='2'}">
							<c:if test="${replyList.reply_no == reply_no}">
								<td rowspan="5"><img src="${cp}/img/admin/admin_report.png"></td>
							</c:if>
						</c:when>
						<c:otherwise>
							<td rowspan="5"></td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<td>작성날짜</td>
					<td>${replyList.reply_insert_date}</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td>${replyList.name}</td>
				</tr>
				<tr>
					<td style="width:20%;">사용유무</td>
					<td>
						<select id="reply_use_yn" name="reply_use_yn">
							<c:if test="${replyList.reply_use_yn == 'y'}">
								<option value="y" selected="selected">yes</option>
								<option value="n">no</option>
							</c:if>
							<c:if test="${replyList.reply_use_yn == 'n'}">
								<option value="y">yes</option>
								<option value="n" selected="selected">no</option>
							</c:if>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="3"><span onclick="javascript:reply_board_update('${replyList.reply_no}');">수정</span></td>
				</tr>
			</table>	
		</c:forEach>		
	</div>
</body>
</html>