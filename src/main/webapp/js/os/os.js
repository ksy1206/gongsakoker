
function getBrowserType(){
	var _ua = navigator.userAgent;
	var  	rv = -1;

	//IE 11,10,9,8
	var trident = _ua.match(/Trident\/(\d.\d)/i);
	if(trident != null){
		if(trident[1] == "7.0") return rv = "InternetExplorer" + 11;
		if(trident[1] == "6.0") return rv = "InternetExplorer" + 10;
		if(trident[1] == "5.0") return rv = "InternetExplorer" + 9;
		if(trident[1] == "4.0") return rv = "InternetExplorer" + 8;
	}
	
	//IE 7
	if(navigator.appName == 'Microsoft Internet Exploer') return rv = "InternetExplorer" + 7;
	
	/*
	var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
	if(re.exec(_ua) != null)rv = parseFloat(RegExp.$1);
	if(rv == 7) return rv = "IE" + 7;
	*/
	
	//other
	var agt = _ua.toLowerCase();
	if(agt.indexOf("chrome") != -1)return 'Chrome';
	if(agt.indexOf("opera") != -1)return 'Opera';
	if(agt.indexOf("staroffice") != -1)return 'Staroffice';
	if(agt.indexOf("webtv") != -1)return 'Webtv';
	if(agt.indexOf("beonex") != -1)return 'Beonex';
	if(agt.indexOf("chimera") != -1)return 'Chimera';
	if(agt.indexOf("netpositive") != -1)return 'Netpositive';
	if(agt.indexOf("phoenix") != -1)return 'Phoenix';
	if(agt.indexOf("firefox") != -1)return 'Firefox';
	if(agt.indexOf("safari") != -1)return 'Safari';
	if(agt.indexOf("skipstone") != -1)return 'Skipstone';
	if(agt.indexOf("netscape") != -1)return 'Netscape';
	if(agt.indexOf("mozilla/5.0") != -1)return 'Mozilla';
}
	var uanaVigatorOs = navigator.userAgent;
	
	var AgentUserOs = uanaVigatorOs.replace(/ /g,'');
	
	var Ostxt = "";
	var OsName = "";
	var OsVers = "";
	//OS명 가져오기
new function(){
		var OsNo = navigator.userAgent.toLowerCase();
		jQuery.os = {
			Linux: /linux/.test(OsNo),
			Unix: /x11/.test(OsNo),
			Mac: /mac/.test(OsNo),
			Windows: /win/.test(OsNo)
		}
	}	
	
	
	
function OSinfoDev(){

	if($.os.Windows){
		if(AgentUserOs.indexOf("WindowsCE") != -1)OSName = "Windows CE";
		else if(AgentUserOs.indexOf("Windows95") != -1) OSName = "Windows 95";
		else if(AgentUserOs.indexOf("Window98") != -1){
			if(AgentUserOs.indexOf("Win9x4.90") != -1) OSName = "Windows Millennium Edition (Windows Me)"
			else OsName = "Windows 98";
		}
		else if(AgentUserOs.indexOf("WindowsNT4.0") != -1) OSName = "WindowsNT4.0";
		else if(AgentUserOs.indexOf("WindowsNT5.0") != -1) OSName = "WindowsNT5.0 ";
		else if(AgentUserOs.indexOf("WindowsNT5.01") != -1) OSName = "WindowsNT5.01";
		else if(AgentUserOs.indexOf("WindowsNT5.1") != -1) OSName = "WindowsNT5.1";
		else if(AgentUserOs.indexOf("WindowsNT5.2") != -1) OSName = "WindowsNT5.2";
		else if(AgentUserOs.indexOf("WindowsNT6.0") != -1) OSName = "WindowsNT6.0";
		else if(AgentUserOs.indexOf("WindowsNT6.1") != -1) OSName = "WindowsNT6.1";
		else if(AgentUserOs.indexOf("WindowsNT6.2") != -1) OSName = "WindowsNT6.2";
		else if(AgentUserOs.indexOf("WindowsNT6.3") != -1) OSName = "WindowsNT6.3";
		else if(AgentUserOs.indexOf("WindowsPhone8.0") != -1) OSName = "WindowsPhone8.0";
		else if(AgentUserOs.indexOf("WindowsOS7.5") != -1) OSName = "WindowsOS7.5";
		else if(AgentUserOs.indexOf("xbox") != -1) OSName = "xbox";
		else if(AgentUserOs.indexOf("xboxOne") != -1) OSName = "xboxOne";
		else if(AgentUserOs.indexOf("Win16") != -1) OSName = "Win16";
		else if(AgentUserOs.indexOf("ARM") != -1) OSName = "ARM";
		else OsName="Windows(unknown)";
		if(AgentUserOs.indexOf("WOW64") != -1) OsVers="64-bit(s/w 32-bit)";
		else if(AgentUserOs.indexOf("Win64;x64;") != -1) OsVers="64-bit(s/w 64-bit)";
		else if(AgentUserOs.indexOf("Win16") != -1) OsVers=" 16-bit";
		else OsVers=" 32-bit"
	}else if($.os.Linux){
		if(AgentUserOs.indexOf("Android") != -1){OSName = getAndroidDevName();}
		else if(AgentUserOs.indexOf("BlackBerry9000") != -1)OSName = "BlackBerry9000";
		else if(AgentUserOs.indexOf("BlackBerry9300") != -1)OSName = "BlackBerry9300";
		else if(AgentUserOs.indexOf("BlackBerry9700") != -1)OSName = "BlackBerry9700";
		else if(AgentUserOs.indexOf("BlackBerry9780") != -1)OSName = "BlackBerry9780";
		else if(AgentUserOs.indexOf("BlackBerry9900") != -1)OSName = "BlackBerry9900";
		else if(AgentUserOs.indexOf("BlackBerry;Opera Mini") != -1)OSName = "Opera/9.80";
		else OSName = "Linux";
		if(AgentUserOs.indexOf("x86_64") != -1) OsVers=" 64-bit";
		else if(AgentUserOs.indexOf("i386") != -1) OsVers=" 32-bit";
		else if(AgentUserOs.indexOf("IA-32") != -1) OsVers=" 32-bit";
		else OsVers=" "

	}else if($.os.Unix){
		OSName="UNIX";
	}else if($.os.Mac){
		if(AgentUserOs.indexOf("iPhoneOS3") != -1) OSName = "iPhone OS 3";
		else if(AgentUserOs.indexOf("iPhoneOS4") != -1)OSName = "iPhone OS 4";
		else if(AgentUserOs.indexOf("iPhoneOS5") != -1)OSName = "iPhone OS 5";
		else if(AgentUserOs.indexOf("iPhoneOS6") != -1)OSName = "iPhone OS 6";
		else if(AgentUserOs.indexOf("iPad") != -1)OSName = "iPad";
		else if((AgentUserOs.indexOf("MacOSX10_9")||AgentUserOs.indexOf("MacOSX10.1") )!= -1)OSName = "Mac OS X Puma";
		else if((AgentUserOs.indexOf("MacOSX10_9")||AgentUserOs.indexOf("MacOSX10.2") )!= -1)OSName = "Mac OS X Jaguar";
		else if((AgentUserOs.indexOf("MacOSX10_9")||AgentUserOs.indexOf("MacOSX10.3") )!= -1)OSName = "Mac OS X Panther";
		else if((AgentUserOs.indexOf("MacOSX10_9")||AgentUserOs.indexOf("MacOSX10.4") )!= -1)OSName = "Mac OS X Tiger";
		else if((AgentUserOs.indexOf("MacOSX10_9")||AgentUserOs.indexOf("MacOSX10.5") )!= -1)OSName = "Mac OS X Leopard";
		else if((AgentUserOs.indexOf("MacOSX10_9")||AgentUserOs.indexOf("MacOSX10.6") )!= -1)OSName = "Mac OS X Snow Leopard";
		else if((AgentUserOs.indexOf("MacOSX10_9")||AgentUserOs.indexOf("MacOSX10.7") )!= -1)OSName = "Mac OS X Lion";
		else if((AgentUserOs.indexOf("MacOSX10_9")||AgentUserOs.indexOf("MacOSX10.8") )!= -1)OSName = "Mac OS X Mountain Lion";
		else if((AgentUserOs.indexOf("MacOSX10_9")||AgentUserOs.indexOf("MacOSX10.9") )!= -1)OSName = "Mac OS X Mavericks";
		else OSName = "MacOS";
	}else{
		OSName = "unKnown OS";
	}
	var OSDev = OSName +" "+ OsVers;
	return OSDev;
}
//Android의 단말 이름을 반환
function getAndroidDevName(){
	var uaAdata = navigator.userAgent;
	var regex = /Android (.*);*,\s*(.*)\sBuild/;
	var match = regex.exec(uaAdata);
	if(match){
		var ver = match[1];
		var dev_name = match[2];
		return "Android "+ ver + "  " + dev_name; 
	}
	return "Android OS";
}

//var br = getBrowserType();//브라우저버전
//var os  = OSinfoDev(); //OS버젼

