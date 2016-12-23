<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% 
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script	src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script>
    (function ($) {
        var methods = {
            init: function (options) {
                var settings = {
                    callback: function () { }
                };
                if (options) {
                    $.extend(settings, options);
                }
                $(":jqmData(role='page')").each(function () {
                    $(this).bind("swipeleft", function () {
                        var nextPage = parseInt($(this).attr("id").split("page")[1]) + 1;
                        if (nextPage === 9) nextPage = 1;
                        $.mobile.changePage("#page" + nextPage, "slide");
                    });
                    $(this).bind("swiperight", function () {
                        var nextPage = parseInt($(this).attr("id").split("page")[1]) - 1;
                        if (nextPage === 0) nextPage = 9;
                        $.mobile.changePage("#page" + nextPage, "slide");
                    });
                });
            }
        }
        $.fn.initApp = function (method) {
            if (methods[method]) {
                return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
            } else if (typeof method === 'object' || !method) {
                return methods.init.apply(this, arguments);
            } else {
                $.error('Method ' + method + ' does not exist');
            }
        }
    })(jQuery);
    $(document).ready(function () {
        $().initApp();
    });
</script>
<script type="text/javascript">
	function send_version() {
		var useragent = navigator.userAgent;
		if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
			window.android.send_version();
		}
	    else if(useragent.indexOf("Connect By iPhone OS") > -1) {
	    	document.location = "iosjavascript://send_version()";
	    }
	    else {
			location.href="<%=cp%>/appMain/appMain.do";
		}
	}
</script>
</head>
<body>
	<div data-role="page" id="page1" style="background-image:url('../img/guide/guide01.gif'); background-size: 100% 100%;">
        <div data-role="header" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; top:0; left:0; width:100%; margin:0 auto;">
			<a href="#" onclick="send_version()" data-transition="slide" data-direction="reverse" style="box-shadow:none; background-color: rgba(255, 255, 255, 0.01); width:95%; border:0; text-align:right; margin:0; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:14px; padding:.3em 0;">닫기 x</a>
		</div>
        <div data-role="footer" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; bottom:0; left:0; width:100%; margin:0 auto;">
			<a href="#page2" data-transition="slide" style="box-shadow:none; border-radius:0; background-color: rgba(255, 255, 255, 0.01); width:100%; border:0; text-align:center; padding:1em 0; margin:0; border:solid 1px #29A9C8; background-color:#29A9C8; color:#fff; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:18px;">다음으로</a>
		</div>
    </div>  

	
	<div data-role="page" id="page2" style="background-image:url('../img/guide/guide02.gif'); background-size: 100% 100%;">
        <div data-role="header" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; top:0; left:0; width:100%; margin:0 auto;">
			<a href="#" onclick="send_version()" data-transition="slide" data-direction="reverse" style="box-shadow:none; background-color: rgba(255, 255, 255, 0.01); width:95%; border:0; text-align:right; margin:0; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:14px; padding:.3em 0;">닫기 x</a>
		</div>
        <div data-role="footer" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; bottom:0; left:0; width:100%; margin:0 auto;">
			<a href="#page3" data-transition="slide" style="box-shadow:none; border-radius:0; background-color: rgba(255, 255, 255, 0.01); width:100%; border:0; text-align:center; padding:1em 0; margin:0; border:solid 1px #29A9C8; background-color:#29A9C8; color:#fff; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:18px;">다음으로</a>
		</div>
    </div>  
    
	<div data-role="page" id="page3" style="background-image:url('../img/guide/guide03.gif'); background-size: 100% 100%;">
        <div data-role="header" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; top:0; left:0; width:100%; margin:0 auto;">
			<a href="#" onclick="send_version()" data-transition="slide" data-direction="reverse" style="box-shadow:none; background-color: rgba(255, 255, 255, 0.01); width:95%; border:0; text-align:right; margin:0; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:14px; padding:.3em 0;">닫기 x</a>
		</div>
        <div data-role="footer" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; bottom:0; left:0; width:100%; margin:0 auto;">
			<a href="#page4" data-transition="slide" style="box-shadow:none; border-radius:0; background-color: rgba(255, 255, 255, 0.01); width:100%; border:0; text-align:center; padding:1em 0; margin:0; border:solid 1px #29A9C8; background-color:#29A9C8; color:#fff; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:18px;">다음으로</a>
		</div>
    </div>  
    
	<div data-role="page" id="page4" style="background-image:url('../img/guide/guide04.gif'); background-size: 100% 100%;">
        <div data-role="header" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; top:0; left:0; width:100%; margin:0 auto;">
			<a href="#" onclick="send_version()" data-transition="slide" data-direction="reverse" style="box-shadow:none; background-color: rgba(255, 255, 255, 0.01); width:95%; border:0; text-align:right; margin:0; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:14px; padding:.3em 0;">닫기 x</a>
		</div>
        <div data-role="footer" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; bottom:0; left:0; width:100%; margin:0 auto;">
			<a href="#page5" data-transition="slide" style="box-shadow:none; border-radius:0; background-color: rgba(255, 255, 255, 0.01); width:100%; border:0; text-align:center; padding:1em 0; margin:0; border:solid 1px #29A9C8; background-color:#29A9C8; color:#fff; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:18px;">다음으로</a>
		</div>
    </div>  
    
	<div data-role="page" id="page5" style="background-image:url('../img/guide/guide05.gif'); background-size: 100% 100%;">
        <div data-role="header" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; top:0; left:0; width:100%; margin:0 auto;">
			<a href="#" onclick="send_version()" data-transition="slide" data-direction="reverse" style="box-shadow:none; background-color: rgba(255, 255, 255, 0.01); width:95%; border:0; text-align:right; margin:0; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:14px; padding:.3em 0;">닫기 x</a>
		</div>
        <div data-role="footer" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; bottom:0; left:0; width:100%; margin:0 auto;">
			<a href="#page6" data-transition="slide" style="box-shadow:none; border-radius:0; background-color: rgba(255, 255, 255, 0.01); width:100%; border:0; text-align:center; padding:1em 0; margin:0; border:solid 1px #29A9C8; background-color:#29A9C8; color:#fff; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:18px;">다음으로</a>
		</div>
    </div>  
    
	<div data-role="page" id="page6" style="background-image:url('../img/guide/guide06.gif'); background-size: 100% 100%;">
        <div data-role="header" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; top:0; left:0; width:100%; margin:0 auto;">
			<a href="#" onclick="send_version()" data-transition="slide" data-direction="reverse" style="box-shadow:none; background-color: rgba(255, 255, 255, 0.01); width:95%; border:0; text-align:right; margin:0; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:14px; padding:.3em 0;">닫기 x</a>
		</div>
        <div data-role="footer" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; bottom:0; left:0; width:100%; margin:0 auto;">
			<a href="#page7" data-transition="slide" style="box-shadow:none; border-radius:0; background-color: rgba(255, 255, 255, 0.01); width:100%; border:0; text-align:center; padding:1em 0; margin:0; border:solid 1px #29A9C8; background-color:#29A9C8; color:#fff; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:18px;">다음으로</a>
		</div>
    </div>  
    
	<div data-role="page" id="page7" style="background-image:url('../img/guide/guide07.gif'); background-size: 100% 100%;">
        <div data-role="header" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; top:0; left:0; width:100%; margin:0 auto;">
			<a href="#" onclick="send_version()" data-transition="slide" data-direction="reverse" style="box-shadow:none; background-color: rgba(255, 255, 255, 0.01); width:95%; border:0; text-align:right; margin:0; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:14px; padding:.3em 0;">닫기 x</a>
		</div>
        <div data-role="footer" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; bottom:0; left:0; width:100%; margin:0 auto;">
			<a href="#page8" data-transition="slide" style="box-shadow:none; border-radius:0; background-color: rgba(255, 255, 255, 0.01); width:100%; border:0; text-align:center; padding:1em 0; margin:0; border:solid 1px #29A9C8; background-color:#29A9C8; color:#fff; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:18px;">다음으로</a>
		</div>
    </div>  
    
	<div data-role="page" id="page8" style="background-image:url('../img/guide/guide08.gif'); background-size: 100% 100%;">
        <div data-role="header" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; top:0; left:0; width:100%; margin:0 auto;">
			<a href="#" onclick="send_version()" data-transition="slide" data-direction="reverse" style="box-shadow:none; background-color: rgba(255, 255, 255, 0.01); width:95%; border:0; text-align:right; margin:0; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:14px; padding:.3em 0;">닫기 x</a>
		</div>
        <div data-role="footer" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; bottom:0; left:0; width:100%; margin:0 auto;">
			<a href="#" onclick="send_version()" data-transition="slide" style="box-shadow:none; border-radius:0; background-color: rgba(255, 255, 255, 0.01); width:100%; border:0; text-align:center; padding:1em 0; margin:0; border:solid 1px #29A9C8; background-color:#29A9C8; color:#fff; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:18px;">시작하기</a>
		</div>
    </div>  
</body>
</html>