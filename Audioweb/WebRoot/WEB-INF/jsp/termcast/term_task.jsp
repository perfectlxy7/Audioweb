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
 
	<script type="text/javascript" >
	</script>
<script type="text/javascript" src="static/js/jquery.min.js"></script>
	 <!-- <script type="text/javascript" src="static/laydate/laydate.js"></script> -->
	  <!-- <script type="text/javascript" src="static/layer/layer.js"></script> -->
</head>

<body class="no-skin">
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
									终端采播&nbsp;任务列表
								</small>
							</h1>
							
                    </div>
							<div class="layui-form-item">
									<div class="layui-inline">
									<span class="input-icon">
										<input class="nav-search-input" autocomplete="off" id="namekey" type="text" style="vertical-align:top;width: 160px; height: 38px" name="namekey" value="${pd.namekey}" placeholder="输入任务名称或编号" />
										<i class="ace-icon fa fa-search nav-search-icon"></i>
									</span>
								</div>
								<div class="layui-inline"> 
									<button class="layui-btn layui-btn-primary" onclick="tosearch();"  title="检索">
										<i class="layui-icon">&#xe615;</i>  
										</button>
								</div>
							   <div class="layui-inline"> 
							   	<button title="批量删除" class="layui-btn  layui-btn-radius layui-btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" >
							   		<i class="layui-icon">&#xe640;</i>批量删除
							   		</button>
							   	</div>								
								<div class="layui-inline"> 
										<button class="layui-btn  layui-btn-radius layui-btn-normal" onclick="addtask();"  title="添加"><i class="layui-icon">&#xe654;</i>添加</button>
								</div>	
								<div class="layui-inline">        
								<c:if test="${pd.namekey != null && pd.namekey != ''}">
									<button class="layui-btn  layui-btn-radius layui-btn-warm" onclick="goback();" title="返回所有任务"><i class="layui-icon">&#xe65c;</i>返回</button>
								</c:if>	  
									<button class="layui-btn  layui-btn-radius" onclick="history.go(0)"  title="刷新">刷新</button>
								</div>	
							</div>
				<div class="row">
						<div class="col-xs-12">
					<form action="termcast/listTermTasks.do?" method="post" name="Form" id="Form">
							<input type="hidden" id="namekey" name="namekey" value="${pd.namekey}" />
							   <table id="simple-table"  class="layui-table" style="margin-top:5px;">
								<thead>
								  <tr>
									<th class="center" style="width:30px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
										<th class="center" >任务编号</th>
										<th class="center" >任务名称</th>
										<th class="center" >任务类型</th>
										<th class="center" >采播终端源</th>
										<th class="center" >采播类型</th>
										<th class="center" >运行状态</th>
										<th class='center'>广播分组</th>	
										<th class="center" >是否启用</th>					
										<th class='center'>下次运行时间</th>	
										<th class='center' >操作</th>
									</tr>
								</thead>

								<tbody>
								<c:choose>
									<c:when test="${not empty taskList}">
									<c:forEach items="${taskList}" var="task" varStatus="vs">
									<tr ondblclick= "javascript:readtask('${task.taskId}');">
										<td class='center' style="width: 30px;">
												<c:if test="${task.taskId != pd.currenTid}"><label><input type='checkbox' name='ids' value="${task.taskName}" id="${task.taskId }"  class="ace"/><span class="lbl"></span></label></c:if>
												<c:if test="${task.taskId  == pd.currentTid}"><label><input type='checkbox' disabled="disabled" class="ace" /><span class="lbl"></span></label></c:if>
											</td>

										<td class='center' style="width: auto;">${task.taskId}</td>
										<td class='center' style="width: auto;">${task.taskName}</td>
										<%-- <c:if test="${String.valueOf(task.weeks.charAt(0)) == '1'}"></c:if> --%>
										<td class='center' style="width: auto;">${String.valueOf(task.weeks.charAt(0)) == '1'?'手动任务':'自动任务'}</td>
										<td class='center' style="width: auto;">${task.TName}${task.isOnline?'在线':'离线'}</td>
										<td align='center' style="width: auto;">
										<c:if test="${task.type == '' ||task.type == null}">无</c:if> 
										<c:if test="${task.type == '1'}">终端</c:if> 
										<c:if test="${task.type == '2'}">终端与线路</c:if> 
										<c:if test="${task.type == '3'}">终端与磁带</c:if> 
										<c:if test="${task.type == '4'}">终端与u盘</c:if> 
										</td>
										<td align='center' style="width: auto;">
										<c:if test="${task.isJuris}">
											<c:if test="${task.jobStatus == '' ||task.jobStatus == null}">未成功创建，请删除新建</c:if> 
											<c:if test="${task.jobStatus == 'NONE'}">未知</c:if> 
											<c:if test="${task.jobStatus == 'NORMAL'}">准备就绪</c:if> 
											<c:if test="${task.jobStatus == 'PAUSED'}">暂停状态</c:if> 
											<c:if test="${task.jobStatus == 'COMPLETE'}"><i style="color:green;">完成状态</i></c:if> 
											<c:if test="${task.jobStatus == 'ERROR'}"><i style="color:red;">错误状态</i></c:if>
											<c:if test="${task.jobStatus == 'BLOCKED'}"><i style="color:yellow;">锁定状态</i></c:if>
											<c:if test="${task.jobStatus == 'RUNNING'}"><i style="color:green;">正在运行</i></c:if>
										</c:if>
										<c:if test="${!task.isJuris}">
											源终端无权限！
										</c:if>
										</td>
										<td class='center' style="width: auto;"><a type="button"  href="javascript:lookdomaininfo('${task.domainsId}','${task.taskName}');" title="查看广播分组" style='text-decoration:none;'><i class="layui-icon"  style="color:blue;" >&#xe60b;</i>查看</a></td>
										<c:if test="${String.valueOf(task.weeks.charAt(0)) == '0'}">
											<td class='center' style="width: auto;">
													<label id="isuse">
														<input name="switch-field-1"  onclick="setenable('${task.taskId}',this)" class="ace ace-switch ace-switch-3" type="checkbox"  <c:if test="${task.status }">checked="checked"</c:if> >
														<span class="lbl"></span>
												</label>
											</td>
											<td align='center' style="width: auto;">
												<c:if test="${task.jobStatus == 'NORMAL'}"><fmt:formatDate value="${task.nextFireTime}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if> 
												<c:if test="${task.jobStatus == 'PAUSED'}">任务暂停中</c:if> 
											</td>
										</c:if>
										<c:if test="${String.valueOf(task.weeks.charAt(0)) == '1'}">
										<td class='center' style="width: auto;"><a type="button"  href="javascript:runjob('${task.taskId}','${task.taskName}');" title="手动执行任务" style='text-decoration:none;'>手动执行任务</a></td>
										<td class='center' style="width: auto;"><a type="button"  href="javascript:runjob('${task.taskId}','${task.taskName}');" title="手动执行任务" style='text-decoration:none;'>手动执行任务</a></td>
										</c:if>
										<td class='center' style="width: auto;">
											<div class="hidden-sm hidden-xs action-buttons">
											<a class="blue" href="javascript:runjob('${task.taskId}','${task.taskName}');">
													<i class="ace-icon fa fa-folder-o bigger-130" title="立即执行"></i>
												</a>
												<a class="green" href="javascript:edittask('${task.taskId}');">
													<i class="ace-icon fa fa-pencil-square-o bigger-130" title="修改"></i>
												</a>
												<a class="red" href="javascript:deltask('${task.taskId}','${task.taskName}');">
													<i class="ace-icon fa fa-trash-o bigger-130" title="删除"></i>
												</a>
											</div> 
											<div class="hidden-md hidden-lg">
												<div class="inline pos-rel">
													<button
														class="btn btn-minier btn-yellow dropdown-toggle"
														data-toggle="dropdown" data-position="auto">
														<i
															class="ace-icon fa fa-caret-down icon-only bigger-120"></i>
													</button>
													<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
												
												<li><a href="javascript:runjob('${task.taskId}','${task.taskName}');" class="tooltip-success" data-rel="tooltip" title="Read">
															<span class="blue">
																<i class="ace-icon fa fa-folder-o bigger-120" title="立即执行"></i>
															</span>
														</a></li>
														<li><a href="javascript:edittask('${task.taskId }');" class="tooltip-success" data-rel="tooltip" title="Edit">
															<span class="green">
																<i class="ace-icon fa fa-pencil-square-o bigger-120" title="修改"></i>
															</span>
														</a></li>
														<li><a href="javascript:deltask('${task.taskId }','${task.taskName}');" class="tooltip-success" data-rel="tooltip" title="Delete">
															<span class="red"> 
																<i class="ace-icon fa fa-trash-o bigger-120"  title="删除"></i>
															</span>
														</a>
														</li>
													</ul>
												</div>
											</div>
										</td>
									</tr>
									</c:forEach>
									</c:when>
										<c:otherwise>
											<tr>
											<td colspan="100" class='center'>没有相关数据,请选择方案或者刷新页面</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
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
						<!-- /.col -->
						</div>
						
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up"
			class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
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
		  var layerIndex;
		  var layerInitWidth;
		  var layerInitHeight;
		 
		
		 $(document).ready(function(){
			top.hangge();
	 		//复选框全选控制
	var active_class = 'active';
	$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
		var th_checked = this.checked;//checkbox inside "TH" table header
		$(this).closest('table').find('tbody > tr').each(function(){
			var row = this;
			if($(row).attr("disabled")!="disabled"){
				if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
				else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
			}
		});
	}); 
	
	
	
});	
		 
		layui.use(['form', 'layer'], function(){
	        var form = layui.form
	                ,layer = layui.layer;
	    });
      //返回
		function goback(){
			window.location.href="<%=basePath%>termcast/listTermTasks.do";
		}
		//检索
		function tosearch(){
		 	 if (document.getElementById("namekey").value != "")  {
				 var namekey = document.getElementById("namekey").value;
			 }else{
				 var namekey = ""; 
			 }
			layer.load();
			window.location.href="<%=basePath%>termcast/listTermTasks.do?namekey="+namekey;
		}
		//新增
		function addtask(){
			layer.load();
			window.location.href="<%=basePath%>termcast/toAdd.do";
		};
			//编辑
		function edittask(TaskId){
			layer.load();
			window.location.href="<%=basePath%>termcast/toEdit.do?TaskId="+TaskId;
		};
			//双击查看
		function readtask(TaskId){
			<%-- layer.load();
			window.location.href="<%=basePath%>timedcast/toRead.do?TaskId="+TaskId+"&ScheId="+ScheId+"&ScheName="+ScheName; --%>
			layer.open({
			    type: 2,
			    title: '查看任务',
			    maxmin: true, 
			    btn: ['确定'],
			    btnAlign: 'c',
			    moveOut: true,
			    area: ['840px', '500px'],
			    anim: 2,
			    content: "termcast/toRead.do?TaskId="+TaskId,
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
			
		};
			//立即执行任务
		function runjob(TaskId,TaskName){
			layer.confirm("确定要立即执行此任务吗(源终端若未登陆或无权限则无法开启)?", {
				btn: ['确定','取消'] //按钮
			  ,icon: 3
			}, function() {
				$.post("<%=basePath%>termcast/runjob.do",{TaskId:TaskId,TaskName:TaskName},function(data){
					if(data.result=="success"){
						layer.msg('执行成功！', {
			            	icon :1
			            	,time:1000
			          	,end: function(){
			          		location.reload(true);
			          	}});
						return true;
					}else{
						layer.msg('执行失败！请检查任务终端是否登录或有权限', {
				            offset: '6px'
				          });
						return false;
					}
				});
			});
		}
		//删除
		function deltask(TaskId,TaskName){
			layer.confirm("确定要删除此任务吗?", {
			  btn: ['确定','取消'] //按钮
			  ,icon: 8
			  ,anim: 6 
			}, function() {
					var url = "<%=basePath%>termcast/delete.do?TaskId="+TaskId+"&TaskName="+TaskName;
					layer.load();
					$.get(url,function(data){
						layer.closeAll();
						if("success" == data.result){
							layer.msg('删除成功！', {
				            	icon :1
				            	,time:1000
				          	,end: function(){
				          		location.reload(true);
				          	}});
						}else if("false" == data.result){
							layer.closeAll();
							layer.msg('删除任务失败!', {
					            offset: '6px'
					          });
						}
					});
			});
		}

		function makeAll(msg){
			layer.confirm(msg, {
				  btn: ['确定','取消'] //按钮
			  ,icon: 8
			  ,anim: 6 
			}, function() {
					var tidstr = '';
					var tnames = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(tidstr=='') tidstr += document.getElementsByName('ids')[i].id;
						  	else tidstr += ',' + document.getElementsByName('ids')[i].id;
						  	if(tnames=='') tnames += document.getElementsByName('ids')[i].value;
						  	else tnames += ',' + document.getElementsByName('ids')[i].value;
						  }
					}
					if(tidstr==''){
						 layer.msg('无法删除，未选择任何任务！',{//
								title: '警告'
								,icon: 2
								,time:1000
								,end: function() {
									layer.tips('点这里全选', '#zcheckbox',{
								          tips: [1,'#3595CC'],
											time:1000
							        });
								}
							});
						/* bootbox.dialog({
							message: "<span class='bigger-110'>您没有选择任何内容!</span>",
							buttons: 			
							{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:3,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						$("#zcheckbox").focus(); */
						return;
					}else{
						layer.load();
						$.ajax({
							type: "POST",
							url: '<%=basePath%>termcast/deleteAllO.do?',
					    	data: {TaskIds:tidstr,TaskName:tnames},
							dataType:'json',
							//beforeSend: validateData,
							cache: false,
							success: function(data){
								layer.closeAll();
								layer.msg('删除成功！',{//
									title: '提示'
									,icon: 1
									,time:1000
									,end: function() {
										location.reload(true);
									}
								});
							}
						});
					}
			});
		}	
		//处理按钮点击,修改方案
		function setenable(TaskId,click){
			var Status = $(click).is(':checked');
			$.post("<%=basePath%>termcast/upTaskEnable.do",{TaskId:TaskId,Status:Status},function(data){
				if(data.result=="success"){
					layer.msg('修改成功！', {
		            	offset: '6px'
		          	});
					return true;
				}else{
					layer.msg('修改失败！请刷新页面重试！', {
		            	offset: '6px'
		          	});
					return false;
				}
			});
		}
		function lookdomaininfo(domainsId,taskName){
			layer.open({
			    type: 2,
			    title: '查看"'+taskName+'"广播分组',
			    maxmin: true, 
			    btn: ['确定'],
			    btnAlign: 'c',
			    moveOut: true,
			    area: ['300px', '480px'],
			    anim: 1,
			    content: "timedcast/finddomids.do?domidInfo="+domainsId+"&statu="+"查看",
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
		function resizeLayer(layerIndex,layerInitWidth,layerInitHeight) {
		    var docWidth = $(document).width();
		    var docHeight = $(document).height();
		    var minWidth = layerInitWidth > docWidth ? docWidth : layerInitWidth;
		    var minHeight = layerInitHeight > docHeight ? docHeight : layerInitHeight;
		    console.log("doc:",docWidth,docHeight);
		    console.log("lay:",layerInitWidth,layerInitHeight);
		    console.log("min:",minWidth,minHeight);
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