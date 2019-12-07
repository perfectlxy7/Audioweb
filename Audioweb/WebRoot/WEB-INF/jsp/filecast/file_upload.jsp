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
	<!-- layui -->
 <link rel="stylesheet" href="static/layuiadmin/layui/css/layui.css">
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="layui-row layui-col-space15">
				<div class="page-header">
					<h1><small><i class="ace-icon fa fa-angle-double-right"></i>
						上传文件</small></h1>
				</div>
				 <div class="layui-col-md12">
			        <div class="layui-card">
			          <div class="layui-card-header">上传列表</div>
			          <div class="layui-card-body">
			            <div class="layui-upload">
			            <div class="layui-btn-group" style="margin-bottom: 10px;">
			              <button type="button" class="layui-btn layui-btn-reload" data-type="reload">重载页面</button>
			              <button type="button" class="layui-btn layui-btn-normal" id="test-upload-testList">选择音频文件</button>
			              <button type="button" class="layui-btn" id="test-upload-testListAction">开始上传</button> 
			             </div>
			              <div class="layui-upload-list">
			                <table class="layui-table">
			                  <thead>
			                    <tr><th>文件名</th>
			                    <th>大小</th>
			                    <th>状态</th>
			                    <th>操作</th>
			                  </tr></thead>
			                  <tbody id="test-upload-demoList"></tbody>
			                </table>
			              </div>
			            </div> 
			          </div>
			        </div>
			      </div>
			      <div class="layui-col-md12">
			        <div class="layui-card">
			          <div class="layui-card-header">音频数据</div>
			          <div class="layui-card-body">
			          	<div class="layui-btn-group test-table-operate-btn" style="margin-bottom: 10px;">
			              <button class="layui-btn layui-btn-danger" data-type="getCheckData">批量删除</button><!-- 
			              <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
			              <button class="layui-btn" data-type="isAll">验证是否全选</button> -->
			            </div>
			            
			            <table class="layui-hide" id="test-table-operate" lay-filter="test-table-operate"></table>
							<!-- <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
              				<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a> -->
			            <script type="text/html" id="test-table-operate-barDemo">
              				<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            			</script>
			          </div>
			        </div>
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
	<!--layui-->
	<script src="static/layuiadmin/layui/layui.js" charset="utf-8"></script>
		<!--引入弹窗组件end-->
	<!-- inline scripts related to this page -->
	<script type="text/javascript">
	layui.use(['form','upload','table'], function(){
        var form = layui.form
       		,layer = layui.layer
            ,upload = layui.upload;
			//按钮监听
		  top.hangge();
	      var $ = layui.$, active = {
	        getCheckData: function(){ //获取选中数据 并批量删除
	          var checkStatus = table.checkStatus('test-table-operate')
	          ,data = checkStatus.data,filenames = '',i;
	         layer.confirm("确定要删除选中的音频么?", {
				  btn: ['确定','取消'] //按钮
				  ,anim: 6 
				  ,icon: 8
				}, function() {
		          if(data.length > 0){
			        	for(i=data.length-1;i>=0;i--){
			        		filenames += data[i].fileName+"//";
			        	} 
			        	filenames.substring(0, filenames.lastIndexOf('//'));  
		        		$.post("<%=basePath%>filecast/deleteAll.do",{filenames:filenames},function(data){
							if(data.result=="success"){
								if(data.failnames != null &&  data.failnames != ''){
									layer.msg(data.failnames+'删除失败，请检查音频信息是否正确', {
							            offset: '6px'
							          });
								}else
								layer.msg('删除成功!', {
						            offset: '6px'
						          });
								active2.reload();
								return true;
							}else{
								layer.msg('删除失败！', {
						            offset: '6px'
						          });
								return false;
							}
						});
		          }else{
		        	  layer.msg('无法删除，未选择任何音频！',{//
							title: '警告'
							,icon: 2
						});
		          }
				});
	        }
	       /*  ,getCheckLength: function(){ //获取选中数目
	          var checkStatus = table.checkStatus('test-table-operate')
	          ,data = checkStatus.data;
	          layer.msg('选中了：'+ data.length + ' 个');
	        }
	        ,isAll: function(){ //验证是否全选
	          var checkStatus = table.checkStatus('test-table-operate');
	          layer.msg(checkStatus.isAll ? '全选': '未全选')
	        } */
	      },
	      active2={
    		  reload: function(){
    	  	        var demoReload = $('#test-table-operate');
    	  	        //console.log("reload");
    	  	        //执行重载
    	  	        table.reload('test-table-operate', {
    	  	          where: {
    	  	            key: {
    	  	              id: demoReload.val()
    	  	            }
    	  	          }
    	  	        });
    	  	     }		
		  };
	      
	      $('.test-table-operate-btn .layui-btn').on('click', function(){
	        var type = $(this).data('type');
	        active[type] ? active[type].call(this) : '';
	      }); 
	      $('.layui-btn-reload').on('click', function(){
		        var type = $(this).data('type');
		        active2[type] ? active2[type].call(this) : '';
		      }); 
      //多文件列表示例
        var demoListView = $('#test-upload-demoList')
        ,uploadListIns = upload.render({
          elem: '#test-upload-testList'
          ,url: 'filecast/addfiles'
          ,accept: 'file'
          ,multiple: true
          ,auto: false
          ,bindAction: '#test-upload-testListAction'
          ,choose: function(obj){   
            var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
            //读取本地文件
            obj.preview(function(index, file, result){
              var tr = $(['<tr id="upload-'+ index +'">'
                ,'<td>'+ file.name +'</td>'
                ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
                ,'<td>等待上传</td>'
                ,'<td>'
                  ,'<button class="layui-btn layui-btn-mini test-upload-demo-reload layui-hide">重传</button>'
                  ,'<button class="layui-btn layui-btn-mini layui-btn-danger test-upload-demo-delete">删除</button>'
                ,'</td>'
              ,'</tr>'].join(''));
              
              //单个重传
              tr.find('.test-upload-demo-reload').on('click', function(){
                obj.upload(index, file);
              });
              
              //删除
              tr.find('.test-upload-demo-delete').on('click', function(){
                delete files[index]; //删除对应的文件
                tr.remove();
                uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
              });
              
              demoListView.append(tr);
            });
          }
          ,done: function(res, index, upload){
            if(res.result == "success" && res.code == 0){ //上传成功
              var tr = demoListView.find('tr#upload-'+ index)
              ,tds = tr.children();
              tds.eq(2).html('<span style="color: #5FB878;">上传成功!</span>');
              tds.eq(3).html(''); //清空操作
              active2.reload();
              return delete this.files[index]; //删除文件队列已经上传成功的文件
            }else if(res.result == "success" &&res.code == -1){
            	var tr = demoListView.find('tr#upload-'+ index)
                ,tds = tr.children();
                tds.eq(2).html('<span style="color: #FF5722;">格式不符!</span>');
                tds.eq(3).html(''); //清空操作
                return delete this.files[index]; //删除文件队列已经上传成功的文件
            }else if(res.result == "success" &&res.code == 1){
            	var tr = demoListView.find('tr#upload-'+ index)
                ,tds = tr.children();
                tds.eq(2).html('<span style="color: #FF5722;">编码率不符!</span>');
                tds.eq(3).html(''); //清空操作
                return delete this.files[index]; //删除文件队列已经上传成功的文件
            }else if(res.result == "success" &&res.code == 1){
            	var tr = demoListView.find('tr#upload-'+ index)
                ,tds = tr.children();
                tds.eq(2).html('<span style="color: #FF5722;">上传出错!</span>');
                tds.eq(3).find('.test-upload-demo-reload').removeClass('layui-hide'); //显示重传
                return;
            }else
            	this.error(index, upload);
          }
          ,error: function(index, upload){
            var tr = demoListView.find('tr#upload-'+ index)
            ,tds = tr.children();
            tds.eq(2).html('<span style="color: #FF5722;">上传失败!</span>');
            tds.eq(3).find('.test-upload-demo-reload').removeClass('layui-hide'); //显示重传
          }
        });
	    //音频数据表格信息
        var table = layui.table;
	    table.render({
	        elem: '#test-table-operate'
	        ,url: 'filecast/listfiles'
	        ,cellMinWidth: 80
	        ,cols: [[
	          {type:'checkbox', fixed: 'left'}
	          /* ,{field:'id', width:80, title: '序号', sort: true, fixed: 'left'} */
	          ,{field:'fileName',  title: '文件名',fixed: 'left', sort: true}
	          ,{field:'timeSize',  title: '时长', sort: true}
	          ,{field:'fileSize',  title: '文件大小'}
	          ,{field:'bitRate', title: '比特率', sort: true}
	          ,{field:'sampleRate', title: '采样率', sort: true}
	          ,{field:'channels', title: '音频类型'}
	          ,{align:'center', fixed: 'right', toolbar: '#test-table-operate-barDemo'}
	        ]]
	        ,page: true 
	      });
	      
	      //监听表格复选框选择
	      table.on('checkbox(test-table-operate)', function(obj){
	        console.log(obj)
	      });
	      //监听工具条
	      table.on('tool(test-table-operate)', function(obj){
	        var data = obj.data;
	        if(obj.event === 'detail'){
		        layer.msg('fileName：'+ data.fileName + ' 的查看操作');
	        } else if(obj.event === 'del'){
	        	var indexconfirm = layer.confirm("确定要删除此音频么?", {
	  			  btn: ['确定','取消'] //按钮
	  			  ,icon: 3
	  			  ,anim: 6
	  			}, function(){
	  				$.post("<%=basePath%>filecast/deletefile.do",{filename:data.fileName},function(data){
						console.log(data);
						if(data.result=="success"){
							layer.msg('执行成功！');
				            obj.del();
						}else{
							layer.msg('执行失败！请刷新页面或确认任务信息！');
						}
			            layer.close(indexconfirm);
					});
	          });
	        } else if(obj.event === 'edit'){
	          layer.alert('编辑行：<br>'+ JSON.stringify(data))
	        }
	      });
    });
	</script>
</body>
</html>