<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="../index/top.jsp"%>
	<script type="text/javascript" src="static/js/jquery.min.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css"/>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.excheck.js"></script>
	<style type="text/css">
	footer{height:50px;position:fixed;bottom:0px;left:0px;width:100%;text-align: center;}
	</style>
<body>

</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<div id="suopu">
								<div style="overflow: scroll; scrolling: yes;height:480px;width: 290px;">
								<ul id="tree" class="ztree" style="overflow:auto;"></ul>
								</div>
							</div>
						<!-- /.col -->
						</div>
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->
	<script type="text/javascript">
		$(top.hangge());
		var zTree;
		$(document).ready(function(){
			
			var setting = {
			   check: {	enable: true},
			};
			var zn = '${zTreeNodes}';
			var zTreeNodes = eval(zn);
			zTree=$.fn.zTree.init($("#tree"), setting,zTreeNodes);
// 			type = { "Y":py + sy, "N":pn + sn};
// 			zTree.setting.check.chkboxType = type;
		});
	
		//保存
		 function save(){
			var nodes = zTree.getCheckedNodes();
			var tmpNode;
			var ids = "";
			for(var i=0; i<nodes.length; i++){
				tmpNode = nodes[i];
				if(i!=nodes.length-1){
					ids += tmpNode.id+",";
				}else{
					ids += tmpNode.id;
				}
			}
			var rid = "${rid}";
			return ids;
		 }
	
	</script>
</body>
</html>