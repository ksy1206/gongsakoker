<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="stylesheet" href="../css/smoothness/jquery-ui.css">
<link rel="stylesheet" href="../css/smoothness/jquery-ui-1.10.4.custom.css">
<link rel="stylesheet" href="../css/smoothness/ui.jqgrid.css">

<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script src="../js/grid/i18n/grid.locale-kr.js"></script>
<script src="../js/grid/jquery.jqGrid.min.js"></script>
<script src="../js/json2.js"></script>

<script type="text/javascript">

	
	
	$(document).ready(function (){
		
			pointChange('${class_code}');
		
			$('#infoAverage').jqGrid({
				colNames : ['회사번호','회사이름','평점','순위']
				,colModel: [
				    {name:'koker_no',index:'koker_no' , width:35,align:'center' , editable:true}
					,{name:'koker_name', index:'koker_name' , width:70,align:'center' , editable:true}
					,{name:'average' , index:'average' , width:25,align:'center' , sortable:true ,sorttype: "number" , editable:true}
					,{name:'ranking', index:'ranking' , width:25,align:'center',  editable:true}
				]
				,loadError:function(xhr, status, error) {
					// 데이터 로드 실패시 실행되는 부분
				    alert(error); 
				} 
				,sortname:'average'
				,sortorder : 'desc'
				,viewrecords:true
				,width:326
				,rowNum:50
				,pager:'#pager1'
				,datatype:'local'
				,caption: "평점 순위 50개 회사"
			});
			
			$('#rankNumber').jqGrid({
				colNames : ['회사번호','회사이름','평점','순위']
				,colModel: [
					{name:'koker_no',index:'koker_no' , width:35,align:'center', editable:true}
					,{name:'koker_name',index:'koker_name', width:70,align:'center', editable:true}
					,{name:'average' ,index:'average', width:25,align:'center',sorttype: "number", sortable:true, editable:true}
					,{name:'ranking',index:'ranking', width:25,align:'center', editable:true}
				]
				,gridComplete : function() {

				}
				,loadError:function(xhr, status, error) {
					// 데이터 로드 실패시 실행되는 부분
				    alert(error); 
				}
				,sortname:'average'
				,sortorder : 'desc'
				,viewrecords:true
				,width:326
				,rowNum:20
				,pager:'#pager2'
				,datatype:'local'
				,caption: "랭크  1~20위 등록"
			});
			
			$('#deleteRank').jqGrid({
				colNames : ['회사번호','회사이름','평점','순위']
				,colModel: [
					{name:'koker_no',index:'koker_no' , width:35,align:'center' , editable:true}
					,{name:'koker_name',index:'koker_name', width:70,align:'center' , editable:true}
					,{name:'average' ,index:'average', width:25,align:'center' ,sortable:true , editable:true}
					,{name:'ranking',index:'ranking', width:25,align:'center',  editable:true}
				]
				,gridComplete : function() {
				}
				,loadError:function(xhr, status, error) {
					// 데이터 로드 실패시 실행되는 부분
				    alert(error); 
				} 
				,sortname:'average'
				,sortorder : 'desc'
				,viewrecords:true
				,width:326
				,rowNum:20
				,pager:'#pager3'
				,datatype:'local'
				,caption: "랭크에서 제외된 회사"
				,loadonce:true,  
			});
			
			$('#sortTable').jqGrid({
				colNames : ['회사번호','회사이름','평점','순위']
				,colModel: [
					{name:'koker_no',index:'koker_no' , width:35,align:'center' , editable:true}
					,{name:'koker_name',index:'koker_name', width:70,align:'center' , editable:true}
					,{name:'average' ,index:'average', width:25,align:'center' ,sortable:true , editable:true}
					,{name:'ranking',index:'ranking', width:25,align:'center',  editable:true}
				]
				,gridComplete : function() {
				}
				,loadError:function(xhr, status, error) {
					// 데이터 로드 실패시 실행되는 부분
				    alert(error); 
				} 
				,sortname:'average'
				,sortorder : 'desc'
				,viewrecords:true
				,width:994
				,rowNum:20
				,pager:'#pager4'
				,datatype:'local'
				,caption: "정렬용 테이블"
				,loadonce:true,  
			});

			jQuery("#infoAverage").jqGrid('gridDnD',{connectWith:'#deleteRank,#rankNumber,#sortTable'});
			jQuery("#rankNumber").jqGrid('gridDnD',{connectWith:'#deleteRank,#infoAverage,#sortTable'});
			jQuery("#deleteRank").jqGrid('gridDnD',{connectWith:'#rankNumber,#infoAverage,#sortTable'});
			jQuery("#sortTable").jqGrid('gridDnD',{connectWith:'#rankNumber,#infoAverage,#deleteRank'});
			
		});
	
	function pointChange(obj){
		
		$('#class_code').val(obj);
		
		var gridInfoAverageData = [],gridRankData = [],gridDeleteRankData = [];
		
		$.ajax({
	        type        : "POST"
	      , url         : "admin_getKokkok20.do"
	      , data        : "class_code=" + obj
	      , dataType    : "json" 
	      , timeout     : 30000      
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
	    	  alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
	      }
	      , success     : function(data) {
	    	  
				var infoCount = 1;
				$.each(data.infoAverage, function(index, infoAverage) {
	    		  
					gridInfoAverageData.push({
						koker_no:infoAverage.koker_no
						,koker_name:infoAverage.koker_name
						,average:infoAverage.average
						,ranking:infoCount
					 
					});
					
					infoCount++;
	    		  
				});
	    	  
				var rankCount = 1;
				$.each(data.rankNumber, function(index, rankNumber) {
	    		  
					gridRankData.push({
						koker_no:rankNumber.koker_no
						,koker_name:rankNumber.koker_name
						,average:rankNumber.average
						,ranking:rankCount
					 
					});
				  
					rankCount++;
					
				});	
	    		
				$.each(data.deleteRank, function(index, deleteRank) {
		    		  
					gridDeleteRankData.push({
						koker_no:deleteRank.koker_no
						,koker_name:deleteRank.koker_name
						,average:deleteRank.average
						
					});
				  
				});
				jQuery ( '#infoAverage' ). jqGrid ( 'clearGridData' ); 
				for (var i = 0; i <= gridInfoAverageData.length; i++) {
				    jQuery("#infoAverage").jqGrid('addRowData',i + 1, gridInfoAverageData[i]);
				}
				jQuery ( '#infoAverage' ). trigger ( 'reloadGrid' );
				
				jQuery ( '#rankNumber' ). jqGrid ( 'clearGridData' ); 
				for (var i = 0; i <= gridRankData.length; i++) {
				    jQuery("#rankNumber").jqGrid('addRowData',i + 1, gridRankData[i]);
				}
				jQuery ( '#rankNumber' ). trigger ( 'reloadGrid' );
				
				jQuery ( '#deleteRank' ). jqGrid ( 'clearGridData' ); 
				for (var i = 0; i <= gridDeleteRankData.length; i++) {
				    jQuery("#deleteRank").jqGrid('addRowData',i + 1, gridDeleteRankData[i]);
				}
				jQuery ( '#deleteRank' ). trigger ( 'reloadGrid' );
				
				jQuery ( '#sortTable' ). jqGrid ( 'clearGridData' ); 
				jQuery ( '#sortTable' ). trigger ( 'reloadGrid' );
	      }
	      
    	});
		
	}
	
	function saveRanking(){
		
		var rankArray = [];
		var deleteArray = [];
		var koker_no_arr= [];
		var koker_name_arr = [];
		var average_arr = [];
		
		var reccount = jQuery('#rankNumber').getGridParam('reccount');
		for (var i = 0; i < reccount; i++) {
			
			var rankRowId = jQuery('#rankNumber').jqGrid('getDataIDs')[i];
			var rankRowData = $('#rankNumber').jqGrid('getRowData', rankRowId);
			koker_no_arr += rankRowData.koker_no+",";
			koker_name_arr += rankRowData.koker_name+",";
			average_arr += rankRowData.average+",";
								
		}
		
		if(koker_no_arr!=""){
			koker_no_arr = koker_no_arr.substring(0, koker_no_arr.length - 1);
			koker_name_arr = koker_name_arr.substring(0, koker_name_arr.length - 1);
			average_arr = average_arr.substring(0, average_arr.length - 1);	
		}else{
			koker_no_arr = 1;
		}
		
		var koker_no_arr1 = [];
		
		var reccount1 = jQuery('#deleteRank').getGridParam('reccount');
		for (var i = 0; i < reccount1; i++) {
			
			var deleteRowId = jQuery('#deleteRank').jqGrid('getDataIDs')[i];
			var deleteRowData = $('#deleteRank').jqGrid('getRowData', deleteRowId);
			
			koker_no_arr1 += deleteRowData.koker_no+",";
				
		}
		if(koker_no_arr1!=""){
			koker_no_arr1 = koker_no_arr1.substring(0, koker_no_arr1.length - 1);	
		}else{
			koker_no_arr1 = 1;
		}
		
		$.ajax({
			  type        : "POST"
			, url         : "rankManager.do"
			, data        : "koker_no_arr=" + koker_no_arr + "&koker_name_arr=" + koker_name_arr 
							+ "&average_arr="+average_arr + "&koker_no_arr1="+koker_no_arr1 + ""
							+ "&class_code="+$('#class_code').val()
			, dataType    : "json"
			, timeout     : 30000
			, contentType : "application/x-www-form-urlencoded;charset=UTF-8"
			, error       : function(request, status, error) {
			}
			, success     : function(data) {
				
				alert('저장되었습니다.');
				var code = $('#class_code').val();
				pointChange(code);
				
			}
		});
		
	}
</script>
</head>
<body>

	<jsp:include page="admin_header.jsp"/>
	
	<p style="font-family:'GodoM'; font-size:18px; width:980px; margin:0 auto; padding-top:1em;">콕콕20 관리</p>
	
	<input type="hidden" name="class_code" id="class_code">
	
	<div class="select_div">
		<input type="button" value="(02)자재" onclick="javascript:pointChange('02')">
		<input type="button" value="(03)기술자" onclick="javascript:pointChange('03')">
		<input type="button" value="(04)장비" onclick="javascript:pointChange('04')">
		<input type="button" value="(05)시공" onclick="javascript:pointChange('05')">
		<input type="button" value="(06)종합" onclick="javascript:pointChange('06')">
		<input type="button" value="(07)운송" onclick="javascript:pointChange('07')">
	</div>
	
	<table class="grid_table">
		<tr>
			<td>
				<table id="infoAverage" style="width:100%; font-family:'GodoM'; font-size:14px;"></table>
				<div id="pager1"></div>
			</td>
			<td>
				<table class="member_table" id="rankNumber" style="width:100%; font-family:'GodoM'; font-size:14px;"></table>
				<div id="pager2"></div>
			</td>
			<td>
				<table class="member_table" id="deleteRank" style="width:100%; font-family:'GodoM' font-size:14px;;"></table>
				<div id="pager3"></div>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<table class="member_table" id="sortTable" style="width:100%; font-family:'GodoM'; font-size:14px;"></table>
				<div id="pager4"></div>
			</td>
		</tr>
	</table>
	
	<div style="width:980px; text-align:right; font-size:14px; font-family:'GodoM'; margin:0 auto; padding-top:1em;">
		<span onclick="saveRanking();" style="color:#fff; padding:.5em 5em; background-color:#29A9C8; border-radius:20px; cursor:pointer;">저장</span>
	</div>	

</body>
</html>