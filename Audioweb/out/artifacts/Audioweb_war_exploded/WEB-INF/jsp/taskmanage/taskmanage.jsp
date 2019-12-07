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
								<div class="page-header">
									<h1><small><i class="ace-icon fa fa-angle-double-right"></i>
										广播任务管理</small></h1>
								</div>
								<div class="col-xs-12">
							<div class="layui-form-item">
								<div class="layui-inline">
									<button title="刷新" class="layui-btn  layui-btn-radius" onclick="history.go(0)" >刷新
									</button>
								</div>
								 <div class="layui-inline"> 
							   		<button title="停止全部任务" class="layui-btn  layui-btn-radius layui-btn-danger" onclick="stopalltask();" >停止全部任务
							   		</button>
							   	</div>	
							</div>
								<table id="table_tasklist" class="layui-table" style="margin-top:5px;">
										<thead>
								<!-- class="table table-striped table-bordered table-hover" -->
								  <tr>
<!-- 									<th class="center" style="width:35px;"> -->
<!-- 									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label> -->
									<!-- </th> -->
										<th class="center" >广播任务编号</th>
										<th class="center" >广播任务类型</th>
										<th class="center" >广播任务信息</th>
										<th class="center" >是否正在广播</th>
										<th class="center" >广播倒计时</th>
										<th class="center" >广播任务优先级</th>		
										<th class="center" >广播音量</th>							
										<th class='center'>广播详细控制</th>						
										<th class='center'>广播分组</th>	
										<th class='center' >操作</th>
									</tr>
								</thead>
								<tbody>
										<c:choose>
									<c:when test="${not empty tasklist}">
									<c:forEach items="${tasklist}" var="task" varStatus="vs">
									<tr>
											<td class='center'>${task.taskid}</td>
											<td class='center'>${task.multiCastType}</td>
											<td class='center'><c:if test="${task.taskName != null}">${task.taskName}</c:if><c:if test="${task.taskName == null}">无</c:if></td>
											<td class='center'>${task.isCast?(task.isStop?'<i class="layui-icon" style="color:yellow;">&#xe652;</i>':'<i class="layui-icon" style="color:green;">&#xe605;</i>'):'<i class="layui-icon" style="color:red;">&#x1006;</i>'}</td>
											<td class='center'><c:if test="${task.mct.bzzzik > 0 && (task.multiCastType eq '定时广播' || task.multiCastType eq '终端采播') }">${Integer.valueOf(task.mct.bzzzik/1000)}</c:if><c:if test="${task.mct.bzzzik <= 0}">0</c:if>秒</td>
											<td class='center'>
											<c:if test="${task.curCastLevel == 1}">警告</c:if> 
											<c:if test="${task.curCastLevel == 2}">最高</c:if> 
											<c:if test="${task.curCastLevel == 3}">高</c:if> 
											<c:if test="${task.curCastLevel == 4}">中</c:if> 
											<c:if test="${task.curCastLevel == 5}">低</c:if> 
											<c:if test="${task.curCastLevel == 6}">最低</c:if>
											</td>
											<td class='center'><c:if test="${task.vol != null && task.vol >= 0}">${task.vol}</c:if><c:if test="${task.vol == null || task.vol < 0}">无</c:if></td>
											<td class='center' style="width: auto;"><c:if test="${task.isCast && (task.multiCastType eq '文件广播' || task.multiCastType eq '定时广播' ||task.multiCastType eq '实时采播' ||task.multiCastType eq '终端采播')}"><a type="button"  href="javascript:taskcontroller('${task.taskid}');" title="广播详细控制" style='text-decoration:none;'><i class="layui-icon"  style="color:blue;" >&#xe60b;</i>控制</a></c:if></td>
											<td class='center' style="width: auto;"><a type="button"  href="javascript:lookdomaininfo('${task.taskid}');" title="查看广播分组" style='text-decoration:none;'><i class="layui-icon"  style="color:blue;" >&#xe60b;</i>查看</a></td>
											<td class='center' >
											<c:if test = "${task.multiCastType != '寻呼话筒'}">
												<div class="action-buttons">
													<a class="red" href="javascript:stoptask('${task.taskid}','');">
														<i class="ace-icon fa fa-stop bigger-130" title="停止"></i>
													</a>
												</div>
											</c:if>
											<c:if test = "${task.multiCastType == '寻呼话筒'}">
												<div class="action-buttons">
													<a class="red" href="javascript:stoptask('${task.taskid}','false');">
														<i class="ace-icon fa fa-stop bigger-130" title="删除"></i>
													</a>
												</div>
											</c:if>
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
										</tbody>
									</table>
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

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
		<!--引入弹窗组件end-->
<!--layui-->
	<script src="static/layuiadmin/layui/layui.js" charset="utf-8"></script>
	<!-- inline scripts related to this page -->
	<script type="text/javascript">
	 
	layui.use(['form'], function(){
        var form = layui.form
                ,layer = layui.layer;
    });
	$(function(){
		$(top.hangge());
		});
		function stoptask(taskid,type){
			if(type == 'false'){
				layer.confirm('确定要删除寻呼话筒任务信息吗?(这并不能使寻呼话筒关闭)', {
					  btn: ['确定','取消'] //按钮
					  ,anim: 6 
					  ,icon: 8
					}, function(){
						layer.load();
						var url = "<%=basePath%>taskmanage/stoptask.do?taskid="+taskid;
						$.get(url,function(data){
								layer.closeAll();
							if(data.result=="success"){
								layer.msg('删除成功！',{//
									title: '提示'
									,icon: 1
									,time:1000
									,end: function() {
										location.reload(true);
									}
								});
							}else
								layer.msg('停止任务出错');
						});
					}, function(){
					  layer.msg('已取消');
					}); 
			}else
				layer.confirm('确定要停止广播任务吗?', {
					  btn: ['确定','取消'] //按钮
					  ,anim: 6 
					  ,icon: 3
					}, function(){
						layer.load();
						var url = "<%=basePath%>taskmanage/stopTask.do?taskid="+taskid;
						$.get(url,function(data){
							layer.closeAll();
							if(data.result=="success"){
								layer.msg('停止任务成功！', {
					            	icon :1
					            	,time:1000
					          	,end: function(){
					          		location.reload(true);
					          	}});
							}else
								layer.msg('停止任务出错',{icon: 2,time:2000});
						});
					}); 
		}
		function stopalltask(){
			layer.confirm('确定要停止全部广播任务吗?', {
				btn: ['确定','取消'] //按钮
			  ,anim: 6 
			  ,icon: 3
			}, function(){
				layer.load();
				var url = "<%=basePath%>taskmanage/stopAllTask.do";
				$.get(url,function(data){
					layer.closeAll();
					if(data.result=="success")
						layer.msg('停止任务成功！', {
			            	icon :1
			            	,time:1000
			          	,end: function(){
			          		location.reload(true);
			          	}});
					else
						layer.msg('停止任务出错',{icon: 2,time:2000});
				});
			});
		}
		function lookdomaininfo(taskid){
			layer.open({
			    type: 2,
			    title: '查看广播任务"'+taskid+'"广播分组',
			    maxmin: true, 
			    btn: ['确定'],
			    btnAlign: 'c',
			    moveOut: true,
			    area: ['300px', '480px'],
			    anim: 1,
			    content: "taskmanage/domids.do?taskid="+taskid,
			    yes: function(index, layero){
			        //按钮【按钮一】的回调
			        layer.close(index);
			      },
			    success: function(layero, index) {
	                //获取当前弹出窗口的索引及初始大小
	                 layerIndex      = index;
	                layerInitWidth  = $("#layui-layer"+layerIndex).width();
	                layerInitHeight = $("#layui-layer"+layerIndex).height();
	                resizeLayer(layerIndex,layerInitWidth,layerInitHeight);
	            }
			  });
		}
		function taskcontroller(taskid){
			var index = layer.open({
			    type: 2,
			    title: '广播任务"'+taskid,
			    maxmin: true, 
			    btn: ['确定'],
			    btnAlign: 'c',
			    moveOut: true,
		        area: ['800px', '600px'],
			    anim: 2,
			    content: "taskmanage/taskcontroller.do?taskid="+taskid,
			   /*  yes: function(index, layero){
			        //按钮【按钮一】的回调
			        layer.close(index);
			      }, */
			  });
		}
		function resizeLayer(layerIndex,layerInitWidth,layerInitHeight) {
		    var docWidth = $(document).width();
		    var docHeight = $(document).height();
		    var minWidth = layerInitWidth > docWidth ? docWidth : layerInitWidth;
		    var minHeight = layerInitHeight > docHeight ? docHeight : layerInitHeight;
		    if(docWidth < 900 || docHeight < 720)
		    layer.style(layerIndex, {
		        top:0,
		        width: minWidth,
		        height:minHeight-20
		    });
		}
	</script>
</body>
</html>