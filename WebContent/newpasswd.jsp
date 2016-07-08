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
<title>密码找回</title>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<link rel="stylesheet" href="css/bootstrap.min.css">

<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript">
	$(function(){
		$("#confirmChange").click(function(){
			alert(1)
		});
	});
</script>

</head>
<body style="background:#ededf0">
	<div class="container-fluid"  style="height:94%;">
	
		<div class="bg-primary" style="width:100%;height:60px;argin-top:-2px;">
			<div class="bg-primary" style="width:100%;height:60px;argin-top:-2px;">
					<form class="navbar-form navbar-left"  >
						<span style='font-size:30px;'>网盘</span>
					</form>
			</div>
		</div>
		
		<br><br><br><br>
		
		<form class="form-horizontal" >
			
		  <div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">用户名</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="name">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">注册邮箱</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" id="mail">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">新密码</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control" id="pwd1">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">密码确认</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control" id="pwd2">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-2 col-sm-10">
		      <button class="btn btn-default" id="confirmChange">确认修改</button>
		      <a href="login.html" class="btn btn-default">返回登录</a>
		    </div>
		  </div>
		  
		</form>
	</div>
</body>
</html>