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
									<c:if test="${MSG=='edit' }">编辑任务</c:if>
									<c:if test="${MSG=='add' }">新增任务</c:if>
									<c:if test="${MSG=='read' }">查看任务</c:if>
									<c:if test="${MSG=='addList'}">批量新增任务</c:if>
									<c:if test="${MSG=='editList'}">批量新增任务</c:if>
								</small>
							</h1>
					</div><!-- /.page-header -->
					<div class="row">
						<div class="col-xs-12">
							

						<form  action="timedcast/${MSG}.do" name="taskForm" id="taskForm" method="post" class="layui-form layui-form-pane">
							<input type="hidden" name="ScheId" id="ScheId" value="${pd.ScheId}"/>
							<input type="hidden" name="ScheName" id="ScheName" value="${pd.ScheName}"/>
						<c:if test="${MSG != 'read'}">
							<div class="layui-collapse" >
						
							    <div class="layui-colla-item">
							        <h2 class="layui-colla-title">基础信息</h2>
							        <div class="layui-colla-content ">
						</c:if>
							<div class="layui-form-item">
        						<div class="layui-inline">
								<label class="layui-form-label"  style="width: 100px;">所属方案</label>
									<div class="layui-input-inline">
											<input type="text"  class="layui-input" name="ScheName" id="ScheName" value="${pd.ScheName}" readonly="readonly" maxlength="32" placeholder="${pd.ScheName}" title="方案"  style="width: 200px;"/>
									</div>
								</div>
								<c:if test="${MSG != 'read'}">
       							 <div class="layui-inline">
       							 <c:if test="${MSG !='addList'}">
									<label class="layui-form-label"  style="width: 100px;">任务编号</label>
								</c:if>
								<c:if test="${MSG =='addList'}">
									<label class="layui-form-label"  style="width: 200px;">起始任务编号</label>
								</c:if>
										<div class="layui-input-inline">
											<input type="text" name="TaskId" id="TaskId" <c:if test="${MSG != 'editList'}"> value="${pd.TaskId}" </c:if> <c:if test="${MSG == 'editList'}"> value='${taskIds}'</c:if>readonly="readonly" placeholder="任务编号" class="layui-input"  style="width: 200px;"/>
										</div>
									</div>
								</c:if>
									<div class="layui-inline">
						    			<label class="layui-form-label"  style="width: 200px;">任务是否启用</label>
						            <input type='checkbox' <c:if test="${MSG == 'read'}"> disabled </c:if> checked name="Status" id="Status" lay-skin="switch" lay-filter='switchTest' lay-text="是|否">
						     </div>
								</div>
							<c:if test="${MSG != 'read'}">
								</div>
	   						 </div>
							<div class="layui-colla-item">
							        <h2 class="layui-colla-title">必填信息</h2>
							        <div class="layui-colla-content layui-show">
							</c:if>
							   <c:if test="${MSG != 'addList'}">
									 <div class="layui-form-item">
							   		<c:if test="${MSG != 'editList'}">
									 	<div class="layui-inline">
										        <label class="layui-form-label"  style="width: 100px;">任务名称</label>
											<input type="text" name="TaskName" id="TaskName" placeholder="请输入" required="required" <c:if test="${MSG == 'read'}"> readonly="readonly" </c:if> value="${task.taskName}" placeholder="这里输入任务名称" class="layui-input" autocomplete="off"  style="width: 400px;"/>
										</div>
									</c:if>
							        <div class="layui-inline">
							        	<label class="layui-form-label"  style="width: 200px;">广播音量</label>
							            <div class="layui-input-inline">
							                <input type="number" name="Vols" id="Vols" autocomplete="off" min="1" max="40" <c:if test="${task.vols.length() > 0}"> value="${task.vols}" </c:if>  <c:if test="${MSG == 'read'}"> readonly="readonly" </c:if> class="layui-input" value="30">
							          	</div>
							        </div>
									</div>
								</c:if>
								<c:if test="${MSG == 'addList'}">
									 <div class="layui-form-item">
									 	<div class="layui-inline">
										        <label class="layui-form-label"  style="width: 100px;">任务名称</label>
										         <div class="layui-input-inline">
											<input type="text" name="Prefix" id="Prefix" placeholder="任务名称前缀" required="required"  value="第" placeholder="这里输入任务名称前缀" class="layui-input" autocomplete="off"  style="width: 200px;"/>
											 </div>
											 <div class="layui-input-inline">
											<input type="number" name="Tnumber" min="1" id="Tnumber" placeholder="任务名称编号" required="required"  placeholder="这里输入任务名称编号" class="layui-input" autocomplete="off"  style="width: 200px;"/>
											</div>
											 <div class="layui-input-inline">
											<input type="text" name="Suffix" id="Suffix" placeholder="任务名称后缀" required="required"  value="节" placeholder="这里输入任务名称后缀" class="layui-input" autocomplete="off"  style="width: 200px;"/>
											</div>
										</div>
										<div class="layui-inline">
							        	<label class="layui-form-label"  style="width: 200px;">广播音量</label>
							            <div class="layui-input-inline">
							                <input type="number" name="Vols" id="Vols" autocomplete="off" min="1" max="40" <c:if test="${task.vols.length() > 0}"> value="${task.vols}" </c:if>  <c:if test="${MSG == 'read'}"> readonly="readonly" </c:if> class="layui-input" value="30">
							          	</div>
							        </div>
									</div>
									<div class="layui-form-item">
										<div class="layui-inline">
											<label class="layui-form-label"  style="width: 200px;">批量创建任务数</label>
											<input type="number" name="TasksNumber" id="TasksNumber" min="1"  max="1000" placeholder="请输入任务数量" value="4" required="required" placeholder="这里输入任务数量" class="layui-input" autocomplete="off"  style="width: 100px;"/>
						      			</div>
										<div class="layui-inline">
											<label class="layui-form-label"  style="width: 200px;">任务间广播时间间隔</label>
											<input type="text" class="demo-input"  name="Interval" placeholder="请选择时间" id="Interval">
										</div>
									</div>
								</c:if>
							<div class="layui-form-item">
        						<div class="layui-inline">
									<label class="layui-form-label"  style="width: 100px;">音频信息</label>
									<input type="text" name="FilesInfo" id="FilesInfo" placeholder="请输入音频名称" value="${task.filesInfo}" required="required" <c:if test="${MSG == 'read'}"> readonly="readonly" </c:if> placeholder="这里输入音频名称" class="layui-input" autocomplete="off"  style="width: 300px;"/>
						      	</div>
						    <c:if test="${MSG != 'read'}">
							 	<div class="layui-inline">
						       		<button type="button" class="layui-btn  layui-btn-normal demo-active" data-type="file">选择</button> 
						       	</div> 
						    </c:if>
						    
						    <div class="layui-inline">
					    			<label class="layui-form-label"  style="width: 200px;">广播类型</label>
					              	<input type="radio" name="tasktype" id="tasktype" value="0" title="顺序播放" <c:if test="${task.tasktype == 0||task.tasktype == null}">  checked="" </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
					              	<input type="radio" name="tasktype" id="tasktype" value="1" title="循环播放" <c:if test="${task.tasktype == 1}">  checked="" </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
					              	<input type="radio" name="tasktype" id="tasktype" value="2" title="随机播放" <c:if test="${task.tasktype == 2}">  checked="" </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
						     		<input type="radio" name="tasktype" id="tasktype" value="3" title="单曲循环" <c:if test="${task.tasktype == 3}">  checked="" </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
						     </div>
						    </div>
						   
						    <div class="layui-form-item">
						    	<c:if test="${MSG != 'editList'}">
						          	<label class="layui-form-label"   style="width: 200px;"><c:if test="${MSG == 'addList'}">首次</c:if>任务广播时间</label>
							         <div class="layui-input-inline">
											<input type="text" class="demo-input"  name="ExecTime" value="${task.execTime}" <c:if test="${MSG == 'read'}"> readonly="readonly" </c:if> placeholder="请选择时间" <c:if test="${MSG != 'read'}">id="ExecTime"</c:if>>
									</div>
						    	</c:if>
       					    		<div class="layui-input-inline">
						            	<label class="layui-form-label" style="width: 200px;">播放持续时间</label>
						            </div>
						            <div class="layui-input-inline"style="width: 100px;">
						                <input type="number"  name="LastingSeconds" id="LastingSeconds" min="1" max="65535" <c:if test="${task.lastingSeconds.length() > 0}"> value="${task.lastingSeconds}" </c:if> autocomplete="off" <c:if test="${MSG == 'read'}"> readonly="readonly" </c:if> class="layui-input" value="30">
						          	</div>
						          	<div class="layui-input-inline" style="width: 10px;">
						          		<label class="layui-form-label">秒</label>
						          	</div>
						       </div>
							<c:if test="${MSG=='add' || MSG=='addList' || MSG=='editList'}">
							<div class="layui-form-item">
						        <label class="layui-form-label">任务类型</label>
									<div class="layui-input-block">
									      <input type="radio"  lay-filter="r-sel" name="0" id="0" value="1" title="单次任务" >
									      <input type="radio"  lay-filter="r-sel" name="0" id="0" value="0" title="每周任务" checked >
								    </div>
						   </div>
							<div class="layui-form-item " id="week" pane="">
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
							<div class="layui-form-item " id="single" style = "display:none;">
							    <div class="layui-inline">
								 		<label class="layui-form-label"   style="width: 200px;">单次任务具体日期</label>
		            					<div class="layui-input-inline">	
											<input type="text" class="demo-input"  name="SingleDate" value="${task.singleDate}"  placeholder="请选择日期" id="SingleDate">
								    	</div>
			        				</div>
		        			</div>
						    </c:if>
						    <c:if test="${MSG=='edit' || MSG== 'read'}">
						    <c:if test="${MSG != 'read'}">
							    <div class="layui-form-item">
							        <label class="layui-form-label">任务类型</label>
										<div class="layui-input-block">
										      <input type="radio"  lay-filter="r-sel"  name="0" id="0" value="1" title="单次任务" <c:if test="${String.valueOf(task.weeks.charAt(0)) == '1'}"> checked </c:if>>
										      <input type="radio"  lay-filter="r-sel"  name="0" id="0" value="0" title="每周任务" <c:if test="${String.valueOf(task.weeks.charAt(0)) == '0'}"> checked </c:if>>
									    </div>
							   </div>
						   </c:if>
							<div class="layui-form-item " id="week" pane="" <c:if test="${String.valueOf(task.weeks.charAt(0)) == '1'}"> style = "display:none;" </c:if>>
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
						    </div>
						    <div class="layui-form-item " id="single" <c:if test="${String.valueOf(task.weeks.charAt(0)) == '0'}"> style = "display:none;" </c:if>>
							    <div class="layui-inline">
								 		<label class="layui-form-label"   style="width: 200px;">单次任务具体日期</label>
		            					<div class="layui-input-inline">	
											<input type="text" class="demo-input"  name="SingleDate" value="${task.singleDate}" <c:if test="${MSG == 'read'}"> readonly="readonly" </c:if> placeholder="请选择日期" <c:if test="${MSG != 'read'}"> id="SingleDate"</c:if>>
								    	</div>
			        				</div>
		        			</div>
						    </c:if>
						    <c:if test="${MSG != 'read'}">
							     <div class="layui-form-item" >
	        						<div class="layui-inline">
										<label class="layui-form-label"  style="width: 200px;">选择广播分组</label>
										<input type="text" name="DomainsId" id="DomainsId" placeholder="请输入分组信息" value="${task.domainsId}"  <c:if test="${MSG == 'read'}"> readonly="readonly" </c:if> required="required" placeholder="这里输入分组信息" class="layui-input" autocomplete="off"  style="width: 300px;"/>
							      	</div>
								 	<div class="layui-inline">
							       		<button type="button" class="layui-btn  layui-btn-normal demo-active" data-type="domainselect">选择</button> 
							       	</div>
							    </div>
						    </c:if> 
							<c:if test="${MSG != 'read'}">
						    </div>
							</div>
						    <div class="layui-colla-item">
							        <h2 class="layui-colla-title">可填信息</h2>
							        <div class="layui-colla-content ">
							</c:if>
						    <div  class="layui-form-item">
						    	<div class="layui-inline">
							 		<label class="layui-form-label"   style="width: 200px;">任务开始日期</label>
	            					<div class="layui-input-inline">	
										<input type="text" class="demo-input"  name="StartDateTime" value="${task.startDateTime}"  <c:if test="${MSG == 'read'}"> readonly="readonly" </c:if> placeholder="请选择日期"  <c:if test="${MSG != 'read'}">id="StartDateTime"</c:if>>
							    	</div>
		        				</div>
		        				<div class="layui-inline">
							 		<label class="layui-form-label"   style="width: 200px;">任务结束日期</label>
	            					<div class="layui-input-inline">	
										<input type="text" class="demo-input"  name="EndDateTime" value="${task.endDateTime}" <c:if test="${MSG == 'read'}"> readonly="readonly" </c:if> placeholder="请选择日期" <c:if test="${MSG != 'read'}">id="EndDateTime"</c:if>>
							    	</div>
		        				</div>
						    </div>
						    <div class="layui-form-item layui-form-text">
						        <label class="layui-form-label">任务备注</label>
						        <div class="layui-input-block">
						            <textarea <c:if test="${MSG != 'read'}"> placeholder="请输入内容" </c:if> name="note" id="note" <c:if test="${MSG == 'read'}"> readonly="readonly" </c:if> class="layui-textarea">${task.note}</textarea>
						        </div>
						    </div>
						<c:if test="${MSG != 'read'}">
						    </div>
						    </div>		
							<%-- <div class="form-group">
								<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 终端IP地址 :</label>
								<div class="col-sm-9">
									<input type="text" name="TIP" id="TIP" value="${pd.term.TIP }" required="required" placeholder="这里输入终端IP地址" class="col-xs-10 col-sm-5" />
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 网关IP号 :</label>
								<div class="col-sm-9">
									<input type="text" name="TGateway" id="TGateway" value="${pd.term.TGateway }"   class="col-xs-10 col-sm-5" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 寻呼话筒 :</label>
								<div class="col-sm-9">
									<input type="text" name="ISCMIC" id="ISCMIC" value="${pd.term.ISCMIC }" placeholder="0为禁用1为启用"  class="col-xs-10 col-sm-5" />
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 自动采播:</label>
								<div class="col-sm-9">
									<input type="text" name="ISAutoCast" id="ISAutoCast" value="${pd.term.ISAutoCast }" placeholder="0为禁用1为启用" class="col-xs-10 col-sm-5" />
								</div>
							</div>
							 --%>
   						 	</div>
   						 </c:if>
							<%-- <div class="clearfix form-actions">
								<div class="col-md-offset-3 col-md-9">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>&nbsp;&nbsp;
									<a class="btn btn-mini btn-danger" onclick="goback('${DomainId}');">取消</a>
								</div>
							</div>
							<div class="hr hr-18 dotted hr-double"></div> --%>
						</form>
						<c:if test="${MSG != 'read'}">
						 <div class="layui-form-item">
						        <div class="layui-input-block" style="margin-top:15px;height: 30px;">
						            <button type="button"   class="layui-btn"   onclick="save();">保存</button>
						            <button type="button" class="layui-btn layui-btn-primary" onclick="goback('${pd.ScheId}','${pd.ScheName}');">取消</button>
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
		  elem: '#StartDateTime' //指定元素
			  ,type: 'datetime'
			  ,calendar: true
		});
		//日期选择
		//执行一个laydate实例
		laydate.render({
		  elem: '#ExecTime' //指定元素
			  ,type: 'time'
		});
		//执行一个laydate实例
		laydate.render({
		  elem: '#EndDateTime' //指定元素
			  ,type: 'datetime'
			  ,calendar: true
		});
		laydate.render({
			  elem: '#Interval' //指定元素
				  ,type: 'time'
			});
		laydate.render({
			  elem: '#SingleDate' //指定元素
				  ,type: 'date'
				 ,calendar: true
			});
		form.on('radio(r-sel)', function(data){
			  console.log(data.value); //被点击的radio的value值
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

	        //监听折叠
	        element.on('collapse(test)', function (data) {
	            layer.msg('展开状态：' + data.show);
	        });
	        var active = {
	                file: function () {
	                	layer.open({
	        			    type: 2,
	        			    title: '选择音频文件',
	        			    maxmin: true,
	        			    shade: 0,
	        			    id: 'file',
	        			    btn: ['完成','清空'],
	        			    btnAlign: 'c',
	        			    moveOut: true,
	        			    area: ['800px', '500px'],
	        			    anim: 2,
	        			    content: "timedcast/findFile.do",
	        			    yes: function(index, layero){
	        			        //按钮【按钮一】的回调
	        			        layer.close(index);
	        			      },
	                		btn2: function(index, layero){
	                			document.taskForm.FilesInfo.value="";
	                			layer.msg("已清空");
	                			return false;
        			        //按钮【按钮二】的回调
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
		function goback(ScheId,ScheName){
			layer.load();/* 
			console.info(ScheId); */
			window.location.href="<%=basePath%>timedcast/listScheTasks.do?ScheId="+ScheId+"&ScheName="+ScheName;
		}
		
		//保存
		function save(){
			if(${MSG != 'editList'}){
				if(${MSG != 'addList'} ){
					 if($("#TaskName").val()==""){
						/* $("#TaskName").tips({
							side:3,
				            msg:'请输入任务名称',
				            bg:'#AE81FF',
				            time:2
				        });
						$("#TaskName").focus(); */
						layer.tips('请输入任务名称', '#TaskName',{
					          tips: [2,'#3595CC'],
								time:1000
				        });
						return false;
					}
				 }else if($("#Prefix").val()=="" && $("#Tnumber").val()==""&& $("#Suffix").val()==""){
						/* $("#Tnumber").tips({
							side:3,
				            msg:'请输入任务名称',
				            bg:'#AE81FF',
				            time:2
				        });
						$("#Tnumber").focus(); */
						layer.tips('请输入任务名称', '#Tnumber',{
					          tips: [1,'#3595CC'],
								time:1000
				        });
						return false;
					}else if($("#TasksNumber").val() == '' || $("#TasksNumber").val() < 0||$("#TasksNumber").val() > 1000){
						/* $("#TasksNumber").tips({
							side:3,
				            msg:'请输入正确的任务数量',
				            bg:'#AE81FF',
				            time:2
				        });
						$("#TasksNumber").focus(); */
						layer.tips('请输入正确的任务数量', '#TasksNumber',{
					          tips: [3,'#3595CC'],
								time:1000
				        });
						return false;
					}else if($("#Interval").val() == "" || $("#Interval").val() == "00:00:00"){
						/* $("#Interval").tips({
							side:3,
				            msg:'请输入正确的时间间隔',
				            bg:'#AE81FF',
				            time:2
				        });
						$("#Interval").focus(); */
						layer.tips('请输入正确的时间间隔', '#Interval',{
					          tips: [2,'#3595CC'],
								time:1000
				        });
						return false;
					}
			}
			if($("#FilesInfo").val()==""){
				/* $("#FilesInfo").tips({
					side:3,
		            msg:'请输入音频信息',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FilesInfo").focus(); */
				layer.tips('请输入音频信息', '#FilesInfo',{
			          tips: [3,'#3595CC'],
						time:1000
		        });
				return false;
			}
			if(${MSG != 'editList'}){
				if($("#ExecTime").val()==""){
					/* $("#ExecTime").tips({
						side:3,
			            msg:'请输入广播时间',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#ExecTime").focus(); */
					layer.tips('请输入广播时间', '#ExecTime',{
				          tips: [1,'#3595CC'],
							time:1000
			        });
					return false;
				}
			}
			if($("#LastingSeconds").val()==""){
				/* $("#LastingSeconds").tips({
					side:3,
		            msg:'请输入播放持续时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LastingSeconds").focus(); */
				layer.tips('请输入播放持续时间', '#LastingSeconds',{
			          tips: [3,'#3595CC'],
						time:1000
		        });
				return false;
			}else if($("#LastingSeconds").val() < 0){
				/* $("#LastingSeconds").tips({
					side:3,
		            msg:'请输入正确的播放持续时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LastingSeconds").focus(); */
				layer.tips('请输入正确的播放持续时间', '#LastingSeconds',{
			          tips: [3,'#3595CC'],
						time:1000
		        });
				return false;
			}
			if($("#Vols").val()==""){
				/* $("#Vols").tips({
					side:3,
		            msg:'请输入音量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#Vols").focus(); */
				layer.tips('请输入音量', '#Vols',{
			          tips: [2,'#3595CC'],
						time:1000
		        });
				return false;
			}else if($("#Vols").val() < 0||$("#Vols").val() > 40){
				/* $("#Vols").tips({
					side:3,
		            msg:'请输入正确的音量值',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#Vols").focus(); */
				layer.tips('请输入正确的音量值', '#Vols',{
			          tips: [2,'#3595CC'],
						time:1000
		        });
				return false;
			}
			if($("#DomainsId").val()==""){
				/* $("#DomainsId").tips({
					side:3,
		            msg:'请输入分区信息',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DomainsId").focus(); */
				layer.tips('请输入分区信息', '#DomainsId',{
			          tips: [3,'#3595CC'],
						time:1000
		        });
				return false;
			}  
			layer.load(0);
			document.getElementById("taskForm").submit();
		}
		function findfile(filename){
			var file = $("#FilesInfo").val();
			if(null == file || "" == file){
			}else{
				filename = file + '//' + filename;
			}
			document.taskForm.FilesInfo.value=filename;
		}
		function closes(){
			var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
			/* console.info(index); */
			parent.layer.close(index); // 关闭layer
		}
	</script>
</body>
</html>