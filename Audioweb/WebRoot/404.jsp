<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/static/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta charset="utf-8">
		  <title>404 页面不存在</title>
		  <meta name="renderer" content="webkit">
		  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
		  <link rel="stylesheet" href="<%=basePath%>/layuiadmin/layui/css/layui.css" media="all">
		  <link rel="stylesheet" href="<%=basePath%>/layuiadmin/style/admin.css" media="all">
	</head>
		 
<body>
	<div class="layui-fluid">
	  <div class="layadmin-tips">
	    <i class="layui-icon" face>&#xe664;</i>
	    <div class="layui-text">
	      <h1>
	        <span class="layui-anim layui-anim-loop layui-anim-">4</span> 
	        <span class="layui-anim layui-anim-loop layui-anim-rotate">0</span> 
	        <span class="layui-anim layui-anim-loop layui-anim-">4</span>
	      </h1>
	    </div>
	  </div>
	</div>
	 <script src="<%=basePath%>/layuiadmin/layui/layui.js"></script>  
  <script>
  layui.config({
    base: '<%=basePath%>/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index']);
  top.layui.layer.ready(function(){ 
  	top.layer.closeAll("loading");
  });
</script>
</body>
</html>