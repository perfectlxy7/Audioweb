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
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
	  <script type="text/javascript" src="static/js/jquery.min.js"></script>
	  
	<!-- layui -->
 <link rel="stylesheet" href="static/layuiadmin/layui/css/layui.css">
 
</head>
<body class="body">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				
				<div class="page-content">
				<div class="page-header">
				
				
							<h1>								
								<small>
									<i class="ace-icon fa fa-angle-double-right"></i>
									方案列表
								</small>																					
								
									</h1>
							
                    </div>
					<div class="row">
						<div class="col-xs-12">
							
						<!-- 检索  -->
						<form action="" method="post" name="Form" id="Form" >
						
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center">编号</th>
									<th class="center">方案名称</th>
									<th class="center">选择</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty schelist}">
									<c:forEach items="${schelist}" var="sche" varStatus="vs">
										<tr>
											<td class='center'>${sche.scheId}</td>
											<td class='center'>${sche.scheName}</td>
											<td class='center'>
												<button 
													class="layui-btn layui-btn-xs layui-btn-radius layui-btn-normal" onclick="select('${sche.scheId}','${sche.scheName}');" title="选择此方案"><i class="layui-icon">&#xe620;</i>
												选择此方案
												</button>
											</td>
											</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						</form>
					
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
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	
<!--layui-->
	<script src="static/layuiadmin/layui/layui.js" charset="utf-8"></script>
	<script type="text/javascript">
		//选择
		function select(ScheId,ScheName){
			var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
			parent.layer.close(index);
			window.parent.goback(ScheId,ScheName);
		}
	</script>
</body>
</html>