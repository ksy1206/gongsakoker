<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%  
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=320, user-scalable=no">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<link rel="stylesheet" href="../css/koker_mobile.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/member/memberJoin.js"></script>
<script type="text/javascript"  src="<%=cp%>/js/jquery.form.js"></script>



</head>


<body>
   <input type="hidden" id="chk_id_btn_yn" value="N"/>
   <input type="hidden" id="member_id_chk" value="N"/>
   <input type="hidden" id="params" value="" />
<div data-role="page" class="koker_page join_font_size">
	<div data-role="header" data-position="fixed" class="join_header">
		<div class="back_btn">
			<a href="../member/memberLogin.do" data-ajax="false" class="relback_btn"><img src="../img/relback.gif"/></a>
		</div>
		<h1>회원가입</h1>
	</div>
	<div data-role="content" class="join_content">
		<p class="join_title">회원정보</p>
		<table>
			<tr>
				<td style=" padding-left:.5em;">
					<label for="name">이름</label>
				</td>
				<td colspan="2">
					<input type="text" id="name" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="이름을 입력해주세요." />
				</td>
			</tr>
			<tr>
				<td style="width:30%; padding-left:.5em;">
					<label for="member_id">이메일</label>
				</td>
				<td style="width:60%;">
					<input type="text" id="member_id" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="OOO@email.com">
				</td>
				<td class="join_button" style="width:10%; padding-right: 0.5em;">
					<input type="button" value="중복확인" id="check_member_id">
				</td>
			</tr>
<!-- 			<tr> -->
<!-- 				<td style="padding-left:.5em;"> -->
<!-- 					<label for="hp">휴대폰</label> -->
<!-- 				</td> -->
<!-- 				<td colspan="2"> -->
<!--					<input type="text" id="hp" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';"  -->
<!--						onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="휴대폰번호를 입력해주세요."/> -->
<!-- 				     <div class="ui-grid-d input_align">  -->
<!-- 					    <div class="ui-block-a" style="width:20% !important; padding:0;"> -->
<!-- 					    	<input type="tel" id="hp01" maxlength="4" value=""  onKeyUp="next_focus('hp01','hp02',3);" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" -->
<!-- 					    	onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" style="text-align:left !important;" /> -->
<!--      					</div>  -->
<!-- 					    <div class="ui-block-b" style="width:5% !important; padding:0;"> -->
<!-- 					    	<p style="margin:.2em 0 0 0;">-</p> -->
<!-- 					    </div>  -->
<!-- 					    <div class="ui-block-c" style="width:20% !important; padding:0;"> -->
<!-- 					    	<input type="tel" maxlength="4" id="hp02" value="" onKeyUp="next_focus('hp02','hp03',4);"  onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" -->
<!-- 					    	onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" style="text-align:left !important;" /> -->
<!-- 				    	</div>  -->
<!-- 					    <div class="ui-block-d" style="width:5% !important; padding:0;"> -->
<!-- 					    	<p style="margin:.2em 0 0 0;">-</p> -->
<!-- 				    	</div>  -->
<!-- 					    <div class="ui-block-e" style="width:20% !important; padding:0;"> -->
<!-- 					    	<input type="tel" maxlength="4" id="hp03" value="" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" -->
<!-- 					    	onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" style="text-align:left !important;" /> -->
<!-- 				    	</div>  -->
<!-- 					</div> -->
<!-- 				</td> -->
<!-- 			</tr> -->
			<tr>
				<td style=" padding-left:.5em;">
					<label for="password">비밀번호</label>
				</td>
				<td colspan="2">
					<input type="password" id="password" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value=""/>
				</td>
			</tr>
			<tr>
				<td style="border-bottom:0 !important; padding-left:.5em;">
					<label for="password_check">재입력</label>
				</td>
				<td colspan="2" style="border:0 !important;">
					<input type="password" id="password_check" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value=""/>
				</td>
			</tr>
		</table>
	</div>
	<div class="join_contant02">
		<div class="join_check">
			<input type="checkbox" name="checkbox-0" id="checkbox-mini-0" class="custom" data-mini="true" style="display:none;"/>
			<label for="checkbox-mini-0" style="padding: 1em 0 1em 1em;"></label>
			<p style="padding: .3em 0;">
				<a href="../appMain/clause.do">서비스 이용약관</a> 및 
				<a href="../appMain/clause.do">개인정보수집/이용</a>, 
				<a href="../appMain/clause.do">개인정보</a>, 
				<a href="../appMain/clause.do">제3자제공</a>에 동의합니다.
			</p>
			<p>* 비밀번호 분실시 이메일을 통해 확인하므로, 정확하게 입력해주세요.</p>
			<p>* 공사콕커는 자재하자 또는 시공하자 발생시에 책임을 지지 않습니다.</p>
		</div>
		<div class="join_submit">
			<input type="button" value="회원가입" id="memberJoin_btn" />
		</div>
	</div>
 

	<div id="popupDialog" class="com_popup" style="max-width:400px;" data-role="popup" data-theme="b" data-overlay-theme="b" data-dismissible="false">
	    <div class="com_popup_text" role="main">
	        <p id="dialog_txt"></p>
	        <a href="#" data-rel="back" data-ajax="false" id="dialog_a">확인</a>
	    </div>
	</div>
	




</div>
</body>
</html>


