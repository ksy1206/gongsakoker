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
	<link rel="stylesheet" href="../css/alertify.core.css" />
	<link rel="stylesheet" href="../css/alertify.default.css" id="toggleCSS" />
	<script src="../js/web/alertify.min.js"></script>
</head>
<script type="text/javascript">

	$(document).ready(function() {
		
		
		//페이지 로딩시 최초 전문분야로딩
		getBusinessKind();
		//페이지 로딩시 최초 지역로딩
		getZip_area();

		
	});//end document ready

	function chk_on(id){
		   $("#"+id+"_label").attr("class","chkOn_css");
		   $("#"+id+"_label").attr("onclick","chk_off('"+id+"');");
	}
	function chk_off(id){
		   $("#"+id+"_label").attr("class","");
		   $("#"+id+"_label").attr("onclick","chk_on('"+id+"');");
	}
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
			<p style="margin:2em; font-size:24px; text-align: center;">업체회원</p>
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
			    <div class="join_grid">
			        <div class="join_grid_sec_2" style="width:25%;">
			          	 <p>휴대폰</p>
			        </div>
			        <div class="join_grid_sec_2 phone_number" style="width:75%;">
			        	<ul style="width:80%;margin-left:-40px;">
							 <li><input type="number" id="hp01" maxlength="4" value=""  onKeyUp="next_focus('hp01','hp02',3);"></li>
							 <li> - </li> 
							 <li><input type="number" id="hp02" maxlength="4" value=""  onKeyUp="next_focus('hp02','hp03',4);"></li>
							 <li> -</li> 
							 <li><input type="number" id="hp03" maxlength="4" value="" ></li>
						 </ul>
			        </div>
		   		</div>
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
	   		
	   		<p style="margin:2em; font-size:24px; text-align: center;">업체정보</p>
			<div style="border:solid 2px #21b4d6; border-radius:20px; padding:0 1em; margin-bottom:2em;">
			    <div class="join_grid">
			        <div class="join_grid_sec_2" style="width:25%;">
			          	 <p>회원유형</p>
			        </div>
			        <div class="join_grid_sec_2" style="width:72%;">
			       
			          	<select  class="join_member_select" id="class_codeList" onchange="getBusinessKind();">
							<option value="02" selected="selected">자재업체</option>
							<option value="03">기술자</option>
							<option value="04">장비업체</option>
							<option value="05">시공업체</option>
							<option value="06">종합</option>
							<option value="07">운송</option> 
						</select>
			        </div>
		   		</div>
			    <div class="join_grid">
			        <div class="join_grid_sec_3" style="width:25%;">
			          	 <p>업체명</p>
			        </div>
			        <div class="join_grid_sec_3" style="width:53%;">
			          	 <input placeholder="업체명을 입력해주세요." type="text" style="width:90%;" id="company_name" />
			        </div>
		   		</div>
			    <div class="join_grid" id="tec_local">
			        <div class="join_grid_sec_2" style="width:25%;">
			          	 <p style="padding:1.5em .5em;">지역</p>
			        </div>
			        <div class="join_grid_sec_2" style="width:75%;">
			          	 <p style="line-height: 48px;">
							<select  id="areaList"  onchange="getZip_city()" >
								<option value="defaults">시/도</option>
									
							</select>
							<select id="cityList"  >
								<option value="defaults">군/구</option> 
							</select>
						</p> 
			        </div>
		   		</div>
			    <div class="join_grid">
			        <div class="join_grid_sec_2" style="width:25%;">
			          	 <p>업체전화</p>
			        </div>
			        <div class="join_grid_sec_2 phone_number" style="width:75%;">
			        	<ul style="width:80%;margin-left:-40px;">
							 <li><input type="number" id="hp01" maxlength="4" value=""  onKeyUp="next_focus('hp01','hp02',3);"></li>
							 <li> - </li> 
							 <li><input type="number" id="hp02" maxlength="4" value=""  onKeyUp="next_focus('hp02','hp03',4);"></li>
							 <li> -</li> 
							 <li><input type="number" id="hp03" maxlength="4" value="" ></li>
						 </ul>
			        </div>
		   		</div>
			    <div class="join_grid" style="border:none;overflow:hidden;">
			        <div class="join_grid_sec_2" style="width:100%;">
			          	 <span>전문분야</span><span style="font-size:9pt;color:#a9a9a9;margin-left:11px;">중복선택 가능합니다.</span>
			        </div>
			        <div class="join_grid_sec_2" style="width:100%;margin-top:20px;" >
			        	<div class="join_onefield" id="code_name_div">
 	
			          	 </div>
			        </div>
		   		</div>
	   		</div>
	   		
	   		<div class="join_file" id= file_upload_p><span style="margin:.1em; font-size:24px; text-align: center;">파일첨부</span>
	   		<span style="font-size:11pt;color:#ddd;font-familly:''Nanum Barun Gothic''">* 필수첨부</span></div>
			<div style="border:solid 2px #21b4d6; border-radius:20px; padding:0 1em; margin-bottom:2em;" id="file_upload_table">
			    <div class="join_grid" id="business_license">
			        <div class="join_grid_sec_2" style="width:33%;">
			          	 <p>사업자등록증</p>
			        </div>
			        <div class="join_grid_sec_2 join_plus" style="width:65%;">

			          	<span onclick='document.getElementById("company_paper").click();' >사업자등록증 첨부하기</span>
			          	<input type="hidden" id="fileUploadPath1" name="fileUploadPath1" value="" />
						<input type="hidden" id="fileNewName1" name="fileNewName1" value="" />
						<input type="hidden" id="destination1" name="destination1" value="" />
						<form id="file_upload1" name="file_upload1" method="post"  enctype="multipart/form-data" action="<%=cp%>/comm/saveFileUpload.do?fileGbn=company_paper">
							<input type="file" class="upload" id="company_paper" name="file"  style="display: none;"> 
						</form>

			          

			        </div>
		   		</div>
			    <div class="join_grid" id="license">
			        <div class="join_grid_sec_3" style="width:26%;">
			          	 <p>공사면허증</p>
			        </div>
			        <div class="join_grid_sec_3 join_plus" style="width:65%;">

						<span style="padding:.5em 33.5%;"  onclick='document.getElementById("company_paper02").click();'>전문건설 등록증 첨부하기</span>
						<input type="hidden" id="fileUploadPath2" name="fileUploadPath2" value=""/>
						<input type="hidden" id="fileNewName2" name="fileNewName2" value="" />
						<input type="hidden" id="destination2" name="destination2" value="" />
			    		<form id="file_upload2" name="file_upload2" method="post"  enctype="multipart/form-data" action="<%=cp%>/comm/saveFileUpload.do?fileGbn=company_paper02">
							<input type="file" class="upload" name="file" id="company_paper02"  style="display: none;"> 
						</form>

						

			        </div>
		   		</div>
	   		</div>
	   		
			<div style="border:solid 2px #21b4d6; border-radius:20px; padding:0 1em;">
			    <div class="join_grid">
			        <div class="join_grid_sec_2" style="width:50%;">
			          	 <p>약관동의</p>
			        </div>
			        <div class="join_grid_sec_2" style="width:50%;">
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



</body>
</html>