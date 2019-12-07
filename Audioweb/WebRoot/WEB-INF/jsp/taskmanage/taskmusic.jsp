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
<style type="text/css">
.progress{position: relative; width:500px;margin:100px auto;background:#f2f2f2;}/* 背景 */
.progress_bg{height: 20px; border: 1px solid #ddd; border-radius: 5px; overflow: hidden;background-color:#f2f2f2;}/* 框 */
.progress_bar{background: #5FB878; width: 0; height: 10px; border-radius: 5px;}/* 流 */
.progress_btn{width: 20px; height: 20px; border-radius: 5px; position: absolute;background:#fff; 
left: 0px; margin-left: -10px; top:-5px; cursor: pointer;border:1px #ddd solid;box-sizing:border-box;}/* 按钮 */
.progress_btn:hover{border-color:#F7B824;height: 20px;}
body{ text-align:center} 
#divcss5{margin:0 auto;width:300px;height:100px} /* 居中显示css */
/* 音量值的css */
.clearfix:after, .container:after {content:"\0020";display:block;height:0;clear:both;visibility:hidden;overflow:hidden;}
.clearfix, .container {display:block;}
.example{border: 1px dashed #d8d8d8; padding: 10px; margin: 10px;}
</style>
	<!-- layui -->
 <link rel="stylesheet" href="static/layuiadmin/layui/css/layui.css">
 
	<script type="text/javascript" src="static/js/jquery.min.js"></script>
	<script type="text/javascript" src="static/js/rating.min.js"></script>
<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>

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
					<div>
					<label  style="font-size:30px;"><c:if test="${task.taskName != null}">${task.taskName}</c:if><c:if test="${task.taskName == null}">主动操作广播</c:if></label>
					</div>
						<div class="col-xs-12">
						<div>
						<label  style="font-size:20px;"><c:if test="${task.mct.fileinfo.size() > 0 }">${task.mct.fileinfo.get(0)}</c:if><c:if test="${task.mct.fileinfo.size() <= 0}">无名称音频</c:if></label>
						<c:if test="${task.mct.fileinfo.size()>0}"><input  style = "display:none;" name= "musictime" id = "musictime" value = "${task.mct.fileinfo.get(2)}" /></c:if>
						<input  style = "display:none;" name= "taskid" id = "taskid" value = "${task.taskid}" />
						<c:if test="${task.mct.fileinfo.size()>0 && !task.isStop}"><input  style = "display:none;" name= "playtime" id = "playtime" value = "${(task.time-(task.mct.fileinfo.get(4)-task.mct.fileinfo.get(3)*1000)-task.mct.fileinfo.get(6))/1000}" /></c:if>
						<c:if test="${task.mct.fileinfo.size()>0 && task.isStop}"><input  style = "display:none;" name= "playtime" id = "playtime" value = "${(task.time-(task.mct.fileinfo.get(4)-task.mct.fileinfo.get(3)*1000)-task.mct.fileinfo.get(6)-(task.time-task.mct.fileinfo.get(5)))/1000}" /></c:if>
						<input  style = "display:none;" name= "isstop" id = "isstop" value = "${task.isStop}" />
						<input  style = "display:none;" name= "taskType" id = "taskType" value = "${task.multiCastType}" />
						<input  style = "display:none;" name= "error" id = "error" value = "${error}" />
						</div> 
								<div class=" progress layui-form-item" style="height:auto;" >
								 		<div class="progress_bg">
								  			<div class="progress_bar"></div>
								 		</div>
								 		<button class="progress_btn"  ></button>
								 		<div class="text layui-inline" style="height: 20px;" >0:00</div>
								 		<div class="layui-inline" style="height: 20px;" >/</div>
								 		<div class="text1 layui-inline" style="height: 20px;" >0:00</div>
						<form class="layui-form" lay-filter="group" name="group">
								 		<div class="layui-input-block" style="margin:0 auto; display:none;" id= "alltype" name="alltype" >
										      <input type="radio"  lay-filter="radioall"  name="type" id="type" value="point" title="音频锁">
										      <input type="radio"  lay-filter="radioall"  name="type" id="type" value="vol" title="音量修改">
										      <input type="radio"  lay-filter="radioall"  name="type" id="type" value="type" title="类型修改">
									    </div>
									    <div  id= "voldiv" name="voldiv" style="height: auto; display:none;">
										      	<div class="layui-inline"> 
										      		<%-- <input type="number"  style="width: 100px;" placeholder="音量" name="volnum" id= "volnum" autocomplete="off"  value="${task.vol}" class="layui-input" >
										      	--%><div id="example-22" class="example">
														<div id="rating-22"></div>
														<!-- <div id="result-22"></div> -->
														<!-- <div id="currentval-22"></div>
														<div class="clearfix"></div> -->
													</div>
										      	</div>
										      	<div class="layui-inline"> 
										      		<div id="currentval-22"></div>
										      	</div>
										      <!-- 	<div class="layui-inline"> 
										      		<button type="button" class="layui-btn  layui-btn-normal demo-active" data-type="volsubmit">提交</button> 
										      	</div> -->
										 </div>
										 <div  id= "typename" name="typename" style="height: auto; display:none;">
										      	<input type="radio"  lay-filter="typeset"  name="0" id="0" value="0" title="顺序播放"<c:if test="${task.tasktype == 0}"> checked </c:if>>
											    <input type="radio"  lay-filter="typeset"  name="0" id="0" value="1" title="循环播放"<c:if test="${task.tasktype == 1}"> checked </c:if>>
											    <input type="radio"  lay-filter="typeset"  name="0" id="0" value="2" title="随机播放"<c:if test="${task.tasktype == 2}"> checked </c:if>>
												<input type="radio"  lay-filter="typeset"  name="0" id="0" value="3" title="单曲循环"<c:if test="${task.tasktype == 3}"> checked </c:if>>
										</div>
						</form>
								</div>
							<div class="layui-form-item" id="divcss5" <c:if test="${(task.multiCastType != '文件广播' && task.multiCastType != '定时广播')||task.multiCastType == ''}">style="display:none;"</c:if>>
								<div class="layui-inline"> 
								        <button class="layui-btn  layui-btn layui-btn-radius" onclick="prev('${task.taskid}');"  title="上一曲"><i class="layui-icon">&#xe65a;</i></button>
								</div>	
								<div class="layui-inline" id="resume" style="display:none;"> 
								        <button class="layui-btn  layui-btn layui-btn-radius" onclick="play('${task.taskid}','1');"  title="播放">&nbsp;<i class="layui-icon">&#xe652;</i></button>
								</div>	
								<div class="layui-inline" id="pause" style="display:none;"> 
								        <button class="layui-btn  layui-btn layui-btn-radius" onclick="play('${task.taskid}','0');"  title="暂停">&nbsp;<i class="layui-icon">&#xe651;</i></button>
								</div>	
								<div class="layui-inline">        
								        <button class="layui-btn  layui-btn layui-btn-radius" onclick="next('${task.taskid}');"  title="下一曲">&nbsp;&nbsp;<i class="layui-icon">&#xe65b;</i></button>
								</div>	
							</div>
						<!-- <div class="m-content">
						</div> -->
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
	<script src="static/layuiadmin/layui/layui.js" charset="utf-8"></script>
	<script type="text/javascript">
		$(top.hangge());
	  	var taskType = document.getElementById("taskType").value;//广播类型
	    var playtime = document.getElementById("playtime")?document.getElementById("playtime").value:"0";//正在播放的时间点
	    var musictime = document.getElementById("musictime")?document.getElementById("musictime").value:"0";//音频总时长
	    var taskid = document.getElementById("taskid").value;//广播编号
	    var statu = "on";//页面状态
	  	var isStop = document.getElementById("isstop").value;//页面状态
	  	var error = document.getElementById("error").value;//错误信息
	    var reload = 0;
	  	//var id;
	    var startTime = new Date().getTime();
	    var count = 0;
		function play(taskid,commd){<%-- 
			window.location.href="<%=basePath%>taskmanage/toplay.do?taskid="+taskid+"&commd="+commd; --%>
			$.post("<%=basePath%>taskmanage/toplay.do",{taskid:taskid,commd:commd},function(data){
				if(data.result=="success"){
					if(commd == 0){
						layer.msg('暂停成功!', {
				            offset: '6px'
				          });
						isStop = 'true';
						$("#pause").hide();
						$("#resume").show();
					}else if(commd == 1){
						layer.msg('继续播放', {
				            offset: '6px'
				          });
						isStop = 'false';
						count = -1;
						reload = 0;
						startTime = new Date().getTime();//重置计时所需值
						setTimeout(fixed);//再次启用
						$("#resume").hide();
						$("#pause").show();
					}else{
						layer.msg('未知操作', {
				            offset: '6px'
				          });
					}
					return true;
				}else{
					layer.msg('操作失败！', {
			            offset: '6px'
			          });
					return false;
				}
			});
		}
		//上一曲
		function prev(taskid){
			setTimeout(100);
			var commd = 2;
			window.location.href="<%=basePath%>taskmanage/toplay.do?taskid="+taskid+"&commd="+commd;
		}
		//下一曲
		function next(taskid){
			setTimeout(100);
			var commd = 3;
			window.location.href="<%=basePath%>taskmanage/toplay.do?taskid="+taskid+"&commd="+commd;
		}
	    var tag = false,ox = 0,left = 0,bgleft = 0,flag = false,returntime;
	    $(function(){
	    	$('.text1').html(parseInt(musictime/60)+':'+parseInt(musictime%60));
			$("#voldiv").hide();
			$("#typename").hide();
			$("#alltype").show();
			playtime = parseInt(playtime);
		  	parse();
		  	//console.log(isStop);
			if(isStop == "false" && taskType != "实时采播"  && taskType != "终端采播"){//排除掉实时采播,终端采播
			  	//每1000毫秒调用一下parse()方法.
				setTimeout(fixed, 1000);
    			//id = setInterval("parse()",1000);
			}
			if(taskType == "实时采播" || taskType == "终端采播"){
				$("#alltype").hide();
				$("#voldiv").show();
				console.log(taskType);
			}
			if(error != null && error != ""){
				if(error == "notaskid"){
					layer.msg('请求失败！无此信息！', {
			            offset: '6px'
			          });
					return false;
				}else if(error == "end"){
					layer.msg('请求失败！任务已结束！', {
			            offset: '6px'
			          });
					return false;
				}
			}
	  	});
	    //音量调节代码
	    var defaultvol = ${task.vol};
	    $('#rating-22').slidy({
			maxval: 44, 
			interval: 1,
			defaultValue: defaultvol+4,
			finishedCallback:function (value){
				/* $('#result-22').html('You selected: ' + value); */
				if(value != defaultvol+4){
					var commd = 4;
	        		$.post("<%=basePath%>taskmanage/toplay.do",{taskid:taskid,commd:commd,renum:value-4},function(data){
						if(data.result=="success"){
							layer.msg('修改成功!', {
					            offset: '6px'
					          });
							defaultvol = value-4;
							return true;
						}else{
							layer.msg('修改失败！', {
					            offset: '6px'
					          });
							return false;
						}
					});
				}
			},
			moveCallback:function (value){
				$('#currentval-22').html('<strong>' + (value-4) + '</strong>');
			}
		});
	    //初始化
		$(function(){
			if(isStop == 'true'){
				$("#resume").show();
			}else{
				$("#pause").show();
			}
		    $('.progress_btn').mousedown(function(e) {//进度条拖动
	    	 if(statu == "off"){
	    		 reload = 2;
	    		/* clearInterval(id);  */
			     ox = e.pageX - parseInt((playtime-1)/musictime*500);
			     tag = true;
				//console.log(statu);
			     check();
	    	 }
		    });
		   });
		function parse(){
			if(parseInt(playtime) <= musictime){
				//console.log(vol);
				var left = playtime/musictime*500;
				$('.progress_btn').css('left', left);
			    $('.progress_bar').animate({width:left},500);
			    $('.text').html(parseInt(playtime/60)+':'+parseInt(playtime%60));
			    playtime++;
			}else if(reload == 1){
				window.location.href="<%=basePath%>taskmanage/taskcontroller.do?taskid="+taskid;
			}else{
				reload++;
			}
			//console.log(playtime);
			//console.log(musictime);
			//console.log(test);
			//console.log(taskid);
			//console.log(statu);
		}
		function fixed() {
			if(isStop == 'false'){
			    count++;
			    var offset = new Date().getTime() - (startTime + count * 1000);
			    var nextTime = 1000 - offset;
			    if (nextTime < 0) nextTime = 0;
			    if(reload < 2){
			    	setTimeout(fixed, nextTime);
			    	parse();
			    	//console.log(new Date().getTime() - (startTime + count * 1000));
			    }
			}
		}
		function point(taskid,returntime){
			<%-- window.location.href="<%=basePath%>taskmanage/toplay.do?taskid="+taskid+"&renum="+returntime; --%>
			$.post("<%=basePath%>taskmanage/toplay.do",{taskid:taskid,renum:returntime},function(data){
				if(data.result=="success"){
					layer.msg('修改成功!', {
			            offset: '6px'
			          });
					playtime = returntime;
					count = -1;
					reload = 0;
					startTime = new Date().getTime();//重置计时所需值
					fixed();//再次启用计时
	    			return true;
				}else{
					layer.msg('修改失败！刷新页面检查任务是否失效', {
			            offset: '6px'
			          });
					return false;
				}
			});
		}
		
		 layui.use(['form', 'layedit', 'laydate'], function(){
			 	var $ = layui.$
         		,form = layui.form
                ,layer = layui.layer
                ,layedit = layui.layedit;
		        var element = layui.element;
			    form.render(null, 'group');
			    /* 监听指定开关 */
			    /* form.on('radio(switchTest)', function(data){
			    	statu = 'off';
			    	layer.msg((this.checked ? '现在可以对音频进度条进行修改' : '现在禁止对音频进度条进行修改'), {
			            offset: '6px'
			          });
			    }); */
			    form.on('radio(radioall)', function(data){
			    	if(data.value == "vol"){
			    		statu = 'on';
			    		if(reload == 2){
			    			reload = 0;
			    			fixed();
			    		}
					    $("#voldiv").show();
			    		$("#typename").hide();
				    	layer.msg((this.checked ? '现在可以对音量进行修改' : '现在禁止对音量进行修改'), {
				            offset: '6px'
				          });
			    	}else if(data.value == "type"){
			    		statu = 'on';
			    		if(reload == 2){
			    			reload = 0;
			    			fixed();
			    		}
					    $("#typename").show();
			    		$("#voldiv").hide();
				    	layer.msg((this.checked ? '现在可以对广播类型进行修改' : '现在禁止对广播类型进行修改'), {
				            offset: '6px'
				          });
			    	}else if(data.value == "point"){
			    		statu = 'off';
			    		$("#voldiv").hide();
			    		$("#typename").hide();
				    	layer.msg((this.checked ? '现在可以对音频进度条进行修改' : '现在禁止对音频进度条进行修改'), {
				            offset: '6px'
				          });
			    	}
			    });
			    form.on('radio(typeset)', function(data){//广播类型修改
	        		var commd = 5;
			    	var typeset;
			    	if(data.value == "0"){
			    		typeset = 0;
			    	}else if(data.value == "1"){
			    		typeset = 1;
			    	}else if(data.value == "2"){
			    		typeset = 2;
			    	}else if(data.value == "3"){
			    		typeset = 3;
			    	}else{
			    		return;
			    	}
			    	$.post("<%=basePath%>taskmanage/toplay.do",{taskid:taskid,commd:commd,renum:typeset},function(data){
						if(data.result=="success"){
							layer.msg('修改成功!', {
					            offset: '6px'
					          });
							return true;
						}else{
							layer.msg('修改失败！', {
					            offset: '6px'
					          });
							return false;
						}
					});
	    			<%-- window.location.href="<%=basePath%>taskmanage/toplay.do?taskid="+taskid+"&commd="+commd+"&renum="+typeset; --%>
			    });
		        <%-- var active = {
		        		volsubmit: function(){
		        			var vol = $("#volnum").val();
		    	        	if(vol > 40 || vol < 0 ){
		    	        		layer.msg(('请输入正确的音量值'), {
		    			            offset: '6px'
		    			          });
		    	        	}else{
		    	        		var commd = 4;
		    	        		$.post("<%=basePath%>taskmanage/toplay.do",{taskid:taskid,commd:commd,renum:vol},function(data){
		    						if(data.result=="success"){
		    							layer.msg('修改成功!', {
		    					            offset: '6px'
		    					          });
		    							return true;
		    						}else{
		    							layer.msg('修改失败！', {
		    					            offset: '6px'
		    					          });
		    							return false;
		    						}
		    					});
		    	    			window.location.href="<%=basePath%>taskmanage/toplay.do?taskid="+taskid+"&commd="+commd+"&renum="+vol;
		    	        	}
		    	        }	
		        }; --%>
		        $('.demo-active').on('click', function () {
		            var type = $(this).data('type');
		            active[type] ? active[type].call(this) : '';
		        });
		    }); 
		function check() {
			//console.log(statu);
			    $(document).mouseup(function() {
					if(statu == "off"){
					     tag = false;
					     if(flag){//拖动播放
					    	 flag =false;
					    	 point(taskid,returntime);
					     }
					}
			    });
			    $('.progress').mousemove(function(e) {//鼠标移动
				     if (tag && statu == "off") {
				    	 //console.log(e.pageX);
				    	 //console.log(ox);
				      left = e.pageX - ox;
				      if (left <= 0) {
				       left = 0;
				      }else if (left > 500) {
				       left = 500;
				      }
				      //console.log(left);
				      $('.progress_btn').css('left', left);
				      $('.progress_bar').width(left);
				      returntime = left*musictime/500;
				      $('.text').html(parseInt(returntime/60)+':'+parseInt(returntime%60));
				      window.getSelection() ? window.getSelection().removeAllRanges() : document.selection.empty();
				      flag = true;
				    }
			    });
			    $('.progress_bg').click(function(e) {//鼠标点击
			     if (!tag && statu == "off") {
			    	 //clearInterval(id);
			      bgleft = $('.progress_bg').offset().left;
			      left = e.pageX - bgleft;
			      if (left <= 0) {
			       left = 0;
			      }else if (left > 500) {
			       left = 500;
			      }
			      $('.progress_btn').css('left', left);
			      $('.progress_bar').animate({width:left},500);
			      returntime = left*musictime/500;
			      $('.text').html(parseInt(returntime/60)+':'+parseInt(returntime%60));
			      //console.log("URL2");
			      point(taskid,returntime);
			     }
			    });
		}
	  	
	</script>
</body>
</html>