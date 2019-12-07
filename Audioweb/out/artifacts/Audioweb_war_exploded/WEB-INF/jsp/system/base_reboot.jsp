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
					<form  action="system/${MSG}.do" name="taskForm" id="taskForm" method="post" class="layui-form layui-form-pane">
							<div class="layui-form-item " >
						          	<label class="layui-form-label"   style="width: 200px;">任务名称</label>
							         <div class="layui-input-inline">
											<input type="text" name="TaskName" value="终端重启任务" readonly="readonly" placeholder="任务名称" id="TaskName">
									</div>
							</div>
							 <c:if test="${MSG == 'edit' || MSG == 'read'}">
							    <div class="layui-form-item">
							        <label class="layui-form-label">任务类型</label>
										<div class="layui-input-block">
										      <input type="radio"  lay-filter="r-sel"  name="0" id="0" value="1" title="每日任务" <c:if test="${String.valueOf(pd.Weeks.charAt(0)) == '1'}"> checked </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
										      <input type="radio"  lay-filter="r-sel"  name="0" id="0" value="0" title="每周任务" <c:if test="${String.valueOf(pd.Weeks.charAt(0)) == '0'}"> checked </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
									    </div>
							   </div>
							   <div class="layui-form-item " id="week" pane="" <c:if test="${String.valueOf(pd.Weeks.charAt(0)) == '1'}"> style = "display:none;" </c:if>>
						        <label class="layui-form-label">每周安排</label>
						        <div class="layui-input-block">
						            <input type="checkbox"  name="1" id="1" lay-skin="primary" title="周一" <c:if test="${String.valueOf(pd.Weeks.charAt(1)) == '1'}">  checked </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
						            <input type="checkbox"  name="2" id="2" lay-skin="primary" title="周二" <c:if test="${String.valueOf(pd.Weeks.charAt(2)) == '1'}">  checked </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
						            <input type="checkbox"  name="3" id="3" lay-skin="primary" title="周三" <c:if test="${String.valueOf(pd.Weeks.charAt(3)) == '1'}">  checked </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
						            <input type="checkbox"  name="4" id="4" lay-skin="primary" title="周四" <c:if test="${String.valueOf(pd.Weeks.charAt(4)) == '1'}">  checked </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
						            <input type="checkbox"  name="5" id="5" lay-skin="primary" title="周五" <c:if test="${String.valueOf(pd.Weeks.charAt(5)) == '1'}">  checked </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
						            <input type="checkbox"  name="6" id="6" lay-skin="primary" title="周六" <c:if test="${String.valueOf(pd.Weeks.charAt(6)) == '1'}">  checked </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
						            <input type="checkbox"  name="7" id="7" lay-skin="primary" title="周日" <c:if test="${String.valueOf(pd.Weeks.charAt(7)) == '1'}">  checked </c:if><c:if test="${MSG == 'read'}"> disabled </c:if>>
						        </div>
						    </div>
						   </c:if>
						    <c:if test="${MSG == 'add'}">
							   <div class="layui-form-item">
							        <label class="layui-form-label">任务类型</label>
										<div class="layui-input-block">
										      <input type="radio"  lay-filter="r-sel" name="0" id="0" value="1" title="每日任务" checked>
										      <input type="radio"  lay-filter="r-sel" name="0" id="0" value="0" title="每周任务"  >
									    </div>
							   </div>
							   <div class="layui-form-item " id="week" pane="" style = "display:none;">
						        <label class="layui-form-label">每周安排</label>
						        <div class="layui-input-block">
						            <input type="checkbox"  name="1" id="1" lay-skin="primary" title="周一" checked>
						            <input type="checkbox"  name="2" id="2" lay-skin="primary" title="周二" checked>
						            <input type="checkbox"  name="3" id="3" lay-skin="primary" title="周三" checked>
						            <input type="checkbox"  name="4" id="4" lay-skin="primary" title="周四" checked>
						            <input type="checkbox"  name="5" id="5" lay-skin="primary" title="周五" checked>
						            <input type="checkbox"  name="6" id="6" lay-skin="primary" title="周六" checked>
						            <input type="checkbox"  name="7" id="7" lay-skin="primary" title="周日" checked>
						        </div>
						    </div>
						   </c:if>
						     <c:if test="${MSG == 'read'}">
							   <div class="layui-form-item " >
							          	<label class="layui-form-label"   style="width: 200px;">下次运行时间</label>
								         <div class="layui-input-inline">
									         <div class="layui-form-label"   style="width: 200px;">
													<fmt:formatDate value="${pd.nextTime}" pattern="yyyy-MM-dd HH:mm:ss" />
											</div>
										</div>
								</div>
							 </c:if>
								<div class="layui-card">
						          <div class="layui-card-header">具体重启时间</div>
							          <div class="layui-card-body">
					                <table class="layui-table" id="table"  name="table" lay-filter="table">
					                  <thead><tr>
					                    <th>时间</th>
					                    <c:if test="${MSG != 'read'}"><th>操作</th></c:if>
					                  </tr></thead>
					                  <tbody id="test-upload-demoList">
					                  	<tr>
											<td><input type="text" class="layui-input " <c:if test="${MSG != 'read'}">id="date_0"</c:if> value = "${pd.ExecDate_0}"<c:if test="${MSG == 'read'}"> readonly="readonly" </c:if>></td>
											<c:if test="${MSG != 'read'}">
												<td>
													<a class="layui-btn layui-btn-xs add">添加</a>
												</td>
											 </c:if>
										</tr>
					                  </tbody>
					                </table>
					              </div>
								</div>
						<%-- <c:if test="${MSG=='edit' }">
								<div class="layui-card">
						          <div class="layui-card-header">具体重启时间</div>
							          <div class="layui-card-body">
					                <table class="layui-table" id="table"  name="table" lay-filter="table">
					                  <thead><tr>
					                    <th>时间</th>
					                    <th>操作</th>
					                  </tr></thead>
					                  <tbody id="test-upload-demoList">
					                  	<tr>
											<td><input type="text" class="layui-input dateInput" id="date_0" value = "${pd.ExecDate_0}"></td>
											<td>
												<a class="layui-btn layui-btn-xs add">添加</a>
											</td>
										</tr>
									<c:choose>
									<c:when test="${not empty exectime}">
									<c:forEach items="${exectime}" var="time" varStatus="vs">
											<tr>
											<td><input type="text" class="layui-input dateInput" id="date_'${stauts.count}'" value = "${time}"></td>
											<td>
												<a  class="layui-btn layui-btn-danger layui-btn-xs delete" onclick="del('${stauts.count}');" >删除</a>
											</td>
										</tr>
									</c:forEach>
									</c:when>
									</c:choose>
					                  </tbody>
					                </table>
					              </div>
								</div>
						</c:if> --%>
						</form>
						</div>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
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
	<script type="text/javascript">  
    var array = new Array();  
    //console.info("info");  
  		<c:choose>
			<c:when test="${not empty pd.exectime}">
			    <c:forEach items="${pd.exectime}" var="item" varStatus="status" >  
			        array.push("${item}");
			    </c:forEach>  
		    </c:when>
		</c:choose>
	</script>  
<!--layui-->
	 <script src="static/layuiadmin/layui/layui.all.js" charset="utf-8"></script>
	<script type="text/javascript">
		$(top.hangge());
		var idNum  = 0;
		var type  = '${MSG}';
	 layui.use(['form', 'layedit', 'laydate', 'table'], function(){
        var form = layui.form
                ,layer = layui.layer
                ,laydate = layui.laydate;
        var table = layui.table;
		//日期选择
		//原有表格日期渲染
	    laydate.render({
	        elem: '#date_0'
	        ,trigger: 'click' //采用click弹出
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
		function closes(){
			var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
			/* console.info(index); */
			parent.layer.close(index); // 关闭layer
		}
		//随机数生成
		$('body').on('click', '.add', function() {
			addtime("");
		});
		layui.layer.ready(function(){
			layer.msg('在设置重启任务时最好在没有任务的时间段生效', {
	            offset: '6px'
	          });
			var num = '${pd.times}';
			if(!num){
				return;
			}
			if(num > 1 && array.length >0){
			    for(var i=0;i<array.length;i++){  
			    	addtime(array[i]);  
			    }     
			}
		});
		// 创建删除函数
		function del(trId){
			//table.deleteRow(trId);
			$('#row'+trId).remove();
		}
		//返回
		function goback(){
			var trList= $("#table").find("tr");
			var from =$("#taskForm").serializeArray();
			JSON.stringify(from);
			for(var i=1;i<trList.length;i++) {
				if($(trList[i]).find("input[type='text']")){
					var codelist=$(trList[i]).find("td:eq(0)").children();
					for(var j=0;j<codelist.length;j++){
						var codeId=!$(codelist[j]).attr('id')?'0':$(codelist[j]).attr('id');
						var val = $("input#"+codeId).val();  
						if(val == '' || val == null){
							return null;
						}
						var res = {
								name:codeId,
								value:val
						}
						from.push(res);
					}
				}
			}
			//console.info(trList);
			return from;
		}
		function addtime(value){
			idNum++;
			var html ;
			if(type != "read")
				html = '<tr id="row'+idNum+'">'+
			    '	<td><input type="text" class="layui-input dateInput" id="date_'+idNum+'" value="'+value+'"></td>'+
			    '	<td>'+
			    '		<a  class="layui-btn layui-btn-danger layui-btn-xs delete" onclick="del('+idNum+');" >删除</a>'+
			    '	</td>'+
			    '</tr>';
		    else
		    	html = '<tr id="row'+idNum+'">'+
			    '	<td><input type="text" class="layui-input" value="'+value+'" readonly="readonly" ></td>'+
			    '</tr>';
		    $(html).appendTo($('#table tbody:last'));
		    //重新渲染日期选择input，并指向添加的id
		    layui.laydate.render({
		        elem: '#date_'+idNum
		        ,trigger: 'click' //采用click弹出
		        ,type: 'time'
		    });
		}
	</script>
</body>
</html>