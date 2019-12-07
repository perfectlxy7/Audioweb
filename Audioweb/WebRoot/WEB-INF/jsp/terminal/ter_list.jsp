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
 <link rel="stylesheet" href="static/layuiadmin/layui/css/layui.css">
	<script type="text/javascript">
	</script>
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
									<c:if test="${pd.term=='' }">所有</c:if>
									<c:if test="${pd.term!='' }">${pd.term.domainName} </c:if>
									&nbsp;终端列表
								</small>																					
								
									</h1>
							
                    </div>
                    <table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
									<span class="input-icon">
										<input class="nav-search-input" autocomplete="off" id="imeikey" type="text" style="vertical-align:top;width: 160px; height: 30px" name="imeikey" value="${pd.imeikey}" placeholder="输入终端名称或编号" />
										<i class="ace-icon fa fa-search nav-search-icon"></i>
									</span>
									</div>
								</td>
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								<td style="vertical-align:top;padding-left:2px"><a title="移动分区" class="btn btn-xs btn-light" onclick="editdomain('确定要移动所选终端的分区么?');" ><i class='ace-icon fa fa-share bigger-120'></i></a></td>								
							    <td style="vertical-align:top;padding-left:2px"><a title="批量删除" class="btn btn-xs btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a></td>								
								<td style="vertical-align:top; padding-left:12px">
										<a class="btn btn-xs btn-success" onclick="addterm('${pd.term.domainName} ');">新增</a>
								        <a class="btn btn-xs btn-success" onclick="addtermlist('${pd.term.domainName}');">批量新增</a>
								        <c:if test="${(pd.term.domainId != null && pd.term.domainId != '')||(pd.imeikey != null && pd.term.domainId != '')}"><a class="btn btn-xs btn-success" onclick="goback();">返回</a></c:if>
									</td>
							</tr>
						</table>
				<div class="row">
						<div class="col-xs-12">
					<form action="terminal/list.do" method="post" name="Form" id="Form">
						<input type="hidden" id="DomainId" name="DomainId" value="${pd.term.domainId}" />
						<input type="hidden" id="imeikey" name="imeikey" value="${pd.imeikey}" />
							   <table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
								<thead>
								  <tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
										<th class="center" >终端编号</th>
										<th class="center" >终端名称</th>
										<th class="center" >终端IP地址</th>
										<th class="center" >寻呼话筒</th>
										<th class="center" >自动采播</th>										
										<th class='center'>所属分区</th>
										<th class='center'>上次离线时间</th>
										<th class='center' >操作</th>
									</tr>
								</thead>

								<tbody>
								<c:choose>
									<c:when test="${not empty termList}">
									<c:forEach items="${termList}" var="term" varStatus="vs">
									<tr  ondblclick= "javascript:editterm('${term.TIDString }');">
										<td class='center' style="width: 30px;">
												<c:if test="${term.TIDString != pd.currenTid}"><label><input type='checkbox' name='ids' value="${term.TName}" id="${term.TIDString }"  class="ace"/><span class="lbl"></span></label></c:if>
												<c:if test="${term.TIDString  == pd.currentTid}"><label><input type='checkbox' disabled="disabled" class="ace" /><span class="lbl"></span></label></c:if>
											</td>

										<td class='center'>${term.TIDString}</td>
										<td class='center'>${term.TName}</td>
										<td class='center'>${term.TIP}</td>
										<td class='center'><c:if test="${term.ISCMIC}"><a type="button"  href="javascript:lookdomaininfo('${term.precinct}','${term.TName}');" title="查看管理分组" style='text-decoration:none;'><i class="layui-icon"  style="color:blue;" >&#xe60b;</i>查看</a></c:if><c:if test="${!term.ISCMIC}">否</c:if></td> 
										<td class='center'><c:if test="${term.ISAutoCast}"><a type="button"  href="javascript:lookdomaininfo('${term.precinct}','${term.TName}');" title="查看管理分组" style='text-decoration:none;'><i class="layui-icon"  style="color:blue;" >&#xe60b;</i>查看</a></c:if><c:if test="${!term.ISAutoCast}">否</c:if></td> 
										<td class='center'>${term.domainName}</td>
										<td align='center' style="width: auto;">
												<c:if test="${term.finalOfflineDate != null}"><fmt:formatDate value="${term.finalOfflineDate}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if> 
												<c:if test="${term.finalOfflineDate == null}">无</c:if> 
											</td>
										<td class='center'>
											<div class="hidden-sm hidden-xs action-buttons">
											
												<a class="green" href="javascript:editterm('${term.TIDString}');">
													<i class="ace-icon fa fa-pencil-square-o bigger-130" title="修改"></i>
												</a>
												<a class="red" href="javascript:delterm('${term.TIDString}','${term.TName}');">
													<i class="ace-icon fa fa-trash-o bigger-130" title="删除"></i>
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
												
												
														<li><a href="javascript:editterm('${term.TIDString }');" class="tooltip-success" data-rel="tooltip" title="Edit">
															<span class="green">
																<i class="ace-icon fa fa-pencil-square-o bigger-120" title="修改"></i>
															</span>
														</a></li>
														<li><a href="javascript:delterm('${term.TIDString }','${term.TName }');" class="tooltip-success" data-rel="tooltip" title="Delete">
															<span class="red"> 
																<i class="ace-icon fa fa-trash-o bigger-120"  title="删除"></i>
															</span>
														</a>
														</li>
														
														
													</ul>
												</div>
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
								</tbody>
							</table>
							<div class="page-header position-relative">
								<table style="width:100%;">
									<tr>
										<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
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
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
<!--layui-->
	<script src="static/layuiadmin/layui/layui.js" charset="utf-8"></script>
	<!-- inline scripts related to this page -->
	<script type="text/javascript">
	layui.use(['form', 'layer'], function(){
        var form = layui.form
                ,layer = layui.layer;
    });
		$(document).ready(function(){
			top.hangge();
			//复选框全选控制
	var active_class = 'active';
	$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
		var th_checked = this.checked;//checkbox inside "TH" table header
		$(this).closest('table').find('tbody > tr').each(function(){
			var row = this;
			if($(row).attr("disabled")!="disabled"){
				if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
				else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
			}
		});
	});
	
	
	
});	

      //返回
		function goback(){
			window.location.href="<%=basePath%>terminal/list.do";
		}
		//检索
		function tosearch(){
			var imeikey = "";
			 if (document.getElementById("imeikey").value != null && document.getElementById("imeikey").value != "")  {
				 imeikey = document.getElementById("imeikey").value;
			 }
			 var DomainId = document.getElementById("DomainId").value;
			layer.load();
			window.location.href="<%=basePath%>terminal/list.do?imeikey="+imeikey+"&DomainId="+DomainId;
		}
		//新增
		function addterm(DomainName){
			var DomainId = document.getElementById("DomainId").value;
			if(DomainName == null || DomainName == ""){
				DomainName = "";
			}
			layer.load();
			window.location.href="<%=basePath%>terminal/toAdd.do?DomainId="+DomainId+"&DomainName="+DomainName;
		};
		//批量新增
		function addtermlist(DomainName){
			var DomainId = document.getElementById("DomainId").value;
			if(DomainName == null || DomainName == ""){
				DomainName = "";
			}
			layer.load();
			window.location.href="<%=basePath%>terminal/toAddList.do?DomainId="+DomainId+"&DomainName="+DomainName;
		};

			//编辑
		function editterm(TIDString){
			layer.load();
			window.location.href="<%=basePath%>terminal/toEdit.do?TIDString="+TIDString;
		};
		//删除
		function delterm(TIDString,TName){
			var index = layer.confirm("确定删除此终端么", {
				btn: ['确定','取消'] //按钮
			  ,anim: 6 
			  ,icon: 8
			}, function() {
					var url = "<%=basePath%>terminal/delete.do?TIDString="+TIDString+"&TName="+TName;
					layer.load();
					$.get(url,function(data){
						layer.closeAll();
						if("success" == data.result){
							layer.msg('删除成功！', {
				            	icon :1
				            	,time:1000
				          	,end: function(){
				          		location.reload(true);
				          	}});
						}else if("false" == data.result){
							layer.msg("删除终端失败，请刷新重试",{icon: 2});
							layer.close(index);
						}
					});
			});
		}

		function makeAll(msg){
			layer.confirm(msg, {
				btn: ['确定','取消'] //按钮
			  ,anim: 6 
			  ,icon: 8
			}, function() {
					var tidstr = '';
					var tnamestr='';
					for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(tidstr=='') tidstr += document.getElementsByName('ids')[i].id;
						  	else tidstr += ',' + document.getElementsByName('ids')[i].id;
						  	if(tnamestr=='') tnamestr += document.getElementsByName('ids')[i].value;
						  	else tnamestr += ',' + document.getElementsByName('ids')[i].value;
						  }
					}
					if(tidstr==''){
						layer.msg('无法删除，未选择任何终端！',{//
							title: '提示'
							,icon: 2
							,time:1000
							,end: function() {
								layer.tips('点这里全选', '#zcheckbox',{
							          tips: [1,'#3595CC'],
										time:1000
						        });
							}
						});
						return;
					}else{
						layer.load();
						$.ajax({
							type: "POST",
							url: '<%=basePath%>terminal/deleteAllO.do?',
					    	data: {TIDStrings:tidstr,TNames:tnamestr},
							dataType:'json',
							//beforeSend: validateData,
							cache: false,
							success: function(data){
								layer.closeAll();
								layer.msg('删除成功！', {
					            	icon :1
					            	,time:1000
					          	,end: function(){
					          		location.reload(true);
					          	}});
							}
						});
				}
			});
		}	
		function lookdomaininfo(precinct,TName){
			layer.open({
			    type: 2,
			    title: '查看"'+TName+'"管理分组',
			    maxmin: true, 
			    btn: ['确定'],
			    btnAlign: 'c',
			    moveOut: true,
			    area: ['300px', '480px'],
			    content: "timedcast/finddomids.do?domidInfo="+precinct+"&statu="+"查看",
			    yes: function(index, layero){
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
		function editdomain(msg){
			layer.confirm(msg, {
				btn: ['确定','取消'] //按钮
			  ,anim: 6 
			  ,icon: 3
			}, function() {
				var tidstr = '';
				for(var i=0;i < document.getElementsByName('ids').length;i++)
				{
					  if(document.getElementsByName('ids')[i].checked){
					  	if(tidstr=='') tidstr += document.getElementsByName('ids')[i].id;
					  	else tidstr += ',' + document.getElementsByName('ids')[i].id;
					  }
				}
				if(tidstr==''){
					layer.msg('无法移动，未选择任何终端！',{//
						title: '警告'
						,time:1000
						,icon: 2
						,end: function() {
							layer.tips('点这里全选', '#zcheckbox',{
						          tips: [1,'#3595CC'],
									time:1000
					        });
						}
					});
					return;
				}else{
					layer.open({
					    type: 2,
					    title: '移动分组',
					    maxmin: true, 
					    btn: ['确定'],
					    btnAlign: 'c',
					    moveOut: true,
					    area: ['300px', '480px'],
					    content: "terminal/finddomids.do",
					    yes: function(index, layero){
	    			    	var body = layer.getChildFrame('body', index);
	    		            var iframeWin = window[layero.find('iframe')[0]['name']];//得到iframe页的窗口对象，执行iframe页的方法：
	    		            var ids = iframeWin.save();//调用子页面的方法，得到子页面返回的ids
	    		            if (!ids) {
	    		            	layer.msg("获取分区失败，请检查输入是否正确",{icon: 2});
	    				      }else{
  				    	  		var str = ids.split("//");
	    		            	//console.log(tidstr);
  				    	  		if(str.length > 1){
  									window.location.href="<%=basePath%>terminal/editdomain.do?domids="+str[0]+"&domainname="+str[1]+"&tids="+tidstr;
  				    	  		}else{
  		    		            	layer.msg("获取分区失败，请检查输入是否正确",{icon: 2});
  				    	  		}
	    				      }
	    			        //按钮【按钮一】的回调
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
			});
		}
	</script>


</body>
</html>