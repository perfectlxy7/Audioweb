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
	  <script type="text/javascript" src="static/js/jquery.min.js"></script>
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
					<div class="row">
						<div class="col-xs-12">
								<form  name="Form" id="Form" method="post">
									<input type="hidden" name="ScheId" id="ScheId" value="${ScheId}"/> 
									<div id="suopu" style="padding-top: 13px;">
									<table id="table_report" class="table table-striped table-bordered table-hover">
										<tr>
											<td style="width:100px;text-align: right;padding-top: 13px;">方案名称:</td>
											<td><input type="text" value="${ScheName}" id="ScheName"  name="ScheName" title="方案名称" style="width:98%;" /></td>
										</tr>
										<tr>
											<td style="width:100px;text-align: right;padding-top: 13px;">方案优先级:</td>
											<td>
												<select class="form-control" id="Priority" name="Priority" value="${Priority}"  data-placeholder="请选择方案优先级" style="width:98%;">
													<option value="2" <c:if test="${Priority=='2'}">selected</c:if>>最高</option>
													<option value="3" <c:if test="${Priority=='3'}">selected</c:if>>高</option>
													<option value="4" <c:if test="${Priority=='4'}">selected</c:if>>中</option>
													<option value="5" <c:if test="${Priority=='5'}">selected</c:if>>低</option>
													<option value="6" <c:if test="${Priority=='6'}">selected</c:if>>最低</option>
												  </select>
											</td>
										</tr>
										<c:if test="${MSG != 'addSche'}">
										<tr>
								        	<td style="width:100px;text-align: right;padding-top: 13px;">方案音量修改:</td>
								            <td class="layui-input-inline">
								                <input type="number" name="Vols" id="Vols" autocomplete="off" min="-40" max="40"  style="width:98%;"value="0">
								          	</td>
								        </tr>
								        </c:if>
										<tr >
											<td style="width:100px;text-align: right;padding-top: 13px;">备注:</td>
											<td ><textarea name="Description" id="Description" wrap="soft" title="备注" style="width:98%;">${Description}</textarea></td>
										</tr>
										<tr>
											<td style="text-align: center;" colspan="10">
												<a class="btn btn-sm btn-primary" onclick="save();" >保存</a>
												<a class="btn btn-sm btn-danger" onclick="close_win();" >取消</a>
											</td>
										</tr>
									</table>
									</div>
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
	</div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!-- <script type="text/javascript" src="static/js/jquery-1.7.2.min.js"></script> -->
<!--layui-->
	 <script src="static/layuiadmin/layui/layui.js" charset="utf-8"></script>
</body>
<script type="text/javascript">
	$(top.hangge());
	layui.use(['form','layer'], function(){
        var form = layui.form
       		layer = layui.layer;
    });
	function save(){
		if($("#ScheName").val()==null||$("#ScheName").val()=="" ){
			/* $("#ScheName").tips({
					side:3,
		            msg:'请输入方案名称',
		            bg:'#AE81FF',
		            time:3
		    });
			$("#ScheName").focus(); */
			layer.tips('请输入方案名称', '#ScheName',{
		          tips: [1,'#3595CC'],
					time:1000
	        });
			return false;
		}else{
			var url = "timedcast/${MSG}.do";
			$.post(url, $("#Form").serialize(), function(data) {
				if ("success" == data.result) {
					var index=parent.layer.getFrameIndex(window.name);
					parent.layer.close(index);
					window.parent.success();
				}
			});
		}
	}
	function close_win(){
		var index=parent.layer.getFrameIndex(window.name);
		parent.layer.close(index);
	}
</script>
</html>