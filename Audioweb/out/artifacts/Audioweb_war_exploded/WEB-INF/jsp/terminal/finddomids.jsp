<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css"/>
<script type="text/javascript" src="static/js/jquery.min.js"></script>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.excheck.js"></script>
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">

					<div class="row">
							<div class="widget-main" id="tertitle">
<!-- 										<div style="overflow: scroll; scrolling: yes;"> -->
											<ul id="domaintree" class="ztree" style="overflow:auto;"></ul>
<!-- 										</div> -->
									</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->
	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
	<!-- inline scripts related to this page -->
	<script type="text/javascript">
	var zTree;
	var curcastid="";
	$(document).ready(function(){
		$(top.hangge());
		var setting = {
				check: {
		            enable: true,
		            chkStyle: "radio",  //单选框
		            radioType: "all" ,  //对所有节点设置单选
		            chkboxType:  { "Y": "", "N": "" }
		        },
				data: {simpleData: {enable: true}}
			};
		var zNodes = eval(${zTreeNodes});
// 			console.info(${zTreeNodes});
		zTree = $.fn.zTree.init($("#domaintree"), setting, zNodes);

		function treeFrameT() {
				var treeT = document.getElementById("domaintree");
				var bheightT = document.documentElement.clientHeight;
				treeT.style.height = (bheightT - 100) + 'px';
		}
		treeFrameT();
		window.onresize = function() {
				treeFrameT();
		};
	});
		//保存
		function save() {
			//获取选择终端
			var nodes = zTree.getCheckedNodes();
			var domids = "";
			// 				var terips = "";
			for (var i = 0; i < nodes.length; i++) {
				if (nodes[i].type == "0") {
					domids += nodes[i].id+"//"+nodes[i].name;
					// 						terips += nodes[i].TIP+",";
				}
			}
			if(domids == "") {
				return "";
			}else{
				return domids;
			}
		}
	</script>
</body>
</html>