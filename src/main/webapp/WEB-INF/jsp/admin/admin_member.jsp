<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 현재페이지 게시글 수 -->
<c:set var="maxRow" value="7" />
<!-- 현재페이지목록 수 -->
<c:set var="maxPageList" value="10" />

<c:set var="pageNum" value="${pageNum}"/>
<c:set var="totalRow" value="${fn:length(list)}" />
<c:set var="totalPage" value="${(totalRow / maxRow) + ((1 - ((totalRow / maxRow) % 1 )) % 1) }" />


<c:set var="startRow" value="${ (maxRow * pageNum) - maxRow }" />
<c:set var="endRow" value="${ (maxRow * pageNum) - 1 }" />
<c:set var="endPage" value="${ ((pageNum / maxPageList) + ((1 - ((pageNum / maxPageList) % 1)) % 1)) * maxPageList }" />
<c:set var="startPage" value="${ endPage - maxPageList + 1 }" />
<fmt:formatNumber var="nextPage" value="${ endPage + 1 }" />
<fmt:formatNumber var="prevPage" value="${ startPage - 1 }" />


<c:if test="${endPage > totalPage}">
	<c:set var="endPage" value="${totalPage}" />
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<link rel="stylesheet" href="../css/koker_admin.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<c:if test="${result == 1}">
<script>

	alert("수정되었습니다!!");
	location.href = 'admin_memberUpdate.do?member_no='+${member_no}+"&koker_no="+${koker_no};

</script>
</c:if>
<script type="text/javascript">
		
	function pageMove(obj){
		
		var member_code = '${member_code}';
		var class_code = '${class_code}';
		var keyword_01 = '${keyword_01}';
		var category = '${category}';
		var use_yn = '${use_yn}';
		if(member_code != ''){
			document.getElementById('member_code').value = '${member_code}';	
		}
		if(class_code != ''){
			document.getElementById('class_code').value = '${class_code}';	
		}
		if(category != ''){
			document.getElementById('category').value = '${category}';
		}
		if(keyword_01 != ''){
			document.getElementById('keyword_01').value = '${keyword_01}';	
		}
		if(use_yn != ''){
			document.getElementById('use_yn').value = '${use_yn}';	
		}
		document.getElementById('pageNum').value = obj;
		memberSearch.action = 'admin_member.do';
		memberSearch.submit();
		
	}
	function Update(obj1,obj2){
		document.getElementById('member_no').value = obj1;
		document.getElementById('koker_no').value = obj2;		
		memberUpdate.action = 'admin_memberUpdate.do';
		memberUpdate.submit();
		
	}
	function menubar(obj){
		var showMenu = obj;
		if(showMenu=="02"){
			$("#cate02").css("display", "");
		}else if(showMenu=="03"){
			$("#cate03").css("display", "");
		}else if(showMenu=="04"){
			$("#cate04").css("display", "");
		}else if(showMenu=="05"){
			$("#cate05").css("display", "");
		}else if(showMenu=="06"){
			$("#cate06").css("display", "");
		}else if(showMenu=="07"){
			$("#cate07").css("display", "");
		}
		
	}
	function menubarHide(obj){
		var showMenu = obj;
		if(showMenu=="02"){
			$("#cate02").css("display", "none");
		}else if(showMenu=="03"){
			$("#cate03").css("display", "none");
		}else if(showMenu=="04"){
			$("#cate04").css("display", "none");
		}else if(showMenu=="05"){
			$("#cate05").css("display", "none");
		}else if(showMenu=="06"){
			$("#cate06").css("display", "none");
		}else if(showMenu=="07"){
			$("#cate07").css("display", "none");
		}
	}
	
	function member_code_confirm(){
		var member_code =  $("#member_code").val();
		if(member_code =='03'){
			$("#use_yn").val('n');
		}else if(member_code == '01'){
			$("#use_yn").val('y');
		}
	}
</script>

<title>Insert title here</title>
</head>
<body>
	
	<jsp:include page="admin_header.jsp"/>
	
	<form accept-charset="UTF-8" method="post" name="memberUpdate" id="memberUpdate">
		<input type="hidden" id="member_no" name="member_no" value=""/>
		<input type="hidden" id="koker_no" name="koker_no" value=""/>
	</form>
	
	<form accept-charset="UTF-8" method="post" action="admin_member.do" id="memberSearch" name="memberSearch">
			
		<input type="hidden" name="pageNum" id="pageNum" value="1"/>
		<input type="hidden" name="use_yn" id="use_yn" value="" />
		<input type="hidden" name="category" id="category" value="" />
		
		<div class="select_div" style="width:980px; margin:0 auto; padding:1em 0; text-align:left; font-family:'GodoM';">
			<span>회원관리</span>
			<select name="member_code" id="member_code">
				<option value="">선택</option>
				<option value="01">승인</option>
				<option value="02">대기</option>
				<option value="03">탈퇴</option>
			</select>	
			<select name="class_code" id="class_code">
				<option value="">선택</option>
				<option value="01">일반</option>
				<option value="02">자재</option>
				<option value="03">기술자</option>
				<option value="04">장비</option>
				<option value="05">시공</option>
				<option value="06">종합</option>
				<option value="07">운송</option>
			</select>
			<input type="text" name="keyword_01" id="keyword_01" value=""/>
			<input type="submit" value="검색" onclick="javascript:member_code_confirm();" />
		</div>
	
	</form>	
	
	<c:if test="${not empty codeCount}">
		<c:forEach var="codeCount" items="${codeCount}" varStatus="count">
			<c:choose>
	
			    <c:when test="${codeCount.cntName eq 'all'}">
					<c:set var="cntAll" value="${codeCount.cnt}" />
			    </c:when>
	
			    <c:when test="${codeCount.cntName eq '01'}">
					<c:set var="cnt01" value="${codeCount.cnt}" />
			    </c:when>
	
			    <c:when test="${codeCount.cntName eq '02'}">
					<c:set var="cnt02" value="${codeCount.cnt}" />
			    </c:when>
	
			    <c:when test="${codeCount.cntName eq '03'}">
					<c:set var="cnt03" value="${codeCount.cnt}" />
			    </c:when>
	
			    <c:when test="${codeCount.cntName eq '04'}">
					<c:set var="cnt04" value="${codeCount.cnt}" />
			    </c:when>
	
			    <c:when test="${codeCount.cntName eq '05'}">
					<c:set var="cnt05" value="${codeCount.cnt}" />
			    </c:when>

			    <c:when test="${codeCount.cntName eq '06'}">
					<c:set var="cnt06" value="${codeCount.cnt}" />
			    </c:when>
			    
			     <c:when test="${codeCount.cntName eq '07'}">
					<c:set var="cnt07" value="${codeCount.cnt}" />
			    </c:when>
	
			    <c:when test="${codeCount.cntName eq 'wait'}">
					<c:set var="cntWait" value="${codeCount.cnt}" />
			    </c:when>
	
			    <c:when test="${codeCount.cntName eq 'del'}">
					<c:set var="cntDel" value="${codeCount.cnt}" />
			    </c:when>
			
			</c:choose>
		</c:forEach>
	</c:if>

		<table style="width:980px; margin:0 auto;">
			<tr>
				<td class="category_td">
					<a href="admin_member.do">
						전체
					<span>
						<c:if test="${empty cntAll}">
							0
						</c:if>
						${cntAll }건
					</span>
					</a>
				</td>
				<td class="category_td">
					<a href="admin_member.do?class_code=01&member_code=01&use_yn=y">
						일반
					<span>
						<c:if test="${empty cnt01}">
							0
						</c:if>
						${cnt01 }건
					</span>	
					</a>
				</td>
				<td class="category_td" onmouseover="javascript:menubar('02');" onmouseout="javascript:menubarHide('02');">
					<a href="admin_member.do?class_code=02&member_code=01&use_yn=y">
						자재
					<span>
						<c:if test="${empty cnt02}">
							0
						</c:if>
						${cnt02 }건
					</span>	
					</a>
					<ul class="category_ul" style="display: none;" id="cate02">
						<c:forEach items="${categoryList}" var="category">
							<c:if test="${category.class_code == '02'}">
								<li><a href="admin_member.do?class_code=02&member_code=01&use_yn=y&category=${category.category}">${category.code_name}</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</td>
				<td class="category_td" onmouseover="javascript:menubar('05');" onmouseout="javascript:menubarHide('05');">
					<a href="admin_member.do?class_code=05&member_code=01&use_yn=y">
						시공
					<span>
						<c:if test="${empty cnt05}">
							0
						</c:if>
						${cnt05 }건
					</span>	
					</a>
					<ul class="category_ul" style="display: none;" id="cate05">
						<c:forEach items="${categoryList}" var="category">
							<c:if test="${category.class_code == '05'}">
								<li><a href="admin_member.do?class_code=05&member_code=01&use_yn=y&category=${category.category}">${category.code_name}</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</td>
				<td class="category_td" onmouseover="javascript:menubar('04');" onmouseout="javascript:menubarHide('04');">
					<a href="admin_member.do?class_code=04&member_code=01&use_yn=y">
						장비
					<span>
						<c:if test="${empty cnt04}">
							0
						</c:if>
						${cnt04 }건
					</span>	
					</a>
					<ul class="category_ul" style="display: none;" id="cate04">
						<c:forEach items="${categoryList}" var="category">
							<c:if test="${category.class_code == '04'}">
								<li><a href="admin_member.do?class_code=04&member_code=01&use_yn=y&category=${category.category}">${category.code_name}</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</td>
				<td class="category_td" onmouseover="javascript:menubar('06');" onmouseout="javascript:menubarHide('06');">
					<a href="admin_member.do?class_code=06&member_code=01&use_yn=y">
						종합
					<span>
						<c:if test="${empty cnt06}">
							0
						</c:if>
						${cnt06 }건
					</span>	
					</a>
					<ul class="category_ul" style="display:none;" id="cate06">
						<c:forEach items="${categoryList}" var="category">
							<c:if test="${category.class_code == '06'}">
								<li><a href="admin_member.do?class_code=06&member_code=01&use_yn=y&category=${category.category}">${category.code_name}</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</td>
				<td class="category_td" onmouseover="javascript:menubar('07');" onmouseout="javascript:menubarHide('07');">
					<a href="admin_member.do?class_code=07&member_code=01&use_yn=y">
						운송
					<span>
						<c:if test="${empty cnt07}">
							0
						</c:if>
						${cnt07}건
					</span>	
					</a>
					<ul class="category_ul" style="display:none;" id="cate07">
						<c:forEach items="${categoryList}" var="category">
							<c:if test="${category.class_code == '07'}">
								<li><a href="admin_member.do?class_code=07&member_code=01&use_yn=y&category=${category.category}">${category.code_name}</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</td>
				<td class="category_td" onmouseover="javascript:menubar('03');" onmouseout="javascript:menubarHide('03');">
					<a href="admin_member.do?class_code=03&member_code=01&use_yn=y">
						기술자
					<span>
						<c:if test="${empty cnt03}">
							0
						</c:if>
						${cnt03 }건
					</span>	
					</a>
					<ul class="category_ul" style="display: none;" id="cate03">
						<c:forEach items="${categoryList}" var="category">
							<c:if test="${category.class_code == '03'}">
								<li><a href="admin_member.do?class_code=03&member_code=01&use_yn=y&category=${category.category}">${category.code_name}</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</td>
				<td class="category_td">
					<a href="admin_member.do?member_code=02&use_yn=y">
						대기
					<span>
						<c:if test="${empty cntWait}">
							0
						</c:if>
						${cntWait }건 
					</span>	
					</a>
				</td>
				<td class="category_td">
					<a href="admin_member.do?member_code=03&use_yn=n">
						탈퇴
					<span>
						<c:if test="${empty cntDel}">
							0
						</c:if>
						${cntDel }건
					</span>	
					</a>
				</td>
			</tr>
		</table>
	
		<table class="member_table">
			<tr style="color:#29A9C8;">
				<td>회원코드</td>
				<td>ID</td>
				<td>업체이름</td>
			</tr>
			<c:if test="${not empty list}">
				<c:forEach var="List" items="${list}" begin="${startRow }" end="${endRow }" varStatus="count">
					<tr>
						<td>${List.class_code}</td>
						<td>${List.member_id}</td>
						<td>${List.koker_name}</td>
						<td>
							<span onclick="javascript:Update(${List.member_no},${List.koker_no});">수정</span>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		
		<div style="width:100%; margin:0 auto; text-align:center; margin-top:2em; font-family:'GodoM'; font-size:14px;">
			<c:if test="${startPage > 1}">
				<span onclick="javascript:pageMove(${prevPage});">
						<a href="#" style="color:#5EBED6;"><<</a>
				</span>
			</c:if>
			<c:forEach var="pageList" begin="${startPage}" end="${endPage}" varStatus="count">
				<c:choose>
					<c:when test="${pageList == pageNum}">
							<span style="color:#29A9C8; padding:0 .3em;">${pageList}</span>
					</c:when>
					<c:otherwise>
						<span onclick="javascript:pageMove(${pageList});" style="padding:0 .3em;">
								<a href="#">${pageList}</a>
						</span>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			<c:if test="${endPage < totalPage}">
				<span onclick="javascript:pageMove(${nextPage});">
						<a href="#" style="color:#5EBED6;">>></a>
				</span>
			</c:if>
		</div>
		
</body>
</html>