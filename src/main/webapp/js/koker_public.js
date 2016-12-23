

	//전화 || 문자 버튼 연결 시 0504임시번호 부여 함수.	
	function doMapping(type,data,koker_no){
		/*
	 	var params = "koker_no="+koker_no+"&call_tel="+data;	
		$.ajax({
	        type        : "POST"  
	      , async       : false 
	      , url         : "/bizlink/set_vn_temp.do"
	      , data        : params
	      , dataType    : "json" 
	      , timeout     : 30000   
	      , cache       : false     
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
	  	    $("#dialog_txt").text("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
			$("#popupDialog").popup("open");   
	      }
	      ,beforeSend:function(){
// 	    	  $("#loading").show();
	      }
	      ,complete:function(){
// 	    	  $("#loading").hide();
	      }
	      , success     : function(data) {
				alert("부여받은 번호는 5분후에 초기화됩니다.");

	    	   connect(type+":"+data.vn);		
	      }
		});
		*/
		
		 connect(type+":"+data);		
 	}
 