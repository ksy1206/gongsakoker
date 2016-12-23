<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<script type="text/javascript"  src="<%=cp%>/js/jquery.form.js"></script>
	<script type="text/javascript" src="<%=cp %>/js/member/memberJoin_web.js"></script>
	<link rel="stylesheet" href="<%=cp%>/css/layout.css" />
	<link rel="stylesheet" href="<%=cp%>/css/main.css" />
	<link rel="stylesheet" href="<%=cp%>/css/join.css">
</head>
<script type="text/javascript">

</script>
<body>
   <input type="hidden" id="chk_id_btn_yn" value="N"/>
   <input type="hidden" id="member_id_chk" value="N"/>
   <input type="hidden" id="params" value="" />
	<div class="wrapper">
		<div class="board_header">
			<jsp:include page="../../web/include/header.jsp"/>
			<div class="title" style="vertical-align: bottom; padding:3em 0 2em 0; text-align:center; border-bottom:solid 1px #ddd;">
				<i><h1 style="color:#21b4d6; font-size:32px;">JOIN<span style="font-size:14px; color:#636363;">회원가입</span></h1>
					<p style="color: #888; vertical-align: middle; font-size:11px;">회원 정보를 입력해주세요.</p></i>
			</div>
		</div>
		
		<div class="board_content">
			<p style="margin:2em; font-size:24px; text-align: center;">일반회원</p>
			<div style="border:solid 2px #21b4d6; border-radius:20px; padding:0 1em; margin-bottom:2em;">
			    <div class="join_grid">
			        <div class="join_grid_sec_2" style="width:25%;">
			          	 <p>이름</p>
			        </div>
			        <div class="join_grid_sec_2" style="width:75%;">
			          	 <input placeholder="이름을 입력해주세요." type="text" style="width:90%;" id="name"/>
			        </div>
		   		</div>
			    <div class="join_grid">
			        <div class="join_grid_sec_3" style="width:25%;">
			          	 <p>이메일</p>
			        </div>
			        <div class="join_grid_sec_3" style="width:50%;">
			          	 <input placeholder="OOO@email.com" type="email" style="width:90%;"  id="member_id" />
			        </div>
			        <div class="join_grid_sec_3" style="width:25%;">

			        	<p style="font-size:14px; border-radius:20px; background-color:#21b4d6; color:#fff; text-align: center; padding:.5em 0; cursor:pointer;" id="check_member_id">중복확인</p>
			        </div>
		   		</div>
<!-- 			    <div class="join_grid"> -->
<!-- 			        <div class="join_grid_sec_2" style="width:25%;"> -->
<!-- 			          	 <p>휴대폰</p> -->
<!-- 			        </div> -->
<!-- 			        <div class="join_grid_sec_2" style="width:75%;"> -->
<!-- 			          	 <input placeholder="휴대폰 번호를 입력해주세요" type="tel" style="width:90%;" /> -->
<!-- 			        </div> -->
<!-- 		   		</div> -->
			    <div class="join_grid">
			        <div class="join_grid_sec_2" style="width:25%;">
			          	 <p>비밀번호</p>
			        </div>
			        <div class="join_grid_sec_2" style="width:75%;">
			          	 <input placeholder="비밀번호를 입력해주세요." type="password" id="password" style="width:90%;" />
			        </div>
		   		</div>
			    <div class="join_grid" style="border:none;">
			        <div class="join_grid_sec_2" style="width:25%;">
			          	 <p>재입력</p>
			        </div>
			        <div class="join_grid_sec_2" style="width:75%;">
			          	 <input placeholder="비밀번호 재입력해주세요." type="password" id="password_check" style="width:90%;" />
			        </div>
		   		</div>
	   		</div>
			<div style="border:solid 2px #21b4d6; border-radius:20px; padding:0 1em;">
			    <div class="join_grid">
			        <div class="join_grid_sec_2" style="width:25%;">
			          	 <p>약관동의</p>
			        </div>
			        <div class="join_grid_sec_2" style="width:75%;">
			          	 <label style="text-align: right; padding-top: .5em; cursor:pointer;">모두동의
			          	 	<input type="checkbox" name="" id="all_chk" value="" style="float:right;">
			          	 </label>
			        </div>
		   		</div>
		   		<div class="join_tabs">
				    <input id="tab1" type="radio" name="tab" checked="checked" />
				    <input id="tab2" type="radio" name="tab" />
				    <input id="tab3" type="radio" name="tab" />
				    <input id="tab4" type="radio" name="tab" />
				    
				    <label for="tab1">서비스 이용 약관</label>
				    <label for="tab2">개인정보 수집/이용</label>
				    <label for="tab3">개인정보</label>
				    <label for="tab4">제3자 제공</label>
				    
				     <div class="tab1_content" >
				    	<img src="../../img/joinLogin/join_clause_01.png" style="width:90%;margin:0 3%;">
				    </div>
				    <div class="tab2_content">
				    	<img src="../../img/joinLogin/join_clause_02.png" style="width:90%;margin:0 3%;">
				    </div>
				    <div class="tab3_content">
				    	<img src="../../img/joinLogin/join_clause_03.png" style="width:90%;margin:0 3%;">
				    </div>
				    <div class="tab4_content">
				    	<img src="../../img/joinLogin/join_clause_04.png" style="width:90%;margin:0 3%;">	
				    </div>
				</div>
			</div>
		</div>
		<div style=" padding:2em 0;">
			<p style="text-align:center; color:#666; line-height:18px;">※ 비밀번호 분실시 이메일을 통해 확인하므로, 정확하게 입력해주세요. 공사콕커는 자재하자 또는 시공하자 발생시에 책임을 지지 않습니다.</p>
		</div>
		<div style="padding:2em 0;">
			<p style="text-align:center; font-size:18px;">
<!-- 				<span style="padding:1em 2em; background-color:#ddd; color:#fff; border-radius:20px; margin:0 .5em; cursor:pointer;">취소</span> -->
				<span style="padding:1em; background-color:#21b4d6; color:#fff; border-radius:20px; margin:0 .5em; cursor:pointer;" id="memberJoin_btn" >회원가입</span>
			</p>
		</div>
		
		<div class="footer_wrap">
			<jsp:include page="../../web/include/footer.jsp" />
		</div>
	</div>


<script language="Javascript"> 
cookiedata = document.cookie;    
if ( cookiedata.indexOf("maindiv=done") < 0 ){      
    document.all['divpop'].style.visibility = "visible"; 
    } 
    else { 
        document.all['divpop'].style.visibility = "hidden"; 
} 
</script>



</body>
</html>