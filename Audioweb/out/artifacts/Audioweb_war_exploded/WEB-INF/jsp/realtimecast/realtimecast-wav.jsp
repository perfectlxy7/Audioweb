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
<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css"/>
<script type="text/javascript" src="static/js/jquery.min.js"></script>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.excheck.js"></script>
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
								实时广播</small></h1>
						</div>
						<form  name="Form" id="Form" method="post" class="form-horizontal" >
							<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report" class="table table-striped table-bordered table-hover">
<!-- 										<table id="table_filelist" class="table table-striped table-bordered table-hover"> -->
										<tr>
											<td style="width:90px;text-align: right;padding-top: 13px;">设置音量:</td>
											<td >
												<input type="number" id="vol" name="vol" min="1" max="40" step="1" value="21">
											</td>
										</tr>
										<tr>
											<td style="width:90px;text-align: right;padding-top: 13px;">设置优先级:</td>
											<td >
												<input type="number" id="castlevel" name="castlevel" min="1" max="10" step="1" value="6">
											</td>
										</tr>
										<tr>
											<td style="text-align: center;" colspan="10">
												<a class="btn btn-sm btn-primary" id="start"  >开始广播</a>&nbsp;&nbsp;&nbsp;
														<a class="btn btn-sm btn-success" disabled="disabled" id="stop" >关闭广播</a>
											</td>
										</tr>
									</table>
									</div>
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
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
	<!-- inline scripts related to this page -->
	
	<script src="static/js/wav-recorder/MediaStreamRecorder.js"></script>

    <!-- for Edige/FF/Chrome/Opera/etc. getUserMedia support -->
    <script src="static/js/wav-recorder/gumadapter.js"></script>
    
    <script type="text/javascript" src="static/js/mp3-recorder/recorder.js"></script>
	<script type="text/javascript">
	var ws=null
	var target= "/Audioweb/webstream";
	if (window.location.protocol == 'http:') {
        target = "ws://" + window.location.host + target;
    } else {
        target = "wss://" + window.location.host + target;
    }
    
    function captureUserMedia(mediaConstraints, successCallback, errorCallback) {
        navigator.mediaDevices.getUserMedia(mediaConstraints).then(successCallback).catch(errorCallback);
    }
    var mediaConstraints = {
        audio: true
    };
    document.querySelector('#start').onclick = function() {
        start();
    };
    document.querySelector('#stop').onclick = function() {
        this.disabled = true;
//         stop();
//         mediaRecorder.stop();
//         mediaRecorder.stream.stop();
//         ws.send("end");
        disconnect();
    };
    var mediaRecorder=null;
    function onMediaSuccess(stream) {
        mediaRecorder = new MediaStreamRecorder(stream);
        mediaRecorder.stream = stream;
//             mediaRecorder.recorderType = StereoAudioRecorder;
            mediaRecorder.mimeType = 'audio/wav';
        mediaRecorder.audioChannels = 1;
        mediaRecorder.sampleRate = 11025 ;
        mediaRecorder.ondataavailable = function(blob) {
        	mediaRecorder.isFirst = false;
        	if(ws!=null)
            ws.send(blob);
        };
        var timeInterval = 150;
        // get blob after specific time interval
        mediaRecorder.start(timeInterval);
        document.querySelector('#stop').disabled = "disabled";
    }
    function onMediaError(e) {
        console.error('media error', e);
    }
//     var index = 1;
//     function bytesToSize(bytes) {
//         var k = 1000;
//         var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
//         if (bytes === 0) return '0 Bytes';
//         var i = parseInt(Math.floor(Math.log(bytes) / Math.log(k)), 10);
//         return (bytes / Math.pow(k, i)).toPrecision(3) + ' ' + sizes[i];
//     }
//     function getTimeLength(milliseconds) {
//         var data = new Date(milliseconds);
//         return data.getUTCHours() + " hours, " + data.getUTCMinutes() + " minutes and " + data.getUTCSeconds() + " second(s)";
//     }
    window.onbeforeunload = function() {
        document.querySelector('#start').disabled = "disabled";
//         $("#start").attr("disabled",connected);
    };
    
    function connect() {
        if (target == '') {
            alert("Please select server side connection implementation.");
            return;
        }
        if ('WebSocket' in window) {
            ws = new WebSocket(target);
        } else if ('MozWebSocket' in window) {
            ws = new MozWebSocket(target);
        } else {
            alert("WebSocket is not supported by this browser.");
            return;
        }
        ws.binaryData = "blob";
        ws.onopen = function () {//连接打开后
            setConnected(true);
        	ws.send("start:"+taskid);//发送任务开始指令
            captureUserMedia(mediaConstraints, onMediaSuccess, onMediaError);//开始采集用户音频
            console.debug("Info: WebSocket connection opened.");
        };
        ws.onmessage = function (event) {
            console.debug("Received: " + event.data);
            document.getElementById('localVideo').src = URL.createObjectURL(event.data);
        };
        ws.onclose = function (event) {
            setConnected(false);
            stop();
            if(mediaRecorder!=null){
           		mediaRecorder.stop();
            	mediaRecorder.stream.stop();
            }
            window.location.reload();
            console.debug("Info: WebSocket connection closed, Code:" + event.code + (event.reason == "" ? "" : ", Reason: " + event.reason));
        };
    }
    function disconnect() {
        if (ws != null) {
            ws.close();
            ws = null;
        }
        setConnected(false);
    }
    function setConnected(connected) {
//         document.querySelector('#start').disabled = connected;
//         document.querySelector('#stop').disabled = !connected;
        $("#start").attr("disabled",connected);
		$("#stop").attr("disabled",!connected);
    }
	
	
	var zTree;
	var taskid;
	$(document).ready(function(){
		$(top.hangge());
		var setting = {
				check: {enable: true},
				data: {simpleData: {enable: true}}
			};
			var zNodes = eval(${zTreeNodes});
// 			console.info(${zTreeNodes});
			zTree = $.fn.zTree.init($("#domaintree"), setting, zNodes);

			function treeFrameT() {
				var treeT = document.getElementById("domaintree");
				var bheightT = document.documentElement.clientHeight;
				treeT.style.height = (bheightT - 100) + 'px';
			}
			treeFrameT();
			window.onresize = function() {
				treeFrameT();
			};
		});
		//保存
		function start() {
			//获取选择终端
			var nodes = zTree.getCheckedNodes();
			var terids = "";
			var domids = "";
			// 				var terips = "";
			for (var i = 0; i < nodes.length; i++) {
				if (nodes[i].type == "1") {
					terids += nodes[i].id + ",";
					// 						terips += nodes[i].TIP+",";
				} else {
					domids += nodes[i].id + ",";
				}
			}
			terids = terids.substring(0, terids.length - 1);
			domids = domids.substring(0, domids.length - 1);
			if (domids == "" || terids == "") {
				$("#start").tips({
					side : 3,
					msg : '请选择播出分组与终端',
					bg : '#AE81FF',
					time : 2
				});
				return false;
			}

			$.post("<%=basePath%>realtimecast/startCast.do",{terids:terids,domids:domids,vol:$("#vol").val(),castlevel:$("#castlevel").val()},function(data){
				if(data.result=="success"){
// 					$("#save").tips({
// 						side : 3,
// 						msg : '操作成功',
// 						bg : '#AE81FF',
// 						time : 2
// 					});
// 					return true;
					taskid = data.taskid;
					connect();//打开websocket连接
				}
			});
		}
		function stop(){
			$.post("<%=basePath%>realtimecast/stopCast.do",{taskid:taskid},function(data){
				if(data.result=="success"){
					taskid = "";
				}
			});
		}
	</script>
</body>
</html>