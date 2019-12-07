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
						<div class="col-xs-12">
							<a href="Qaudioplayer://" id="player"></a>
						</div>
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
	<!-- 页面引用 -->
	<script type="text/javascript" src="static/js/protocol/protocolcheck.js"></script>
	<script type="text/javascript" src="static/js/protocol/example.js"></script>
	<script type="text/javascript">
		var times = 1;
		$(document).ready(function(){
			$(top.hangge());
			var href = document.getElementById("player");
			href.click();//触发打开事件
	        setTimeout(getClient,1000);
	        top.jzts();
		});
		 function getClient(){
			 $.post("<%=basePath%>realtimecast/getClient.do","",function(data){
				if(data.result=="success"){
					top.hangge();
					top.close();
				}else{
					if(times > 5){
				        top.hangge();
				        times = 1;
			    		if(confirm("若加载未成功,请下载插件,请下载后手动运行插件")){
			                window.location.href="/Audioweb/tool/Qaudioplayer.exe";
			            }else{
			            	setTimeout("top.close()",1);
			            }
					}else{
			        	setTimeout(getClient,1000);
						times++;
					}
				}
			});
		 }
	</script>


</body>
</html>