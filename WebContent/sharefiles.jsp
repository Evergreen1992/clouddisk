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
<title>我分享的文件</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript">
	$(function(){
		$.ajax({  
			type:'post',      
			url:'<%=basePath %>share!listShareFiles.action',  
			cache:false,  
			dataType:'text',  
			success:function(data){  
				var obj = eval("(" + data + ")");
				var html = "";
				$(obj).each(function(index, item){
					html += "<tr>";
					html += "<td>" + item.name + "</td>";
					//
					if( item.type == 0){
						html += "<td style='color:green;'>" + "公开文件" + "</td>";
						html += "<td >" + " - " + "</td>";
					}else{
						html += "<td style='color:red;'>" + "加密文件" + "</td>";
						html += "<td>" + item.pwd + "</td>";
					}
					
					html += "<td>" + item.zan + "</td>";
					html += "<td>" + item.cai + "</td>";
					html += "<td>" + item.viewcount + "</td>";
					html += "<td>" + item.date + "</td>";
					html += "<td>" + "<a target='_blank' href='share!getShareFiles.action?shareId=" + item.id + "'>查看</a>" + "</td>";
					html += "<td><a class='shareitem' href='#' id='" + item.id + "'>取消共享</a></td>";
					html += "</tr>";
				});
				$("#table").append(html);
			}  
		}); 	
		
		$(document).on("click", ".shareitem", function(){
			var id = $(this).attr("id")
			$.ajax({  
				type:'post',      
				url:'<%=basePath %>share!delete.action?id=' + id,  
				cache:false,  
				dataType:'text',  
				success:function(data){  
					if( data == "true"){
						location.reload()
					}else{
						alert("取消失败")
					}
				}  
			}); 	
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
						<span style='font-size:15px;'> - 我的分享</span>
					</form>
			</div>
		</div>
		
		
		<center>
			<div style="background:url(images/bg.jpg);margin-top:20px;" id="sharefilePanel">
				<table class="table table-bordered" id="table" style="text-align:center;">
					<tr class="info">
						<td>文件名</td>
						<td>分享类型</td>
						<td>访问密码</td>
						<td>赞</td>
						<td>踩</td>
						<td>浏览量</td>
						<td>分享时间</td>
						<td>查看</td>
						<td>操作</td>
					</tr>
				</table>
			</div>
		</center>
	</div>
</body>
</html>