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
<script type="text/javascript" src="static/js/jquery.min.js"></script>
	<script type="text/javascript" src="static/js/rating.min.js"></script>
	<!-- layui -->
 <link rel="stylesheet" href="static/layuiadmin/layui/css/layui.css">
<style>
#divcss5{margin:0 auto;width:300px;height:100px} /* 居中显示css */
 </style>
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="hr hr-18 dotted hr-double"></div>
					<div class="row">
					<form name="Form" id="Form" class="layui-form layui-form-pane ">
						<div class="layui-form-item divcss5" >
							<div class="layui-form-item " >
								<div class="layui-inline">
									<label class="layui-form-label"  style="width: 100px;">音量设置</label>
								</div>
								<div class="layui-inline">
									<div id="rating-22"></div>
								</div>
								<div class="layui-inline">
									<div id="currentval-22"></div>
								</div>
								
							</div>
							<div class="layui-form-item " >
								<div class="layui-inline">
									<label class="layui-form-label"  style="width: 100px;">是否固定</label>
								</div>
								<div class="layui-inline">
									<input type='checkbox' name="fixation" id="fixation" lay-skin="switch" lay-filter='switchTest' lay-text="是|否">
								</div>
							</div>
						</div>
					</form>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->


		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
<!--layui-->
	<script src="static/layuiadmin/layui/layui.js" charset="utf-8"></script>
	<script type="text/javascript">
		$(top.hangge());
		layui.use(['form', 'layer'], function(){
	        var form = layui.form
	                ,layer = layui.layer;
	    });
		 var defaultvol = 30;
		 //音量调节代码
	    $('#rating-22').slidy({
			maxval: 44, 
			interval: 1,
			defaultValue: defaultvol+4,
			finishedCallback:function (value){
				if(defaultvol != value-4){
					defaultvol = value-4;
				}
			},
			moveCallback:function (value){
				$('#currentval-22').html('<strong>' + (value-4) + '</strong>');
			}
		});
		 function back(){
			var is =  $('#fixation').is(':checked');
			console.log(is);
			var info={
					is:is,
					vol:defaultvol
			}
			return info;
		 }
	</script>


</body>
</html>