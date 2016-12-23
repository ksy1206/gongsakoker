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


<script type="text/javascript">

	$(document).ready(function() {
		//페이지 로딩시 최초 전문분야로딩
		getBusinessKind();
		//페이지 로딩시 최초 지역로딩
		getZip_area();
		
		$("#next_btn").click(function(){
		
		   var name = $( "#name").val();
           var member_id = $( "#member_id").val();
           var member_id_chk =  $( "#member_id_chk").val()
           var password = $( "#password").val();
           var password_check = $( "#password_check" ).val();
           var hp01 = $("#hp01").val();
           var hp02 = $("#hp02").val();
           var hp03 = $("#hp03").val();
           
           if(name == null||name == ""||name == undefined ||name=="이름을 입력해주세요." ){
               $( "#dialog_txt").text( "이름을 입력해주세요.");
               $( "#popupDialog").popup( "open");
               $( "#name").focus();
                return false;
         }
           if(member_id== null||member_id== ""||member_id== undefined ||member_id=="OOO@email.com" ){
               $( "#dialog_txt").text( "이메일을 입력해주세요.");
               $( "#popupDialog").popup( "open");
               $( "#member_id").focus();
                return false;
                 
          }
           
           if($( "#chk_id_btn_yn").val()== "N"){
               $( "#dialog_txt").text( "중복확인을 해주세요.");
               $( "#popupDialog").popup( "open");
               $( "#password_check" ).focus();
                return false;
          }
           
           if(member_id_chk == "N" ){
          	 $( "#dialog_txt").text( "아이디 중복확인을 해주세요." );
               $( "#popupDialog").popup( "open");
               $( "#member_id").focus();
                return false;
         }
           
           if(hp01 == null||hp01 == ""||hp01 == undefined){
               $( "#dialog_txt").text( "휴대폰번호를 입력해주세요.");
               $( "#popupDialog").popup( "open");
               $( "#hp01").focus();
                return false;
          
          } 
           if(hp02 == null||hp02 == ""||hp02 == undefined){
               $( "#dialog_txt").text( "휴대폰번호를 입력해주세요.");
               $( "#popupDialog").popup( "open");
               $( "#hp02").focus();
                return false;
          
          } 
           if(hp03 == null||hp03 == ""||hp03 == undefined){
               $( "#dialog_txt").text( "휴대폰번호를 입력해주세요.");
               $( "#popupDialog").popup( "open");
               $( "#hp03").focus();
                return false;
          
          } 
          
           if(password== null||password== ""||password== undefined ||password=="비밀번호를 입력해주세요." ){
               $( "#dialog_txt").text( "비밀번호를 입력해주세요.");
               $( "#popupDialog").popup( "open");
               $( "#password").focus();
                return false;
          
    }
           if(password_check== null||password_check== ""||password_check==undefined ||password_check=="비밀번호를 재입력해주세요." ){
               $( "#dialog_txt").text( "비밀번호확인을 입력해주세요.");
               $( "#popupDialog").popup( "open");
               $( "#password_check" ).focus();
                return false;
     
          }
          
           if(password_check!=password){
                //pw불일치
               $( "#dialog_txt").text( "비밀번호 불일치" );
               $( "#popupDialog").popup( "open");
               $( "#password_check" ).focus();
                return false;
          }
           
           var pattern1 = /[0-9]/; //숫자
           var pattern2 = /[a-zA-Z]/; //문자
//           var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/; //특수문자
             

           if( !pattern1.test(password) || !pattern2.test(password)  || password.length<6 || password.length>12 ){
          	 $( "#dialog_txt").text( "비밀번호는 문자,숫자 포함한 6~12자리로 구성하여야 합니다.");
               $( "#popupDialog").popup( "open");
               $( "#password" ).focus();
                return false;
        
           }
           var pattern_semi = /[;]/;  
           if(pattern_semi.test(password)){
          	 $( "#dialog_txt").text( "비밀번호에 ';' 은 포함시킬 수 없습니다.");
               $( "#popupDialog").popup( "open");
               $( "#password" ).focus();
                return false;
           }
          
          
			$("#join_1").css("display","none");
			$("#join_2").css("display","");
			$("#next_btn").css("display","none");
			$("#join_btn").css("display","");
			$("#join_check").css("display","");
		});
		
	});//end document ready
	
	//안드로이드 파일가져오기
	// str -> 첨부파일,사업자등록증인지 확인
	function getFile(str) {
		var useragent = navigator.userAgent;
		if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
			window.android.getFile(str);
		}
		else if(useragent.indexOf("Connect By iPhone OS") > -1) {
		} 	    
		else {
		    	 	
		}
	}
	
	//안드로이드 파일세팅 4.42 이하 실행
	function setFilePath1(path, name, dest){

		path = splitColon(path);
		dest = splitColon(dest);
		$("#android_version_chk").val("y");
		$("#fileUploadPath1").val(path);
		$("#fileNewName1").val(name);
		$("#destination1").val(dest);
		//파일첨부완료메시지
		window.android.uploadcomplete();
	}
	function setFilePath2(path, name, dest){
		path = splitColon(path);
		dest = splitColon(dest);
		$("#android_version_chk").val("y");
		$("#fileUploadPath2").val(path);
		$("#fileNewName2").val(name);
		$("#destination2").val(dest);
		//파일첨부완료메시지
		window.android.uploadcomplete();
	}
	
	
	function getFileName() {
		window.android.uploadcomplete();
		
	}
	
	//파일업로드 스플릿
	function splitColon(str){
		
		str_arr = str.split(":");
		str = str_arr[1];
		
		return str;
		
	}
</script>
<body>
	
  <input type="hidden" id="chk_id_btn_yn" value="N"/>
  <input type="hidden" id="member_id_chk" value="N"/>
  <input type="hidden" id="params" value="" />
  <input type="hidden" id="android_version_chk" value="n" />
<div data-role="page" class="koker_page">
	<div data-role="header" class="join_header">
		<div class="back_btn">
			<a href="../member/memberLogin.do" data-ajax="false"  class="relback_btn"><img src="../img/relback.gif"/></a>
		</div>
		<h1>업체 및 기술자 회원가입</h1>
		
	</div>
	<div data-role="content" class="join_content">
	<div id="join_1">
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
			<tr>
				<td style="padding-left:.5em;">
					<label for="hp">휴대폰</label>
				</td>
				<td colspan="2">
<!-- 					<input type="text" id="hp" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';"  -->
<!-- 							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="휴대폰번호를 입력해주세요."/> -->
				     <div class="ui-grid-d input_align"> 
					    <div class="ui-block-a" style="width:20% !important; padding:0;">
					    	<input type="tel" id="hp01" maxlength="4" value=""  onKeyUp="next_focus('hp01','hp02',3);" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';"
					    	onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" style="text-align:left !important;" />
     					</div> 
					    <div class="ui-block-b" style="width:5% !important; padding:0;">
					    	<p style="margin:.2em 0 0 0;">-</p>
					    </div> 
					    <div class="ui-block-c" style="width:20% !important; padding:0;">
					    	<input type="tel" id="hp02" maxlength="4" value="" onKeyUp="next_focus('hp02','hp03',4);"  onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';"
					    	onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" style="text-align:left !important;" />
				    	</div> 
					    <div class="ui-block-d" style="width:5% !important; padding:0;">
					    	<p style="margin:.2em 0 0 0;">-</p>
				    	</div> 
					    <div class="ui-block-e" style="width:20% !important; padding:0;">
					    	<input type="tel" id="hp03" maxlength="4"  value=""  onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';"
					    	onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" style="text-align:left !important;" />
				    	</div> 
					</div>
				</td>
			</tr>
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
		<div id="join_2" style="display: none;">
		<!-- 자재업체, 시공업체 -->
		<p class="join_title" style="margin:1em 0 .3em 0;">업체 정보</p>
		<table class="company_table">
			<tr>
				<td style="width:25%; padding-left:.5em;">
					<p style="font-size: 14px; padding-top: 5px; color: #686868; margin:0;">회원 유형</p>
				</td>
				<td style="width:75%;" class="radio_check">
					<div class="ui-grid-b"> 
					    <div class="ui-block-a">
					  	 	<input class='' id='radio01' type='radio' name="chk_info" value="02" checked="checked">
   							<label class='' for='radio01'>자재업체</label>
				    	</div> 
					    <div class="ui-block-b">
					  	 	<input class='' id='radio02' type='radio' name="chk_info" value="05">
   							<label class='' for='radio02'>시공업체</label>
					    </div> 
					    <div class="ui-block-c">
					  	 	<input class='' id='radio03' type='radio' name="chk_info" value="04">
   							<label class='' for='radio03'>장비업체</label>
					    </div> 
				    </div>
				    <div class="ui-grid-b">
					    <div class="ui-block-a">
					  	 	<input class='' id='radio04' type='radio' name="chk_info" value="03">
   							<label class='' for='radio04'>기술자</label>
					    </div> 
					     <div class="ui-block-b">
					  	 	<input class='' id='radio05' type='radio' name="chk_info" value="06">
   							<label class='' for='radio05'>종합</label>
					    </div> 
					     <div class="ui-block-c" >
					  	 	<input class='' id='radio06' type='radio' name="chk_info" value="07" >
   							<label class='' for='radio06'>운송</label>
					    </div> 
					</div>
				</td>
			</tr>
			<tr>
				<td style=" padding-left:.5em;">
					<label for="company_name">업체명</label>
				</td>
				<td>
					<input type="text" id="company_name" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="업체명을 입력해주세요." />
				</td>
			</tr>
			<!-- 기술자 -->
			<tr id="tec_local">
				<td style=" padding-left:.5em;">
					<label for="company_name">지  역</label>
				</td>
				<td class="area_select">
					<div class="ui-grid-a">
						<div class="ui-block-a">
							<select  id="areaList"  onchange="getZip_city()"  >
							 <option value="default">도를 선택해주세요</option>
							</select>
						</div>
						<div class="ui-block-b">
							<select id="cityList"  >
							 <option value="default">시/ /구를 선택해주세요</option> 
							</select>
						</div>
					</div>
				</td>
			</tr>
			<!-- 기술자 끝 -->
			<tr>
				<td style="padding-left:.5em;">
					<label for="company_tel">업체 전화</label>
				</td>
				<td>
<!-- 					<input type="text" id="company_tel" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';"  -->
<!-- 							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="업체 연락가능한 번호를 입력해주세요."> -->
				     <div class="ui-grid-d input_align"> 
					    <div class="ui-block-a" style="width:20% !important; padding:0;">
					    	<input type="tel" id=call_tel01 value=""  maxlength="4" onKeyUp="next_focus('call_tel01','call_tel02',3);" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';"
					    	onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" style="text-align:left !important;" />
     					</div> 
					    <div class="ui-block-b" style="width:5% !important; padding:0;">
					    	<p style="margin:.2em 0 0 0;">-</p>
					    </div> 
					    <div class="ui-block-c" style="width:20% !important; padding:0;">
					    	<input type="tel" id="call_tel02" value="" maxlength="4" onKeyUp="next_focus('call_tel02','call_tel03',4);" onKeyUp="next_focus('hp01','hp02',3);" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';"
					    	onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" style="text-align:left !important;" />
				    	</div> 
					    <div class="ui-block-d" style="width:5% !important; padding:0;">
					    	<p style="margin:.2em 0 0 0;">-</p>
				    	</div> 
					    <div class="ui-block-e" style="width:20% !important; padding:0;">
					    	<input type="tel" id="call_tel03" value="" maxlength="4" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';"
					    	onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" style="text-align:left !important;" />
				    	</div> 
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="padding-left:.5em; border-bottom:0 !important;">
					<p style="font-size: 12px; padding-top: 5px; color: #686868; margin:0;">전문 분야
						<span style="font-size:8px; color:#999; padding-left:.3em;"> 중복선택가능합니다.</span>
					</p>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="" >
					<div class="ui-grid-b total_type" id=code_name_div> 

					</div>
				</td>
			</tr>
		</table>
		<p class="join_title" style="margin:1em 0 .3em 0;" id= file_upload_p>파일첨부</p>
		
			<table id="file_upload_table"  style="padding: .3em 0 .2em 0;">
				<tr id="business_license">
					<td style="width:35%; padding-left:.5em; border: none !important;">
						<label for="company_paper" >사업자등록증</label>
					</td>
					<td style="padding: 0 .3em 0 0; border: none !important;">
						<div class="fileUpload">
			    			<span>사업자등록증 첨부하기</span>
			    			<input type="hidden" id="fileUploadPath1" name="fileUploadPath1" value="" />
							<input type="hidden" id="fileNewName1" name="fileNewName1" value="" />
							<input type="hidden" id="destination1" name="destination1" value="" />
							<form id="file_upload1" name="file_upload1" method="post"  enctype="multipart/form-data" action="<%=cp%>/comm/saveFileUpload.do?fileGbn=company_paper">
								<input type="file" class="upload" id="company_paper" name="file" accept="image/*;capture=camera"  onClick="getFile('company_paper')"> 
							</form>
						</div>
					</td>
				</tr>
				<tr id="license">
					<td style="width:25%; padding-left:.5em;">
						<label for="company_paperwr02">공사면허증</label>
					</td>
					<!-- 시공업체 -->
					<td style="padding: 0 .3em 0 0;">
						<div class="fileUpload">
			    			<span>공사면허증 첨부하기</span>
			    			<input type="hidden" id="fileUploadPath2" name="fileUploadPath2" value=""/>
							<input type="hidden" id="fileNewName2" name="fileNewName2" value="" />
							<input type="hidden" id="destination2" name="destination2" value="" />
			    			<form id="file_upload2" name="file_upload2" method="post"  enctype="multipart/form-data" action="<%=cp%>/comm/saveFileUpload.do?fileGbn=company_paper02">
								<input type="file" class="upload" name="file" id="company_paper02" accept="image/*;capture=camera" onClick="getFile('company_paper02')"> 
							</form>
						</div>
					</td>
					<!-- 시공업체 끝 -->
				</tr>
			</table>
	
		<!-- 자재업체, 시공업체 끝 -->
	</div>
		
	</div>
	
	<div class="join_contant02">
		<div class="join_check"  id="join_check" style="display:none;">
			<input type="checkbox" name="checkbox-0" id="checkbox-mini-0" class="custom" data-mini="true" style="display:none;"/>
			<label for="checkbox-mini-0" style="padding: 2em 0 1em 3em;"></label>
			<p style="padding: .3em 0;"><a href="../appMain/clause.do">서비스 이용약관</a> 및  <a href="../appMain/clause.do">개인정보수집/이용</a>, <a href="../appMain/clause.do">개인정보</a>, <a href="../appMain/clause.do">제3자제공</a>에 동의합니다.</p>
			<p>* 비밀번호 분실시 이메일을 통해 확인하므로, 정확하게 입력해주세요.</p>
			<p>* 공사콕커는 자재하자 또는 시공하자 발생시에 책임을 지지 않습니다.</p>
		</div>
		<div class="join_submit">
			<div  id="next_btn">
				<input type="button" value="다음"  />
			</div>
			<div  style="display:none;" id="join_btn">
				<input type="button" value="회원가입" id="memberJoin_btn" />
			</div>
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


