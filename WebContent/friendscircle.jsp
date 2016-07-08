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
<title>朋友圈</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript">
	$(function(){
		var name = "${sessionScope.loginUser.name }";
		$.ajax({  
			type:'post',      
			url:'shuoshuo!list.action',  
			data:'',  
			cache:false,  
			dataType:'text',  
			success:function(data){  
				var obj = eval("(" + data + ")");
				var html = "";
				$(obj).each(function(item, index){
					html += "<div style='width:630px;background-color:#337ab7;color:white;margin-left:10px;'>";
					html += "<div style=''>";
					html += "<img alt='' src='head/head1.jpg' style='width:80px;height:80px;border:1px solid #000000;'>"
					html += "<span style='margin-left:20px;'>" + index.username + "</span><br>"
					html += "<span style='margin-left:100px;'>" + index.date + "</span><br>";
					html += "</div>";
					html += "<span class='title'></span>";
					html += "<span class='content' style='text-align:left;'>" + index.content + "</span>";
					html += "<br><br>&nbsp;&nbsp;&nbsp;<a likes='" + index.likes + "' class='dianzan' href='javascript:void(0)' style='color:white;' id='" + index.id + "'><span class='glyphicon glyphicon-thumbs-up' aria-hidden='true'></span>&nbsp;赞(" + index.likes + ")</a><br><br>"
					html += "</div>";
					
					html += "<br>";
				});
				$("#contentList").append(html);
			}  
		});  
		
		//点赞
		$(document).on("click",".dianzan",function(){
			var id = $(this).attr("id");
			var likes = $(this).attr("likes") ;
			
			$.ajax({  
				type:'post',      
				url:'shuoshuo!zan.action?id=' + id,  
				data:'content=' + content,  
				cache:false,  
				dataType:'text',  
				success:function(data){ 
					if( data == "false"){
						alert("失败，请重试")
					}else if(data == "true"){
						location.reload();
						//$("#" + id).attr("likes",(parseInt(likes) + 1) + "");
					}
				}  
			});  
		});
		
		$("#postBtn").click(function(){
			var content = $("#content").val() ;
			if( content == null || content == ""){
				alert("内容不能为空")
				return ;
			}
			$.ajax({  
				type:'post',      
				url:'shuoshuo!create.action',  
				data:'content=' + content,  
				cache:false,  
				dataType:'text',  
				success:function(data){ 
					if( data == "true"){
						/* var data = new Date();
						var time = data.getTime() + ":" + data.getHours() + ":" + data.getMinutes(); 
						var html = "";
						html += "<div style='width:630px;background-color:#337ab7;color:white;margin-left:10px;'>";
						html += "<div style=''>";
						html += "<img alt='' src='head/head1.jpg' style='width:80px;height:80px;border:1px solid #000000;'>"
						html += "<span style='margin-left:20px;'>" + name + "</span><br>"
						html += "<span style='margin-left:100px;'>" + data.toLocaleDateString() + "</span><br>";
						html += "</div>";
						html += "<span class='title'></span>";
						html += "<span class='content' style='text-align:left;'>" + content + "</span>";
						html += "</div>";
						html += "<br>";
						$("#contentList").prepend(html);
						$("#content").val(null); */
						location.reload();
					}else{
						alert("失败");
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
						<span style='font-size:15px;'> - 朋友圈</span>
					</form>
			</div>
		</div>
		
		
		
		<div style="margin-left:300px;width:650px;background:url(images/bg.jpg);margin-top:20px;" id="shuoshuocontent">
			<textarea class="form-control" rows="3" placeholder="说点什么吧" id="content"></textarea>
			<button id="postBtn" class="btn btn-primary" style="float:right;margin-top:10px;margin-right:10px;">发表</button>
			<br><br><br>
			
			<div id="contentList"></div>
			<!-- 说说内容 -->
		
		</div>	
		
		<br>
		<br>
		<br>
		
	</div>
</body>
</html>