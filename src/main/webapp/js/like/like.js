//북마크 삭제
function delete_bookmark_no(){
	var session = $("#session_member_no").val();
	
	if(session == "" || session == "null"){
		$("#popupCheck").popup("open");
	} else {
		var member_no = $("#session_member_no").val();
		var koker_no = $("#return_koker_no").val();
		params = "member_no="+member_no+"&koker_no="+koker_no;
		$.ajax({
	        type        : "POST"  
	      , async       : false 
	      , url         : "/kokkok20/deleteBookmark.do"
	      , data        :  params
	      , dataType    : "json" 
	      , timeout     : 30000   
	      , cache       : false     
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
				alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
	      }
	      , success     : function(data) {
	    	  var html = "<img src='../../img/list/list_zzim_off.png' onclick='add_bookmark_no()'/>"    	  
	    	  $("#bookMark").html(html).trigger("create");
	    	  $("#popupDeleteBookmark").popup("open");
	    	  setTimeout("$('#popupDeleteBookmark').popup('close')", 1500);
	      }
		});		
	}
}

//북마크 추가
function add_bookmark_no(){
	var session = $("#session_member_no").val();
	if(session == "" || session == "null"){
		$("#popupCheck").popup("open");
	} else {
		var member_no = $("#session_member_no").val();
		var koker_no = $("#return_koker_no").val();
		params = "member_no="+member_no+"&koker_no="+koker_no;
		$.ajax({
	        type        : "POST"  
	      , async       : false 
	      , url         : "/kokkok20/addBookmark.do"
	      , data        :  params
	      , dataType    : "json" 
	      , timeout     : 30000   
	      , cache       : false     
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
				alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
	      }
	      , success     : function(data) {
	    	  var bookmark_no_reset = $("#bookmark_no_reset").val();
	    	  var html = "";
	    	  html+="<img src='../../img/list/list_zzim_on.png' onclick='delete_bookmark_no()'/>"
	    	  $("#bookMark").html(html).trigger("create");
	    	  $("#popupAddBookmark").popup("open");
	    	  setTimeout("$('#popupAddBookmark').popup('close')", 1500);
	      }
		});		
	}	
}


function delete_bookmark_no_getNo(koker_no,num){
	var session = $("#session_member_no").val();
	if(session == "" || session == "null"){
		$("#popupCheck").popup("open");
	} else {
		var member_no = $("#session_member_no").val();
		//var koker_no = $("#return_koker_no").val();
		params = "member_no="+member_no+"&koker_no="+koker_no;
		$.ajax({
	        type        : "POST"  
	      , async       : false 
	      , url         : "/kokkok20/deleteBookmark.do"
	      , data        :  params
	      , dataType    : "json" 
	      , timeout     : 30000   
	      , cache       : false     
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
				alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
	      }
	      , success     : function(data) {
	    	  var html = "<img src='../../img/list/list_zzim_off.png' onclick='add_bookmark_no_getNo("+koker_no+","+num+")'/>"    	  
	    	  $("#bookMark_"+num).html(html).trigger("create");
	    	  $("#bookMark_S"+num).html(html).trigger("create");
	    	  $("#popupDeleteBookmark").popup("open");
	    	  setTimeout("$('#popupDeleteBookmark').popup('close')", 1500);
	      }
		});		
	}
}

//북마크 추가
function add_bookmark_no_getNo(koker_no,num){
	var session = $("#session_member_no").val();
	if(session == "" || session == "null"){
		$("#popupCheck").popup("open");
	} else {
		var member_no = $("#session_member_no").val();
		//var koker_no = $("#return_koker_no").val();
		params = "member_no="+member_no+"&koker_no="+koker_no;
		$.ajax({
	        type        : "POST"  
	      , async       : false 
	      , url         : "/kokkok20/addBookmark.do"
	      , data        :  params
	      , dataType    : "json" 
	      , timeout     : 30000   
	      , cache       : false     
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
				alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
	      }
	      , success     : function(data) {
	    	  var bookmark_no_reset = $("#bookmark_no_reset").val();
	    	  var html = "";
	    	  html+="<img src='../../img/list/list_zzim_on.png' onclick='delete_bookmark_no_getNo("+koker_no+","+num+")'/>"	  
	    	  $("#bookMark_"+num).html(html).trigger("create");
	    	  $("#bookMark_S"+num).html(html).trigger("create");
	    	  $("#popupAddBookmark").popup("open");
	    	  setTimeout("$('#popupAddBookmark').popup('close')", 1500);
	      }
		});		
	}	
}