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
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>   
<script type="text/javascript"  src="<%=cp%>/js/jquery.form.js"></script>
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
		$('#event_title_img').setPreview(opt1); 
		$('#event_content_img').setPreview(opt2); 
	}); 
	
</script> 
<!--파일 미리보기 END  -->
<script type="text/javascript">
	$(function() {
		$("#event_date1").datepicker({
			dateFormat : 'yy-mm-dd'
		});
		$("#event_date2").datepicker({
			dateFormat : 'yy-mm-dd'
		});
	});
	
	function insert_submit(){
		
		document.eventInsert.action = 'event_insert.do';
		document.eventInsert.submit();
		
	}
</script>

<title>Insert title here</title>
</head>
<body>

	<jsp:include page="admin_header.jsp"/>
	
	<form  enctype="multipart/form-data" method="post" id="eventUpdate" name="eventUpdate" action="event_update.do">
		
		<c:forEach items="${list}" var="list">
		
		<input type="hidden" value="${list.event_no}" name="event_no"/>
		<input type="hidden" value="${list.event_title_img}" name="file_delete1"/>
		<input type="hidden" value="${list.event_content_img}" name="file_delete2"/>
		<input type="hidden" value="1" name="pageNum">
		
		<p style="font-family:'GodoM'; font-size:18px; width:980px; margin:0 auto; padding-top:1em;">이벤트 수정</p>
		
		<table class="member_table" style="text-align:left;">
				<tr>
					<td>이벤트 제목</td>
					<td colspan="3"><input type="text" name="event_title" value="${list.event_title}"/></td>
				</tr>
				<tr>
					<td>이벤트 내용</td>
					<td colspan="3"><input type="text" name="event_content" value="${list.event_content}"/></td>
				</tr>
				<tr>
					<td>참여방법</td>
					<td colspan="3"><textarea cols="50" rows="5" name="event_participation">${list.event_participation}</textarea></td>
				</tr>
				<tr>
					<td>참여기간</td>
					<td> 
						<input type="text" id="event_date1" name="event_date1" value="${list.event_date1}"/>
					</td>
					<td> ~ </td>
					<td>
						<input type="text" id="event_date2" name="event_date2" value="${list.event_date2}"/>
					</td>
				</tr>
				<tr>
					<td>지급</td>
					<td colspan="3"><input type="text" name="event_pay" value="${list.event_pay}"/></td>
				</tr>
				<tr>
					<td>이벤트 URL 내용</td>
					<td colspan="3"><input type="text" name="event_url_text" value="${list.event_url_text}"></td>
				</tr>
				<tr>
					<td>이벤트URL</td>
					<td colspan="3"><input type="text" name="event_url" value="${list.event_url}"></td>
				</tr>
				<tr>
					<td>이벤트 리스트 이미지</td>
					<td colspan="3">
						<input type="file" name="fileUpload1" id="event_title_img"/>
						<img id="img_preview1" style="display:;height:200px;width:200px;" src="/upload/event/banner/${list.event_title_img}"/>
					</td>
				</tr>
				<tr>
					<td>이벤트 내용 이미지</td>
					<td colspan="3">
						<input type="file" name="fileUpload2" id="event_content_img"/>
						<img id="img_preview2" style="display:;height:200px;width:200px;" src="/upload/event/sub/${list.event_content_img}"/>
					</td>
				</tr>
				<tr>
					<td>사용유무</td>
					<td colspan="3">
						<c:if test="${list.event_use_yn == 'y'}">
							<select name="event_use_yn">
								<option value="y" selected="selected">Yes</option>
								<option value="n">No</option>
							</select>
						</c:if>
						<c:if test="${list.event_use_yn == 'n'}">
							<select name="event_use_yn">
								<option value="y" selected="selected">Yes</option>
								<option value="n" selected="selected">No</option>
							</select>
						</c:if>
					</td>
				</tr>
			</table>
			
		<div style="width:980px; margin:0 auto; text-align:center; padding:2em 0 5em 0;">
			<input type="submit" value="수정" style="padding:.5em 2em; border:solid 2px #29A9C8; background-color:#29A9C8; color:#fff; font-family:'GodoM'; border-radius:5px; margin-right:1em;"/>
			<input type="button" value="취소" onclick="javascript:history.back();" style="padding:.5em 2em; border:solid 2px #29A9C8; background-color:#fff; color:#29A9C8; font-family:'GodoM'; border-radius:5px;" />
		</div>
		</c:forEach>
	</form>
</body>
</html>