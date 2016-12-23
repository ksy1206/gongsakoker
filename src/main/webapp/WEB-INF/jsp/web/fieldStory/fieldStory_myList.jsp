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
<script src="../js/jquery.bxslider.min.js"></script>
<link rel="stylesheet" href="<%=cp %>/css/jquery.bxslider.css">
<link rel="stylesheet" href="<%=cp %>/css/layout.css" />
<link rel="stylesheet" href="<%=cp %>/css/main.css" />
<link rel="stylesheet" href="<%=cp %>/css/swiper.min.css">
<script type="text/javascript">

window.onload=function getZip_area(){
	fieldStory_search();
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
function change_list(data){
	if(data == 1){
		$("#list_select").val("new");
		fieldStory_search();
	} else if(data == 2){
		$("#list_select").val("comment");
		fieldStory_search();
	} else if(data == 3){
		$("#list_select").val("recommend");
		fieldStory_search();
	}
}

//검색
function fieldStory_search(){
	var list_select = $("#list_select").val();
	var search_choice = $("#search_choice").val();
	var search_content = $("#search_content").val();
	var sido = $("#areaList").val();
	var gugun = $("#cityList").val();
	var pageNum = $("#pageNum").val();
	var member_no = $("#session_member_no").val();
	params = "sido="+sido+"&gugun="+gugun+"&list_select="+list_select+"&search_choice="+search_choice+"&search_content="+search_content+"&member_no="+member_no+"&pageNum="+pageNum;
    $.ajax({
        type        : "POST" 
      , async       : false
      , url         : "/fieldStory_web/search_fieldStory.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
       	$( "#dialog_txt").text( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );
        $( "#popupDialog").popup( "open");
      }
      , success     : function(data) {
    	  var html = "";
    	  $.each(data.fieldStory.rows, function(index, fieldStory){
			html += "<div class='container_content' onclick='details("+fieldStory.fs_no+")'>";
			html += "<div class='content_local'>"+fieldStory.sido+" "+fieldStory.gugun+"</div>";
			if((fieldStory.title).length > 20){
				html += "<div class='content_title'><a href='#'>"+(fieldStory.title).substring(0,20)+"...</a>";
			} else {
				html += "<div class='content_title'><a href='#'>"+fieldStory.title+"</a>";
			}	
			html += "<img src='<%=cp %>/img/local/comment_icon.png' style='width:20px;padding:0 1%;vertical-align:middle;'>";
			html += "<span>"+fieldStory.answer_count+"</span>";
			html += "</div>"
			html += "<div class='content_person'>"+fieldStory.member_id+"</div>";
			html += "<div class='content_good'>"+fieldStory.recommend_count+"</div>";
			html += "<div class='content_date'>"+(fieldStory.insertDate).substring(0,10)+"</div>";
			html += "</div>";
    	  });    	  
    	  
    	  if(data.fieldStory == null || data.fieldStory == ""){
    		  html += "<div style='text-shadow:none; font-weight:normal !important; color:#666; font-size:14px;'> 검색 결과가 없습니다.</div>"
    	  }
    	  $("#content_list_div").html(html).trigger("create");
    	  
    	  //페이징 id=fieldStory_pageNum
    	  var check = false;
    	  var html2 = "";
    	  html2 += "<ul>";
    	  
    	  if(data.fieldStory.page_start > 1){
    		  html2 += "<li><a href='#' onclick='pagging_move("+(Number(data.fieldStory.currentPage)-Number(1))+")'>[이전]</a></li>";		
    	  }
    	  
    	  for(i=data.fieldStory.page_start; i<=data.fieldStory.totalPage; i++){
    		  if(check == false){
    			  if(i == $("#pageNum").val()){
    				  html2 += "<li><a href='#' onclick='pagging_move("+i+")'>["+i+"]</a></li>";
    			  } else {
    				  html2 += "<li><a href='#' onclick='pagging_move("+i+")'>"+i+"</a></li>";
    			  }
    			  
      			  if(data.fieldStory.page_count < data.fieldStory.totalPage){
      				if(i == data.fieldStory.page_count){
      					check = true;
//       					html2 += "<li><a href='#' onclick='pagging_move("+(Number(data.fieldStory.currentPage)+Number(1))+")>[다음]</a></li>"
      					html2 += "<li><a href='#' onclick='pagging_move("+(Number(data.fieldStory.currentPage)+Number(1))+")'>[다음]</a></li>"
      				}
      			  }
    		  }  
    	  }
    	  
		  html2 += "</ul>";
    	  
    	  $("#fieldStory_pageNum").html(html2).trigger("create");
      }
	});
}

function fieldStory_web_main(){
	location.href="<%=cp%>/fieldStory_web/mainList.do";
}
	
//페이징 처리 함수
function pagging_move(pageNum){
	$("#pageNum").val(pageNum);
	fieldStory_search();
}

//글쓰기 페이지 이동
function fieldStory_write(){
	location.href="<%=cp%>/fieldStory_web/posting.do";
}

</script>
<script>
$(document).ready(function(){
  $('.bxslider').bxSlider({
	  mode: 'horizontal',
	  auto:true,
	  autoControls: true,
	  pause: 5500,
	});
});
</script>

</head>
<div>
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
	
	<input type="hidden" id="pageNum" value="1">
	<input type="hidden" id="list_select" value="new">
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="session_member_no">
	<input type="hidden" id="my_fieldStory_list">
	
	<div class="board_notice"  style="box-shadow:0 5px 5px #d7d7d7;">
		<article class="main_notice">
			<ul class="bxslider">
				<c:forEach var="data" items="${fieldStoryNotice_list}">
				<li><a href="#">${data.c_s_title}</a></li>
				</c:forEach>
			</ul>
		</article>
	</div>
	
	<div>
		<div class="board_sub_title"> 
		    <div style="line-height: 48px;">
		    	<div class="board_search_left">
					<select  id="areaList"  onchange="getZip_city()"  >
						<option value="default">시 / 도를 선택해주세요.</option>			  
					</select>
					<select id="cityList"  >
						<option value="default">구 / 군을 선택해주세요.</option> 
					</select>
				</div>
				<div class="board_search">
					<div class="search-wrapper">
						<form>
							<select id="search_choice" style="padding: .5em 0em .5em 1em;border:solid #21b4d6 2px;">
								<option value="1" selected>제목</option>
								<option value="2">작성자</option>
								<option value="0">제목 + 내용</option>
							</select>
							<input type="text" name="focus" required class="search-box" placeholder="검색어를 입력해주세요." id="search_content" />
							<span onclick="fieldStory_search()">검색</span>
						</form>
					</div>
				</div>
			</div>
		</div>		
	</div>
	
	<div class="board_content">
		<div class="board_post_icon">
			<span onclick="fieldStory_web_main()" class="mypost" style="cursor:pointer;">전체글<img src="<%=cp %>/img/local/mypost_icon.png" style="width:8%;vertical-align:middle;padding-left: .5em;"></span>
			<span onclick="fieldStory_write()" class="posting" style="cursor:pointer;">글쓰기<img src="<%=cp %>/img/local/posting_icon.png" style="width:8%;vertical-align:middle;padding-left: .5em;"></span>
		</div>
		<div class="board_range">
			<ul>
				<li><a href="#" onclick="change_list('1')">최신순</a> |</li>
				<li><a href="#" onclick="change_list('2')">댓글순</a></li>
				<li>| <a href="#" onclick="change_list('3')">추천순</a></li>
			</ul>
		</div>
	</div>
	
	<div id="area_back_cha" style="display:none; text-align:center; width:100%; margin:0 auto;">
		<p><img src="../img/board/no_tikok.gif" style="width:40%; vertical-align: middle;"/>검색 결과가 없습니다.</p>
	</div>
	
    <div class="container">
		<form>
		  	<div id="list_div" class="board_content" style="margin:0 auto; text-align:center;">
		  		<div class="container_title">
		  			<div class="content_local">지역</div>
		  			<div class="content_title">제목</div>
		  			<div class="content_none content_person" >작성자</div>
		  			<div class="content_none content_good" >추천</div>
		  			<div class="content_none content_date" >등록일</div>
		  		</div>
		  		<div id="content_list_div">
			  	
		  		</div>
		    </div>
		</form>		
	</div>
	
	<div class="list_num" id="fieldStory_pageNum">
	<!-- 페이징 -->
	</div>
	
	
	
	<div class="footer_wrap">
		<jsp:include page="../../web/include/footer.jsp"/>
	</div>
</div>
</body>
</html>
