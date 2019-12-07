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
<title>MP3实时采集编码传输</title>

<style>
body{
	word-wrap: break-word;
}
pre{
	white-space:pre-wrap;
}
.pd{
	padding:0 0 6px 0;
}

</style>

<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
<script type="text/javascript" src="static/js/jquery.min.js"></script>
	<script type="text/javascript" src="static/js/rating.min.js"></script><!-- 音量调节导入的js -->
<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css"/>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.excheck.js"></script>
	

<!--加载核心库，其他类型支持库在下面根据用户点击选择加载-->
<script type="text/javascript" src="static/js/wav-recorder/recorder-core.js"></script>

<!--加载mp3库-->
<script type="text/javascript" src="static/js/wav-recorder/lame.min.js"></script>


<script>
//兼容环境

function BuildHtml(html,o,notEncode,loop){return o||(o={}),html=(null==html?"":html+"").replace(/\{(fn:)?(:)?(.+?)\}/gi,function(a,b,c,code){try{var v=eval(b?code:"o."+code);return v=void 0===v?"":v+"",c||notEncode?v:v}catch(e){return console.log("BuildHtml Fail",a+"\n"+e.stack),""}}),loop&&/\{(fn:)?(.+?)\}/.test(html)&&(html=BuildHtml(html,o,notEncode,loop)),html};
function RandomKey(){
	return "randomkey"+(RandomKey.idx++);
};
RandomKey.idx=0;
</script>

</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="hr hr-18 dotted hr-double"></div>
					<div class="row">
						<div class="col-xs-8 col-sm-5 col-sm-offset-1">
							<div class="page-header">
								<h1><small><i class="ace-icon fa fa-angle-double-right"></i>
									实时广播</small></h1>
							</div>
							<form  name="Form" id="Form" method="post" class="form-horizontal" >
									<table id="table_report" class="table table-striped table-bordered table-hover" align="center">
<!-- 										<table id="table_filelist" class="table table-striped table-bordered table-hover"> -->
										<tr id ="Playmode" style="display:none;">
											<td style="width:90px;text-align: right;padding-top: 13px;">设置模式:</td>
											<td >
												<input type="radio"   name="Playmode1" id="Playmode1" value="-1" title="浏览器环境好且网络环境好时使用，使用中浏览器不可后台！"<c:if test="${realcasttype == '-1'}">checked</c:if>   onclick="checkradioOnclick(this)" >急速模式
											    <input type="radio"   name="Playmode1" id="Playmode1" value="0" title="在网络环境良好时可使用" <c:if test="${realcasttype == '0'}">checked</c:if>  onclick="checkradioOnclick(this)" >低延时模式
											    <input type="radio"   name="Playmode1" id="Playmode1" value="1" title="能稳定播放，但延时较高"<c:if test="${realcasttype == '1'}">checked</c:if>  onclick="checkradioOnclick(this)" >稳定模式
											 </td>
										</tr>
										<tr>
											<td style="width:90px;text-align: right;padding-top: 13px;">插件:</td>
											<c:if test="${clientTaskId == null}">
												<td class='center' style="width: auto;">
													<a href="Qaudioplayer://"><i class="ace-icon fa fa-cloud-download bigger-130" title="调用">调用</i></a>
													</td>
											</c:if>
											<c:if test="${clientTaskId == '0'}">
												<td class='center' style="width: auto;">
													终端在线
												</td>
											</c:if>
											<c:if test="${clientTaskId != null && clientTaskId != '0'}">
												<td class='center' style="width: auto;">
													终端广播中,任务编号:${clientTaskId}
												</td>
											</c:if>
										</tr>
										<tr>
											<td style="width:90px;text-align: right;padding-top: 13px;">设置音量:</td>
											<td >
												<div id="example-22" >
														<div id="rating-22" style="float: left;"></div>
														<div id="currentval-22"></div>
												</div>
											</td>
										</tr>
										<tr>
											<td style="width:90px;text-align: right;padding-top: 13px;">设置优先级:</td>
											<td >
												<select class="form-control" id="castlevel" name="castlevel"  style="width:98%;">
													<option value="2" >最高</option>
													<option value="3" selected>高</option>
													<option value="4" >中</option>
													<option value="5" >低</option>
													<option value="6" >最低</option>
												  </select>
											</td> 
										</tr>
										<tr>
											<td style="text-align: center;" colspan="10">
												<a class="btn btn-sm btn-success" id="start" >开启任务</a>
												<a class="btn btn-sm btn-primary" id="pause"  style="display:none;">暂停广播</a>
												<a class="btn btn-sm btn-success" id="resume" style="display:none;">开始广播</a>&nbsp;&nbsp;&nbsp;
												<a class="btn btn-sm btn-primary"  id="stop"  style="display:none;">关闭广播</a>
											</td>
										</tr>
									</table>
								</form>
							 <div class="pd types" style="display:none;">
								类型:
								<label><input type="radio" name="type" value="mp3" engine="mp3,mp3-engine" class="initType" checked>mp3</label>
								<label><input type="radio" name="type" value="wav" engine="wav" class="initType"  >wav</label>
								
							 </div>
							<div class="pd" style="display:none;">
								比特率:<input type="text" class="bit" value="192">如：kbps mp3、wav取值8位16位
							</div>
							<div class="pd" style="display:none;">
								采样率:<input type="text" class="sample" value="48000">如：mp3标准值，wav任意
							</div> 
							<textarea class="reclog" style="width:100%;height:160px;" readonly ></textarea>
						</div>
						<!-- 						选择分组广播 -->
						<div class="col-xs-4 col-sm-4">
							<div class="page-header">
								<h1><small><i class="ace-icon fa fa-angle-double-right"></i>
									选择广播分组</small></h1>
							</div>
							<div class="widget-main" id="tertitle">
											<ul id="domaintree" class="ztree" style="overflow:auto;"></ul>
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
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
	<!-- <script type="text/javascript" src="static/ace/js/ace/ace.js"></script> -->
	<!-- <script type="text/template" class="tp_recinfo"></script> -->
	<!-- 页面引用 -->
	<script type="text/javascript" src="static/js/protocol/protocolcheck.js"></script>
	<script type="text/javascript" src="static/js/protocol/example.js"></script>
	<script>
	var times = 1;
	function reclog(s){
		$(".reclog").prepend('本地时间:['+new Date().toLocaleTimeString()+']'+s+'\n');
	};
	$(window).bind("error",function(e){
		reclog('<span style="color:red">【Error】:<pre>'+(e.error?e.error.stack:event.message)+'</pre></span>');
	});
	</script>
	<script>
	/*******************以下为音频处理********************/
	var rec;
	var size;
    var defaultvol = 30;
	function recopen(){
		var type=$("[name=type]:checked").val();
		var mode = $("[name=Playmode1]:checked").val();
		var type=$("[name=type]:checked").val();
		var bit=+$(".bit").val();
		var sample=+$(".sample").val();
		rec = null;
		if(!mode){
			mode = '1';
		}
		rec=Recorder({
			type:type
			,bitRate:bit
			,sampleRate:sample
			,bufferSize:size
			,onComplete: function (data,time) {
	            if(worker!=null){
	            	worker.postMessage({//实时发送编码数据
			            cmd: "encoding",
			            data: data,
			            time: time
			        });
	            }
		     }
			,mode:mode
		});
		rec.open(function(){
			worker.postMessage({//发送初始化命令
		        cmd: "init",
		        data: {
		        	 bufferSize: size,
		        	 sampleRate: sample,
		             bitRate: bit,
		             mode:mode
		        }
		    });
		},function(e,isUserNotAllow){
			reclog((isUserNotAllow?"UserNotAllow，":"")+"打开失败："+e);
			$("#start").hide();
		});
	};
	function recclose(){
		if(rec){
			rec.close(function(){
				reclog("已更新录音设置");
			});
		}
	};
	function recstart(){
		if(rec){
			rec.start();
			reclog("开启录制，请勿将此系统网页后台或关闭,否则可能会影响录音！");
		};
	};
	function recpause(){
		if(rec){
			rec.pause();
			reclog("已暂停");
    		$("#pause").hide();
    		$("#resume").show();
		};
	};
	function recresume(){
		if(rec){
			rec.resume();
			reclog("录音中...");
    		$("#pause").show();
    		$("#resume").hide();
		};
	};
	function recstop(){
		if(rec){
			var t1=Date.now();
			rec.stop(function(blob,time){
				reclog("已停止录制");
			},function(s){
				reclog("失败："+s);
			});
		};
	};
	var intp=function(s,len){
		s=""+s;
		if(s.length>=len)return s;
		return ("_______"+s).substr(-len);
	};
	/* $(".recinfo").html(BuildHtml($(".tp_recinfo").html())); */
	//reclog("点击打开录音开始哦，此浏览器<span style='color:"+(Recorder.Support()?"green'>":"red'>不")+"支持录音</span>");
	if(Recorder.Support()){
		reclog("此浏览器支持录音!");
	}else{
		reclog("此浏览器不支持录音!");
	}
	/*****以下为worker，进行音频编码和webSocket交互********/
	//websocket路径获取
	var target= "/Audioweb/webstream";
	var sockettype = 0;
	var countcon = 0;
	if (window.location.protocol == 'http:') {
        target = "ws://" + window.location.host + target;
        console.log(target);
    } else {
        target = "wss://" + window.location.host + target;
    }
	if ('WebSocket' in window) {
		sockettype = 1;
    } else if ('MozWebSocket' in window) {
    	sockettype = 2
    } else {
        alert("WebSocket is not supported by this browser.");
		reclog("此浏览器不支持WebSocket!请更换浏览器重试");
    }
	var worker= new Worker('static/js/wav-recorder/recorder-worker.js');//开一个线程做实时编码处理
    worker.onmessage = function (e) {//worker接收
        var obj = e.data, data = obj.data;
        switch (obj.cmd) {
        case "error":
            if (onError) onError(data);
            break;
            
        case "started":
            if (data){ 
            	reclog(data);
        		recstart();//开始录制音频
            }
            break;
        case "starterror":
            if (data){ 
            	reclog(data);
            }
            break;
        case "stop":
            if (data){
            	stop();
                recstop();
                setTimeout("disconnect();",10);
            	reclog(data);
            }
            break;
        case "stoped":
            if (data){
            	disconnect();
            }
            break;
    	}
    };
	/***************以下为广播处理，页面交互***************/
    
    document.querySelector('#start').onclick = function() {
        start();
    };
    document.querySelector('#pause').onclick = function() {
    	recpause();
    };
    document.querySelector('#resume').onclick = function() {
    	recresume();
    };
  /*   document.querySelector('#volchange').onclick = function() {
    	volchange();//修改音量
    }; */
    document.querySelector('#stop').onclick = function() {
//         this.disabled = true;
		stop();
        disconnect();
    };
    
/*     window.onbeforeunload = function() {
        document.querySelector('#start').disabled = "disabled";
//         $("#start").attr("disabled",connected);
    }; */
    
    function connect() {
    	 worker.postMessage({
   	        cmd: "start",
   	        data: {
   	        	target: target,
   	        	taskid: taskid,
   	        	sockettype:sockettype
   	        }
    	});
    }
    
    function disconnect() {
    	setTimeout("sendstop()",10);
    }
	function sendstop(){
		if (taskid != "" && countcon < 3) {
			worker.postMessage({//发送停止广播命令
	            cmd: "stop",
	            data:"stop"
	        });
	    	countcon++;
        }else{
        	if(countcon >=3){
        		reclog("与服务器断开连接，请检查网络或服务器状态！");
        	}
    		$("#start").show();
    		$("#stop").hide();
    		$("#pause").hide();
    		$("#resume").hide();
    		countcon = 0;
    		/* $("#Playmode").show(); */
    		/* $("#Recwave2").show(); */
        }
	}
	//终端分区
	var zTree;
	var taskid = "";
	$(document).ready(function(){
		$(top.hangge());
		var setting = {
				check: {enable: true},
				data: {simpleData: {enable: true}},
				callback:{
					onClick: function(e, treeId, treeNode, clickFlag){
						zTree.checkNode(treeNode, !treeNode.checked, true); 
					}
				}
			};
			var zNodes = eval(${zTreeNodes});
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
			var mode = $("[name=Playmode1]:checked").val();//查询默认设置模式
			if(mode == '-1'){
				size = 512;
				$(".bit").val(256);
				reclog("已设置为急速模式");
			}else if(mode == '0'){
				size = 1024;
				$(".bit").val(192);
				reclog("已设置为低延时模式,建议在网络稳定通畅时使用");
			}else{
				size = 4096;
				$(".bit").val(128);
				reclog("已设置为稳定模式");
			}
			//loadEngine($(".initType"));
			setTimeout("recopen();",100)//开启声卡监听
		});
	//保存
	function start() {
		//获取选择终端
		var nodes = zTree.getCheckedNodes();
		var terids = "";
		var domids = "";
		var mode=$("[name=Playmode1]:checked").val();
		for (var i = 0; i < nodes.length; i++) {
			if (nodes[i].type == "1") {
				terids += nodes[i].tid + ",";
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
		$.post("<%=basePath%>realtimecast/startCast.do",{terids:terids,domids:domids,vol:defaultvol,castlevel:$("#castlevel").val(),playmode:mode},function(data){
			if(data.result=="success"){
				taskid = data.taskid;
				connect();//打开worker websocket连接
				reclog("广播正在开启");
			}else{
				reclog("广播开启失败！请关闭重启");
			}
		});
		$("#start").hide();
		$("#stop").show();
		$("#pause").show();
		/* $("#Playmode").hide(); */
		/* $("#Recwave2").hide(); */
	}
	function stop(){
		if(taskid != ""){
			$.post("<%=basePath%>realtimecast/stopCast.do",{taskid:taskid},function(data){
				if(data.result=="success"){
					taskid = "";
				}else{
					taskid = "";
					reclog("关闭失败！请在广播控制界面进行管理");
				}
			});
			worker.postMessage({//发送停止广播命令
	            cmd: "stop",
	            data:"stop"
	        });
		}else{
			reclog("已关闭广播任务！");
		}
	}
	
/* 	function loadEngine(input){
		if(input.length&&input[0].nodeName=="INPUT"){
			var type=input.val();
			var engines=input.attr("engine").split(",");
			var end=function(){
				var enc=Recorder.prototype["enc_"+type];
				$(".typeTips").html(!enc?"这个编码器无提示信息":type+"编码器"+(enc.stable?"稳定版":"beta版")+"，"+enc.testmsg);
			};
			if(!Recorder.prototype[type]){
				var i=-1;
				reclog("正在加载编码器...");
				var load=function(){
					i++;
					if(i>=engines.length){
						reclog("编码器已准备好,可以开始广播");
						end();
						return;
					}
					var elem=document.createElement("script");
					elem.setAttribute("type","text/javascript");
					elem.setAttribute("src","static/js/wav-recorder/engine/"+engines[i]+".js");
					elem.onload=function(){
						load();
					};
					$("head")[0].appendChild(elem);
				};
				load();
			}else{
				end();
			};
		};
	}; */
	function checkradioOnclick(radio){
		if(radio.name == "Playmode1"&&radio.value == "0"){
			size = 1024;
			$(".bit").val(192);
			reclog("已设置为低延时模式,建议在网络稳定通畅时使用");
		}else if(radio.name == "Playmode1"&&radio.value == "1"){
			size = 4096;
			$(".bit").val(128);
			reclog("已设置为稳定模式");
		}else if(radio.name == "Playmode1"&&radio.value == "-1"){
			size = 512;
			$(".bit").val(256);
			reclog("已设置为急速模式");
		}
		recclose();
		recopen();//开始采集用户音频
	}
	 //音量调节代码
    $('#rating-22').slidy({
		maxval: 44, 
		interval: 1,
		defaultValue: defaultvol+4,
		finishedCallback:function (value){
			//console.log(taskid,value,defaultvol);
			if(taskid != "" && value != defaultvol+4){
        		$.post("<%=basePath%>realtimecast/volChange.do",{taskid:taskid,vol:value-4},function(data){
					if(data.result=="success"){
	        			reclog("广播音量成功修改为"+(value-4));
						$("#currentval-22").tips({
	    					side : 3,
	    					msg : '修改成功',
	    					bg : '#AE81FF',
	    					time : 2
	    				});
	    				return true;
					}else{
						reclog("广播音量修改失败，检查此任务是否已停止");
						$("#currentval-22").tips({
	    					side : 3,
	    					msg : '修改失败',
	    					bg : '#AE81FF',
	    					time : 2
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
	 function getClient(){
		 $.post("<%=basePath%>realtimecast/getClient.do","",function(data){
			if(data.result=="success"){
				if(taskid == "")
					location.reload(true);
			}else{
				if(times > 5){
			        top.hangge();
			        times = 1;
		    		if(confirm("若加载未成功,请下载插件,请下载后手动运行插件")){
		                window.location.href="/Audioweb/tool/Qaudioplayer.exe";
		            }
				}else{
		        	setTimeout(getClient,1000);
					times++;
				}
			}
		});
	 }
	</script>

</body>
</html>