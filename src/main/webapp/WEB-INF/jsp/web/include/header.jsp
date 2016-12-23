<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="java.util.Map" %>
<%@page import="gongsakoker.vo.MemberVO"%>
<%  
	String cp = request.getContextPath();
	Map sessionData = null;
	
	boolean isSession = true;
	MemberVO memberVO = null;
	String member_no=null;
	String push_yn="";
	String class_code="";
	String member_id = "";
	String member_code="";
	String name = "";
	String hp01="";
	String hp02="";
	String hp03="";
	
	
	if (session.getAttribute("sessionData") != null) {
	    sessionData = (Map)session.getAttribute("sessionData");
	    memberVO = (MemberVO)sessionData.get("memberInfo");
	    member_no = memberVO.getMember_no();
	    push_yn = memberVO.getPush_yn();
		class_code = memberVO.getClass_code();
		member_id =  memberVO.getMember_id();
		member_code= memberVO.getMember_code();
		name = memberVO.getName();
		hp01= memberVO.getHp01();
		hp02= memberVO.getHp02();
		hp03= memberVO.getHp03();
	} else {
	    isSession = false;
	    session.removeAttribute("sessionData");
	}
%>
<script type="text/javascript" src="<%=cp %>/js/web/webHeader.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		var isSession = "<%=isSession%>";
	
		//로그인 처리
		if(isSession=="true"){
			$("#login_on").css("display","");
			$("#login_off").css("display","none");
		}else{
			$("#login_on").css("display","none");
			$("#login_off").css("display","");		
		}
		


	});
</script>
<div class="board_head" style="background-color:#29a9c8; padding:0 1em">
	<nav>
	  <a href="http://www.gongsakoker.com" class="logo">
		<img src="../img/logo.png" style="width:3.5em;"/>
	  </a>
	  <input type="checkbox" id="nav" /><label for="nav"></label>     
		<ul>                                     
<!-- 					<li> -->
<!-- 						<a href="#">▼ 회원명</a> -->
<!-- 						<ul> -->
<!-- 							<li>정보1</li> -->
<!-- 						</ul> -->
<!-- 					</li>                                    -->
	
			<li class="search_btn" style="color:#fff;">
				<select style="color:#fff;line-height:40px; font-size:18px;    width: 20%;"  id="classCodeList">
					<option value="" selected>검색</option>
					<option value="02">자재업체</option>
					<option value="05">시공업체</option>
					<option value="04">장비업체</option>
					<option value="03">기술자</option>
					<option value="06">종합</option>
					<option value="07">운송</option>
				</select>
				<span><img src="<%=cp%>/img/web/header_search_ico.png" style="margin-right:2%;" onclick="search('web');">
				<input type="text" id="search" placeholder="검색어를 입력해 주세요." style="width:55%; border-radius:0; outline:none;font-size:14px;  border-bottom: solid 1px #fff;"></span>
			</li>
			<li class="head_login_btn" style="float:right; text-align:center !important;">
				<a href="<%=cp %>/fieldStory_web/mainList.do" style=" font-size: 20px;  font-weight: 400;">현장스토리</a>
			</li>
			<li class="head_login_btn" style="float:right;text-align:center !important;">
				<a href="https://play.google.com/store/apps/details?id=com.gonggan.koker" style=" font-size: 20px;  font-weight: 400;">다운로드</a>
			</li>
			<li class="head_login_btn" style="float:right;"  id="login_off">
				<span style="color:#29a9c8;background-color:#fff;padding:.5em .7em;border-radius:10px;font-size:10pt;">
				<a href="<%=cp %>/member/webLogin.do" style="color:#29a9c8;font-size:14px;">로그인</a> | 
				<a href="<%=cp %>/member/joinMain.do" style="color:#29a9c8;font-size:14px;">회원가입</a></span>
			</li>
			<li class="head_login_btn" style="float:right; display: none;" id="login_on" >
					<span style="color:#29a9c8;background-color:#fff;padding:.5em .7em;font-size:10pt;border-radius:10px;">
						<a href="<%=cp %>/member/doMember_logout_web.do" style="font-size:16px;color:#29a9c8;">로그아웃</a> 
					</span>
			</li>
		</ul>
	</nav>
</div>