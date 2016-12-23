

	$(document).ready(function(){
//		var isSession = "<%=isSession%>";
//
//		//로그인 처리
//		if(isSession=="true"){
//			$("#login_on").css("display","");
//			$("#login_off").css("display","none");
//		}else{
//			$("#login_on").css("display","none");
//			$("#login_off").css("display","");		
//		}
		
		
		//엔터키입력 시 검색처리
		$('input').keyup(function(e) {
		    if (e.keyCode == 13){
		   
		    	search("web");
			
		    }      
		});
	});
	
	
	function search(flag){
		var class_code =  "";
		var search = "";
		var category = "";
		var gugun = "";
		var sido  = "";
		var order = "";
		
		if(flag=="web"){
			class_code =  $( "#classCodeList option:selected").val();
			search = $("#search").val();
			
		}else if(flag=="web_detail"){
			class_code =  $("#class_code_hidden").val();
			search = $("#search_hidden").val();
			
			$("input[name='category']:checked").each(function() {
				category += 'ca'+$(this).val()+",";
			});
			
			category = category.substring(0,category.length-1);
			gugun = $('input:radio[name="area"]:checked' ).val();
		    sido = $('input:radio[name="city"]:checked' ).val();
			order = $('#order').val();
			
			if(gugun!=undefined && gugun != null && gugun != "" && gugun != "null" ){
				
			}else{
				gugun = "";
			}
			
			if(sido!=undefined && sido != null && sido != "" && sido != "null" ){
			
			}else{
				sido = "";
			}
		}else if(flag=="web_order"){
			class_code =  $("#class_code_hidden").val();
			search = $("#search_hidden").val();
			category =  $("#category_hidden").val();
			gugun = $("#gugun_hidden").val();
			sido =  $("#sido_hidden").val();
			order = $('#order').val();
			
			
			
			if(gugun!=undefined && gugun != null && gugun != "" && gugun != "null" ){
				
			}else{
				gugun = "";
			}
			
			if(sido!=undefined && sido != null && sido != "" && sido != "null" ){
			
			}else{
				sido = "";
			}
		}
		
		if(search == "" ||search == null || search == "null" || search == undefined || search == "검색어를 입력해 주세요."){
			alert( "검색어를 입력해주세요." );
		}else{
			if(class_code == ""){
				alert( "검색할 업체종류를 선택해주세요." );
	            return false;
			}else{
				
				location.href="/search/getSearchList_web.do?search="+search+"&class_code="+class_code+"&category="+category+"&gugun="+gugun+"&order="+order+"&sido="+sido+"&flag="+flag; 
			}
		}
	}
