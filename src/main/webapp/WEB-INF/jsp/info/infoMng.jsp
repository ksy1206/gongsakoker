<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Map" %>
<%@page import="gongsakoker.vo.MemberVO"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();	

    Map sessionData = null;
  
    boolean isSession = true;
    MemberVO memberVO = null;
    String member_no="";
    String class_code="";
    String member_id = "";
    String member_code="";
    String name = "";
    String hp01="";
    String hp02="";
    String hp03="";
    String password = "";
    String hp = "";
   
    if (session.getAttribute("sessionData") != null) {
        sessionData = (Map)session.getAttribute("sessionData");
        memberVO = (MemberVO)sessionData.get("memberInfo");
        member_no = memberVO.getMember_no();
    	class_code = memberVO.getClass_code();
    	member_id =  memberVO.getMember_id();
   	  	member_code= memberVO.getMember_code();
    	name = memberVO.getName();
   	 	hp01= memberVO.getHp01();
   	  	hp02= memberVO.getHp02();
    	hp03= memberVO.getHp03();
    	password = memberVO.getPassword();
//     	hp = memberVO.getHp01()+"-"+memberVO.getHp02()+"-"+memberVO.getHp03();
       
    } else {
        isSession = false;
        session.removeAttribute("sessionData");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript"  src="<%=cp%>/js/jquery.form.js"></script>
<script type="text/javascript">
<%-- $("pwd").val("<%=password%>"); --%>
// 이미지 미리보기
	$.fn.setPreview = function(opt){
 		"use strict"   
 		var defaultOpt = {         
 				inputFile: $(this),img: null};
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
									
// 									img.style.width  = defaultOpt.w+'px';
// 									img.style.height = defaultOpt.h+'px';
									img.style.display = '';
									}
								reader.readAsDataURL(inputFile.files[0]);
							} catch (e) {
								// exception...  
								}        
							// img.filters (MSIE) 
					}   
				};      
					// onchange    
		$(this).change(function(){ 
			previewImage();
		});
					
	};  //end 이미지 미리보기
	
	$(document).ready(function(){
		
		//이미지 미리보기 실행
		var opt1 = {img: $('#file01_preview')}; 
		$('#file01').setPreview(opt1); 
		var opt2 = {img: $('#file02_preview')}; 
		$('#file02').setPreview(opt2); 
		var opt3 = {img: $('#file03_preview')}; 
		$('#file03').setPreview(opt3); 
		var opt4 ="";
		
		if("<%=class_code%>" == "01"){
			opt4 = {img: $('#member_preview')}; 
			$('#logo').setPreview(opt4); 
		}else{
			opt4 = {img: $('#logo_preview')}; 
			$('#logo').setPreview(opt4); 
		}
		
		
		
		getCompanyInfo();
		
		
	    //---------------------------------------
		// 폼 전송후 콜백함수 호출
		//---------------------------------------	
		var options = {
			dataType : "json",
	        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
			success : function(data){
					if(data.resultCode == '1') {
						
						
						var file02 = $("#file02").val();
						var file03 = $("#file03").val();
						var logo = $("#logo").val();

						$("#fileUploadPath1").val(data.fileUploadPath);
						$("#fileNewName1").val(data.fileName);
						$("#destination1").val(data.destination);
						
					 	if((file02 == "" || file02 == null || file02 == undefined)
				    			&&(file03 == "" || file03 == null || file03 == undefined)
				    			&&(logo == "" || logo == null || logo == undefined)){
					 			saveCompanyFile();
				    	}else{
				    		if(file02 != "" && file02 != null && file02 != undefined){
				    			var frm = $('#file_upload2'); 
					  			fileUpload(frm);
				    		}else if(file03 != "" && file03 != null && file03 != undefined){
				    			var frm = $('#file_upload3'); 
					  			fileUpload(frm);
				    		}else if(logo != "" && logo != null && logo != undefined){
				    			var frm = $('#logo_upload'); 
					  			fileUpload(frm);
				    		}
				    		
				    	}
							
					}else{
						$("#dialog_txt").text("첨부파일 등록에 실패하였습니다.");
					    $("#popupDialog").popup("open");
					}										
					
			},
			error : function(xhr, error, data) {
				$("#dialog_txt").text("파일 업로드에 실패하였습니다.");
				$("#popupDialog").popup("open");
			}
		};
		var options2 = {
				dataType : "json",
		        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
				success : function(data){
						if(data.resultCode == '1') {

							var file03 = $("#file03").val();
							var logo = $("#logo").val();

							$("#fileUploadPath2").val(data.fileUploadPath);
							$("#fileNewName2").val(data.fileName);
							$("#destination2").val(data.destination);
							
						 	if((file03 == "" || file03 == null || file03 == undefined)
					    			&&(logo == "" || logo == null || logo == undefined)){
						 			 saveCompanyFile();
					    	}else{
					    		if(file03 != "" && file03 != null && file03 != undefined){
					    			var frm = $('#file_upload3'); 
						  			fileUpload(frm);
					    		}else if(logo != "" && logo != null && logo != undefined){
					    			var frm = $('#logo_upload'); 
						  			fileUpload(frm);
					    		}
					    		
					    	}
								
						}else{
							$("#dialog_txt").text("첨부파일 등록에 실패하였습니다.");
							$("#popupDialog").popup("open");
						}										
						
				},
				error : function(xhr, error, data) {
					$("#dialog_txt").text("파일 업로드에 실패하였습니다.");
					$("#popupDialog").popup("open");
				}
			};
		var options3 = {
				dataType : "json",
		        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
				success : function(data){
						if(data.resultCode == '1') {
							
							
							var file03 = $("#file03").val();
							var logo = $("#logo").val();
							
					
							$("#fileUploadPath3").val(data.fileUploadPath);
							$("#fileNewName3").val(data.fileName);
							$("#destination3").val(data.destination);
							
						 	if(logo == "" || logo == null || logo == undefined){
						 			 saveCompanyFile();
					    	}else{
					    			var frm = $('#logo_upload'); 
						  			fileUpload(frm);
					    	}
								
						}else{
							$("#dialog_txt").text("첨부파일 등록에 실패하였습니다.");
							$("#popupDialog").popup("open");
						}								
						
				},
				error : function(xhr, error, data) {
					$("#dialog_txt").text("파일 업로드에 실패하였습니다.");
					$("#popupDialog").popup("open");
				}
			};
		
		var options4 = {
				dataType : "json",
		        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
				success : function(data){
						if(data.resultCode == '1') {
							
							
							$("#fileUploadPath4").val(data.fileUploadPath);
							$("#fileNewName4").val(data.fileName);
							$("#destination4").val(data.destination);
							saveCompanyFile();
					    
								
						}else{
							$("#dialog_txt").text("첨부파일 등록에 실패하였습니다.");
							$("#popupDialog").popup("open");
						}								
						
				},
				error : function(xhr, error, data) {
					$("#dialog_txt").text("파일 업로드에 실패하였습니다.");
					$("#popupDialog").popup("open");
				}
			};
	    
	    
	    
		jQuery("#file_upload1").ajaxForm(options);
		jQuery("#file_upload2").ajaxForm(options2);
		jQuery("#file_upload3").ajaxForm(options3);
		jQuery("#logo_upload").ajaxForm(options4);
		
		
	});//end document ready..

	
	function getCompanyInfo(){
		
		var member_no = <%=member_no%>;
		var member_code = <%=member_code%>;
		var class_code = "<%=class_code%>";
		var hp= "";
		var class_name = "";	
		
		switch(class_code) {
				case '01' :
					class_name="일반회원"
					break;
				case '02' :
					class_name="자재업체"
					break;
				case '03' :
					class_name="기술자"
					break;
				case '04' :
					class_name="장비업체"
					break;
				case '05' :
					class_name="시공업체"
					break;
				
				default :
					break;
			}
		
		
		var params="member_no="+member_no;
		
	 	$.ajax({
	        type        : "POST"  
	      , async       : false 
	      , url         : "/member/getMemberInfo.do"
	      , data        : params
	      , dataType    : "json" 
	      , timeout     : 30000   
	      , cache       : false     
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
	  	    $("#dialog_txt").text("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
			$("#popupDialog").popup("open");
	      }
	      , success     : function(data) {
	    	 	
	    		  hp = data.member.hp01+"-"+data.member.hp02+"-"+data.member.hp03;

	    		  if(class_code!="01"){
	    			  $("#hp01").val(data.member.hp01);
	 	    		  $("#hp01").css("color","black");
	 				  $("#hp02").val(data.member.hp02);
	 	    		  $("#hp02").css("color","black");
	 				  $("#hp03").val(data.member.hp03);
	 	    		  $("#hp03").css("color","black");
		    		  $("#hp_p").html(hp);
		    		  $("#koker_name_div").css("display","none");
	    		  }else{
	    			  
	    		  }
 				 
	    		  $("#pwd").val(data.member.password);		
	      }
		});
		
		
		if(class_code=="01"){
			
			$("#koker_name_div").css("display","");
			$("#name").html("<%=name%>");
			$("#class_name").html(class_name);
			$("#member_id").html("<%=member_id%>");
			$("#info_modify").css("display","none");
			$("#member_img").css("display","");
			$("#nomal_member").css("display","");
			$("#wait_member").css("display","none");
			$("#company_member").css("display","none");
			$("#tec_member_off").css("display","none");
			$("#tec_member_on").css("display","none");
			//일반회원은 휴대폰번호를 안받기로해서 안보여줌
			$("#hp_div").css("display","none");
		}else if(member_code=="02"){
			$("#koker_name_div").css("display","none");
			$("#name").html("<%=name%>");
			$("#class_name").html(class_name);
			$("#member_id").html("<%=member_id%>");
			$("#info_modify").css("display","none");
			$("#member_img").css("display","none");
			$("#wait_member").css("display","");
			$("#nomal_member").css("display","none");
			$("#company_member").css("display","none");
			$("#tec_member_off").css("display","none");
			$("#tec_member_on").css("display","none");
		}
		
			var params="member_no="+member_no+"&class_code="+class_code;
			
		 	$.ajax({
		        type        : "POST"  
		      , async       : false 
		      , url         : "/member/getCompanyInfo.do"
		      , data        : params
		      , dataType    : "json" 
		      , timeout     : 30000   
		      , cache       : false     
		      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		      , error       : function(request, status, error) {
		  	    $("#dialog_txt").text("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
				$("#popupDialog").popup("open");
		      }
		      , success     : function(data) {
		    	
		    	  if(member_code != "02"){
		    		  if(class_code != "01"){
		    			  $("#koker_name_div").css("display","none");
				    	  $("#member_img").css("display","none");
				    	  $("#info_modify").css("display","");
				    	  $("#hp_div").css("display","");
		    		   }else{
		    			 
		    			   $("#member_img").css("display","");
					       $("#info_modify").css("display","none");
					       $("#hp_div").css("display","none");
		    		   }
		    		  
						if(data.infoList!=null && data.infoList.length != 0){
					
							$.each(data.infoList, function(index, infoList) {
								if(class_code != "01"){
						    		if(class_code == "03"){
						    			$("#wait_member").css("display","none");
						    			$("#nomal_member").css("display","none");
										$("#company_member").css("display","none");
		
										 if(infoList.state=="0"){
											$("#tec_member_off").css("display","");
											$("#tec_member_on").css("display","none");
										 }else{
											$("#tec_member_off").css("display","none");
											$("#tec_member_on").css("display","");
										 }
										
						    		}else{
						    			
						    			if(infoList.koker_auth=='y'){
						    				$("#nomal_member").css("display","none");
						    				$("#wait_member").css("display","none");
											$("#company_member").css("display","none");
											$("#tec_member_off").css("display","none");
											$("#tec_member_on").css("display","none");
											$("#company_auth_member").css("display","");
						    				
						    				$("#mark_inzng").css("display","");	
						    			}else{
						    				$("#nomal_member").css("display","none");
						    				$("#wait_member").css("display","none");
											$("#company_member").css("display","");
											$("#tec_member_off").css("display","none");
											$("#tec_member_on").css("display","none");
											$("#company_auth_member").css("display","none");
											
											$("#mark_inzng").css("display","none");	
						    			}
						    			
						    		}
						    		
						    		$("#name").html(infoList.koker_name);
									$("#class_name").html(class_name);
									$("#member_id").html(infoList.member_id);
									$("#hp_p").html(infoList.call_tel01+"-"+infoList.call_tel02+"-"+infoList.call_tel03);
									if(infoList.call_tel01==""||infoList.call_tel01==null||infoList.call_tel01==undefined){
										
									}else{
		// 								$("#call_tel").val(infoList.call_tel01+"-"+infoList.call_tel02+"-"+infoList.call_tel03);
		// 								$("#call_tel").css("color","black");
										$("#call_tel01").val(infoList.call_tel01);
		 								$("#call_tel01").css("color","black");
										$("#call_tel02").val(infoList.call_tel02);
		 								$("#call_tel02").css("color","black");
										$("#call_tel03").val(infoList.call_tel03);
		 								$("#call_tel03").css("color","black");
		
									}
						
									if(infoList.call_stime==""||infoList.call_stime==null||infoList.call_stime==undefined){
									
									}else{
										
										$("#call_stime").val(infoList.call_stime);
										$("#call_stime").css("color","black");
									}
									if(infoList.call_ntime==""||infoList.call_ntime==null||infoList.call_ntime==undefined){
										
									}else{
										$("#call_ntime").val(infoList.call_ntime);
										$("#call_ntime").css("color","black");
									}
									if(infoList.holiday==""||infoList.holiday==null||infoList.holiday==undefined){
										
									}else{
										$("#holiday").val(infoList.holiday);
										$("#holiday").css("color","black");
									}
									if(infoList.koker_url==""||infoList.koker_url==null||infoList.koker_url==undefined){
										
									}else{
										$("#koker_url").val(infoList.koker_url);
										$("#koker_url").css("color","black");
									}
									if(infoList.koker_content==""||infoList.koker_content==null||infoList.koker_content==undefined){
										
									}else{
										$("#koker_content").html(infoList.koker_content);
										$("#koker_content").css("color","black");
									}
									if(infoList.file01_name==""||infoList.file01_name==null||infoList.file01_name==undefined){
										
									}else{
									
										$("#file01_preview").attr("src","/upload/img/<%=member_id%>/"+ infoList.file01_name);
										$("#file01_hidden").val("/upload/img/<%=member_id%>/"+ infoList.file01_name);
									}
									if(infoList.file02_name==""||infoList.file02_name==null||infoList.file02_name==undefined){
			
									}else{
										$("#file02_preview").attr("src","/upload/img/<%=member_id%>/"+ infoList.file02_name);
										$("#file02_hidden").val("/upload/img/<%=member_id%>/"+ infoList.file02_name);
									}
									if(infoList.file03_name==""||infoList.file03_name==null||infoList.file03_name==undefined){
										
									}else{
										$("#file03_preview").attr("src","/upload/img/<%=member_id%>/"+ infoList.file03_name);
										$("#file03_hidden").val("/upload/img/<%=member_id%>/"+ infoList.file03_name);
									}
									if(infoList.logo_name==""||infoList.logo_name==null||infoList.logo_name==undefined){
										
									}else{
										$("#logo_preview").attr("src","/upload/img/<%=member_id%>/"+ infoList.logo_name);
										$("#logo_hidden").val("/upload/img/<%=member_id%>/"+ infoList.logo_name);
										$(".member_set_back").attr("style","background-image:url('/upload/img/<%=member_id%>/"+infoList.logo_name+"')");
									}
									
									$("#answer").attr("href","../kokkok20/answer.do?koker_no="+infoList.koker_no+"&backCount=1");
									$("#details").attr("href","../kokkok20/kokkok20_details.do?koker_no="+infoList.koker_no+"&backCount=1");
									 
									
									
								}else if(class_code == "01"){//end class_code not equal '01'
									$("#koker_name").css("color","black");
									$("#koker_name").val(infoList.koker_name);
									if(infoList.logo_name==""||infoList.logo_name==null||infoList.logo_name==undefined){
										
									}else{
										$("#member_preview").attr("src","/upload/img/<%=member_id%>/"+ infoList.logo_name);
										$("#logo_hidden").val("/upload/img/<%=member_id%>/"+ infoList.logo_name);
										$(".member_set_back").attr("style","background-image:url('/upload/img/<%=member_id%>/"+infoList.logo_name+"')");
									}
								}
						   	}); 
							
							
							
							
						}else{
							
						}
		    		
		      	}//end member_code not equal '02'
					
		      }
			});
		 	
		
	
	}
	
	function updateWork_state(){
		var class_code = "<%=class_code%>";
    	var member_no = "<%=member_no%>";
 	
   	 	$.ajax({
	        type        : "POST"  
	      , async       : false 
	      , url         : "/member/getWork_sate.do"
	      , data        : "member_no=" + member_no + "&class_code=" + class_code + "&update_yn=y" 
	      , dataType    : "json" 
	      , timeout     : 30000   
	      , cache       : false     
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
	  	    $("#dialog_txt").text("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
			$("#popupDialog").popup("open");
	      }
	      , success     : function(data) {
	    		  if(data.work_state != null){
	    			
					 if(data.work_state=="0"){
							$("#tec_member_off").css("display","");
							$("#tec_member_on").css("display","none");
						 }else{
							$("#tec_member_off").css("display","none");
							$("#tec_member_on").css("display","");
						 }
	    			
	    			

	    		  }
	      }
    	});	
	}
	
	
	function memberLeave(){
    	var member_no = "<%=member_no%>";
   	 	$.ajax({
	        type        : "POST"  
	      , async       : false 
	      , url         : "/member/doMemberLeave.do"
	      , data        : "member_no=" + member_no 
	      , dataType    : "json" 
	      , timeout     : 30000   
	      , cache       : false     
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
	  	    $("#dialog_txt").text("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
			$("#popupDialog").popup("open");      
	      }
	      , success     : function(data) {
	    
	    		if(data.result=="1"){
	    			location.href = "/member/doMember_logout.do";
	    		}else{
	    			
	    		}
	      }
    	});	
	}
	
	
	
	function chkCompanyInfo(){
		
		var call_stime = $("#call_stime").val();
		var call_ntime = $("#call_ntime").val();
		var holiday = $("#holiday").val();
		var koker_url = $("#koker_url").val();
		var koker_content = $("#koker_content").val();
		var class_code = "<%=class_code%>";
    	var member_no = "<%=member_no%>";
		var file01 = $("#file01").val();
		var file02 = $("#file02").val();
		var file03 = $("#file03").val();
		var logo = $("#logo").val();
		var koker_name = $("#koker_name").val();
		
		var password = $("#password").val();
		var password_new = $("#password_new").val();
		var password_chk = $("#password_chk").val();
// 		var hp  = $("#hp").val();
// 		var hp_arr = "";
	    var hp01 = $("#hp01").val();
        var hp02 = $("#hp02").val();
        var hp03 = $("#hp03").val();
// 		var call_tel = $("#call_tel").val();
// 		var call_tel_arr = "";
		var call_tel01 = $("#call_tel01").val();
		var call_tel02 = $("#call_tel02").val();
		var call_tel03 = $("#call_tel03").val();
		
    	if(holiday=="   주말 , 공휴일"){
    		holiday="";
    	}
    	if(koker_url=="www.ooooooo.com"){
    		koker_url="";
    	}
    	if(koker_content=="인사말을 적어주세요"){
    		koker_content="";
    	}



	if(class_code != "01"){
    	if(hp01 == null||hp01 == ""||hp01 == undefined){
            $( "#popupDialog_text").text( "휴대폰번호를 입력해주세요.");
            $( "#hp01").focus();
            $("#chkCompany_ok").css("display","");
			$("#chkCompany_upt").css("display","none");
			$("#chkCompany_cancle").css("display","none");
			
             return false;
       
       } 
        if(hp02 == null||hp02 == ""||hp02 == undefined){
            $( "#popupDialog_text").text( "휴대폰번호를 입력해주세요.");
            $( "#hp02").focus();
            $("#chkCompany_ok").css("display","");
			$("#chkCompany_upt").css("display","none");
			$("#chkCompany_cancle").css("display","none");
           
             return false;
       
       } 
        if(hp03 == null||hp03 == ""||hp03 == undefined){
            $( "#popupDialog_text").text( "휴대폰번호를 입력해주세요.");
            $( "#hp03").focus();
            $("#chkCompany_ok").css("display","");
			$("#chkCompany_upt").css("display","none");
			$("#chkCompany_cancle").css("display","none");
           
             return false;
       
       } 
	}
//         if(call_tel01 == null||call_tel01 == ""||call_tel01 == undefined){
//             $( "#popupDialog_text").text( "업체번호를 입력해주세요.");
//             $( "#call_tel01").focus();
//             $("#chkCompany_ok").css("display","");
// 			$("#chkCompany_upt").css("display","none");
           
//              return false;
       
//        } 
       
//         if(call_tel02 == null||call_tel02 == ""||call_tel02 == undefined){
//             $( "#popupDialog_text").text( "업체번호를 입력해주세요.");
//             $( "#call_tel02").focus();
//             $("#chkCompany_ok").css("display","");
// 			$("#chkCompany_upt").css("display","none");
          
//              return false;
       
//        } 
        
//         if(call_tel03 == null||call_tel03 == ""||call_tel03 == undefined){
//             $( "#popupDialog_text").text( "업체번호를 입력해주세요.");
//             $( "#call_tel03").focus();
//             $("#chkCompany_ok").css("display","");
// 			$("#chkCompany_upt").css("display","none");
           
//              return false;
       
//        } 


		if(password==null||password==""||password== undefined){
			password = "";
		
    	}else{
    		if(password!=$("#pwd").val()){
    			
    			$("#popupDialog_text").html("비밀번호가 다릅니다.");
				$("#chkCompany_ok").css("display","");
				$("#chkCompany_upt").css("display","none");
				$("#chkCompany_cancle").css("display","none");
 
    			$("#password").focus();
    			return false;
      		 }
    		if(password_new == null || password_new == "" || password_new == undefined){
    		
    			$("#popupDialog_text").html("신규 비밀번호를 입력해주세요.");
				$("#chkCompany_ok").css("display","");
				$("#chkCompany_upt").css("display","none");
				$("#chkCompany_cancle").css("display","none");
    			$("#password_new").focus();
    			return false;
    		}
    		
    	}
		if(password_new == null || password_new == "" || password_new == undefined){
			password_new = "";
			if(password_chk == null || password_chk == "" || password_chk == undefined){
				password_chk = "";
			}else{
				$("#popupDialog_text").html("신규비밀번호를 입력해주세요.");
				$("#chkCompany_ok").css("display","");
				$("#chkCompany_upt").css("display","none");
				$("#chkCompany_cancle").css("display","none");

				$("#password_chk").focus();
				return false;
			}
			
		}else{
			if(password==password_new){

    			$("#popupDialog_text").html("기존비밀번호와 다르게 입력해주세요.");
				$("#chkCompany_ok").css("display","");
				$("#chkCompany_upt").css("display","none");
				$("#chkCompany_cancle").css("display","none");
				
				$("#password_new").focus();
				return false;
	  		 }
			
			if(password_chk == null || password_chk == "" || password_chk == undefined){
				$("#popupDialog_text").html("비밀번호를 확인해주세요.");
				$("#chkCompany_ok").css("display","");
				$("#chkCompany_upt").css("display","none");
				$("#chkCompany_cancle").css("display","none");

				$("#password_chk").focus();
				return false;
			}else{
				if(password_new!=password_chk){
					$("#popupDialog_text").html("비밀번호 불일치");
					$("#chkCompany_ok").css("display","");
					$("#chkCompany_upt").css("display","none");
					$("#chkCompany_cancle").css("display","none");

					$("#password_chk").focus();
					return false;
		  		 }
		}
		

			
			
			 var pattern1 = /[0-9]/; //숫자
	         var pattern2 = /[a-zA-Z]/; //문자
//	         var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/; //특수문자
	           

	         if( !pattern1.test(password_new) || !pattern2.test(password_new)  || password_new.length<6 || password_new.length>12 ){
	        	 $("#popupDialog_text").html("비밀번호는 문자,숫자 포함한 6~12자리로 구성하여야 합니다.");
				 $("#chkCompany_ok").css("display","");
				 $("#chkCompany_upt").css("display","none");
				 $("#chkCompany_cancle").css("display","none");
	             $( "#password_new" ).focus();
	              return false;
	      
	         }
	         
	         var pattern_semi = /[;]/;  
             if(pattern_semi.test(password_new)){
            	 $("#popupDialog_text").html("비밀번호에 ';' 은 포함시킬 수 없습니다.");
				 $("#chkCompany_ok").css("display","");
				 $("#chkCompany_upt").css("display","none");
				 $("#chkCompany_cancle").css("display","none");
	             $( "#password_new" ).focus();
	              return false;
             }
		}
		

    	var params= "member_no="+member_no+"&class_code="+class_code+
    	"&call_stime="+call_stime+"&call_ntime="+call_ntime+"&holiday="+holiday+"&koker_url="+koker_url+"&koker_content="+koker_content
    	+"&hp01="+hp01+"&hp02="+hp02+"&hp03="+hp03+"&call_tel01="+call_tel01
    	+"&call_tel02="+call_tel02+"&call_tel03="+call_tel03+"&password="+password+"&password_new="+password_new;
		
    	if(class_code=="01"){
    		params += "&koker_name="+koker_name;
    	}
    	$("#params").val(params);
    	
    	var android_version_chk = $("#android_version_chk").val();
    	
        if(android_version_chk=="n"){
	    	if((file01 == "" || file01 == null || file01 == undefined)
	    			&&(file02 == "" || file02 == null || file02 == undefined)
	    			&&(file03 == "" || file03 == null || file03 == undefined)
	    			&&(logo == "" || logo == null || logo == undefined)){
	    				updateCompanyInfo();
	    	}else{
	    		//파일업로드
	        	if(file01 == "" || file01 == null || file01 == undefined){
	    				file01="";
	        	}else{
	        		
	   				var frm = $('#file_upload1'); 
	   				fileUpload(frm);
	   				return false;
	    		}
	        	if(file02 == "" || file02 == null || file02 == undefined){
	    			file02="";
	    		}else{
	    			var frm = $('#file_upload2'); 
	    			fileUpload(frm);
	    			return false;
	    		}
	        	if(file03 == "" || file03 == null || file03 == undefined){
	    			file03="";
	    		}else{
	    			var frm = $('#file_upload3'); 
	    			fileUpload(frm);
	    			return false;
	    		}
	        	if(logo == "" || logo == null || logo == undefined){
	        		logo="";
	    		}else{
	    			var frm = $('#logo_upload'); 
	    			fileUpload(frm);
	    			return false;
	    		}
	    	}//end else
		}else{//end android if
			saveCompanyFile();
		}
	}
	
	function updateCompanyInfo(){
		
		var params = $("#params").val();
		var file01 = $("#file01").val();
		var file02 = $("#file02").val();
		var file03 = $("#file03").val();
		var logo = $("#logo").val();
		
		var android_version_chk = $("#android_version_chk").val();
		var fileName1 = $("#fileNewName1").val();
		var fileName2 = $("#fileNewName2").val();
		var fileName3 = $("#fileNewName3").val();
		var fileName4 = $("#fileNewName4").val();

		
		
        if(android_version_chk=="n"){
    		
    		if(file01 != null && file01 != "" && file01 != undefined){
    			params += "&file01_name=" + jQuery("#fileNewName1").val() + "&file01_path=" + jQuery("#fileUploadPath1").val();

    		}
    		if(file02 != null && file02 != "" && file02 != undefined){
    			params += "&file02_name=" + jQuery("#fileNewName2").val() + "&file02_path=" + jQuery("#fileUploadPath2").val();
    		}
    		if(file03 != null && file03 != "" && file03 != undefined){
    			params += "&file03_name=" + jQuery("#fileNewName3").val() + "&file03_path=" + jQuery("#fileUploadPath3").val();
    		}
    		if(logo != null && logo != "" && logo != undefined){
    			params += "&logo_name=" + jQuery("#fileNewName4").val() + "&logo_path=" + jQuery("#fileUploadPath4").val();
    		}
	        	  

		}else{
			if(fileName1 != null && fileName1 != "" && fileName1 != undefined){
				params += "&file01_name=" + jQuery("#fileNewName1").val() + "&file01_path=" + jQuery("#fileUploadPath1").val();
			}
			if(fileName2 != null && fileName2 != "" && fileName2 != undefined){
				params += "&file02_name=" + jQuery("#fileNewName2").val() + "&file02_path=" + jQuery("#fileUploadPath2").val();
			}
			if(fileName3 != null && fileName3 != "" && fileName3 != undefined){
				params += "&file03_name=" + jQuery("#fileNewName3").val() + "&file03_path=" + jQuery("#fileUploadPath3").val();
			}
			if(fileName4 != null && fileName4 != "" && fileName4 != undefined){
				params += "&logo_name=" + jQuery("#fileNewName4").val() + "&logo_path=" + jQuery("#fileUploadPath4").val();
			}
		}
		
    	
		
   	 	$.ajax({
	        type        : "POST"  
	      , async       : false 
	      , url         : "/member/updateCompanyInfo.do"
	      , data        : params
	      , dataType    : "json" 
	      , timeout     : 30000   
	      , cache       : false     
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
				$("#popupDialog_text").html("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
				$("#chkCompany_ok").css("display","");
				$("#chkCompany_upt").css("display","none");
				$("#chkCompany_cancle").css("display","none");
	      }
	      , success     : function(data) {
	    	  
	    	  	$("#file01").val("");
	  			$("#file02").val("");
	  			$("#file03").val("");
	  		 	$("#logo").val("");
	  		 	$("#fileNewName1").val("");
	  			$("#fileNewName2").val("");
	  			$("#fileNewName3").val("");
	  		 	$("#fileNewName4").val("");
	  		 	
// 	  		    $("#popupDialog_submit").popup("close");
				$("#popupDialog_text").html("정보수정완료");
				$("#chkCompany_ok").css("display","");
				$("#chkCompany_upt").css("display","none");
				$("#chkCompany_cancle").css("display","none");
				
	    	  	getCompanyInfo();
	    	   
	    	  	//자동로그인 비밀번호 변경
				var pwd = $("#password_new").val();
				if(pwd != null && pwd != '' && pwd != undefined) {
					pwdChanged(pwd);
	      		}
				//변경 끝
	      }
    	});	
	}
	
	// 파일업로드 이벤트
	function fileUpload(frm){

			frm.submit(); 		
	}
	
	// 팝업 텍스트 변경
	function chgPopup(){
		setTimeout(function(){
			$("#popupDialog_text").text("정보를 수정하시겠습니까?");
			$("#chkCompany_ok").css("display","none");
			$("#chkCompany_upt").css("display","");
			$("#chkCompany_cancle").css("display","");
		},"1000");
		
		
	}
	
	
	function saveCompanyFile(){
		
		
		var file_cnt = 0;
		var file_stat = "";
		var member_id = "<%=member_id%>";
		var file01 = $("#file01").val();
		var file02 = $("#file02").val();
		var file03 = $("#file03").val();
		var logo = $("#logo").val();
		
		var fileName1 = $("#fileNewName1").val();
		var fileName2 = $("#fileNewName2").val();
		var fileName3 = $("#fileNewName3").val();
		var fileName4 = $("#fileNewName4").val();
	
		var params = "member_id=" + member_id;
		var android_version_chk = $("#android_version_chk").val();
        if(android_version_chk=="n"){
			if(file01 != null && file01 != "" && file01 != undefined){
				file_cnt += 1;
				file_stat = ",1";
				var destination1 =  jQuery("#destination1").val();
				params += "&fileNewName1=" + jQuery("#fileNewName1").val() + "&fileUploadPath1=" + jQuery("#fileUploadPath1").val() +
				"&destination1=" + jQuery("#destination1").val(); 
			}
			if(file02 != null && file02 != "" && file02 != undefined){
				file_cnt += 1;
				file_stat +=",2";
	
				params += "&fileNewName2=" + jQuery("#fileNewName2").val() + "&fileUploadPath2=" + jQuery("#fileUploadPath2").val() +
				"&destination2=" + jQuery("#destination2").val(); 
			}
			if(file03 != null && file03 != "" && file03 != undefined){
				file_cnt += 1;
				file_stat +=",3";
				params += "&fileNewName3=" + jQuery("#fileNewName3").val() + "&fileUploadPath3=" + jQuery("#fileUploadPath3").val() +
				"&destination3=" + jQuery("#destination3").val(); 
			}
			if(logo != null && logo != "" && logo != undefined){
				file_cnt += 1;
				file_stat +=",4";
				params += "&fileNewName4=" + jQuery("#fileNewName4").val() + "&fileUploadPath4=" + jQuery("#fileUploadPath4").val() +
				"&destination4=" + jQuery("#destination4").val(); 
			}

		}else{
			if(fileName1 != null && fileName1 != "" && fileName1 != undefined){
				file_cnt += 1;
				file_stat = ",1";
				var destination1 =  jQuery("#destination1").val();
				params += "&fileNewName1=" + jQuery("#fileNewName1").val() + "&fileUploadPath1=" + jQuery("#fileUploadPath1").val() +
				"&destination1=" + jQuery("#destination1").val(); 
			}
			if(fileName2 != null && fileName2 != "" && fileName2 != undefined){
				file_cnt += 1;
				file_stat +=",2";
	
				params += "&fileNewName2=" + jQuery("#fileNewName2").val() + "&fileUploadPath2=" + jQuery("#fileUploadPath2").val() +
				"&destination2=" + jQuery("#destination2").val(); 
			}
			if(fileName3 != null && fileName3 != "" && fileName3 != undefined){
				file_cnt += 1;
				file_stat +=",3";
				params += "&fileNewName3=" + jQuery("#fileNewName3").val() + "&fileUploadPath3=" + jQuery("#fileUploadPath3").val() +
				"&destination3=" + jQuery("#destination3").val(); 
			}
			if(fileName4 != null && fileName4 != "" && fileName4 != undefined){
				file_cnt += 1;
				file_stat +=",4";
				params += "&fileNewName4=" + jQuery("#fileNewName4").val() + "&fileUploadPath4=" + jQuery("#fileUploadPath4").val() +
				"&destination4=" + jQuery("#destination4").val(); 
			}
		}
		file_stat  = file_stat.substring(1, file_stat.length);
		params += "&file_cnt="+file_cnt+"&file_stat="+file_stat;

		$.ajax({
	            type        : "POST"  
	          , async       : true 
	          , url         : "/member/saveCompanyFile.do"
	          , data        : params
	          , dataType    : "json" 
	          , timeout     : 30000   
	          , cache       : false     
	          //, contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	          , error       : function(request, status, error) {
	      	    $("#dialog_txt").text("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
				$("#popupDialog").popup("open");
	          }
	          , success     : function(data) {

	              if(android_version_chk=="n"){
	            	  if(file01 != null && file01 != "" && file01 != undefined){
		        		  $("#fileUploadPath1").val(data.fileUploadPath1);
						  $("#fileNewName1").val(data.fileNewName1);
			      		}
			      		if(file02 != null && file02 != "" && file02 != undefined){
			      			 $("#fileUploadPath2").val(data.fileUploadPath2);
							 $("#fileNewName2").val(data.fileNewName2);
			      		}
			      		if(file03 != null && file03 != "" && file03 != undefined){
			      			$("#fileUploadPath3").val(data.fileUploadPath3);
							 $("#fileNewName3").val(data.fileNewName3);
			      		}
			      		if(logo != null && logo != "" && logo != undefined){
			      			$("#fileUploadPath4").val(data.fileUploadPath4);
							 $("#fileNewName4").val(data.fileNewName4);
			      		}
			        	  

	      		}else{
	      			if(fileName1 != null && fileName1 != "" && fileName1 != undefined){
	      				 $("#fileUploadPath1").val(data.fileUploadPath1);
						  $("#fileNewName1").val(data.fileNewName1);
	      			}
	      			if(fileName2 != null && fileName2 != "" && fileName2 != undefined){
	      				 $("#fileUploadPath2").val(data.fileUploadPath2);
						  $("#fileNewName2").val(data.fileNewName2);
	      			}
	      			if(fileName3 != null && fileName3 != "" && fileName3 != undefined){
	      				 $("#fileUploadPath3").val(data.fileUploadPath3);
						  $("#fileNewName3").val(data.fileNewName3);
	      			}
	      			if(fileName4 != null && fileName4 != "" && fileName4 != undefined){
	      				 $("#fileUploadPath4").val(data.fileUploadPath4);
						  $("#fileNewName4").val(data.fileNewName4);
	      			}
	      		}
	        
	        	
		      		updateCompanyInfo();
 
	          }
    	});
							
	}
	function getFile(str) {
 		window.android.getFile(str);
	}
	function setInfoFilePath1(path, name, dest){
		//file1
		path = splitColon(path);
		dest = splitColon(dest);
		$("#android_version_chk").val("y");
		
		$("#fileUploadPath1").val(path);
		$("#fileNewName1").val(name);
		$("#destination1").val(dest);
	
		$("#file01_preview").attr("src","/upload/img/temp/"+ name);
		window.android.uploadcomplete();
		
	}
function setInfoFilePath2(path, name, dest){
		//file2
		path = splitColon(path);
		dest = splitColon(dest);
		$("#android_version_chk").val("y");
		
		$("#fileUploadPath2").val(path);
		$("#fileNewName2").val(name);
		$("#destination2").val(dest);
	
		$("#file02_preview").attr("src","/upload/img/temp/"+ name);
		window.android.uploadcomplete();
		
	}
function setInfoFilePath3(path, name, dest){
	//file3
	path = splitColon(path);
	dest = splitColon(dest);
	
	$("#android_version_chk").val("y");
	
	$("#fileUploadPath3").val(path);
	$("#fileNewName3").val(name);
	$("#destination3").val(dest);

	$("#file03_preview").attr("src","/upload/img/temp/"+ name);
	window.android.uploadcomplete();
	
}
function setInfoFilePath4(path, name, dest){
	//logo
	path = splitColon(path);
	dest = splitColon(dest);
	
	$("#android_version_chk").val("y");
	$("#fileUploadPath4").val(path);
	$("#fileNewName4").val(name);
	$("#destination4").val(dest);

	
	
		if("<%=class_code%>" == "01"){
			$("#member_preview").attr("src","/upload/img/temp/"+ name); 
		}else{
			$("#logo_preview").attr("src","/upload/img/temp/"+ name);
		}
	
	window.android.uploadcomplete();
	
}
//가라로 파일업로드 스플릿
function splitColon(str){
	str_arr = str.split(":");
	str = str_arr[1];
	
 	return str;
	
}

//자동탭처리함수
function next_focus(tag_id,next_tag_id,val){  

	  if(tag_id == "call_tel01"){
			if($("#"+tag_id).val() == "02"){
				$("#"+next_tag_id).focus(); 
	      		return false; 
  		}
		}
	  
	if ($("#"+tag_id).val().length == val ){
		
			$("#"+next_tag_id).focus(); 
    		return false; 	
		
	} 
} 

function pwdChanged(pwd) {
	var useragent = navigator.userAgent;
	if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1) {
		window.android.passwordChanged(pwd);
	}else if(useragent.indexOf("Connect By iPhone OS") > -1) {
		var s2 = "iosjavascript://passwordChanged" + ";;;" + pwd;
   		document.location = s2;
	}else {
	}
}

function del_img(file_no){
    var class_code = "<%=class_code%>";
	var file = $("#"+file_no).val();
	var file_hidden = $("#"+file_no+"_hidden").val();
	var chk_file = "Y";
	if(file_hidden == ""){//초기이미지일 경우 hidden에 val 없음
		file_hidden = "../img/member_set/member_img_plus.jpg";
		chk_file = "N";
	}else{
		chk_file = "Y";
	}

	
	if(file!=""){//미리보기일 경우
		if(class_code != "01"){
			 $("#"+file_no+"_preview").attr("src",file_hidden);	
			 $("#"+file_no).val("");
    	 }else{
    		 $("#member_preview").attr("src",file_hidden);	
    		 $("#"+file_no).val("");
    	 }
		
	}else{//이미 저장된 파일일 경우
		if(chk_file=="Y"){
			
			params = "member_no=<%=member_no%>"+"&file_no="+file_no;

			$.ajax({
		            type        : "POST"  
		          , async       : true 
		          , url         : "/member/delCompanyFile.do"
		          , data        : params
		          , dataType    : "json" 
		          , timeout     : 30000   
		          , cache       : false     
		          //, contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		          , error       : function(request, status, error) {
		      	    $("#dialog_txt").text("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
					$("#popupDialog").popup("open");
		          }
		          , success     : function(data) {
		        	
		        	 if(class_code != "01"){
		        		$("#"+file_no+"_preview").attr("src","../img/member_set/member_img_plus.jpg");	
		  				$("#"+file_no).val("");
		        	 }else{
		        		 $("#member_preview").attr("src","../img/member_set/member_img_plus.jpg");	
			  			 $("#"+file_no).val("");
		        	 }
		        	 
		        	 $("#"+file_no+"_hidden").val("");
		          }
	    	});
					
		}else{
			
		}
	}
	
}
</script>
</head>

<body>
	
		
<div data-role="page" class="koker_page member_set_page">
 <input type="hidden" id="params" value="" />
 <input type="hidden" id="pwd" value="" />
 <input type="hidden" id="file01_hidden" value="" />
 <input type="hidden" id="file02_hidden" value="" />
 <input type="hidden" id="file03_hidden" value="" />
 <input type="hidden" id="logo_hidden" value="" />
 <input type="hidden" id="android_version_chk" value="n" />
	<div data-role="header" data-position="fixed" class="join_header">
		<div class="back_btn">
			<a href="../appMain/appMain.do" data-ajax="false" data-rel="" class="relback_btn"><img src="../img/relback.gif"/></a>
		</div>
		<h1>정보관리</h1>
	</div>
	<div class="member_set_name">
		<h6 id="name"></h6>
		<p id="class_name"></p>
		<div class="mark_inzng" id="mark_inzng" style="display: none;"><img src="../img/inzng_mark.png" /></div>
	</div>
	<div class="member_set_back"></div>
	<div class="member_set_add">
		<div class="member_set_cha"> 
			<!-- 일반회원 -->
			<img src="../img/member_set/normal_person.gif" style="width:7em; display: none;" id="nomal_member"> 
			<!-- 일반회원 -->
			<img src="../img/member_set/wait_person.gif" style="width:7em; display: none;" id="wait_member"> 
			<!-- 업체회원 -->
			<img src="../img/member_set/company_person.gif" style="width:6em; display: none;" id="company_member">
			<!-- 기술자회원 --> 
			<img src="../img/member_set/engineer_person_off.gif" style="width:10em; display: none;" id="tec_member_off" onclick="updateWork_state()">
			<img src="../img/member_set/engineer_person_on.gif" style="width:10em; display: none;" id="tec_member_on" onclick="updateWork_state()">
			<!-- 인증회원 -->
			<img src="../img/inzng_cha.gif" style="width:5.5em; display: none;" id="company_auth_member">
		</div>
		<div class="text_right">
			<a href="#popupDialog_del" data-rel="popup" data-position-to="window" data-transition="pop" style="padding:.5em 1em;">회원탈퇴</a>
		
			<div id="popupDialog_del" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
		    	<div class="ui-content" role="main">
					<p style="margin:0 !important;"><img src="../img/member_set/out_pop_cha.gif" style="width:6em;"></p>
					<p>탈퇴하시겠습니까?</p>
		      	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">취소</a>   
		      	  	<a style="background-color:#29A9C8;" href="#"  data-ajax="false"  onclick="memberLeave()">완료</a>    
		  	  	</div>    
		    </div>
		</div>
		<p id="member_id"></p>
		<p id="hp_p"></p>
		<div class="member_set_a">
			<a href="/member/doMember_logout.do" data-ajax="false" >로그아웃</a>
		</div>
	</div>  
<!-- 공통수정사항	-->
	<div data-role="content" class="join_content">
		<div class="ui-grid-b member_set_title"> 
		    <p class="ui-block-a join_title">정보수정</p> 
	    </div>
	    <div class="member_set_table">
	    	<div class="ui-grid-a" id="hp_div"> 
			    <div class="ui-block-a">
					<label for="">휴대폰번호</label>
				</div> 
			    <div class="ui-block-b" style="width:75% !important;">
<!-- 					<input type="text" id="hp" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';"  -->
<!-- 							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="000-0000-0000" /> -->
				     <div class="ui-grid-d input_align"> 
					    <div class="ui-block-a" style="width:20% !important; padding:0;">
     					  <input type="text" id="hp01" value=""  onKeyUp="next_focus('hp01','hp02',3);" /></div> 
					    <div class="ui-block-b" style="width:5% !important; padding:0;"><p style="margin:.2em 0 0 0;">-</p></div> 
					    <div class="ui-block-c" style="width:20% !important; padding:0;">
					     <input type="text" id="hp02" value="" onKeyUp="next_focus('hp02','hp03',4);"/></div> 
					    <div class="ui-block-d" style="width:5% !important; padding:0;"><p style="margin:.2em 0 0 0;">-</p></div> 
					    <div class="ui-block-e" style="width:20% !important; padding:0;"><input type="text" id="hp03" value="" /></div> 
					</div>
				</div> 
			</div>
			<div class="ui-grid-a" id="koker_name_div"> 
			    <div class="ui-block-a" >
					<label for="">닉네임</label>
				</div> 
			    <div class="ui-block-b">
					<input type="text" id="koker_name" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="" />
				</div> 
			</div>
	    	<div class="ui-grid-a"> 
			    <div class="ui-block-a" >
					<label for="">기존비밀번호</label>
				</div> 
			    <div class="ui-block-b">
					<input type="password" id="password" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="" />
				</div> 
			</div>
			<div class="ui-grid-a"> 
			    <div class="ui-block-a" >
					<label for="">신규비밀번호</label>
				</div> 
			    <div class="ui-block-b">
					<input type="password" id="password_new" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="" />
				</div> 
			</div>
			<div class="ui-grid-a"> 
			    <div class="ui-block-a" >
					<label for="">비밀번호확인</label>
				</div> 
			    <div class="ui-block-b">
					<input type="password" id="password_chk" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="" />
				</div> 
			</div>
	    </div>

</div>
<!--start 일반회원 이미지 -->
	<div data-role="content" class="join_content" id="member_img" style="display: none;">
		<div class="member_set_table title_set"> 
	    	<p style="margin:.5em 0 !important;">파일 첨부</p>
		</div>
	    <div class="member_set_img_table">
	    	<p>프로필이미지</p>
		    <div class="set_img_logo" style="position:relative; ">
		    	<input type="hidden" id="fileUploadPath4" name="fileUploadPath4" value=""/>
				<input type="hidden" id="fileNewName4" name="fileNewName4" value="" />
				<input type="hidden" id="destination4" name="destination4" value="" />
    			<form id="logo_upload" name="logo_upload" method="post"  enctype="multipart/form-data" action="<%=cp%>/comm/saveFileUpload.do?fileGbn=logo">
					<input type=file name='file'  id="logo"   style='display: none;'accept="image/*;capture=camera" onclick="getFile('logo')"> 
				</form>
				<img src='../img/member_set/member_img_logo.jpg' border='0' onclick='document.getElementById("logo").click();' id="member_preview">
				<div class="list_text_mark" onclick="del_img('logo');" style="right:16px; width: 1em;"> 
			   			<img src="../../img/del_btn.png" />
			   	</div>
		    </div> 
	    </div>
		<div class="member_set_table title_set"> 

		</div>
	</div>
<!--end 일반회원이미지 -->	
	
	
<!-- 업체회원부분 -->
	<div data-role="content" class="join_content" id="info_modify">
		<div class="ui-grid-b member_set_title"> 
		    <p class="ui-block-a join_title" style="line-height:42px; margin:0; padding:0;">업체정보수정</p> 
		    	<a href="../kokkok20/kokkok20_details.do?koker_no" class="ui-block-c" data-ajax="false" id="details" style="background-color: #29A9C8; border-radius: 20px; color: #fff !important; text-align: center; width: 40%;
					padding: .5em .2em; float: right;">내 업체정보 보기</a> 
	    </div>
	    <div class="member_set_table">
	    	<div class="ui-grid-c input_height"> 
			    <div class="ui-block-a">
					<label for="work_time">업무시간</label>
				</div> 
			    <div class="ui-block-b" style="width:35% !important;">
					<input type="time" id="call_stime" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="오전 9:00 ~ 오후 6:00" />
				</div> 
			    <div class="ui-block-c" style="width:5% !important;">
			    	<p>~</p>
				</div> 
			    <div class="ui-block-d" style="width:35% !important; margin:0;">
					<input type="time" id="call_ntime" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="오전 9:00 ~ 오후 6:00">
				</div> 
			</div>
	    	<div class="ui-grid-a"> 
			    <div class="ui-block-a">
					<label for="holiday">휴일</label>
				</div> 
			    <div class="ui-block-b" style="width:55% !important;">
					<input type="text" id="holiday" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="   주말 , 공휴일" />
				</div> 
			</div>
			<div class="ui-grid-a"> 
			    <div class="ui-block-a">
					<label for="call_tel">업체번호</label>
				</div> 
			    <div class="ui-block-b" style="width:75% !important;">
<!-- 					<input type="text" id="call_tel" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';"  -->
<!-- 							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="000-000-0000" /> -->
				     <div class="ui-grid-d input_align"> 
					    <div class="ui-block-a" style="width:20% !important; padding:0;">
     					  <input type="text" id=call_tel01 value=""  onKeyUp="next_focus('call_tel01','call_tel02',3);" /></div> 
					    <div class="ui-block-b" style="width:5% !important; padding:0;"><p style="margin:.2em 0 0 0;">-</p></div> 
					    <div class="ui-block-c" style="width:20% !important; padding:0;">
					     <input type="text" id="call_tel02" value="" onKeyUp="next_focus('call_tel02','call_tel03',4);"/></div> 
					    <div class="ui-block-d" style="width:5% !important; padding:0;"><p style="margin:.2em 0 0 0;">-</p></div> 
					    <div class="ui-block-e" style="width:20% !important; padding:0;"><input type="text" id="call_tel03" value="" /></div> 
					</div>
				</div> 
			</div>
	    	<div class="ui-grid-a"> 
			    <div class="ui-block-a">
					<label for="url">홈페이지</label>
				</div> 
			    <div class="ui-block-b">
					<input type="url" id="koker_url" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="www.ooooooo.com" />
				</div> 
			</div>
	    	<div class="ui-grid-a"> 
			    <div class="ui-block-a textarea_size">
					<label for="hello" style="border-right:solid #d7d7d7 0px;">인사말</label>
				</div> 
			    <div class="ui-block-b">
					<textarea id="koker_content" style="font-size:1em; color:#686868;" onfocus="if(this.value==인사말을 적어주세요){this.value='';}this.style.color='#686868';" 
							onblur="if(this.value==this.defaultValue){this.value=this.defaultValue;this.style.color='#DBDBDB';}" >인사말을 적어주세요</textarea>
				</div> 
			</div>
	    </div>
	   <div id="footer" data-position="fixed" class="member_set_footer">
	    	<a href="../kokkok20/answer.do?koker_no"  data-ajax="false" id="answer">질문답변하기</a>
	    	
		</div>

		<div class="member_set_table title_set"> 
	    	<p style="margin:.5em 0 !important;">파일 첨부</p>
		</div>
	    <div class="member_set_img_table">
	    	<p>갤러리 <span>*최대3장 첨부가능*</span></p>
	    	<div class="ui-grid-b"> 
			    <div class="ui-block-a list_stats_img" style="text-align:center; width:33.333% !important;">
	    			<input type="hidden" id="fileUploadPath1" name="fileUploadPath1" value=""/>
					<input type="hidden" id="fileNewName1" name="fileNewName1" value="" />
					<input type="hidden" id="destination1" name="destination1" value="" />
	    			<form id="file_upload1" name="file_upload1" method="post"  enctype="multipart/form-data" action="<%=cp%>/comm/saveFileUpload.do?fileGbn=file01">
						<input type=file name='file' id="file01" style='display: none; ' accept="image/*;capture=camera" onclick="getFile('file01')"> 
					</form>
					<img src='../img/member_set/member_img_plus.jpg' border='0' onclick='document.getElementById("file01").click();' id="file01_preview" accept="image/*" capture="camera">
			   		<div class="list_text_mark" onclick="del_img('file01');"> 
			   			<img src="../../img/del_btn.png" />
			   		</div>
			    </div> 
			    <div class="ui-block-b list_stats_img" style="text-align:center; width:33.333% !important;">
			   		<input type="hidden" id="fileUploadPath2" name="fileUploadPath2" value=""/>
					<input type="hidden" id="fileNewName2" name="fileNewName2" value="" />
					<input type="hidden" id="destination2" name="destination2" value="" />
	    			<form id="file_upload2" name="file_upload2" method="post"  enctype="multipart/form-data" action="<%=cp%>/comm/saveFileUpload.do?fileGbn=file02">
						<input type=file name='file' id="file02" style='display: none;'accept="image/*;capture=camera" onclick="getFile('file02')" > 
					</form>
					<img src='../img/member_set/member_img_plus.jpg' border='0' onclick='document.getElementById("file02").click();' id="file02_preview">
					<div class="list_text_mark" onclick="del_img('file02');"> 
			   			<img src="../../img/del_btn.png" />
			   		</div>
			    </div> 
			    <div class="ui-block-c list_stats_img" style="text-align:center; width:33.333% !important;">
			    	<input type="hidden" id="fileUploadPath3" name="fileUploadPath3" value=""/>
					<input type="hidden" id="fileNewName3" name="fileNewName3" value="" />
					<input type="hidden" id="destination3" name="destination3" value="" />
	    			<form id="file_upload3" name="file_upload3" method="post"  enctype="multipart/form-data" action="<%=cp%>/comm/saveFileUpload.do?fileGbn=file03">
						<input type=file name='file' id="file03" style='display: none;'accept="image/*;capture=camera" onclick="getFile('file03')"> 
					</form>
					<img src='../img/member_set/member_img_plus.jpg' border='0' onclick='document.getElementById("file03").click();' id="file03_preview">
					<div class="list_text_mark" onclick="del_img('file03');"> 
			   			<img src="../../img/del_btn.png" />
			   		</div>
			    </div> 
			</div>
	    	<p>로고 및 대표이미지</p>
		    <div class="set_img_logo " style="position:relative;">
		    	<input type="hidden" id="fileUploadPath4" name="fileUploadPath4" value=""/>
				<input type="hidden" id="fileNewName4" name="fileNewName4" value="" />
				<input type="hidden" id="destination4" name="destination4" value="" />
    			<form id="logo_upload" name="logo_upload" method="post"  enctype="multipart/form-data" action="<%=cp%>/comm/saveFileUpload.do?fileGbn=logo">
					<input type=file name='file'  id="logo"   style='display: none;'accept="image/*;capture=camera" onclick="getFile('logo')"> 
				</form>
				<img src='../img/member_set/member_img_logo.jpg' border='0' onclick='document.getElementById("logo").click();' id="logo_preview">
				<div class="list_text_mark" onclick="del_img('logo');" style="right:16px; width: 1em;"> 
			   			<img src="../../img/del_btn.png" />
			   		</div>
		    </div> 
	    </div>
		<div class="member_set_table title_set"> 
<!-- 	    	<p><span>*사진업로드시 미리보기 이미지는 제공되지 않습니다.</span></p> -->
<!-- 	    	<p style="margin-bottom:.5em !important;" ><span>*업로드한 사진은 내 업체 정보보기에서 확인해주세요.</span></p> -->
		</div>
		
	<div id="footer" data-position="fixed" class="member_set_footer">
<!-- 		<p>*개인 정보 (이름, 메일, 휴대폰 등) 변경은 고객지원실(1566-5831)을 이용 해주시기 바랍니다.</p> -->
<!-- 		<a href="#popupDialog_submit" data-rel="popup" data-position-to="window" data-transition="pop">정보 수정하기</a> -->
<!-- 		<a href="#"  data-position-to="window" onclick="chkCompanyInfo()" >정보 수정하기</a> -->
<!-- 		<div id="popupDialog_submit" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup"> -->
<!-- 	    	<div class="ui-content" role="main"> -->
<!-- 				<p>정보를 수정하시겠습니까?</p>	      		 -->
<!-- 	      	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false" >취소</a>   -->
<!-- 	      	  	<a style="background-color:#29A9C8;" href="#" data-rel="back">완료</a>     -->
<!-- 	  	  	</div>     -->
<!-- 	    </div> -->
 	</div> 
	
		<div id="popupDialog" class="com_popup" style="max-width:400px;" data-role="popup" data-theme="b" data-overlay-theme="b" data-dismissible="false">
		    <div class="com_popup_text" role="main">
		        <p id="dialog_txt"></p>
		        <a href="#" data-rel="back" data-ajax="false">확인</a>
		    </div>
		</div>

	</div>	
	<div id="footer" data-position="fixed" class="member_set_footer">
		<a href="#popupDialog_submit"  data-rel="popup" data-position-to="window">정보 수정하기</a>
		
		<div id="popupDialog_submit" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup" data-overlay-theme="b" data-dismissible="false">
	    	<div class="ui-content" role="main">
				<p id="popupDialog_text">정보를 수정하시겠습니까?</p>	      		
	      	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false" id="chkCompany_cancle" >취소</a>  
	      	  	<a style="background-color:#29A9C8;" href="#" onclick="chkCompanyInfo()"  data-ajax="false" id="chkCompany_upt">수정</a>    
	      	  	<a style="background-color:#29A9C8; display: none; padding: .7em 6.2em !important;" href="#" data-ajax="false" onclick="chgPopup()" data-rel="back" id="chkCompany_ok" >확인</a>    
	  	  	</div>  
	  	 </div>	  
	</div>
</div>
</body>
</html>


