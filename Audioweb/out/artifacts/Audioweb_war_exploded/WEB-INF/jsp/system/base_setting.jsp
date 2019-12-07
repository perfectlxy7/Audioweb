<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="ft"%>
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
<script type="text/javascript" src="static/js/jquery.min.js"></script>
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
						<div class="layui-col-md9 layui-row">
							<form class="layui-form" lay-filter="group" name="group">
								        <div class="layui-card">
								          <div class="layui-card-header">权限信息</div>
								          <div class="layui-card-body">
									          <div class="layui-card-body layui-row layui-col-space10">
										          <div class="layui-form-item ">
										         	 	<div class="layui-col-md4">
											         		<label class="layui-form-label" style="width: 200px;">终端点播优先级:</label>
											          	</div>
											            <div class="layui-col-md8">
											            	<div id="terunicast">
											              <select class="form-control" id="terunicast" name="terunicast" lay-filter="onchange">
															<option value="2" <c:if test="${pd.terunicast=='2'}">selected</c:if>>最高</option>
															<option value="3" <c:if test="${pd.terunicast=='3'}">selected</c:if>>高</option>
															<option value="4" <c:if test="${pd.terunicast=='4'}">selected</c:if>>中</option>
															<option value="5" <c:if test="${pd.terunicast=='5'}">selected</c:if>>低</option>
															<option value="6" <c:if test="${pd.terunicast=='6'}">selected</c:if>>最低</option>
														  </select>
														  </div>
											            </div>
										          </div>
										          <div class="layui-form-item ">
										         	 	<div class="layui-col-md4">
										         			<label class="layui-form-label" style="width: 200px;">终端采播优先级:</label>
													  </div>
											            <div class="layui-col-md8">
											            	<div id="tergathercast">
											              	<select class="form-control" id="tergathercast" name="tergathercast" lay-filter="onchange">
																<option value="2" <c:if test="${pd.tergathercast=='2'}">selected</c:if>>最高</option>
																<option value="3" <c:if test="${pd.tergathercast=='3'}">selected</c:if>>高</option>
																<option value="4" <c:if test="${pd.tergathercast=='4'}">selected</c:if>>中</option>
																<option value="5" <c:if test="${pd.tergathercast=='5'}">selected</c:if>>低</option>
																<option value="6" <c:if test="${pd.tergathercast=='6'}">selected</c:if>>最低</option>
														  	</select>
														  	</div>
														  </div>
										          </div>
										          <div class="layui-form-item ">
										         	 	<div class="layui-col-md4">
											         		<label class="layui-form-label" style="width: 200px;">寻呼话筒优先级:</label>
											          	</div>
											            <div class="layui-col-md8">
											            	<div id="pagphone">
											              <select class="form-control" id="pagphone" name="pagphone" lay-filter="onchange">
															<option value="2" <c:if test="${pd.pagphone=='2'}">selected</c:if>>最高</option>
															<option value="3" <c:if test="${pd.pagphone=='3'}">selected</c:if>>高</option>
															<option value="4" <c:if test="${pd.pagphone=='4'}">selected</c:if>>中</option>
															<option value="5" <c:if test="${pd.pagphone=='5'}">selected</c:if>>低</option>
															<option value="6" <c:if test="${pd.pagphone=='6'}">selected</c:if>>最低</option>
														  </select>
													  </div>
													  </div>
										          </div>
										          <div class="layui-form-item ">
										         	 	<div class="layui-col-md4">
											         		<label class="layui-form-label" style="width: 200px;">实时采播模式:</label>
											          	</div>
											            <div class="layui-col-md8">
											              	<div  id= "realcasttype" name="typename">
														      	<input type="radio"  lay-filter="typeset"  name="realcasttype" id="realcasttype" value="10" title="本地模式"<c:if test="${pd.realcasttype == 10}"> checked </c:if>>
															    <input type="radio"  lay-filter="typeset"  name="realcasttype" id="realcasttype" value="-1" title="急速模式"<c:if test="${pd.realcasttype == -1}"> checked </c:if>>
															    <input type="radio"  lay-filter="typeset"  name="realcasttype" id="realcasttype" value="0" title="低延时模式"<c:if test="${pd.realcasttype == 0}"> checked </c:if>>
															    <input type="radio"  lay-filter="typeset"  name="realcasttype" id="realcasttype" value="1" title="稳定模式"<c:if test="${pd.realcasttype == 1}"> checked </c:if>>
															</div>
														</div>
										          </div>
									          </div>
								          </div>
								        </div>
								        <div class="layui-card">
								          <div class="layui-card-header">系统信息</div>
								          <div class="layui-card-body">
									          <div class="layui-card-body layui-row layui-col-space10">
										          <div class="layui-form-item ">
										         	 	<div class="layui-col-md4">
											         		<label class="layui-form-label" style="width: 200px;">系统名称:</label>
											          	</div>
											            <div class="layui-col-md8">
											              <input type="text" name="systemname" placeholder="请输入系统名称" autocomplete="off" class="layui-input" id="systemname" value="${pd.systemname }" onchange="save(this.id,this.value)">
											            </div>
										          </div>
										          <div class="layui-form-item ">
										         	 	<div class="layui-col-md4">
											         		<label class="layui-form-label" style="width: 200px;">系统所有者:</label>
											          	</div>
											            <div class="layui-col-md8">
											              <input type="text" name="owner" placeholder="请输入系统所有者名称" autocomplete="off" class="layui-input" id="owner" value="${pd.owner }" onchange="save(this.id,this.value)">
											            </div>
										          </div>
										          <div class="layui-form-item ">
										         	 	<div class="layui-col-md4">
											         		<label class="layui-form-label" style="width: 200px;">文件广播目录:</label>
											          	</div>
											            <div class="layui-col-md8">
											              <input type="text" name="filecastpath" placeholder="请输入文件广播目录 "autocomplete="off" class="layui-input" id="filecastpath" value="${pd.filecastpath }" onchange="save(this.id,this.value)">
											            </div>
										          </div>
										          <div class="layui-form-item ">
										         	 	<div class="layui-col-md4">
											         		<label class="layui-form-label" style="width: 200px;">终端点播目录:</label>
											          	</div>
											            <div class="layui-col-md8">
											              <input type="text" name="tercastpath" placeholder="请输入终端点播目录" autocomplete="off" class="layui-input" id="tercastpath" value="${pd.tercastpath }" onchange="save(this.id,this.value)">
											            </div>
										          </div>
										           <div class="layui-form-item ">
										           <div class="layui-col-md4">
											         		<label class="layui-form-label" style="width: 200px;">终端检查程序:</label>
											          	</div>
										           <div class="layui-col-md4">
										          		 <label class="layui-form-label" style="width: 200px;">
										           			<c:if test="${pd.jobStatus == '' ||pd.jobStatus == null}"><i style="color:red;">未成功创建，请删除新建</i></c:if> 
															<c:if test="${pd.jobStatus == 'NONE'}">未知</c:if> 
															<c:if test="${pd.jobStatus == 'NORMAL'}">正在运行</c:if> 
											          	</label>
											        </div>
										          <div class="layui-col-md4">
														<button title="重置终端检测" type="button"class="layui-btn layui-btn-normal layui-btn-danger demo-active" data-type="reset">重置
														</button>
													</div>
												</div>
										           <!-- <div class="layui-form-item ">
										           <div class="layui-col-md4">
											         		<label class="layui-form-label" style="width: 200px;">侧边栏页面刷新设置:</label>
											          	</div>
										          <div class="layui-col-md8">
										          		<button type="button" class="layui-btn  layui-btn-normal demo-active" data-type="menuRights">设置</button> 
													</div>
												</div> -->
									          </div>
								          </div>
								        </div>
								        <c:if test="${pd.userid == '1'}">
								        <div class="layui-card">
								          <div class="layui-card-header">系统关键信息配置</div>
								          <div class="layui-card-body">
									          <div class="layui-card-body layui-row layui-col-space10">
									          <div class="layui-form-item ">
										           <div class="layui-col-md4">
											         		<label class="layui-form-label" style="width: 200px;">终端定时重启程序:</label>
											          	</div>
										           <div class="layui-col-md4">
										          		 <label class="layui-form-label" style="width: 200px;" >
										           			<c:if test="${pd.RebootjobStatus == '' ||pd.RebootjobStatus == null}"><i style="color:red;">无</i></c:if> 
															<c:if test="${pd.RebootjobStatus == 'NONE'}"><i>未知</i></c:if> 
															<c:if test="${pd.RebootjobStatus == 'NORMAL'}"><a type="button"  href="javascript:readReboot();" title="查看任务信息" style='text-decoration:none;'>
															<i class="layui-icon"  style="color:blue;" >&#xe60b;</i>正在运行</a></c:if> 
											          	</label>
											        </div>
											        <c:if test="${pd.RebootjobStatus == '' || pd.RebootjobStatus == null}">
											          	<div class="layui-col-md4">
															<button title="新建" type="button"class="layui-btn layui-btn-normal demo-active" data-type="addReboot">新建
															</button>
														</div>
													</c:if> 
													 <c:if test="${pd.RebootjobStatus != '' && pd.RebootjobStatus != null}">
											          	<div class="layui-col-md2">
															<button title="修改" type="button"class="layui-btn layui-btn-normal demo-active" data-type="editReboot">修改
															</button>
														</div>
														<div class="layui-col-md2">
															<button title="删除" type="button"class="layui-btn layui-btn-normal layui-btn-danger demo-active" data-type="deleteReboot">删除
															</button>
														</div>
													</c:if> 
												</div>
										          <%-- <div class="layui-form-item ">
										         	 	<div class="layui-col-md4">
											         		<label class="layui-form-label" style="width: 200px;">服务器IP:</label>
											          	</div>
											            <div class="layui-col-md8">
											              <input type="text" name="serverIp" placeholder="请输入系服务器IP" autocomplete="off" class="layui-input" id="serverIp" value="${pd.serverIp }" onchange="important(this.id,this.value)">
											            </div>
										          </div>
										          <div class="layui-form-item ">
										         	 	<div class="layui-col-md4">
											         		<label class="layui-form-label" style="width: 200px;">网关:</label>
											          	</div>
											            <div class="layui-col-md8">
											              <input type="text" name="gateway" placeholder="请输入系统所有者名称" autocomplete="off" class="layui-input" id="gateway" value="${pd.gateway }" onchange="important(this.id,this.value)">
											            </div>
										          </div>
										          <div class="layui-form-item ">
										         	 	<div class="layui-col-md4">
											         		<label class="layui-form-label" style="width: 200px;">子网掩码:</label>
											          	</div>
											            <div class="layui-col-md8">
											              <input type="text" name="netmask" placeholder="请输入子网掩码 "autocomplete="off" class="layui-input" id="netmask" value="${pd.netmask }" onchange="important(this.id,this.value)">
											            </div>
										          </div>
												<div class="layui-form-item ">
										           <div class="layui-col-md4">
											         		<label class="layui-form-label" style="width: 200px;">更新在线终端配置:</label>
											          	</div>
										          <div class="layui-col-md8">
														<button title="更新" name="updata"  type="button"class="layui-btn layui-btn-normal layui-btn-danger demo-active" id="updata" data-type="updata">更新
														</button>
													</div>
												</div> --%>
									          </div>
								          </div>
								        </div>
								   </c:if>
							</form>
						</div>
						    </div>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
		<!-- /.main-content -->
	<!-- /.main-container -->
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	<!--layui-->
	<script src="static/layuiadmin/layui/layui.js" charset="utf-8"></script>
</body>
<script type="text/javascript">
	$(function(){
		top.hangge();
		});
	layui.use(['form','layer'], function(){
		var $ = layui.$;
        var form = layui.form
       		,layer = layui.layer
            ,layedit = layui.layedit;
	        var element = layui.element;
		    form.render(null, 'group');
		    form.on('select(onchange)', function(data){/* 
		    	console.log(data.elem.id); //得到select原始DOM对象
		    	console.log(data.value); //得到被选中的值
		    	console.log(data.othis); //得到美化后的DOM对象 */
		    	upload(data.elem.id,data.value);
		    });
		    form.on('radio(typeset)', function(data){//获取类型
		    	upload(data.elem.id,data.value);
		    });
		    var active = {
		    	      reset: function(){
		    	        var resume = true;
	    	    	  	$.post("<%=basePath%>system/reset.do",{resume:resume},function(data){
	    					if(data.result=="success"){
	    						layer.msg('重置终端检测成功！');
	    						return true;
	    					}else{
	    						layer.msg('重置失败！请刷新页面重试！');
	    						return false;
	    					}
	    				});
		    	      },
		    	      deleteReboot: function(){
		    	    	  layer.confirm("确定删除终端定时重启任务么？", {
							  btn: ['确定','取消'] //按钮
						   	 ,icon: 3
							},  function(){
								$.post("<%=basePath%>system/delete.do",{},function(data){
			    					if(data.result=="success"){
			    						layer.msg('删除成功！',{//
											title: '提示'
											,icon: 1
											,time:1000
											,end: function() {
												location.reload(true);
											}
										});
			    						return true;
			    					}else{
			    						layer.msg('删除失败！请刷新页面重试！');
			    						return false;
			    					}
			    				});
							});
			    	      },
		    	      updata: function(){
		    	    	  var msg = "确定要更新同步全部在线终端的配置么？请确认在没有任务的状态下才使用";
		    	    	  updata(false,msg);
			    		},
			    	addReboot: function(){
			    		layer.open({
			    			    type: 2,
			    			    title: '新增终端重启任务',
			    			    maxmin: true,
			    			    btn: ['确定','取消'],
			    			    btnAlign: 'c',
			    			    area: ['800px', '500px'],
			    			    anim: 2,
			    			    content: "system/toAdd.do?",
			    			    yes: function(index, layero){
			    			    	var body = layer.getChildFrame('body', index);
			    		            var iframeWin = window[layero.find('iframe')[0]['name']];//得到iframe页的窗口对象，执行iframe页的方法：
			    		            var ids = iframeWin.goback();//调用子页面的方法，得到子页面返回的ids
			    		            if (!ids) {
			    		            	layer.msg("提交失败，请检查输入是否正确",{icon: 2,time:1000});
			    				      }else{
			    				    	  layer.load();
				    		            $.post("<%=basePath%>system/add.do",ids,function(data){
				    		            	layer.closeAll();
				        					if(data.result=="success"){
				        						layer.msg('新增成功！',{//
													title: '提示'
													,icon: 1
													,time:1000
													,end: function() {
														location.reload(true);
													}
												});
				        						return true;
				        					}else{
				        						layer.msg('新增失败！请刷新页面重试！');
				        						return false;
				        					}
				        				});
				    			        //按钮【按钮一】的回调
				    			        layer.close(index);
			    				      }
			    			      }
			    			  });
		    			 //layer.iframeAuto(index)
			    		},
			    		editReboot: function(){
				    		layer.open({
				    			    type: 2,
				    			    title: '修改终端重启任务',
				    			    maxmin: true,
				    			    btn: ['确定','取消'],
				    			    btnAlign: 'c',
				    			    area: ['800px', '500px'],
				    			    anim: 2,
				    			    content: "system/toEdit.do?",
				    			    yes: function(index, layero){
				    			    	var body = layer.getChildFrame('body', index);
				    		            var iframeWin = window[layero.find('iframe')[0]['name']];//得到iframe页的窗口对象，执行iframe页的方法：
				    		            var ids = iframeWin.goback();//调用子页面的方法，得到子页面返回的ids
				    		            if (!ids) {
				    		            	layer.msg("提交失败，请检查输入是否正确",{icon: 2,time:1000});
				    				      }else{
				    				    	  layer.load();
					    		            $.post("<%=basePath%>system/edit.do",ids,function(data){
					    		            	layer.closeAll();
					        					if(data.result=="success"){
					        						layer.msg('修改成功！',{//
														title: '提示'
														,icon: 1
														,time:1000
														,end: function() {
															location.reload(true);
														}
													});
					        						return true;
					        					}else{
					        						layer.msg('修改失败！请刷新页面重试！');
					        						return false;
					        					}
					        				});
					    			        //按钮【按钮一】的回调
					    			        layer.close(index);
				    				      }
				    			      }
				    			  });
			    			 //layer.iframeAuto(index)
				    		},
		    		menuRights: function(){
		    			layer.open({
		    			    type: 2,
		    			    title: '选择需要刷新的目录',
		    			    maxmin: true,
		    			    btn: ['确定','取消'],
		    			    btnAlign: 'c',
		    			    area: ['300px', '480px'],
		    			    anim: 1,
		    			    content: "system/toaccredit.do?rid="+RoleId,
		    			    yes: function(index, layero){
		    			    	var body = layer.getChildFrame('body', index);
		    		            var iframeWin = window[layero.find('iframe')[0]['name']];//得到iframe页的窗口对象，执行iframe页的方法：
		    		            var ids = iframeWin.save();//调用子页面的方法，得到子页面返回的ids
		    		           // console.log(ids);
		    		            $.post("<%=basePath%>system/accredit.do",{RoleId:RoleId,menuIds:ids},function(data){
		        					if(data.result=="success"){
		        						layer.msg('更新成功！下次登录生效');
		        						return true;
		        					}else{
		        						layer.msg('授权失败！请刷新页面重试！');
		        						return false;
		        					}
		        				});
		    			        //按钮【按钮一】的回调
		    			        layer.close(index);
		    			      }
		    			  });
		    	      }
		    };
		    $('.demo-active').on('click', function () {
	            var type = $(this).data('type');
	            active[type] ? active[type].call(this) : '';
	        });
    });
	//保存
	function save(id,value) {
		if (value == "") {
			layer.tips('请输入正确的数据', '#'+id,{
		          tips: [2,'#FFB800'],
					time:1000
	        });
			return false;
		}
		upload(id,value);
	}
	function upload(id,value){
		$.post("system/saveEdit.do", {content:value,name:id}, function(data) {
			if ("success" == data.result) {
				layer.tips('保存成功!', '#'+id,{
			          tips: [2,'#3595CC'],
						time:1000
		        });
			}else if("error" == data.result){
				layer.tips('保存失败!请检查是否输入正确', '#'+id,{
			          tips: [2,'#FFB800'],
						time:1000
		        });
			}else if("isnodir" == data.result){
				var layrconid = layer.confirm("无此路径!是否创建此路径？", {
					  btn: ['确定','取消'] //按钮
				   	 ,icon: 3
					},  function() {
						layer.load();
						$.post("system/saveEdit.do", {content:value,name:id,istrue:'is'}, function(data) {
							layer.closeAll();
							if ("creatdir" == data.result || "success" == data.result ) {
								layer.tips('保存成功!', '#'+id,{
							          tips: [2,'#3595CC'],
										time:1000
						        });
							}else{
								layer.tips('保存失败!请检查是否输入正确', '#'+id,{
							          tips: [2,'#FFB800'],
										time:1000
						        });
							}
						});
				},function(){
					layer.tips('无此路径!创建失败', '#'+id,{
				          tips: [2,'#FFB800'],
							time:1000
			        });
				});
			}
		});
	}
	//保存
	/* function important(id,value) {
		layer.confirm("确定要修改此项数据吗?修改后可能导致终端与服务器通信故障", {
			  btn: ['确定','取消'] //按钮
			  ,anim: 6 
			  ,icon: 8
			}, function() {
				layer.closeAll();
				save(id,value);
			},function(){
				layer.tips('已取消', '#'+id,{
			          tips: [2,'#3595CC'],
						time:1000
		        });
			});
	} */
	<%-- function updata(is,msg){
		 layer.confirm(msg, {
			  btn: ['确定','取消'] //按钮
			  ,anim: 6 
			  ,icon: 8
			}, function() {
				if(is){
					layer.load();
					$.post("<%=basePath%>system/updata.do",{resume:is},function(data){
						layer.closeAll();
    					if(data.result=="success"){
    						layer.msg('更新成功！');
    						return true;
    					}else{
    						layer.msg('更新失败！请刷新页面重试！');
    						return false;
    					}
    				});
				}else{
					layer.closeAll();
					msg = "请再确认一次是否修改同步全部在线终端的配置信息？此功能为终端配置管理,请不要在日常使用中启用";
					is = true;
					updata(is,msg);
				}
			},function(){
				layer.tips('已取消', '#updata',{
			          tips: [2,'#3595CC'],
						time:1000
		        });
			});
	}  --%>
	function readReboot(){
		layer.open({
		    type: 2,
		    title: '查看终端重启任务',
		    maxmin: true,
		    btn: ['确定'],
		    btnAlign: 'c',
		    area: ['800px', '500px'],
		    anim: 2,
		    content: "system/toRead.do?",
		    yes: function(index, layero){
			        //按钮【按钮一】的回调
			        layer.close(index);
		      }
		  });
	}
</script>
</html>