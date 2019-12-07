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
	<!-- layui -->
 <link rel="stylesheet" href="static/layuiadmin/layui/css/layui.css">
 

<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
<script type="text/javascript" src="static/js/jquery.min.js"></script>
	 <!-- <script type="text/javascript" src="static/laydate/laydate.js"></script> -->
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
									<c:if test="${MSG=='edit' }">编辑任务</c:if>
									<c:if test="${MSG=='add' }">添加任务</c:if>
									<c:if test="${MSG=='read' }">查看任务</c:if>
								</small>
							</h1>
					</div><!-- /.page-header -->
					<div class="row">
						<div class="col-xs-12">
							

						<form  action="termcast/${MSG}.do" name="taskForm" id="taskForm" method="post" class="layui-form layui-form-pane">
							<input type="hidden" id="tid" name="tid" value="${tid}" />
							<div class="layui-form-item">
								<c:if test="${MSG != 'read'}">
	       							 <div class="layui-inline">
	       							 <c:if test="${MSG =='add' || MSG == 'edit'}">
										<label class="layui-form-label"  style="width: 100px;">任务编号</label>
									 </c:if>
										<div class="layui-input-inline">
											<input type="text" name="TaskId" id="TaskId" value="${pd.TaskId}" readonly="readonly" placeholder="任务编号" class="layui-input"  style="width: 200px;"/>
										</div>
									 </div>
								</c:if>
								 	<div class="layui-inline">
									        <label class="layui-form-label"  style="width: 100px;">任务名称</label>
										<input type="text" name="TaskName" id="TaskName" placeholder="请输入" required="required" <c:if test="${MSG == 'read'}"> readonly="readonly" </c:if> value="${task.taskName}" placeholder="这里输入任务名称" class="layui-input" autocomplete="off"  style="width: 400px;"/>
									</div>
								</div>
							<div class="layui-form-item">
        						<div class="layui-inline">
									<label class="layui-form-label"  style="width: 200px;">源终端编号</label>
									<input type="text" name="TIDString" id="TIDString" placeholder="请输入源终端编号"<c:if test="${tid == null}"> value="${task.TIDString}"  </c:if> <c:if test="${tid != null}"> value="${tid}"  </c:if>required="required" <c:if test="${MSG == 'read'}"> readonly="readonly" </c:if> placeholder="这里输入源终端编号" class="layui-input" autocomplete="off"  style="width: 300px;"/>
						      	</div>
						    <c:if test="${MSG != 'read'}">
							 	<div class="layui-inline">
						       		<button type="button" class="layui-btn  layui-btn-normal demo-active" data-type="Tid">选择</button> 
						       	</div> 
						    </c:if>
						    </div>
						    <div class="layui-form-item">
							 	<div class="layui-inline">
							   		<label class="layui-form-label">任务优先级</label>
							    </div>
							    <div class="layui-inline">
								    <select class="form-control" id="CastLevel" name="CastLevel" style="width:98%;" <c:if test="${MSG == 'read'}"> disabled="disabled" </c:if>>
															<option value="6" <c:if test="${task.castLevel=='6'}">selected</c:if>>最低</option>
															<option value="5" <c:if test="${task.castLevel=='5'}">selected</c:if>>低</option>
															<option value="4" <c:if test="${task.castLevel=='4'}">selected</c:if>>中</option>
															<option value="3" <c:if test="${task.castLevel=='3' || task.castLevel==null}">selected</c:if>>高</option>
															<option value="2" <c:if test="${task.castLevel=='2'}">selected</c:if>>最高</option>
									</select>
								</div>
							 </div>
							<c:if test="${MSG=='add'}">
							<div class="layui-form-item">
						        <label class="layui-form-label"  style="width: 200px;">采集终端属性</label>
									<div class="layui-input-block">
									      <input type="radio"  name="type" id="type" value="1" title="终端" >
									      <input type="radio"  name="type" id="type" value="2" title="终端与线路"  checked >
									      <input type="radio"  name="type" id="type" value="3" title="终端与磁带">
									      <!-- <input type="radio"  name="type" id="type" value="4" title="终端与u盘" > -->
								    </div>
						   </div>
							<div class="layui-form-item">
						        <label class="layui-form-label">任务类型</label>
									<div class="layui-input-block">
									      <input type="radio"  lay-filter="r-sel" name="0" id="0" value="1" title="手动采播任务" checked  >
									      <input type="radio"  lay-filter="r-sel" name="0" id="0" value="0" title="自动采播任务" >
								    </div>
						   </div>
							<div id="week" pane="" style = "display:none;">
							<div class="layui-form-item">
								<div class="layui-inline">
					    			<label class="layui-form-label"  style="width: 200px;">任务是否启用</label>
					            	<input type="checkbox" checked name="Status" id="Status" lay-skin="switch" lay-filter="switchTest" lay-text="是|否">
							     </div>
							</div>
							 <div class="layui-form-item">
							        <label class="layui-form-label">每周安排</label>
							        <div class="layui-input-block">
							            <input type="checkbox"  name="1" id="1" lay-skin="primary" title="周一" checked>
							            <input type="checkbox"  name="2" id="2" lay-skin="primary" title="周二" checked>
							            <input type="checkbox"  name="3" id="3" lay-skin="primary" title="周三" checked>
							            <input type="checkbox"  name="4" id="4" lay-skin="primary" title="周四" checked>
							            <input type="checkbox"  name="5" id="5" lay-skin="primary" title="周五" checked>
							            <input type="checkbox"  name="6" id="6" lay-skin="primary" title="周六" >
							            <input type="checkbox"  name="7" id="7" lay-skin="primary" title="周日" >
							       </div>
						    </div>
						        <div class="layui-form-item">
						          <label class="layui-form-label"   style="width: 200px;">任务广播时间</label>
						         <div class="layui-input-inline">
										<input type="text" class="demo-input"  name="ExecTime" value="${task.execTime}"  placeholder="请选择时间" <c:if test="${MSG != 'read'}">id="ExecTime"</c:if>>
								</div>
       					    		<div class="layui-input-inline">
						            	<label class="layui-form-label" style="width: 200px;">采播持续时间</label>
						            </div>
						            <div class="layui-input-inline"style="width: 100px;">
						                <input type="number"  name="LastingSeconds" id="LastingSeconds" min="1" max="65535" <c:if test="${task.lastingSeconds.length() > 0}"> value="${task.lastingSeconds}" </c:if> autocomplete="off"  class="layui-input" value="300">
						          	</div>
						          	<div class="layui-input-inline" style="width: 10px;">
						          		<label class="layui-form-label">秒</label>
						          	</div>
						       </div>
						    </div>
							<div class="layui-form-item " id="single" style = "display:none;">
		        			</div>
						    </c:if>
						    <c:if test="${MSG=='edit' || MSG== 'read'}">
						    <div class="layui-form-item">
						        <label class="layui-form-label">采集终端属性</label>
									<div class="layui-input-block">
									      <input type="radio"  name="type" id="type" value="1" title="终端" <c:if test="${task.type == '1'}"> checked </c:if><c:if test="${MSG == 'read'}"> disabled="disabled" </c:if>>
									      <input type="radio"  name="type" id="type" value="2" title="终端与线路" <c:if test="${task.type == '2'}"> checked </c:if><c:if test="${MSG == 'read'}"> disabled="disabled" </c:if>>
									      <input type="radio"  name="type" id="type" value="3" title="终端与磁带" <c:if test="${task.type == '3'}"> checked </c:if><c:if test="${MSG == 'read'}"> disabled="disabled" </c:if>>
									      <%-- <input type="radio"  name="type" id="type" value="4" title="终端与u盘" <c:if test="${task.type == '4'}"> checked </c:if><c:if test="${MSG == 'read'}">disabled="disabled"</c:if>>
								    --%> </div>
						   </div>
						    <c:if test="${MSG != 'read'}">
							    <div class="layui-form-item">
							        <label class="layui-form-label">任务类型</label>
										<div class="layui-input-block">
										      <input type="radio"  lay-filter="r-sel"  name="0" id="0" value="1" title="手动采播任务" <c:if test="${String.valueOf(task.weeks.charAt(0)) == '1'}"> checked </c:if>>
										      <input type="radio"  lay-filter="r-sel"  name="0" id="0" value="0" title="自动采播任务" <c:if test="${String.valueOf(task.weeks.charAt(0)) == '0'}"> checked </c:if>>
									    </div>
							   </div>
						   </c:if>
							<div id="week" pane="" <c:if test="${String.valueOf(task.weeks.charAt(0)) == '1'}"> style = "display:none;" </c:if>>
								<div class="layui-form-item">
								<div class="layui-inline">
					    			<label class="layui-form-label"  style="width: 200px;">任务是否启用</label>
					            	<input type="checkbox" <c:if test="${MSG == 'read'}"> disabled </c:if> checked name="Status" id="Status" lay-skin="switch" lay-filter="switchTest" lay-text="是|否">
							     </div>
								</div>
						        <label class="layui-form-label">每周安排</label>
						        <div class="layui-input-block">
						            <input type="checkbox"  name="1" id="1" lay-skin="primary" title="周一" <c:if test="${String.valueOf(task.weeks.charAt(1)) == '1'}">  checked </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
						            <input type="checkbox"  name="2" id="2" lay-skin="primary" title="周二" <c:if test="${String.valueOf(task.weeks.charAt(2)) == '1'}">  checked </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
						            <input type="checkbox"  name="3" id="3" lay-skin="primary" title="周三" <c:if test="${String.valueOf(task.weeks.charAt(3)) == '1'}">  checked </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
						            <input type="checkbox"  name="4" id="4" lay-skin="primary" title="周四" <c:if test="${String.valueOf(task.weeks.charAt(4)) == '1'}">  checked </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
						            <input type="checkbox"  name="5" id="5" lay-skin="primary" title="周五" <c:if test="${String.valueOf(task.weeks.charAt(5)) == '1'}">  checked </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
						            <input type="checkbox"  name="6" id="6" lay-skin="primary" title="周六" <c:if test="${String.valueOf(task.weeks.charAt(6)) == '1'}">  checked </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
						            <input type="checkbox"  name="7" id="7" lay-skin="primary" title="周日" <c:if test="${String.valueOf(task.weeks.charAt(7)) == '1'}">  checked </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
						        </div>
						          <div class="layui-form-item">
						          <label class="layui-form-label"   style="width: 200px;">任务广播时间</label>
						         <div class="layui-input-inline">
										<input type="text" class="demo-input"  name="ExecTime" value="${task.execTime}" <c:if test="${MSG == 'read'}"> readonly="readonly" </c:if> placeholder="请选择时间" <c:if test="${MSG != 'read'}">id="ExecTime"</c:if>>
								</div>
       					    		<div class="layui-input-inline">
						            	<label class="layui-form-label" style="width: 200px;">采播持续时间</label>
						            </div>
						            <div class="layui-input-inline"style="width: 100px;">
						                <input type="number"  name="LastingSeconds" id="LastingSeconds" min="1" max="65535" <c:if test="${task.lastingSeconds.length() > 0 && task.lastingSeconds != '-1'}"> value="${task.lastingSeconds}" </c:if> autocomplete="off" <c:if test="${MSG == 'read'}"> readonly="readonly" </c:if> class="layui-input" value="300">
						          	</div>
						          	<div class="layui-input-inline" style="width: 10px;">
						          		<label class="layui-form-label">秒</label>
						          	</div>
						       </div>
						    </div>
						    <div class="layui-form-item " id="single" <c:if test="${String.valueOf(task.weeks.charAt(0)) == '0'}"> style = "display:none;" </c:if>>
		        			</div>
						    </c:if>
						    
						    <c:if test="${MSG != 'read'}">
							     <div class="layui-form-item" >
	        						<div class="layui-inline">
										<label class="layui-form-label"  style="width: 200px;">选择广播分组</label>
										<input type="text" name="DomainsId" id="DomainsId" placeholder="请输入分组信息" value="${task.domainsId}"  required="required" placeholder="这里输入分组信息" class="layui-input" autocomplete="off"  style="width: 300px;"/>
							      	</div>
								 	<div class="layui-inline">
							       		<button type="button" class="layui-btn  layui-btn-normal demo-active" data-type="domainselect">选择</button> 
							       	</div>
							    </div>
						    </c:if> 
						     <div class="layui-form-item">
						        <div class="layui-inline">
						        	<label class="layui-form-label"  style="width: 200px;">广播音量</label>
						            <div class="layui-input-inline">
						                <input type="number" name="Vols" id="Vols" autocomplete="off" min="1" max="40" <c:if test="${task.vols != null}"> value="${task.vols}" </c:if>  <c:if test="${MSG == 'read'}"> readonly="readonly" </c:if> class="layui-input" value="30">
						          	</div>
						        </div>
						    </div>
						    <div class="layui-form-item layui-form-text">
						        <label class="layui-form-label">任务备注</label>
						        <div class="layui-input-block">
						            <textarea <c:if test="${MSG != 'read'}"> placeholder="请输入内容" </c:if> name="note" id="note" <c:if test="${MSG == 'read'}"> readonly="readonly" </c:if> class="layui-textarea">${task.note}</textarea>
						        </div>
						    </div>
						</form>
						<c:if test="${MSG != 'read'}">
						 <div class="layui-form-item">
						        <div class="layui-input-block" style="margin-top:15px;height: 30px;">
						            <button type="button"   class="layui-btn"   onclick="save();">保存</button>
						            <button type="button" class="layui-btn layui-btn-primary" onclick="goback();">取消</button>
						        </div>
						    </div>
						</c:if>
						</div>
						</div>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		<!-- /.main-content -->


		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up"
			class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- inline scripts related to this page -->
	
<!--layui-->
	<script src="static/layuiadmin/layui/layui.js" charset="utf-8"></script>
	<script type="text/javascript">
		$(top.hangge());
		
	 layui.use(['form', 'layedit', 'laydate'], function(){
        var form = layui.form
                ,layer = layui.layer
                ,layedit = layui.layedit
                ,laydate = layui.laydate;
		//日期选择
		//执行一个laydate实例
		laydate.render({
		  elem: '#ExecTime' //指定元素
			  ,type: 'time'
		});
			form.on('radio(r-sel)', function(data){
			  //console.log(data.value); //被点击的radio的value值
			  if(data.value == "1"){
				  /* console.log(data.elem); //得到radio原始DOM对象
				  var id = document.all.week;
				  console.log(id); //得到radio原始DOM对象 */
				  $("#week").hide();
				  $("#single").show();
			  }else{
				  $("#week").show();
				  $("#single").hide();
			  }
			}); 
		
    }); 
	 layui.use(['element', 'layer'], function () {
	        var $ = layui.jquery;
	        var element = layui.element
	                , layer = layui.layer;

	        var active = {
	        		Tid: function () {
	    	        var domidInfo = $("#TIDString").val();
	                	layer.open({
	        			    type: 2,
	        			    title: '选择源终端',
	        			    maxmin: true,
	        			    btn: ['确定','取消'],
	        			    btnAlign: 'c',
	        			    moveOut: true,
	        			    area: ['300px', '480px'],
	        			    anim: 1,
	        			    content: "termcast/finddomids.do?domidInfo="+domidInfo,
	        			    yes: function(index, layero){
	        			    	var body = layer.getChildFrame('body', index);
	        		            var iframeWin = window[layero.find('iframe')[0]['name']];//得到iframe页的窗口对象，执行iframe页的方法：
	        		            var ids = iframeWin.save();//调用子页面的方法，得到子页面返回的ids
	                			document.taskForm.TIDString.value=ids;
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
	                },
	        domainselect: function(){
	        	var domidInfo = $("#DomainsId").val();
	        	layer.open({
    			    type: 2,
    			    title: '选择广播分组',
    			    maxmin: true,
    			    btn: ['确定','取消'],
    			    btnAlign: 'c',
    			    moveOut: true,
    			    area: ['300px', '480px'],
    			    anim: 1,
    			    content: "timedcast/finddomids.do?domidInfo="+domidInfo,
    			    yes: function(index, layero){
    			    	var body = layer.getChildFrame('body', index);
    		            var iframeWin = window[layero.find('iframe')[0]['name']];//得到iframe页的窗口对象，执行iframe页的方法：
    		            var ids = iframeWin.save();//调用子页面的方法，得到子页面返回的ids
            			document.taskForm.DomainsId.value=ids;
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
	        };
	        $('.demo-active').on('click', function () {
	            var type = $(this).data('type');
	            active[type] ? active[type].call(this) : '';
	        });

	    });
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
	//返回
		function goback(){
			layer.load();
			/*console.info(ScheId); */
			window.location.href="<%=basePath%>termcast/listTermTasks.do";
		}
		
		//保存
		function save(){
				 if($("#TaskName").val()==""){
					/* $("#TaskName").tips({
						side:3,
			            msg:'请输入任务名称',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#TaskName").focus(); */
					layer.tips("请输入任务名称",'#TaskName',{
				          tips: [2,'#3595CC'],
							time:1000
			        });
					return false;
				}
			else
			if($("#TIDString").val()==""){
				/* $("#TIDString").tips({
					side:3,
		            msg:'请输入源终端ID号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TIDString").focus(); */
				layer.tips("请输入源终端ID号",'#TIDString',{
			          tips: [3,'#3595CC'],
						time:1000
		        });
				return false;
			}else
			if($("#Vols").val()==""){
				/* $("#Vols").tips({
					side:3,
		            msg:'请输入音量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#Vols").focus(); */
				layer.tips("请输入音量",'#Vols',{
			          tips: [2,'#3595CC'],
						time:1000
		        });
				return false;
			}else
				if($("#Vols").val()<0|| $("#Vols").val() > 40){
					/* $("#Vols").tips({
						side:3,
			            msg:'请输入正确的音量值',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#Vols").focus(); */
					layer.tips("请输入正确的音量值",'#Vols',{
				          tips: [2,'#3595CC'],
							time:1000
			        });
					return false;
				}else
			if($("#DomainsId").val()==""){
				/* $("#DomainsId").tips({
					side:3,
		            msg:'请输入分区信息',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DomainsId").focus(); */
				layer.tips("请输入分区信息",'#DomainsId',{
			          tips: [1,'#3595CC'],
						time:1000
		        });
				return false;
			}else
				if($("#0").val()=="0" && $("#ExecTime").val()==""){
					/* $("#ExecTime").tips({
						side:3,
			            msg:'请输入任务广播时间',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#ExecTime").focus(); */
					layer.tips("请输入任务广播时间",'#ExecTime',{
				          tips: [2,'#3595CC'],
							time:1000
			        });
					return false;
				}  
			if(null != $("#tid")){
				document.getElementById("taskForm").submit();
				
				var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
				/* console.info(index); */
				parent.layer.close(index); // 关闭layer
			}else{
				document.getElementById("taskForm").submit();
			}
		}
		function closes(){
			var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
			/* console.info(index); */
			parent.layer.close(index); // 关闭layer
		}
	</script>
</body>
</html>