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
<!-- layui -->
 <link rel="stylesheet" href="static/layuiadmin/layui/css/layui.css">
 
 
<script type="text/javascript" src="static/js/jquery.min.js"></script>
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
						<form  action="timedcast/findFile.do" name="Form" id="Form" method="post" class="layui-from">
									<table id="table_report"  class="layui-table">
									<thead>
										<tr>
											<th class="center">文件信息</th>
											<th class="center">选择</th>
										</tr>
									</thead>
										
										<c:choose>
									<c:when test="${not empty filelist}">
									<c:forEach items="${filelist}" var="filename" varStatus="vs">
									<tr ondblclick= "javascript:select('${filename}');">
											<td class='center' style="width: auto;">${filename }</td>
											<td class='center' style="width: auto;">
											<a class="layui-btn layui-btn-xs layui-btn-radius layui-btn-normal" type="button"  href="javascript:select('${filename}');" title="选择此文件" style='text-decoration:none;'><i class="layui-icon"  style="color:blue;" >&#xe608;</i>选择此文件</a>
											</td>
										</tr>
									</c:forEach>
									</c:when>
										<c:otherwise>
											<tr>
											<td colspan="100" class='center'>没有相关数据</td>
											</tr>
										</c:otherwise>
									</c:choose>
										
									</table>
									<div class="page-header position-relative">
											<table style="width:100%;">
													<tr>
														<td style="vertical-align:top;"><div class="pagination"   style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
													</tr>
											</table>
									</div>
								</form>
						
				</div>
				<!-- /.page-content -->
			</div>
		</div>
	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	
<!--layui-->
	<script src="static/layuiadmin/layui/layui.js" charset="utf-8"></script>
	<script type="text/javascript">
		$(top.hangge());
		//选择
		function select(filename){
			window.parent.findfile(filename);
		}
	</script>
</body>
</html>