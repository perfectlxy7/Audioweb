<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <%@   page   import= "org.jaudiotagger.audio.mp3.MP3AudioHeader"%> --%>
<%-- <%@   page   import= "org.jaudiotagger.audio.mp3.MP3File"%> --%>
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
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
				<div class="col-xs-12 col-sm-6">
				<div class="page-header">
					<h1><small><i class="ace-icon fa fa-angle-double-right"></i>
						上传文件</small></h1>
				</div>
						<div class="col-xs-12">
						<form  action="filecast/addfile.do" name="Form" id="Form" method="post" class="form-horizontal" enctype="multipart/form-data">
									<table id="table_report" class="table table-striped table-bordered table-hover">
										<tr>
											<td style="width:90px;text-align: right;padding-top: 13px;">音频文件:</td>
											<td >
												<div>
<!-- 												<input type="hidden" id="filepath" />  -->
												<input type="file" id="file" name="file" accept="audio/mpeg"   /><!-- ,audio/ogg -->
												<audio id="audio" controls="" style="display: none;"></audio>
												</div>
												<a onclick="addfileinput(this);">添加文件</a>
											</td>
											<td style="width:100px;text-align: center;">
														<a class="btn btn-xs btn-primary" onclick="save();" >提交</a>&nbsp;&nbsp;&nbsp;
											</td>
										</tr>
									</table>
								</form>
								</div>
								</div>
<!-- 								</div> -->
<!-- 								<div class="row"> -->
								<div class="col-xs-12 col-sm-6">
								<div class="page-header">
									<h1><small><i class="ace-icon fa fa-angle-double-right"></i>
										文件管理</small></h1>
								</div>
								<div class="col-xs-12">
								<table id="table_filelist" class="table table-striped table-bordered table-hover">
										<c:choose>
									<c:when test="${not empty filelist}">
									<c:forEach items="${filelist}" var="filename" varStatus="vs">
									<tr>
											<td style="padding-top: 13px;">${filename}</td>
											<td class='center' >
											<div class="action-buttons">
												<a class="red" href="javascript:deletefile('${filename}');">
													<i class="ace-icon fa fa-trash-o bigger-130" title="删除"></i>
												</a>
											</div>
										</td>
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
						</div>
						<!-- /.col -->
						</div>
					</div>
					<!-- /.row -->
					
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 上传控件 -->
	<script src="static/ace/js/ace/elements.fileinput.js"></script>
	<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
	<!-- inline scripts related to this page -->
	<script type="text/javascript">
	$(function(){
		$(top.hangge());
		var msg = "${pd.msg}";
		if(msg=="success"){
			Dialog.alert("音频文件上传成功！");
		}else if(msg=="bitrateerror"){
			Dialog.alert("${pd.files}"+"音频比特率不符合或文件格式出错！请转码后重新上传");
		}else if(msg!=""){
			Dialog.alert(msg);
		}
			//上传
			$('#file').ace_file_input({
				no_file:'请选择文件...上传前需转码',
				btn_choose:'选择',
				btn_change:'更改',
				droppable:false,
				onchange:null,
				thumbnail:false, //| true | large
				allowExt: ['mp3']
// 				allowMime: ['audio/mpeg'] //html5 browsers only
			}).on('change', function (){
// 				fileBitRate(this);
        });
		});
		var i = 1;
		function addfileinput(obj){
			$(obj).prev().after("<div ><input type='file' id='file"+i+"' name='file' accept='audio/mpeg'  class='file' />"+
								"<audio id='audio"+i+"' controls='' style='display: none;'></audio><a onclick='this.parentNode.remove();'>删除</a></div>");
			$('#file'+i).ace_file_input({
				no_file:'请选择文件...上传前需转码',
				btn_choose:'选择',
				btn_change:'更改',
				droppable:false,
				onchange:null,
				thumbnail:false, //| true | large
				allowExt: ['mp3']
// 				allowMime: ['audio/mpeg'] //html5 browsers only
			}).on('change', function (){
// 				fileBitRate(this);
        });
			i=i+1;
		}

		//保存
		function save(){
			if($("#file").val()=="" || document.getElementById("file").files[0] =='请选择文件...上传前需转码'){
						$("#file").tips({
							side:3,
				            msg:'请选择音乐文件',
				            bg:'#AE81FF',
				            time:2
				        });
						return false;
			}
// 			for(var j=0;j<i-2;j++)
			$("#Form").submit();
// 			$("#zhongxin").hide();
// 			$("#zhongxin2").show();
		}
		function deletefile(filename){
			Dialog.confirm("确定要删除["+filename+"]吗?", function() {
				top.jzts();
				var url = "<%=basePath%>filecast/deletefile.do?filename="+filename;
				$.get(url,function(data){
					window.location.href ="<%=basePath%>filecast/toFileManage.do";
				});
		});
		}
	</script>
</body>
</html>