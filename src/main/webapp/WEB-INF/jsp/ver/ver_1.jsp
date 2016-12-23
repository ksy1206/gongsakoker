<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
 	<link rel="stylesheet" href="../css/koker_mobile.css">
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
	<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
	<title>Insert title here</title>
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
                            if (nextPage === 4) nextPage = 1;
                            $.mobile.changePage("#page" + nextPage, "slide");
                        });
                        $(this).bind("swiperight", function () {
                            var nextPage = parseInt($(this).attr("id").split("page")[1]) - 1;
                            if (nextPage === 0) nextPage = 3;
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
</head>
<body>    
	<div data-role="page" id="page1" style="background-image:url('../img/ver/ver1_end.png'); background-size: 100% 100%;">
        <div data-role="footer" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; bottom:0; left:0; width:100%; margin:0 auto; padding-bottom:1.5em;">
			<a href="https://play.google.com/store/apps/details?id=com.gonggan.koker" style="width:80%; box-shadow:none;	border-radius:0; background-color: rgba(255, 255, 255, 0.01); text-align:center; padding:1em 0; margin:0 10%; border:solid 1px #29A9C8; background-color:#fff; color:#29A9C8; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:18px;">다운로드 바로가기</a>
			<p></p>
			<a href="#page2" data-transition="slide" style="width:80%; box-shadow:none; border-radius:0; background-color: rgba(255, 255, 255, 0.01); text-align:center; padding:1em 0; margin:0 10%; border:solid 1px #29A9C8; background-color:#29A9C8; color:#fff; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:12px;">그 외 다운로드 방법 안내</a>
		</div>
    </div>  
	<div data-role="page" id="page2" style="background-image:url('../img/ver/ver2_page1.png'); background-size: 100% 100%;">
        <div data-role="header" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; top:0; left:0; width:100%; margin:0 auto;">
			<a href="#page1" data-transition="slide" data-direction="reverse" style="box-shadow:none; background-color: rgba(255, 255, 255, 0.01); width:95%; border:0; text-align:right; margin:0; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:14px; padding:.3em 0;">닫기 x</a>
		</div>
        <div data-role="footer" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; bottom:0; left:0; width:100%; margin:0 auto;">
			<a href="#page3" data-transition="slide" style="box-shadow:none; border-radius:0; background-color: rgba(255, 255, 255, 0.01); width:100%; border:0; text-align:center; padding:1em 0; margin:0; border:solid 1px #29A9C8; background-color:#29A9C8; color:#fff; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:18px;">다음으로</a>
		</div>
    </div>  
	<div data-role="page" id="page3" style="background-image:url('../img/ver/ver2_page2.png'); background-size: 100% 100%;">
        <div data-role="header" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; top:0; left:0; width:100%; margin:0 auto;">
			<a href="#page1" data-transition="slide" data-direction="reverse" style="box-shadow:none; background-color: rgba(255, 255, 255, 0.01); width:95%; border:0; text-align:right; margin:0; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:14px; padding:.3em 0;">닫기 x</a>
		</div>
        <div data-role="footer" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; bottom:0; left:0; width:100%; margin:0 auto;">
			<a href="#page4" data-transition="slide" style="box-shadow:none; border-radius:0; background-color: rgba(255, 255, 255, 0.01); width:100%; border:0; text-align:center; padding:1em 0; margin:0; border:solid 1px #29A9C8; background-color:#29A9C8; color:#fff; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:18px;">다음으로</a>
		</div>
    </div>  
	<div data-role="page" id="page4" style="background-image:url('../img/ver/ver2_page3.png'); background-size: 100% 100%;">
        <div data-role="header" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; top:0; left:0; width:100%; margin:0 auto;">
			<a href="#page1" data-transition="slide" data-direction="reverse" style="box-shadow:none; background-color: rgba(255, 255, 255, 0.01); width:95%; border:0; text-align:right; margin:0; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:14px; padding:.3em 0;">닫기 x</a>
		</div>
        <div data-role="footer" style="background-color: rgba(255, 255, 255, 0.01); border:none; position:fixed; bottom:0; left:0; width:100%; margin:0 auto;">
			<a href="#page1" data-transition="slide" data-direction="reverse" data-transition="slide" style="box-shadow:none; border-radius:0; background-color: rgba(255, 255, 255, 0.01); width:100%; border:0; text-align:center; padding:1em 0; margin:0; border:solid 1px #29A9C8; background-color:#29A9C8; color:#fff; font-family:'godom'; text-shadow:none; font-weight:normal; font-size:18px;">끝</a>
		</div>
    </div>  
</body>
</html>