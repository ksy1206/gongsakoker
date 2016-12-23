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
<link rel="stylesheet" href="../css/alertify.core.css" />
<link rel="stylesheet" href="../css/alertify.default.css" id="toggleCSS" />

<style>
	p{margin:1em 0;}
</style>
<script src="../js/web/alertify.min.js"></script>

<script>
    $(document).ready(function() {
      $('.fielddetail_content').on( 'keyup', 'textarea', function (e){
        $(this).css('height', 'auto' );
        $(this).height( this.scrollHeight );
      });
      $('.fielddetail_content').find( 'textarea' ).keyup();
    });
  </script>

<title>공사 KOKER</title>

<script type="text/javascript">

//댓글 삭제하기
function answer_delete(ans_no){
	var fs_no = $("#fs_no").val();
	var params = "fs_no="+fs_no+"&ans_no="+ans_no;
	$.ajax({
	    type        : "POST" 
	  , async       : false
	  , url         : "/admin/fieldStory_deleteAnswer.do"
	  , data        : params
	  , dataType    : "json"
	  , timeout     : 30000  
	  , cache       : false    
	  , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	  , error       : function(request, status, error) {
	   		alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 개발팀에 문의하십시오." );	
	  }
	  , success     : function(data) {	       
	       location.reload();
	       alert("삭제 완료");
	  }
	});
}

//글 사용유무 변경
function update_fieldStory(){
	var fs_no = $("#fs_no").val();
	var use_yn = $("#use_yn").val();
	var params = "fs_no="+fs_no+"&use_yn="+use_yn; 
	$.ajax({
	    type        : "POST" 
	  , async       : false
	  , url         : "/admin/modify_fieldStory.do"
	  , data        : params
	  , dataType    : "json"
	  , timeout     : 30000  
	  , cache       : false    
	  , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	  , error       : function(request, status, error) {
	   		alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 개발팀에 문의하십시오." );	      
	  }
	  , success     : function(data) {        			
	       alert("수정완료");
	  }
	});
}

</script>

</head>
<body>
	<jsp:include page="admin_header.jsp"/>

	<input type="hidden" value="${fieldStoryVo.fs_no}" id="fs_no">
	
<div class="field_container" style="width:980px; margin:3em auto;">
	<div class="fielddetail_title">
		<h2>${fieldStoryVo.title}</h2>		
		<p class="admin_grid_sec_3" style="width:60%;">${fieldStoryVo.member_id}<span style="margin:0 10px;">|</span><span>${fieldStoryVo.sido} ${fieldStoryVo.gugun}</span></p>
		<div class="admin_grid_sec_3" style="width:20%;">
			<select onchange="update_fieldStory()" id="use_yn">
				<c:if test="${fieldStoryVo.use_yn == 'y'}">
					<option value="y" selected="selected">사용</option>
					<option value="n">사용안함</option>
				</c:if>
				<c:if test="${fieldStoryVo.use_yn == 'n'}">
					<option value="y">사용</option>
					<option value="n" selected="selected">사용안함</option>
				</c:if>
			</select>
		</div>
		<div class="admin_grid_sec_3" style="width:20%;">
			<c:choose>
				<c:when test="${gubun=='1'}">
					<c:if test="${fieldStoryVo.fs_no == fs_no}">
						<img src="${cp}/img/admin/admin_report.png" style="width:3em; vertical-align:bottom;">
					</c:if>
				</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="fielddetail_content">
		<p><textarea readonly="readonly" style="width:100%;border:none;resize:none;font-family:'나눔바른고딕';">${fieldStoryVo.content}</textarea></p>
		<div class="fielddetail_photobox">
			<c:if test="${fieldStoryVo.img01 != null && fieldStoryVo.img01 != ''}">
				<c:if test="${fieldStoryVo.img02 == null || fieldStoryVo.img02 == ''}">
					<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img01}" width="100%"/>
				</c:if>
				<c:if test="${fieldStoryVo.img03 == null || fieldStoryVo.img03 == ''}">
					<c:if test="${fieldStoryVo.img02 != null && fieldStoryVo.img02 != ''}">
						<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img01}" width="49%"/>
						<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img02}" width="49%"/>
					</c:if>
				</c:if>
				<c:if test="${fieldStoryVo.img03 != null && fieldStoryVo.img03 != ''}">
					<c:if test="${fieldStoryVo.img02 != null && fieldStoryVo.img02 != ''}">
						<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img01}" width="30%"/>
						<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img02}" width="30%"/>
						<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img03}" width="30%"/>
					</c:if>
				</c:if>
			</c:if>
		</div>
	</div>
	<div class="fielddetail_ico">
		<span class="fielddetail_ico_good">
			<div id="recommend_div">
				<p>${fieldStoryVo.recommend_count}명이 추천합니다.</p>
			</div>
		</span>
	</div>
	<div class="fielddetail_comment">
		<div class="fielddetail_comment_area">
			<p>댓글 <span style="color:red;">${fieldStoryVo.answer_count}</span></p>
		</div>
		<div class="fielddetail_comment_list">
			<c:forEach var="answer" items="${fieldStoryAnswer}">
				<div class="fielddetail_comment_list_01">
					<div>
						<span style="font-size:11pt;margin-right:20px;">작성자 : ${answer.member_id}</span>
						<span style="font-size:11pt;margin-right:20px;">내용 : ${answer.ans_content}</span>
						<span style="color:#969696;">${answer.ans_insertDate}</span>
						<span>
							<input type="button" value="삭제" onclick="answer_delete('${answer.ans_no}')">
						</span>
						<span>
							<c:choose>
								<c:when test="${gubun=='2'}">
									<c:if test="${answer.ans_no == ans_no}">
										<img src="${cp}/img/admin/admin_report.png" style="width: 3em;">
									</c:if>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						</span>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
</body>
</html>