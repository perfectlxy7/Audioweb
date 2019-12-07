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
	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css"/>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core-3.5.js"></script>
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
									<c:if test="${MSG=='edit' }">编辑终端</c:if>
									<c:if test="${MSG=='add' }">添加终端</c:if>
									<c:if test="${MSG=='addlist'}">批量添加终端</c:if>
								</small>
							</h1>
					</div><!-- /.page-header -->

					<div class="row">
						<div class="col-xs-12">

						<form  action="terminal/${MSG }.do" name="termForm" id="termForm" method="post" class="form-horizontal">
							<input type="hidden" name="DomainId" id="DomainId" value="${DomainId}"/>

							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 所属分区 :</label>
								<div class="col-sm-9">
									<div style="padding-top:5px;">
										<input type="text" name="DomainName" id="DomainName" value="${DomainName}" readonly="readonly" maxlength="32" placeholder="选择区域" title="区域" />
											<button id="DomainsBtn" href="#"  onclick="showDomains(); return false;">选择</button>
									</div>
								</div>
							</div>
							

							<c:if test="${MSG=='add'}">
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 终端编号 : </label>
									<div class="col-sm-9">
										<input type="text" name="TIDString" id="TIDString" value="${TIDString}" placeholder="这里输入终端编号"  title="请输入正整数" class="col-xs-10 col-sm-5" onchange="istrue(this.id,this.value)"/>
										<i id= "istrue1" class="layui-icon" style="color:green;display:none;">&#xe605; </i>
										<i id= "isfalse1" class="layui-icon" style="color:red;display:none;">&#x1006; 输入终端编号有误或已有此终端</i>
									</div>
								</div>
							
							</c:if>
							<c:if test="${MSG=='addlist'}">
							<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 起始终端编号 : </label>
									<div class="col-sm-9">
										<input type="text" name="TIDString" id="TIDString" value="${TIDString}" readonly="readonly" placeholder="这里输入终端编号"  title="请输入正整数" class="col-xs-10 col-sm-5" />
									</div>
								</div>
							<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 批量添加个数 : </label>
									<div class="col-sm-9">
										<input type="number" name="Number" id="Number"  min="1" required="required" value="${pd.term.Number}" placeholder="这里输入批量添加的终端个数"  title="请输入正整数" class="col-xs-10 col-sm-5" />
									</div>
								</div>
							
							</c:if>
							<c:if test="${MSG=='edit' }">
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1">终端编号: </label>
									<div class="col-sm-9">
										<input type="text" name="TIDString" id="TIDString" required="required" value="${pd.term.TIDString}"  readonly="readonly"  placeholder="这里输入终端编号"  title="请输入正整数" class="col-xs-10 col-sm-5" />
									</div>
								</div>
							</c:if>
							<c:if test="${MSG=='edit'||MSG=='add'}">
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 终端名称 :</label>
								<div class="col-sm-9">
									<input type="text" name="TName" id="TName" value="${pd.term.TName }" required="required" placeholder="这里输入终端名称" class="col-xs-10 col-sm-5" onchange="istrue(this.id,this.value)"/>
									<i id= "istrue2" class="layui-icon" style="color:green;display:none;">&#xe605;</i>
									<i id= "isfalse2" class="layui-icon" style="color:red;display:none;">&#x1006;</i>
								</div>
							</div>
							</c:if>
							<c:if test="${MSG=='addlist'}">
							<div id ="text" class="form-group">
								<label class="col-sm-3 control-label no-padding-right" for="form-field-2"> 终端名称 :&nbsp&nbsp&nbsp&nbsp</label>
								<div style="float:left">
									<input type="text" name="text1" id="text1" value="第" placeholder="终端名称前缀" class="col-xs-10 col-sm-14" />
								</div>
								<div style="float:left">
									 <input type="number" name="TNameId" id="TNameId" min="1" required="required" value="${pd.term.TNameId}" placeholder="名称编号（数字）" class="col-xs-10 col-sm-18" />
								</div>
								<div style="float:left">
									<input type="text" name="text3" id="text3" value="班" placeholder="终端名称后缀" class="col-xs-10 col-sm-14" />
								</div>
								<div>
									<input type="hidden" name="TName" id="TName" value="${pd.term.TName}"/>
								</div>
							</div>
							</c:if>
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 终端IP地址 :</label>
								<div class="col-sm-9">
									<input type="text" name="TIP" id="TIP" value="${pd.term.TIP }" required="required" placeholder="这里输入终端IP地址" class="col-xs-10 col-sm-5" onchange="istrue(this.id,this.value)"/>
									<i id= "istrue3" class="layui-icon" style="color:green;display:none;">&#xe605; </i>
									<i id= "isfalse3" class="layui-icon" style="color:red;display:none;">&#x1006; 请正确输入IP地址</i>
									<i id= "isfalse33" class="layui-icon" style="color:red;display:none;">&#x1006; 此IP已被终端占用</i>
								</div>
							</div>
							<%-- <c:if test="${MSG=='edit' && user == '1'}">
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right" for="form-field-1">同步IP:</label>
								<div class="col-sm-9">
									<label>
											<input  id="setTer" name="setTer"  class="ace ace-switch ace-switch-3" type="checkbox" onchange="setterminals();">
											<span class="lbl"></span>
									</label>
								</div>
							</div>
							</c:if> --%>
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 寻呼话筒 :</label>
								<div class="col-sm-9">
									<label>
											<input id="ISCMIC" name="ISCMIC" class="ace ace-switch ace-switch-3" type="checkbox" onchange="showSelect();"<c:if test="${pd.term.ISCMIC}"> checked </c:if>>
											<span class="lbl"></span>
									</label>
									<%-- <div class='col-sm-9'>
												<label id="ISCMIC">
														<input name="ISCMIC"  onchange="setenable('${pd.term.TIDString}','${DomainId}')" class="ace ace-switch ace-switch-3" type="checkbox"<c:if test="${pd.term.ISCMIC}"> checked </c:if>>
														<span class="lbl"></span>
													</label>
											</div> --%>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 自动采播:</label>
								<div class="col-sm-9">
									<label>
											<input  id="ISAutoCast" name="ISAutoCast"  class="ace ace-switch ace-switch-3" type="checkbox" onchange="showSelect();"<c:if test="${pd.term.ISAutoCast}"> checked </c:if>>
											<span class="lbl"></span>
									</label>
								</div>
							</div>
							<div id= "domainSelect" class="form-group" <c:if test="${!pd.term.ISAutoCast && !pd.term.ISCMIC}"> style="display:none;" </c:if>>
	        						<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 管理分组:</label>
									<div class="col-sm-9">
										<div style="padding-top:5px;">
											<input type="text" name="Precinct" id="Precinct" placeholder="请输入分组信息" value="${pd.term.precinct}" required="required" placeholder="这里输入分组信息" class="col-xs-10 col-sm-5" autocomplete="off"  style="width: 300px;"/>
							      			&nbsp;<button type="button"  onclick="lookdomaininfo('${pd.term.precinct}','${pd.term.TName}');">选择</button> 
							      		</div>
									</div>
								 	<%-- <div class="col-sm-1 control-label no-padding-right">
							       		<button type="button" class="layui-btn  layui-btn-normal demo-active" onclick="lookdomaininfo('${pd.term.precinct}','${pd.term.TName}');">选择</button> 
							       	</div> --%>
							    </div>
							
							<div class="clearfix form-actions">
								<div class="col-md-offset-3 col-md-9">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>&nbsp;&nbsp;
									<a class="btn btn-mini btn-danger" onclick="goback('${DomainId}');">取消</a>
								</div>
							</div>
							<div class="hr hr-18 dotted hr-double"></div>
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
		<div id="DomainsContent" class="alert alert-info"  style="display:none; position: absolute;overflow:auto;background-color:#f0f6e4;border-color:#c3c3c3;padding:0px">
		<ul id="DomainsTree" class="ztree" style="margin-top:0; width:160px;"></ul>
	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- inline scripts related to this page -->
	<!--layui-->
		<script src="static/layuiadmin/layui/layui.js" charset="utf-8"></script>
	<script type="text/javascript">
	 var istrues = 0;
	layui.use(['form', 'layedit', 'laydate'], function(){
        var form = layui.form
                ,layer = layui.layer
                ,layedit = layui.layedit
                ,laydate = layui.laydate;
     
    });
		
		$(top.hangge());
// 		console.info("${MSG}")
		var setting = {
			view: {
				dblClickExpand: false
			},
			data: {
				simpleData: {
					enable: true
				}},
			callback: {
				onClick: onClick
			}
		};
		var areaZNodes;
		$(function(){
			$.get("terminal/listSelectDomains", function(data, status) {
					if (status == "success") {
						areaZNodes = eval(data);
						areazTreeObj = $.fn.zTree.init($("#DomainsTree"), setting,areaZNodes);
						if($("#DomainName").val()==""){
							$("#DomainName").val(areaZNodes[0].name);
							$("#DomainId").val(areaZNodes[0].id);
						}
					}
				});
		});
		
	// 	选择区域
	function showDomains() {
		var cityObj = $("#DomainName");
		var cityOffset = $("#DomainName").offset();
		$("#DomainsContent").css({
			left : cityOffset.left + "px",
			top : cityOffset.top + cityObj.outerHeight() + "px"
		}).slideDown("fast");
		$("#DomainsTree").css("width",cityObj.css("width")+ "px");
		$("body").bind("mousedown", onBodyDown);
	}
	function hideMenu() {
		$("#DomainsContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		if (!(event.target.id == "DomainsBtn" || event.target.id == "DomainsContent" || $(
				event.target).parents("#DomainsContent").length > 0)) {
			hideMenu();
		}
	}
	function onClick(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("DomainsTree"), 
		nodes = zTree.getSelectedNodes(),
		v = "",id="";
		v = nodes[nodes.length-1].name ;
		id = nodes[nodes.length-1].id ;
		$("#DomainName").val(v);
		$("#DomainId").attr("value", id);
	}
	function setterminals(){
		var is = $("#setTer").is(':checked');
		if(is)
		layer.msg('请确认终端在线！并保证配置信息正确，否则将同步失败！甚至可能影响终端配置',{//
			title: '警告'
			,icon: 8
		});
	}
	//返回
		function goback(DomainId){
			layer.load();
			console.info(DomainId)
			window.location.href="<%=basePath%>terminal/list.do?DomainId="+DomainId;
		}
	//合并字符串
		function tname(){
			var tname = "";
			if(document.getElementById("TNameId")!= null || document.getElementById("text1")!= null || document.getElementById("text3")!= null){
				tname=tname+(document.getElementById("text1").value != null ? document.getElementById("text1").value : "");
				tname=tname+(document.getElementById("TNameId").value != null ? document.getElementById("TNameId").value : "");
				tname=tname+(document.getElementById("text3").value != null ? document.getElementById("text3").value : "");
				document.getElementById("TName").value=tname;
				if($("#Number").val()==""){
					layer.tips('请输入终端个数', '#Number',{
				          tips: [2,'#3595CC'],
							time:1000
			        });
					return false;
				}
				if($("#TName").val()==""){
					layer.tips('请输入终端名称', '#TNameId',{
				          tips: [1,'#3595CC'],
							time:1000
			        });
					return false;
				}
				document.getElementById("TNameId").value != "" ? "" : document.getElementById("TNameId").value = -1;
			 }
			return true;
		}
		//保存
		function save(){
			if($("#TIDString").val()=="" || $("#isfalse1").is(":visible")){
				$("#TIDString").focus();
				layer.tips('请正确输入终端编号', '#TIDString',{
			          tips: [1,'#3595CC'],
						time:1000
		        });
				return false;
			}
			if($("#DomainName").val()==""){
				$("#DomainName").focus();
				layer.tips('请正确选择终端分区', '#DomainName',{
			          tips: [1,'#3595CC'],
						time:1000
		        });
				return false;
			}
			if($("#TIP").val()=="" || $("#isfalse3").is(":visible") || $("#isfalse33").is(":visible")){
				layer.tips('请正确输入终端IP地址', '#TIP',{
			          tips: [1,'#3595CC'],
						time:1000
		        });
				return false;
			}
			if(($("#ISAutoCast").is(':checked')||$("#ISCMIC").is(':checked')) && $("#Precinct").val()=="" ){
				$("#Precinct").focus();
				layer.tips('请输入终端管理分区', '#Precinct',{
			          tips: [1,'#3595CC'],
						time:1000
		        });
				return false;
			}
			if(tname() == false){
				return;
			}
			if($("#TName").val()=="" || $("#isfalse2").is(":visible")){
				$("#TName").focus();
				layer.tips('请正确输入终端名称', '#TName',{
			          tips: [1,'#3595CC'],
						time:1000
		        });
				return false;
			}
			$("#termForm").submit();
		}
		//处理按钮点击,创建任务
		function showSelect(){
			var is = $("#ISAutoCast").is(':checked')||$("#ISCMIC").is(':checked');
			if(is){
				$("#domainSelect").show();
			}else{
				$("#domainSelect").hide();
			}
		}
		function istrue(id,value){
			/* var ID = $(focus).attr('id');
			var value = $(focus).attr('value'); */
			$.post("<%=basePath%>terminal/istrue.do",{id:id,value:value},function(data){
				if(data.result=="success"){
					switch(id){
					case "TIDString":
						$("#istrue1").show();
						$("#isfalse1").hide();
						break;
					case "TName": 
						$("#istrue2").show();
						$("#isfalse2").hide();
						break;
					case "TIP": 
						$("#istrue3").show();
						$("#isfalse3").hide();
						$("#isfalse33").hide();
						break;
					default: 
						break;
					}
					console.log("true");
				}else if(data.result=="false"){
					switch(id){
					case "TIDString":
						$("#istrue1").hide();
						$("#isfalse1").show();
						console.log($("#isfalse1").is(":hidden"));
						break;
					case "TName": 
						$("#istrue2").hide();
						$("#isfalse2").show();
						break;
					case "TIP": 
						$("#istrue3").hide();
						$("#isfalse3").hide();
						$("#isfalse33").show();
						break;
					default: 
						break;
					}
					console.log("false");
				}else{
					switch(id){
					case "TIDString":
						$("#istrue1").hide();
						$("#isfalse1").show();
						console.log($("#isfalse1").is(":hidden"));
						break;
					case "TName": 
						$("#istrue2").hide();
						$("#isfalse2").show();
						break;
					case "TIP": 
						$("#istrue3").hide();
						$("#isfalse3").show();
						$("#isfalse33").hide();
						break;
					default: 
						break;
					}
					console.log("false");
				}
			});
			
		}
		function lookdomaininfo(precinct,TName){
			layer.open({
			    type: 2,
			    title: '选择"'+TName+'"管理分组',
			    maxmin: true, 
			    btn: ['确定'],
			    btnAlign: 'c',
			    moveOut: true,
			    area: ['300px', '480px'],
			    content: "timedcast/finddomids.do?domidInfo="+precinct,
			    yes: function(index, layero){
			        //按钮【按钮一】的回调
			    	var body = layer.getChildFrame('body', index);
		            var iframeWin = window[layero.find('iframe')[0]['name']];//得到iframe页的窗口对象，执行iframe页的方法：
		            var ids = iframeWin.save();//调用子页面的方法，得到子页面返回的ids
        			document.termForm.Precinct.value=ids;
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