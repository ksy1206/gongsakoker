<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%  
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="stylesheet" href="../css/koker_admin.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script type="text/javascript">
function delete_estimate(){
	var est_no = $("#est_no").val();
	location.href="<%=cp%>/admin/admin_estimateDelete.do?est_no="+est_no;
}
</script>
<body>
	<jsp:include page="admin_header.jsp"/>
	<div style="padding-top:3em; font-family:'godom'; font-weight:normal; font-size: 14px;">
	<div style="width:980px; margin:0 auto; position:relative; padding:1em; border:solid 1px #e9e9e9;">
		<div style="position:absolute; top:1em; right:1em;">
			<input type="button" value="삭제" onclick="delete_estimate()">
			<input type="hidden" value="${est_no}" id="est_no">
		</div>
		<table style="width:980px; margin:0 auto;">
			<tr>
				<td style="width:10%;">시공대상</td>
				<td colspan="2">
					<c:if test="${estimateVo.estType01_code == 1}">
						<c:if test="${estimateVo.estType02_code == '01'}">
							아파트
						</c:if>
						<c:if test="${estimateVo.estType02_code == '02'}">
							주상복합
						</c:if>
						<c:if test="${estimateVo.estType02_code == '03'}">
							오피스텔
						</c:if>
						<c:if test="${estimateVo.estType02_code == '04'}">
							빌라/연립
						</c:if>
						<c:if test="${estimateVo.estType02_code == '05'}">
							기타
						</c:if>
					</c:if>
					<c:if test="${estimateVo.estType01_code == 2}">
						<c:if test="${estimateVo.estType02_code == '01'}">
							사무공간
						</c:if>
						<c:if test="${estimateVo.estType02_code == '02'}">
							식당/요리
						</c:if>
						<c:if test="${estimateVo.estType02_code == '03'}">
							학원/교육
						</c:if>
						<c:if test="${estimateVo.estType02_code == '04'}">
							병원/의료
						</c:if>
						<c:if test="${estimateVo.estType02_code == '05'}">
							매장/상업
						</c:if>
						<c:if test="${estimateVo.estType02_code == '05'}">
							체육기타
						</c:if>
					</c:if>
				</td>				
			</tr>
			<tr>
				<td>시공주소</td>
				<td colspan="2">${estimateVo.est_sido} ${estimateVo.est_gugun}</td>
			</tr>
			<tr>
				<td>시공면적</td>
				<td colspan="2">${estimateVo.est_area}m<sup>2</sup> /${est_area2}평</td>
			</tr>
			<tr>
				<td>시공일자</td>
				<td colspan="2">${estimateVo.est_startDate} ~ ${estimateVo.est_endDate}</td>
			</tr>
			<tr>
				<td>시공비용</td>
				<td colspan="2">${estimateVo.est_cost}만원</td>
			</tr>
			<tr>
				<td>상세설명</td>
				<td colspan="2">
					<textarea readonly="readonly" style="border:none; resize:none; font-family:'godom'; font-size:14px; padding-top:1em;">${estimateVo.est_content}</textarea>
				</td>
			</tr>
		</table>
			<div style="overflow: auto;">
				<p>갤러리</p>
				<div class="admin_grid_sec_3" style="text-align:center;">
					<img src="../upload/img_estimate/${estimateVo.member_no}/${estimateVo.est_img01}" width="30%"/>
				</div>
				<div class="admin_grid_sec_3" style="text-align:center;">
					<img src="../upload/img_estimate/${estimateVo.member_no}/${estimateVo.est_img02}" width="30%"/>
				</div>
				<div class="admin_grid_sec_3" style="text-align:center;">
					<img src="../upload/img_estimate/${estimateVo.member_no}/${estimateVo.est_img03}" width="30%"/>
				</div>
			</div>
		<p style="text-align:center; padding:.5em 0;">==시공분야==</p>
		<c:forEach var="list" items="${fieldList}">
			<c:forEach var="list2" items="${fieldList2}">
				<c:if test="${list.estimate_field_code == list2.field}">
					<c:if test="${list2.value == 'y'}">
						<span style="padding:0 .5em;">${list.estimate_field_name}</span>
					</c:if>
				</c:if>
			</c:forEach>
		</c:forEach>
	</div>
	<c:forEach var="data" items="${list}">
		<div style="overflow:auto; margin:1em 0;">
			<div style="width:980px; margin:0 auto; position:relative; padding:1em; border:solid 1px #e9e9e9;">
				<p class="admin_grid_sec_3" style="width:20%;">
					${data.koker_name}
	<%-- 				<img src="../img/estimate/moveKoker_info.png" onclick="goBusiness_details('${data.koker_no}')"> --%>
				</p>
				<p class="admin_grid_sec_3" style="width:60%;">견적가 ${data.setEst_price} 만원</p>
				<p class="admin_grid_sec_3" style="width:20%; text-align:right;">${data.setEst_insertDate.substring(0,10)}</p>
				<p><textarea readonly="readonly" style="border:none; resize:none; font-family:'godom'; font-size:14px; padding-top:1em;">${data.setEst_content}</textarea></p>
			</div>
		</div>
	</c:forEach>
	</div>
</body>
</html>