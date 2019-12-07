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
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- layui -->
 <link rel="stylesheet" href="static/layuiadmin/layui/css/layui.css">
 
	<script type="text/javascript" >
	</script>
<script type="text/javascript" src="static/js/jquery.min.js"></script>
	 <!-- <script type="text/javascript" src="static/laydate/laydate.js"></script> -->
	  <!-- <script type="text/javascript" src="static/layer/layer.js"></script> -->
	  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
									方案列表
								</small>																					
								
									</h1>
							
							
                    </div>
							<div class="layui-form-item">
									<div class="layui-inline">
									<span class="input-icon">
										<input class="nav-search-input" autocomplete="off" id="namekey" type="text" style="vertical-align:top;width: 160px; height: 38px" name="namekey" value="${pd.namekey}" placeholder="输入方案名称" />
										<i class="ace-icon fa fa-search nav-search-icon"></i>
									</span>
								</div>
								<div class="layui-inline"> 
									<button class="layui-btn layui-btn-primary" onclick="tosearch();"  title="检索">
										<i class="layui-icon">&#xe615;</i>  
										</button>
								</div>
								<div class="layui-inline"> 
										<button class="layui-btn  layui-btn-radius layui-btn-normal" onclick="addSche();"  title="添加"><i class="layui-icon">&#xe654;</i>添加</button>
								</div>	
								<div class="layui-inline"> 
									<button class="layui-btn  layui-btn layui-btn-radius" id="file" name="file"  title="导入方案"><i class="layui-icon">&#xe67c;</i>导入方案</button>
								</div>	
							</div>
				<div class="row">
						<div class="col-xs-12">
					<form action="timedcast/listSchedules.do?" method="post" name="Form" id="Form">
							<input type="hidden" id="namekey" name="namekey" value="${pd.namekey}" />
							   <table id="simple-table"  class="layui-table" style="margin-top:5px;">
								<thead>
								  <tr>
									<!-- <th class="center" style="width:30px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th> -->
									<th class="center" style="width:80px;">序号</th>
									<th class="center">方案名称</th>
									<th class="center">方案优先级</th>
									<th class="center">方案状态</th>
									<th class="center">方案包含任务数</th>
									<th class="center">备注</th>
									<th class="center">操作</th>
									</tr>
								</thead>

								<tbody>
								<c:choose>
									<c:when test="${not empty schelist}">
									<c:forEach items="${schelist}" var="sche" varStatus="vs">
										<tr ondblclick= "javascript:editSche('${sche.scheId}','${sche.scheName }',${sche.priority});">
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>${sche.scheName}</td>
											<td style="width: 200px;">
												<select class="form-control" id="priority" name="priority" onchange="rolecontroller('${sche.scheId}','${sche.scheName}',this.options[this.options.selectedIndex].value)">
													<option value="2" <c:if test="${sche.priority=='2'}">selected</c:if>>最高</option>
													<option value="3" <c:if test="${sche.priority=='3'}">selected</c:if>>高</option>
													<option value="4" <c:if test="${sche.priority=='4'}">selected</c:if>>中</option>
													<option value="5" <c:if test="${sche.priority=='5'}">selected</c:if>>低</option>
													<option value="6" <c:if test="${sche.priority=='6'}">selected</c:if>>最低</option>
												  </select>
											</td>
											<td class='center' style="width: auto;">
													<label id="isuse">
														<input name="switch-field-1"  onclick="setenable('${sche.scheId}','${sche.scheName}',this)" type="checkbox"  class="ace ace-switch ace-switch-3" <c:if test="${sche.isExecSchd }">checked="checked"</c:if>>
														<span class="lbl"></span>
												</label>
											</td>
											<td class='center'>${sche.taskNum == null || sche.taskNum == ""?'无': sche.taskNum}</td>
											<td class='center'>${sche.description}</td>
											<td class='center' style="width: auto;">
											<div class="hidden-sm hidden-xs action-buttons">
												<a class="green" href="javascript:editSche('${sche.scheId}','${sche.scheName }',${sche.priority});">
													<i class="ace-icon fa fa-pencil-square-o bigger-130" title="修改"></i>
												</a>
												<a class="red" href="javascript:delSche('${sche.scheId }','${sche.scheName }','${sche.isExecSchd}');">
													<i class="ace-icon fa fa-trash-o bigger-130" title="删除"></i>
												</a>
												<a class="blue" href="javascript:toExcel('${sche.scheId }','${sche.scheName}');">
													<i class="ace-icon fa  fa-cloud-download bigger-130" title="方案导出"></i>
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
														<li><a href="javascript:editSche('${sche.scheId}','${sche.scheName }',${sche.priority});" class="tooltip-success" data-rel="tooltip" title="Edit">
															<span class="green">
																<i class="ace-icon fa fa-pencil-square-o bigger-120" title="修改"></i>
															</span>
														</a></li>
														<li><a href="javascript:delSche('${sche.scheId }','${sche.scheName }','${sche.isExecSchd}');" class="tooltip-success" data-rel="tooltip" title="delSche">
															<span class="red"> 
																<i class="ace-icon fa fa-trash-o bigger-120"  title="删除"></i>
															</span>
														</a></li>
														<li><a href="javascript:toExcel('${sche.scheId }','${sche.scheName }');" class="tooltip-success" data-rel="tooltip" title="toExcel">
															<span class="blue"> 
																<i class="ace-icon fa  fa-cloud-download bigger-120"  title="方案导出"></i>
															</span>
														</a></li>
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
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script> 
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
		
<!--layui-->
	 <script src="static/layuiadmin/layui/layui.js" charset="utf-8"></script>
	
	
	<script type="text/javascript">
	$(top.hangge());//关闭加载状态
	layui.use(['form','layer','upload'], function(){
        var form = layui.form
       		layer = layui.layer
        	,upload = layui.upload;
        var uploadInst = upload.render({
		    elem: '#file' //绑定元素
		    ,url: '<%=basePath%>timedcast/addScheExcel.do'
		    ,accept: 'file'
		    , field: "file"     //添加这个属性与后台名称保存一致
	    	,before: function(obj){
                 layer.load();
            }
		    ,done: function(res, index, upload){
		    	if(res.result == "success" && res.code == 0){ //上传成功
		    		layer.closeAll();
		    		layer.msg('导入成功！',{//
							title: '提示'
							,icon: 1
							,time:1000
							,end: function() {
								location.reload(true);
							}
					});
		        }else{
		        	layer.closeAll();
		    		layer.msg('导入失败！',{//
							title: '警告'
							,icon: 2
							,time:1000
							,end: function() {
								location.reload(true);
							}
					});
		        }
		    }
		  	,error: function(){
		  		//location.reload(true);
		    }
		  });
    });
	//检索
	function tosearch(){
		 if (document.getElementById("namekey").value != "")  {
			 var namekey = document.getElementById("namekey").value;
		 }else{
			 var namekey = ""; 
		 }
		layer.load();
		window.location.href="<%=basePath%>timedcast/listSchedules.do?namekey="+namekey;
	}
	//删除
function delSche(ScheId,msg,isExecSchd){
layer.confirm("确定要删除["+msg+"]吗?删除此方案则此方案下所有任务全部删除", {
	  btn: ['确定','取消'] //按钮
   	 ,anim: 6
   	 ,icon: 3
	},  function() {
        layer.load();
		var url = "<%=basePath%>timedcast/deleteSchedule.do?ScheId="+ScheId;
		$.get(url,function(data){
			if(data.result == "success"){
				layer.closeAll();
				layer.msg('删除成功！',{//
					title: '提示'
					,icon: 1
					,time:1000
					,end: function() {
						location.reload(true);
					}
				});
			}else{
				layer.closeAll();
	    		layer.msg('删除失败！',{//
						title: '警告'
						,icon: 2
						,time:1000
						,end: function() {
							location.reload(true);
						}
				});
			}
		});
});
}

//修改
function editSche(ScheId,ScheName,Priority){
layer.open({
    type: 2,
    title: '修改方案',
    maxmin: true,
    anim: 2,
    area: ['800px', '500px'],
    content: "timedcast/editSchedule.do?ScheId="+ScheId+"&ScheName="+ScheName+"&Priority="+Priority,
    end: function(){
    }
  });
}
//添加
function addSche(){
layer.open({
    type: 2,
    title: '添加方案',
    maxmin: true,
    area: ['800px', '500px'],
    anim: 2,
    content: "timedcast/addSchedule.do",
    end: function(){
    }
  });
 
}
//处理按钮点击,修改方案启用
function setenable(ScheId,ScheName,button){
	//询问框
	console.log(button.checked);
	var text;
	if(button.checked){
		text = '是否启用此方案？';
	}else{
		text = '是否禁用此方案？';
	}
	layer.confirm(text, {
		  btn: ['确定','取消'] //按钮
		  ,anim: 6
		  ,icon: 3
		}, function(){
			layer.load();
			$.ajax({
				type: "POST",
				url: "<%=basePath%>timedcast/upEnable.do?ScheId="+ScheId+"&checked="+button.checked,
				dataType:'json',
				success: function(data){
					layer.closeAll();
					if(data.result=="success"){
						layer.msg('修改成功！',{//
							title: '提示'
							,icon: 1
							,time:1000
						});
					}else{
						layer.msg('修改失败！',{//
							title: '警告'
							,icon: 1
							,time:1000
							,end: function() {
								location.reload(true);
							}
						});
					}
				}
			});
		}, function(){
			location.reload(true);
		});
}
//处理下拉栏,优先级设置
	function rolecontroller(ScheId,ScheName,Priority){
		$.post("<%=basePath%>timedcast/editSche.do",{ScheId:ScheId,ScheName:ScheName,Priority:Priority},function(data){
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
	//导出excel
	function toExcel(ScheId,ScheName){
			layer.confirm("是否导出此方案?", {
				  btn: ['确定','取消'] //按钮
		  	  ,icon: 3
			} ,function() {
				layer.msg('正在下载');
				window.location.href='<%=basePath%>timedcast/excel.do?ScheId='+ScheId+'&ScheName='+ScheName;
			});
	}
	function success(){
		layer.msg('保存成功！',{//
			title: '提示'
			,icon: 1
			,time:1000
			,end: function() {
				location.reload(true);
			}
		});
	}
	</script>
</body>
</html>