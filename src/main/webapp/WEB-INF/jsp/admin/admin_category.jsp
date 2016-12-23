<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true"%>

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
			var updateDialog = {
	                url: 'categoryUpdate.do'
	                , modal: true
	                , onclickSubmit: function (params) {
	                	var classCode = $('#class_code').val();
	                    var ajaxData = {};
	                    var list = $("#categoryTable");
	                    var selectedRow = list.getGridParam("selrow");
	                    rowData = list.getRowData();
	                    cellData = list.getRowData(selectedRow);
	                    ajaxData = { category: rowData.category , code_name:rowData.code_name , code_sort: rowData.code_sort  , gubunCode : 1 , class_code : classCode , code_no : cellData.code_no};
	                    return ajaxData;
	                }
	                , afterSubmit: function (response, postdata){
	                	
	                	if(response.responseText == ""){
	                        return [false,"오류가 났습니다. 담당자에게 문의해주시기 바랍니다."];
	                    }else{
	                    	pointChange($('#class_code').val());
	                        return [true,"Ok"];
	                    }
	                	
	                }
	                , closeAfterEdit: true
	                , width: "400"
	            };
			var addDialog = {
	                url: 'categoryUpdate.do'
	                ,closeAfterAdd: true
	                , modal: true
	                , onclickSubmit: function (params) {
	                	var classCode = $('#class_code').val();
	                    var ajaxData = {};
	                    var list = $("#categoryTable");
	                    var selectedRow = list.getGridParam("selrow");
	                    rowData = list.getRowData();
	                    ajaxData = { category: rowData.category , code_name:rowData.code_name , code_sort: rowData.code_sort , gubunCode : 2 , class_code : classCode};
	                    return ajaxData;
	                }
		            , afterSubmit: function (response, postdata){
		            	
		            	if(response.responseText == ""){
		                    return [false,"오류. 담당자에게 문의해주시기 바랍니다."];
		                }else{
		                	pointChange($('#class_code').val());
		                    return [true,"Ok"];
		                }
		            	
		            }
	                , width: "400"
	            };
			var deleteDialog = {
	                url: 'categoryUpdate.do'
	                ,closeAfterAdd: true
	                , closeAfterEdit: true
	                , modal: true
	                , onclickSubmit: function (params) {
	                	var classCode = $('#class_code').val();
	                    var ajaxData = {};
	                    var list = $("#categoryTable");
	                    var selectedRow = list.getGridParam("selrow");
	                    rowData = list.getRowData(selectedRow);
	                    ajaxData = { category: rowData.category , code_name:rowData.code_name , code_sort: rowData.code_sort , gubunCode : 3 , class_code : classCode , code_no : rowData.code_no };
	                    return ajaxData;
	                }
		            , afterSubmit: function (response, postdata){
		            	
		            	if(response.responseText == ""){
		                    return [false,"오류. 담당자에게 문의해주시기 바랍니다."];
		                }else{
		                	pointChange($('#class_code').val());
		                    return [true,"Ok"];
		                }
		            	
		            }
	                , width: "400"
	            };
			$('#categoryTable').jqGrid({
				colNames : ['카테고리 번호','카테고리 이름','카테고리 정렬 순서','카테고리 pk']
				,colModel: [
					{name:'category',index:'category' , width:35,align:'center', editable:true}
					,{name:'code_name',index:'code_name', width:70,align:'center', editable:true}
					,{name:'code_sort' ,index:'code_sort', width:25,align:'center',sorttype: "number", sortable:true, editable:true}
					,{name:'code_no',index:'code_no' , hidden:true , editable:true , key:true}
				]
				,gridComplete : function() {

				}
				,loadError:function(xhr, status, error) {
					// 데이터 로드 실패시 실행되는 부분
				    alert(error); 
				}
				,ondblClickRow: function (rowid, iRow, iCol, e) {
                    $("#categoryTable").editGridRow(rowid, updateDialog);
                }
				,sortname:'code_sort'
				,sortorder : 'asc'
				,viewrecords:true
				,width:1024
				,height:500
				,rowNum:40
				,pager:'#pager2'
				,datatype:'local'
				,caption: "카테고리 수정 테이블"
				,editable: true
			}).navGrid('#pager2',{edit: true, add: true, del: true, search: false, refresh: true}, updateDialog,addDialog,deleteDialog);

			//jQuery("#categoryTable").jqGrid('navGrid',"#pager2",{edit:false,add:false,del:false});
			//jQuery("#categoryTable").jqGrid('inlineNav',"#pager2");

			//jQuery("#categoryTable").jqGrid('gridDnD',{connectWith:'#categoryTable'});
			
	});
	
	function pointChange(obj){
		
		$('#class_code').val(obj);
		
		var gridInfoAverageData = gridRankData = [];
		
		$.ajax({
	        type        : "POST"
	      , url         : "admin_categoryUpdate.do"
	      , data        : "class_code=" + obj
	      , dataType    : "json" 
	      , timeout     : 30000      
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
	    	  alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
	      }
	      , success     : function(data) {
	    	  
				
				$.each(data.categoryList, function(index, categoryList) {
	    		  
					gridRankData.push({
						category:categoryList.category
						,code_name:categoryList.code_name
						,code_sort:categoryList.code_sort
						,code_no:categoryList.code_no
					});
					
				});	
				
				jQuery ( '#categoryTable' ).jqGrid ('clearGridData'); 
				for (var i = 0; i <= gridRankData.length; i++) {
				    jQuery("#categoryTable").jqGrid('addRowData',i + 1, gridRankData[i]);
				}
				jQuery ( '#categoryTable' ).trigger('reloadGrid');
				
	      }
	      
    	});
		
	}
		
	function saveRanking(){
		
		var category_arr= [];
		var code_name_arr = [];
		var code_sort_arr = [];
		var categorySplit = "";
		var countCategory = 0;
		var countSort = 0;
		var reccount = jQuery('#categoryTable').getGridParam('reccount');
		
		for (var i = 0; i < reccount; i++) {
			
			var categoryRowId = jQuery('#categoryTable').jqGrid('getDataIDs')[i];
			var categoryRowData = $('#categoryTable').jqGrid('getRowData', categoryRowId);
			
			var categoryRow = $('#categoryTable').jqGrid('getRowData', categoryRowId);
			//alert(categoryRowId);
			//alert(categoryRowData.category);
			/* if(i<9){
				categorySplit = categoryRowData.code_sort.split('0')+"";
				categorySplit = categorySplit.substring(1,categorySplit.length);
			}else {
				categorySplit = categoryRowData.category;
			} */
			
			for(var v = 0; v < reccount; v++){
				var rowId = jQuery('#categoryTable').jqGrid('getDataIDs')[v];
				var rowData = $('#categoryTable').jqGrid('getRowData', rowId);
				if(rowData.category == categoryRowData.category){
					countCategory++;
				}
				if(rowData.code_sort == categoryRowData.code_sort){
					countSort++;
				}
			}
			if(countCategory > 1){
				alert("중복된 카테고리가 있습니다.");
				return;
			}
			if(countSort > 1){
				alert("중복된 카테고리정렬순서가 있습니다.");
				return;
			}
			
			countCategory = 0;
			countSort = 0;
			
			category_arr += categoryRowData.category+",";
			code_name_arr += categoryRowData.code_name+",";
			code_sort_arr += categoryRowData.code_sort+",";
			

			category_arr = category_arr.substring(0, category_arr.length - 1);
			code_name_arr = code_name_arr.substring(0, code_name_arr.length - 1);
			code_sort_arr = code_sort_arr.substring(0, code_sort_arr.length - 1);
								
		}
		
/* 		
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
		}); */
		
	}
</script>
</head>

<body>

	<jsp:include page="admin_header.jsp"/>
	
	<div style="width:100%; text-align:center; font-size:14px; font-family:'GodoM'; margin:0 auto; padding-top:5em;">
			
			<input type="hidden" id="class_code" name="class_code"/>
			
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
						<table class="member_table" id="categoryTable" style="width:100%; font-family:'GodoM'; font-size:14px;"></table>
						<div id="pager2"></div>
					</td>
				</tr>
			</table>
			
			<!-- <div style="width:980px; text-align:right; font-size:14px; font-family:'GodoM'; margin:0 auto; padding-top:1em;">
				<span onclick="saveRanking();" style="color:#fff; padding:.5em 5em; background-color:#29A9C8; border-radius:20px; cursor:pointer;">저장</span>
			</div> -->	
		
	</div>	
</body>
</html>