<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix ="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户中心</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript">
	$(function(){
		
	});
</script>

</head>
<body style="background:#ededf0">
	<div class="container-fluid"  style="height:94%;">
	
		<div class="bg-primary" style="width:100%;height:60px;argin-top:-2px;">
			<div class="bg-primary" style="width:100%;height:60px;argin-top:-2px;">
					<form class="navbar-form navbar-left"  >
						<span style='font-size:30px;'>网盘</span>
						<span style='font-size:15px;'> - 个人中心</span>
					</form>
			</div>
		</div>
		
		
		<center>
			<div style="width:650px;background:url(images/bg.jpg);margin-top:20px;" id="sharefilePanel">
				<h2>个人中心</h2>
				<br>
				<img alt="" src="head/head1.jpg" style="border:2px solod #000000">
				<br><br>
				我的等级:
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				14
				<br><br>
				内存容量:    100M/2018M
				
			<br>
			<br>
			<br>
		</center>
	</div>
</body>
</html>