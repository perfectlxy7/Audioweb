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
<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css"/>
<script type="text/javascript" src="static/js/jquery.min.js"></script>
	<script type="text/javascript" src="static/js/rating.min.js"></script>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.excheck.js"></script>
	<style>
         table tbody {
            display: block;
            height: 400px; 
            overflow-y: scroll;
        } 
 
        table thead{
            display: table;
            width: 100%;
        }
        table tbody tr {
            display: table;
            width: 100%;
            table-layout: fixed;
            text-align: center;
        }
 
        thead th,
        tbody td {
            width: 100%;
        }
  
        table thead {
            width: calc( 100% - 1em);
        }
    </style>
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">

					<div class="row">
						<div class="col-xs-8 col-sm-6 col-sm-offset-1">
						<div class="page-header">
							<h1><small><i class="ace-icon fa fa-angle-double-right"></i>
								选择文件</small></h1>
						</div>
						<form  action="filecast/startCast.do" name="Form" id="Form" method="post" class="form-horizontal" >
									<table id="table_report" class="table table-striped table-bordered table-hover" align="center">
<!-- 										<table id="table_filelist" class="table table-striped table-bordered table-hover"> -->
									<thead>
										<tr>
											<td style="width:100px;text-align: right;padding-top: 13px;">音量:</td>
											 
											<!-- <p class="ui-state-default ui-corner-all ui-helper-clearfix" style="padding:4px;">
											  <span class="ui-icon ui-icon-volume-on" style="float:left; margin:-2px 5px 0 0;"></span>
											</p> -->
 
											<td>
												<!-- <input type="number" id="vol" name="vol" min="1" max="40" step="1" value="25"> -->
												<div id="example-22" >
														<div id="rating-22" style="float: left;"></div>
														<div id="currentval-22"></div>
														<!-- <a class="btn btn-sm btn-success" id="volchange" style="display:none;">修改音量</a> -->
												</div>
											</td>
											</tr>
											<tr>
											<td style="width:100px;text-align: right;padding-top: 13px;">设置优先级:</td>
											<td >
												<select class="form-control" id="castlevel" name="castlevel"  style="width:98%;">
													<option value="2" >最高</option>
													<option value="3" >高</option>
													<option value="4" selected>中</option>
													<option value="5" >低</option>
													<option value="6" >最低</option>
												  </select>
											</td> 
										<tr>
											<td style="width:50px;text-align: right;padding-top: 13px;">
												全选&nbsp;&nbsp;&nbsp;<input type="checkbox" name="selectfile" id="allcheck">
											</td>
 											<td style="text-align: center;" colspan="10"> 
												<a class="btn btn-sm btn-success" id="start" >开始广播</a>
												<a class="btn btn-sm btn-success" id="play" style="display:none;">详细控制</a>
												<a class="btn btn-sm btn-primary" id="pause"  style="display:none;">暂停广播</a>
												<a class="btn btn-sm btn-success" id="resume" style="display:none;">继续广播</a>
												<a class="btn btn-sm btn-primary" id="stop"  style="display:none;">关闭广播</a>
											</td>
										</tr>
									</thead>
										<c:choose>
									<c:when test="${not empty filelist}">
									<c:forEach items="${filelist}" var="filename" varStatus="vs">
									<tr>
										<td style="width:50px;text-align: right;padding-top: 13px;">
											<input type="checkbox" name="selectfile" class="qx" value="${filename}" >
										</td>
											<td style="padding-top: 13px;"><a type="button"  href="javascript:change('${filename}');" title="选中或取消此音频" style='text-decoration:none;'>${filename}</a></td>
											<%-- <td style="padding-top: 13px;">${filename}</td> --%>
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
									<!-- <table class="layui-hide" id="test-table-checkbox"></table> -->
<!-- 									<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"></h4></div> -->
								</form>
						</div>
<!-- 						选择分组广播 -->
						<div class="col-xs-4 col-sm-4">
							<div class="page-header">
								<h1><small><i class="ace-icon fa fa-angle-double-right"></i>
									选择广播分组</small></h1>
							</div>
							<div class="widget-main" id="tertitle">
<!-- 										<div style="overflow: scroll; scrolling: yes;"> -->
											<ul id="domaintree" class="ztree" style="overflow:auto;"></ul>
<!-- 										</div> -->
									</div>
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
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
<!--layui-->
	<script src="static/layuiadmin/layui/layui.js" charset="utf-8"></script>
	<!-- inline scripts related to this page -->
	<script type="text/javascript">
	$("#allcheck").click(function(){//给全选按钮加上点击事件
        var xz = $(this).prop("checked");//判断全选按钮的选中状态
        var ck = $(".qx").prop("checked",xz);  //让class名为qx的选项的选中状态和全选按钮的选中状态一致。  
        })
	layui.use(['form', 'layer'], function(){
        var form = layui.form
                ,layer = layui.layer;
    });
	var zTree;
    var defaultvol = 30;
	var curcastid="";
	$(document).ready(function(){
		$(top.hangge());
		var setting = {
				check: {enable: true/* ,txtSelectedEnable: true */},
				data: {simpleData: {enable: true}},
				callback:{
					onClick: function(e, treeId, treeNode, clickFlag){
						zTree.checkNode(treeNode, !treeNode.checked, true); 
					}
				}
			};
		var zNodes = eval(${zTreeNodes});
		//console.log(zNodes);
// 			console.info(${zTreeNodes});
		zTree = $.fn.zTree.init($("#domaintree"), setting, zNodes);
		function treeFrameT() {
				var treeT = document.getElementById("domaintree");
				var bheightT = document.documentElement.clientHeight;
				treeT.style.height = (bheightT - 100) + 'px';
		}
		//treeFrameT();
		window.onresize = function() {
				treeFrameT();
		};
	});
    document.querySelector('#start').onclick = function() {
        start();
    };
    document.querySelector('#pause').onclick = function() {
    	pause();
    };
    document.querySelector('#resume').onclick = function() {
    	resume();
    };
    /* document.querySelector('#volchange').onclick = function() {
    	volchange();//修改音量
    }; */
    document.querySelector('#play').onclick = function() {
    	castcontroller(curcastid);//详细控制
    };
    document.querySelector('#stop').onclick = function() {
//         this.disabled = true;
		stop();
    };
		//保存
		function start() {
			 var filename = '';
	        $("input[name='selectfile']:checked").each(function(){
	        	filename += $(this).val()+'//';
	        })
			//console.log(filename);
			if (filename == "" || filename == null) {
				/* $("#start").tips({
					side : 3,
					msg : '请选择文件',
					bg : '#AE81FF',
					time : 2
				}); */
				layer.tips('请选择文件', '#allcheck', {
			          tips: [2,'#FFB800'],
				time:1000
			        });
				return false;
			}else{
				filename = filename.substring(0, filename.lastIndexOf('//'));  
			}
			//获取选择终端
			var nodes = zTree.getCheckedNodes();
			var terids = "";
			var domids = "";
			// 				var terips = "";
			for (var i = 0; i < nodes.length; i++) {
				if (nodes[i].type == "1") {
					terids += nodes[i].tid + ",";
					// 						terips += nodes[i].TIP+",";
				} else {
					domids += nodes[i].id + ",";
				}
			}
			terids = terids.substring(0, terids.length - 1);
			domids = domids.substring(0, domids.length - 1);
			if (domids == "" || terids == "") {
				/* $("#start").tips({
					side : 3,
					msg : '请选择播出分组与终端',
					bg : '#AE81FF',
					time : 2
				}); */
				layer.tips('请选择播出分组与终端', '#domaintree',{
			          tips: [1,'#FFB800'],
						time:1000
		        });
				return false;
			}
			$.post("<%=basePath%>filecast/startCast.do",{terids:terids,domids:domids,filename:filename,vol:defaultvol,castlevel:$("#castlevel").val()},function(data){
				if(data.result=="success"){
					/* $("#start").tips({
						side : 3,
						msg : '操作成功',
						bg : '#AE81FF',
						time : 2
					}); */
					layer.tips('操作成功', '#start',{
			          tips: [3,'#3595CC'],
						time:1000
			        });
					curcastid = data.taskid;
					$("#start").hide();
					$("#stop").show();
					$("#play").show();
					$("#pause").show();
					//$("#volchange").show();
				}
			});
		}
		function stop(){
			layer.confirm("确定要停止广播任务吗?", {
				  btn: ['确定','取消'] //按钮
			  ,anim: 6 
		  	  ,icon: 3
		}, function() {
// 				top.jzts();
				var url = "<%=basePath%>filecast/stopCast.do?taskid="+curcastid;
				$.get(url,function(data){
					if(data.result=="success"){
// 						window.location.reload();
						curcastid="";
						$("#start").show();
						$("#stop").hide();
						$("#play").hide();
						$("#pause").hide();
						$("#resume").hide();
						layer.msg('停止任务成功');
						return true;
						//$("#volchange").hide();
					}
					else{
						layer.alert("停止任务出错，没有开启任务");
						return false;
					}
				});
		});
			
		}
		
		<%-- function volchange(){
			$.post("<%=basePath%>filecast/toplay.do",{taskid:curcastid,vol:$("#vol").val()},function(data){
				if(data.result=="success"){
					$("#volchange").tips({
						side : 3,
						msg : '修改成功',
						bg : '#AE81FF',
						time : 2
					});
					return true;
				}else{
					$("#volchange").tips({
						side : 3,
						msg : '修改失败',
						bg : '#AE81FF',
						time : 2
					});
					return false;
				}
			});
		} --%>
		function pause(){
			$.post("<%=basePath%>filecast/toplay.do",{taskid:curcastid,commd:'true'},function(data){
				if(data.result=="success"){
					/* $("#pause").tips({
						side : 3,
						msg : '暂停成功',
						bg : '#AE81FF',
						time : 2
					}); */
					layer.tips('暂停成功', '#pause',{
			          tips: [3,'#3595CC'],
						time:1000
			        });
		    		$("#pause").hide();
		    		$("#resume").show();
					return true;
				}else{
					/* $("#pause").tips({
						side : 3,
						msg : '暂停失败',
						bg : '#AE81FF',
						time : 2
					}); */
					layer.tips('暂停失败', '#pause',{
			          tips: [3,'#FF5722'],
						time:1000
			        });
					return false;
				}
			});
		};
		function resume(){
			$.post("<%=basePath%>filecast/toplay.do",{taskid:curcastid,commd:'false'},function(data){
				if(data.result=="success"){
					/* $("#resume").tips({
						side : 3,
						msg : '继续播放',
						bg : '#AE81FF',
						time : 2
					}); */
					layer.tips('继续播放', '#resume',{
			          tips: [3,'#3595CC'],
						time:1000
			        });
		    		$("#pause").show();
		    		$("#resume").hide();
					return true;
				}else{
					/* $("#resume").tips({
						side : 3,
						msg : '播放失败',
						bg : '#AE81FF',
						time : 2
					}); */
					layer.tips('播放失败', '#resume',{
			          tips: [3,'#FF5722'],
						time:1000
			        });
					return false;
				}
			});
		};
		function castcontroller(castid){
			var index = layer.open({
			    type: 2,
			    title: '广播任务"'+castid,
			    maxmin: true, 
			    btn: ['确定'],
			    btnAlign: 'c',
			    moveOut: true,
		        area: ['800px', '600px'],
			    anim: 2,
			    content: "taskmanage/taskcontroller.do?taskid="+castid,
			   /*  yes: function(index, layero){
			        //按钮【按钮一】的回调
			        layer.close(index);
			      }, */
			  });
		};
		function change(filename){
			$("input[name='selectfile']").each(function(){
	        	if(filename == $(this).val()){
	        		if($(this).is(':checked')){
	        			$(this).prop("checked",false);
	        		}else{
	        			$(this).prop("checked",true);
	        		}
	        	}
	        	
	        })
		}
		 //音量调节代码
	    $('#rating-22').slidy({
			maxval: 44, 
			interval: 1,
			defaultValue: defaultvol+4,
			finishedCallback:function (value){
				if(curcastid != "" && value != defaultvol+4){
	        		$.post("<%=basePath%>filecast/toplay.do",{taskid:curcastid,vol:value-4},function(data){
						if(data.result=="success"){
							layer.tips('修改音量为'+(value-4), '#example-22',{
						          tips: [1,'#3595CC'],
									time:1000
					        });
							return true;
						}else{
							layer.tips('修改失败', '#example-22',{
						          tips: [1,'#FFB800'],
									time:1000
					        });
							return false;
						}
					});
				}
				if(defaultvol != value-4){
					defaultvol = value-4;
				}
			},
			moveCallback:function (value){
				$('#currentval-22').html('<strong>' + (value-4) + '</strong>');
			}
		});
	</script>
</body>
</html>