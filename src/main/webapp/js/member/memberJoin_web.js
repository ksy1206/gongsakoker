
$("#chk_id_btn_yn" ).val("N" );

     $(document).ready( function() {
          
            //이메일 중복확인 버튼 클릭
           $( "#check_member_id" ).click(function (){
                $( "#chk_id_btn_yn").val( "Y");
                 var member_id = $( "#member_id").val();
                 var chkVal=chkEmail(member_id,chkVal);
                 
                 if(chkVal==1){  
                    $.ajax({
                        type        : "POST" 
                      , async       : false
                      , url         : "/member/checkMemberId.do"
                      , data        : "member_id=" + member_id
                      , dataType    : "json"
                      , timeout     : 30000  
                      , cache       : false    
                      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
                      , error       : function(request, status, error) {
                    	  	alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );     
                      } 
                      , success     : function(data) {
                                
                                 if(data.member_id_chk== "N"){
                                    alert("아이디 사용가능합니다.");
                                    $( "#member_id_chk").val("Y");
                                } else{
                                	alert("아이디가 중복되었습니다."); 
                                	 $( "#member_id_chk").val("N");
                                }
                                
                      }
                });
                }
           });  
           
            //회원가입 버튼 클릭
           $( "#memberJoin_btn" ).click(function(){
                
                 var name = $( "#name").val();
                 var member_id = $( "#member_id").val();
                 var member_id_chk =  $( "#member_id_chk").val();
                 var password = $( "#password").val();
                 var password_check = $( "#password_check" ).val();
                   
                 var member_code = "";
                 var class_code = "01";
                 var params = "";
                 
                
                
               
                 if(name == null||name == ""||name == undefined ||name=="이름을 입력해주세요." ){
                    alert( "이름을 입력해주세요.");
                    
                     $( "#name").focus();
                      return false;
               }
                 if(member_id== null||member_id== ""||member_id== undefined ||member_id=="OOO@email.com" ){
                    alert( "이메일을 입력해주세요.");
                    
                     $( "#member_id").focus();
                      return false;
                       
                }
                 
                 if($( "#chk_id_btn_yn").val()== "N"){
                    alert("중복확인을 해주세요.");
                    
                     $( "#password_check" ).focus();
                      return false;
                }
                 
                 if(member_id_chk == "N" ){
                	alert( "아이디가 중복되었습니다." );
                    
                     $( "#member_id").focus();
                      return false;
               }

                 if(password== null||password== ""||password== undefined ||password=="비밀번호를 입력해주세요." ){
                    alert( "비밀번호를 입력해주세요.");
                    
                     $( "#password").focus();
                      return false;
                
          }
                 if(password_check== null||password_check== ""||password_check==undefined ||password_check=="비밀번호를 재입력해주세요." ){
                    alert( "비밀번호확인을 입력해주세요.");
                    
                     $( "#password_check" ).focus();
                      return false;
           
                }
                
                 if(password_check!=password){
                      //pw불일치
                    alert( "비밀번호 불일치" );
                    
                     $( "#password_check" ).focus();
                      return false;
                }
                 
                 var pattern1 = /[0-9]/; //숫자
                 var pattern2 = /[a-zA-Z]/; //문자
//               var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/; //특수문자
               

                 if( !pattern1.test(password) || !pattern2.test(password)  || password.length<6 || password.length>12 ){
                	alert( "비밀번호는 문자,숫자 포함한 6~12자리로 구성하여야 합니다.");
                    
                     $( "#password" ).focus();
                      return false;
              
                 }
                 var pattern_semi = /[;]/;  
                 if(pattern_semi.test(password)){
                	alert( "비밀번호에 ';' 은 포함시킬 수 없습니다.");
                    
                     $( "#password" ).focus();
                      return false;
                 }

                
                 if(!$( "#all_chk" ).is(":checked" )){
                    alert( "이용약관에 체크해주세요.");
                    
                      return false;
               }
                
                 //일반회원 파라미터
//                 params = "name=" +name+"&member_id=" +member_id+"&hp01=" +hp01+"&hp02=" +hp02+"&hp03=" +hp03+"&password=" +password;
                 params = "name=" +name+"&member_id=" +member_id+"&password=" +password;
                
                class_code = $("#class_codeList option:selected").val();
                
                 if(class_code == undefined ){
                     class_code = "01";
                     
                }
                
                 if(class_code == "01"){
                	 member_code = "01";
                     params += "&class_code=" +class_code+"&member_code=" +member_code
                     $( "#params").val(params);
                      //회원가입 데이터 전송
                     memberJoin();
                }else{
                	 if(class_code == "03"){
                         member_code = "01";
                         params += "&member_code=" +member_code
                   } else{
                         member_code = "02";
                         params += "&member_code=" +member_code
                   }
                }

                 
                 //업체회원가입부분 스크립트 시작
 
                 if(class_code != "01"){
                	 
                           var koker_name =$('#company_name' ).val();
//                           var call_tel = $("#company_tel" ).val();
//                            var call_tel_arr = call_tel.split("-" );
//                            var call_tel01 = call_tel_arr[0];
//                            var call_tel02 = call_tel_arr[1];
//                            var call_tel03 = call_tel_arr[2];
                           
                           var call_tel01 = $("#call_tel01" ).val();
                           var call_tel02 = $("#call_tel02" ).val();
                           var call_tel03 = $("#call_tel03" ).val();
                           
                           
                         var hp01 = $("#hp01").val();
                         var hp02 = $("#hp02").val();
                         var hp03 = $("#hp03").val();
                         
                         if(hp01 == null||hp01 == ""||hp01 == undefined){
                            alert( "휴대폰번호를 입력해주세요.");
                             
                             $( "#hp01").focus();
                              return false;
                        
                        } 
                         if(hp02 == null||hp02 == ""||hp02 == undefined){
                        	 alert( "휴대폰번호를 입력해주세요.");
                             
                             $( "#hp02").focus();
                              return false;
                        
                        } 
                         if(hp03 == null||hp03 == ""||hp03 == undefined){
                        	 alert( "휴대폰번호를 입력해주세요.");
                             
                             $( "#hp03").focus();
                              return false;
                        
                        } 
                        
                      //member_code = "02";
                        
                      if(koker_name== null||koker_name== ""||koker_name ==undefined ||koker_name=="업체명을 입력해주세요." ){
                          alert( "업체명을 입력해주세요.");
                          
                           $( "#company_name").focus();
                            return false;
                }
                     

                     
                      if(call_tel01 == null||call_tel01 == ""||call_tel01 == undefined){
                         alert( "업체 연락가능한 번호를 입력해주세요.");
                         
                          $( "#call_tel01").focus();
                           return false;
                     
                     } 
                      if(call_tel02 == null||call_tel02 == ""||call_tel02 == undefined){
                         alert( "업체 연락가능한 번호를 입력해주세요.");
                         
                          $( "#call_tel02").focus();
                           return false;
                     
                     }
                      if(call_tel03 == null||call_tel03 == ""||call_tel03 == undefined){
                         alert( "업체 연락가능한 번호를 입력해주세요.");
                         
                          $( "#call_tel03").focus();
                           return false;
                     
                     }
                
                     
                      //전문분야 선택부분
                      var categoryVal= "";
                     $( "input[name='category']" ).each(function (index){
                             var subObj = $( this);
                             if( subObj.is(':checked')){    
                                  categoryVal +=  subObj.val()+ ',';
                             }  
                           });
                           categoryVal  = categoryVal.substring(0, categoryVal.length - 1);
                           var category_arr = categoryVal.split(",");
                          
                           //카테고리 순서별로 정렬	
                           category_arr.sort();
                           categoryVal ="";
                           
                           for(var j = 0;j<category_arr.length;j++){
                        	   categoryVal +=  category_arr[j]+ ',';
                           }
                           categoryVal  = categoryVal.substring(0, categoryVal.length - 1);
                          
                          
                            if(categoryVal.length==0){
                               alert( "전문분야를 1개 이상 선택해주세요.");
                               
                                 return false;
                           }
                     
                           params += "&koker_name=" +koker_name+"&call_tel01=" +call_tel01+"&call_tel02=" +call_tel02+"&call_tel03=" +call_tel03
                           +"&category=" +categoryVal+"&class_code=" +class_code+"&hp01=" +hp01+"&hp02=" +hp02+"&hp03=" +hp03;  
                           $( "#params").val(params);
                     
                           
                      //기술자부분
                      if(class_code == "03"){
                            //member_code = "01";
                            var area = $( "#areaList option:selected").val();
                            var city = $( "#cityList option:selected").val();
                            if(area== null||area== ""||area == undefined ||area=="default" ){
                               alert( "도지역을 선택해주세요.");
                               
                                
                                 return false;
                     }
                            if(city== null||city== ""||city == undefined ||city=="default" ){
                               alert( "시/군/구 지역을 선택해주세요.");
                               
                                
                                 return false;
                     }
                           
                           params += "&addr01="+area+ " "+city; 
                            //기술자 회원가입 데이터 전송
                           $( "#params").val(params);
                           memberJoin();
                     }
                      
 
	                     if(class_code == "02" || class_code == "04" || class_code == "06"|| class_code == "07" ){
	                    	 
	                    		 if($( "#company_paper").val()!= "" && $("#company_paper" ).val()!= null && $("#company_paper" ).val() !=undefined ){
	                            	
	                            		var frm = $( '#file_upload1');
	                                    fileUpload(frm);
	                            		
	                                 
	                     
	                    		 } else{
	                           
	//                            alert("사업자등록증을 첨부해주세요.");
	//                              $("#popupDialog"). popup("open");
	//                              return false;
	                                memberJoin();
	                    		}
	                      
	                     }
	           
	                      if(class_code == "05"){
	                    	  
	                            if($( "#company_paper").val()!= "" && $("#company_paper" ).val()!= null && $("#company_paper" ).val() !=undefined ){
	                               
	                            		var frm = $( '#file_upload1');
	                                    fileUpload(frm);
	                            	
	                           }
	                           else if($( "#company_paper02").val()!= "" && $("#company_paper02" ).val()!= null && $("#company_paper02" ).val() !=undefined ){ 
	                        	  
	                            		var frm = $( '#file_upload2');
	                                    fileUpload(frm);
	                            	
	                           
	                           } 
	                           else{
	                           
	//                            alert("사업자등록증을 첨부해주세요.");
	//                              $("#popupDialog"). popup("open");
	//                              return false;
	                                
	                                memberJoin();
	                           }
	     
	                     }
                     
                }    
                
                
                            
            });        
            //end 회원가입
           
       
           
         //---------------------------------------
            // 폼 전송후 콜백함수 호출
            //---------------------------------------  
            var options = {
                dataType : "json",
             contentType : "application/x-www-form-urlencoded;charset=UTF-8" ,
                success : function(data){
                
                            if(data.resultCode == '1') {
                                
                                 var class_code = $("#class_codeList option:selected").val();
                                     $( "#fileUploadPath1" ).val(data.fileUploadPath);
                                     $( "#fileNewName1").val(data.fileName);
                                     $( "#destination1").val(data.destination);
                                     
                                 if(class_code== "02" || class_code=="04" || class_code=="06"|| class_code=="07" ){
                                      saveCompanyFile();
                                } else{
//                                	var frm = $( '#file_upload2');
//	                                    fileUpload(frm);
                                	if($("#company_paper02").val()!= "" && $("#company_paper02" ).val()!= null && $("#company_paper02" ).val() !=undefined ){ 
     	                            		var frm = $( '#file_upload2');
     	                                    fileUpload(frm);
     	                           }else{
     	                        	  saveCompanyFile();
     	                           }
                                      
                                }

                           } else{
                               alert( "첨부파일 등록에 실패하였습니다.");
                               
                           }
                                                                                
                           
                },
                error : function(xhr, error, data) {
                     
                   alert( "파일 업로드에 실패하였습니다.");
                    
                     
                }
           };

           jQuery( "#file_upload1").ajaxForm(options);
           
            var options2 = {
                     dataType : "json",
                   contentType : "application/x-www-form-urlencoded;charset=UTF-8" ,
                     success : function(data){
                           
                                 if(data.resultCode == '1') {
                                     $( "#fileUploadPath2" ).val(data.fileUploadPath);
                                     $( "#fileNewName2").val(data.fileName);
                                     $( "#destination2").val(data.destination);
                                     
                                      saveCompanyFile();
                                } else	{
                                   alert("첨부파일 등록에 실패하였습니다.");
                                    
                                }
                                                                                      
                                
                     },
                     error : function(xhr, error, data) {
                          alert( "파일 업로드에 실패하였습니다.");
                          
                           
                     }
                };

                jQuery( "#file_upload2").ajaxForm(options2);
           

     }); //end document ready
     
     
      function memberJoin(){
           
            var class_code = $("#class_codeList option:selected").val();
            var params = $( "#params").val();
            

            if(class_code== "02" || class_code== "04" || class_code== "06"|| class_code== "07"){
                params += "&business_file01_name=" + jQuery("#fileNewName1" ).val() + "&business_file01_path=" + jQuery("#fileUploadPath1" ).val();

           } else if(class_code== "05"){
        	 
        		   params += "&business_file01_name=" + jQuery("#fileNewName1").val() + "&business_file01_path=" + jQuery("#fileUploadPath1").val();
                   params += "&business_file02_name=" + jQuery("#fileNewName2").val() + "&business_file02_path=" + jQuery("#fileUploadPath2").val();
        	   
  
           }
           
        
       
           $.ajax({
             type        : "POST" 
           , async       : false
           , url         : "/member/insertMember_join.do"
           , data        : params
           , dataType    : "json"
           , timeout     : 30000  
           , cache       : false    
           , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
           , error       : function(request, status, error) {
                    alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );
           }
           , success     : function(data) {
                
                      if(data.member_join_chk== "Y"){
                          
                          alert( "회원가입이 완료되었습니다." );
                          location.href="/member/webLogin.do";
                         
                            
                          $("#name").val("");
                          $("#member_id").val("");
                          $("#password").val("");
                          $("#password_check").val("");
                          $("#chk_id_btn_yn").val("N");
                          $("#member_id_chk").val("N");
                          $("#params").val("");
                         
                           
                     } else if(data.member_join_chk== "R"){
                          alert( "이미 가입된 회원입니다. 고객센터에 문의주시기 바랍니다." );
                          
                     }else{
                        alert( "회원 가입실패..고객센터에 문의주시기 바랍니다." );
                        
                   }
                     
           }
     });
     }
     


      // 파일업로드 이벤트
      function fileUpload(frm){
    	  frm.submit();        
      }

     
      function saveCompanyFile(){
           
            var params = "";
            var file_cnt = 0;
            var file_stat = "1";
           
            var file_name1 = jQuery("#fileNewName1" ).val();
            var file_name2 = jQuery("#fileNewName2" ).val();
               
            var class_code = $("#class_codeList option:selected").val();
            var member_id = jQuery( "#member_id").val();
           
            if(class_code== "02" || class_code== "04" || class_code== "06"|| class_code== "07"){
                file_cnt = 1;
                file_stat = "1";
                 var destination1 =  jQuery("#destination1" ).val();
                params = "fileNewName1=" + jQuery("#fileNewName1" ).val() + "&fileUploadPath1=" + jQuery("#fileUploadPath1" ).val() +
                 "&file_cnt=" + file_cnt+ "&member_id=" + member_id+"&destination1=" + destination1+"&file_stat=" + file_stat;
           } else{
        	   if(file_name1!=""&&file_name2==""){
        			file_cnt = 1;
        			file_stat = "1";
        			var destination1 =  jQuery("#destination1" ).val();
                    params = "fileNewName1=" + jQuery("#fileNewName1" ).val() + "&fileUploadPath1=" + jQuery("#fileUploadPath1" ).val() +
                     "&file_cnt=" + file_cnt+ "&member_id=" + member_id+"&destination1=" + destination1+"&file_stat=" + file_stat;
        	   }else if(file_name1==""&&file_name2!=""){
        		   file_cnt = 1;
        		   file_stat = "2";
        		      var destination2 =  jQuery("#destination2" ).val();
                      params = "fileNewName2=" + jQuery("#fileNewName2" ).val() + "&fileUploadPath2=" + jQuery("#fileUploadPath2" ).val() +
                       "&file_cnt=" + file_cnt+ "&member_id=" + member_id+"&destination2=" + destination2+"&file_stat=" + file_stat;
        	   }else{
        	   	file_cnt = 2;
                file_stat = "1,2";
                 var destination1 =  jQuery("#destination1" ).val();
                 var destination2 =  jQuery("#destination2" ).val();
                params = "fileNewName1=" + jQuery("#fileNewName1" ).val() + "&fileUploadPath1=" + jQuery("#fileUploadPath1" ).val() +
                 "&fileNewName2=" + jQuery("#fileNewName2" ).val() + "&fileUploadPath2=" + jQuery("#fileUploadPath2" ).val() +
                 "&file_cnt=" + file_cnt+ "&member_id=" + member_id+"&destination1=" + destination1+"&destination2=" + destination2+"&file_stat=" + file_stat;
                
        	   }
           }

           
           $.ajax({
                 type        : "POST" 
               , async       : true
               , url         : "/member/saveCompanyFile.do"
               , data        : params
               , dataType    : "json"
               , timeout     : 30000  
               , cache       : false    
               //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
               , error       : function(request, status, error) {
                   alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );
                          
                     
               }
               , success     : function(data) {
                  if(class_code== "02" || class_code== "04" || class_code== "06"|| class_code== "07"){
                     $( "#fileUploadPath1" ).val(data.fileUploadPath1);
                          $( "#fileNewName1").val(data.fileNewName1);
                     } else{
                    	 if(file_name1!=""&&file_name2==""){
                    		 $( "#fileUploadPath1" ).val(data.fileUploadPath1);
                             $( "#fileNewName1").val(data.fileNewName1);
                 	   }else if(file_name1==""&&file_name2!=""){
                 		  $( "#fileUploadPath2" ).val(data.fileUploadPath2);
                          $( "#fileNewName2").val(data.fileNewName2);
                 	   }else{
                 		  $( "#fileUploadPath1" ).val(data.fileUploadPath1);
                          $( "#fileNewName1").val(data.fileNewName1);
                          $( "#fileUploadPath2" ).val(data.fileUploadPath2);
                          $( "#fileNewName2").val(data.fileNewName2);
                         
                 	   }

                     }
                 
                  memberJoin();
 
               }
     });
                                     
     }
     

     
  	//업체별 전문 분야 로딩 및 화면 세팅
  	function getBusinessKind(){
  	    
  	    
  	      var class_code = $("#class_codeList option:selected").val();
  	    
  	     
  	      $.ajax({
  	             type        : "POST" 
  	           , async       : false
  	           , url         : "/member/getBusinessKind.do"
  	           , data        : "class_code=" + class_code
  	           , dataType    : "json"
  	           , timeout     : 30000  
  	           , cache       : false    
  	           , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
  	           , error       : function(request, status, error) {
  	              $( "#dialog_txt").text( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );
  	              $( "#popupDialog").popup( "open");
  	                     
  	           }
  	           , success     : function(data) {
  	        	
                   
  	                      if(data.kindList!= null && data.kindList.length != 0){
  	                    	  if(data.kindList[0].class_code== "02"||data.kindList[0].class_code== "04"||data.kindList[0].class_code== "06"||data.kindList[0].class_code== "07"){
  	                            $( "#tec_local").css( "display", "none");
  	                            $( "#license").css( "display", "none");
  	                            $( "#file_upload_p").css( "display", "");
  	                            $( "#file_upload_table" ).css("display" ,"" );
	  	                       } else if(data.kindList[0].class_code== "05"){ //시공업체
	  	                            $( "#tec_local").css( "display", "none");
	  	                            $( "#license").css( "display", "");
	  	                            $( "#file_upload_p").css( "display", "");
	  	                            $( "#file_upload_table" ).css("display" ,"" );
	  	                       } else if(data.kindList[0].class_code== "03"){ //기술자
	  	                            $( "#tec_local").css( "display", "");
	  	                            $( "#file_upload_p").css( "display", "none");
	  	                            $( "#file_upload_table" ).css("display" ,"none" );
	  	                            
	  	                       }
  	                           var html =  "";
  	                          $.each(data.kindList, function (index, kindList) {
  	                              
  	                        	html+= "<input  id='check"+kindList.category+ "' type='checkbox' name='category' value='"+kindList.category+ "'  style='display: none;'>" +
  	                        			"<label class='' for='check"+kindList.category+ "' id='check"+kindList.category+"_label' onclick=chk_on('check"+kindList.category+"');  style='padding:.5em 1em;margin:10px 5px;'>"+kindList.code_name+ "</label></div>" ;
 			              	
  	                          });
  	                          
  	                        $( "#code_name_div").html(html).trigger("create");
  	                         
  	                     } else{
  	                    	 
  				          
  	                     }
  	                     
  	                     
  	           }
  	    });
  	     
  	}
     
function getZip_area(){
           
           
            $.ajax({
                   type        : "POST" 
                 , async       : false
                 , url         : "/member/getZip_area.do"
                
                 , dataType    : "json"
                 , timeout     : 30000  
                 , cache       : false    
                 , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
                 , error       : function(request, status, error) {
                 alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );
                          
                     
                 }
                 , success     : function(data) {
                           
                            if(data.areaList!= null && data.areaList.length != 0){
                     
                     
                                 var html = "<option value='default' >시/도</option>";
                                $.each(data.areaList, function (index, areaList) {
                                     
                                     html+= " <option value='"+areaList.sido+ "'>"+areaList.sido+ "</option>" ;
                                     
                                     

                                });
                                
                                $( "#areaList").html(html);
                                
                                
                           } else{
                                
                           }

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
                 alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );
                          
                           
                 }
                 , success     : function(data) {
                           
                            if(data.cityList!= null && data.cityList.length != 0){

                                 var html = "<option value='default'  id='default_option'>군/구</option>";
                                $.each(data.cityList, function (index, cityList) {
                                     html+= " <option value='"+cityList.gugun+ "'>"+cityList.gugun+ "</option>" ;
                                });
                                
                           $( "#cityList").html(html);
                          
                                
                           } else{
                                
                           }
                           
                           

                 }
                
                
          });
           
     }    
     
      //이메일 체크
      function chkEmail(emailStr,chkVal) {
            var format  = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/ ;
            if(emailStr.search(format) == -1||emailStr=="OOO@email.com" ){
            	alert( "이메일 형식에 맞게 입력해주세요.");
                chkVal = 0;
                 return chkVal;
           } else{
                chkVal = 1;
                 return chkVal;       
           }
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

  
