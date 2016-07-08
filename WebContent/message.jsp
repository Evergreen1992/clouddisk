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
<title>站内信</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript">
	$(function(){
		var currentUserId ;//当前聊天用户的id
		$("#showApplyPanelBtn").click(function(){//显示申请面板
			$("#friendAppPanel").show();
			$("#messagePanel").hide();
		});
		$("#send").click(function(){
			if( $("#content").val() == null || $("#content").val() == ""){
				alert("请输入消息内容")
				return ;
			}
			var content = encodeURI($("#content").val());
			$.ajax({  
				type:'post',      
				url:'<%=basePath %>message!create.action?toUid=' + currentUserId + "&content=" + content,  
				cache:false,  
				dataType:'text',  
				success:function(data){  
					if( data == "true"){
						var html = "";
						html += "<tr><td>";
						html += "<p style='float:left;'>";
						html += "<img alt='' src='head/head1.jpg' class='head_img'>";
						html += "<div class='message'>" + $("#content").val() + "</div>";
						html += "</p>";
						html += "<p style='color:gray;'>&nbsp;&nbsp;2016-3-7 13:01:18</p>";
						html += "</td></tr>";
						
						$("#informationList").append(html);
						$("#content").val(null)
					}else{
						alert("消息发送失败");
					}
				}  
			}); 	
		});
		$(document).on("click",".list-group-item",function(){//显示聊天面板
			if( $(this).attr("type") != "apply"){
				var uname = $(this).attr("uname");
				$("#infomation").text("与" + uname + "对话中");
				$("#friendAppPanel").hide();
				$("#messagePanel").show();
				//加载消息
				$("#informationList").html(null);
				var uid = $(this).attr("uid");
				currentUserId = uid ;
				$.ajax({  
					type:'post',      
					url:'<%=basePath %>message!list.action?toUid=' + uid,  
					cache:false,  
					dataType:'text',  
					success:function(data){  
						var obj = eval("(" + data + ")");
						var html = "";
						$(obj).each(function(index, item){
							html += "<tr><td>";
							html += "<p style='float:left;'>";
							html += "<img alt='' src='head/head1.jpg' class='head_img'>";
							html += "<div class='message'>" + item.content + "</div>";
							html += "</p>";
							html += "<p style='color:gray;'>&nbsp;&nbsp;2016-3-7 13:01:18</p>";
							html += "</td></tr>";
						});
						$("#informationList").append(html);
					}  
				}); 	
			}
		});
		$.ajax({  
			type:'post',      
			url:'<%=basePath %>friend!listFriend.action',  
			cache:false,  
			dataType:'text',  
			success:function(data){
				var obj = eval("(" + data + ")");
				var html = "";
				$(obj).each(function(index, item){
					html += "<a href='#' uid='" + item.id + "' class='list-group-item' type='2' uname='" + item.name + "'>";
				  	html += "<span class='badge'>1</span>";
				  	html += "<span class='glyphicon glyphicon-user' aria-hidden='true'></span>";
				  	html += item.name ;
				  	html += "</a>";
				});
				$("#listFriend").append(html);
			}  
		});
		
		$("#sendApply").click(function(){
			var uname = $("#friendName").val();
			if( uname == null || uname == ""){
				alert("请输入好友名称")
				return ;
			}
			$.ajax({  
				type:'post',      
				url:'<%=basePath %>friend!sendApply.action?uname=' + uname,  
				cache:false,  
				dataType:'text',  
				success:function(data){  
					alert(data);
					$("#friendName").val(null);
				}  
			}); 	
		});
		$(document).on("click",".btn-xs",function(){
			var id = $(this).attr("applyid");
			var type = $(this).attr("type");
			var userid = $(this).attr("userid");
			$.ajax({  
				type:'post',      
				url:'<%=basePath %>friend!selection.action?id=' + id + '&type=' + type + '&toUid=' + userid,  
				cache:false,  
				dataType:'text',  
				success:function(data){
					$("#" + id).remove();
				}  
			}); 	
		});
		function listApply(){
			$.ajax({  
				type:'post',      
				url:'<%=basePath %>friend!listapply.action',  
				cache:false,  
				dataType:'text',  
				success:function(data){
					var obj = eval("(" + data + ")");
					var html = "";
					
					$(obj).each(function(index, item){
						html += "<tr id='" + item.id + "'>"
						html += "<td>" + item.name + "请求添加您为好友" + "</td>";
						html += "<td><button class='btn btn-primary btn-xs' userid='" + item.userid + "' type='1' applyid='" + item.id + "'>同意</button></td>";
						html += "<td><button class='btn btn-danger btn-xs' userid='" + item.userid + "' type='2' applyid='" + item.id + "'>拒绝</button></td>";
						html += "</tr>";
					});
					$("#table").append(html);
				}  
			}); 	
		}
		
		listApply();
	});
</script>

<style type="text/css">
	.text_style{
		zoom: 1;
	    margin-top: 14px;
	    margin-left: 9px;
	    padding: 1px 3px;
	    width: 650px;
	    min-height: 49px;
	    max-height: 200px;
	    border: 2px solid #d5dffa;
	    overflow: auto;
	    outline: 0;
	    resize: vertical;
	}
	.message{
		padding: 5px 11px;
	    background: #f8f8f8;
	    border: 1px solid #e6e6e6;
	    border-radius: 1px;
	    min-height: 21px;
	    line-height: 20px;
	    font-size: 12px;
	    float: left;
	    position: relative;
	    word-wrap: break-word;
	    max-width: 400px;
	}
	.head_img{
		border: 1px solid #cfcfcf;
	    width: 28px;
	    height: 28px;
	    float: left;
	    margin-left:20px;
	}
	.datestyle{
		display: block;
	    color: gray;
	    height: 25px;
	    line-height: 25px;
	    width: 150px;
	    clear: both;
	    margin-left:50px;
	}
</style>

</head>
<body style="background:#ededf0">
	<div class="container-fluid"  style="height:94%;">
	
		<div class="panel panel-default" style="width:100%;height:60px;argin-top:-2px;">
			<div class="bg-default" style="width:100%;height:60px;argin-top:-2px;">
					<form class="navbar-form navbar-left"  >
						<span style='font-size:30px;'>网盘</span>
						<span style='font-size:15px;'> - 站内信</span>
					</form>
			</div>
		</div>
		
		<!-- 左边好友列表面板 -->
	    <div style="height:92%;width:15%;float:left;margin-top:1px;margin-left:170px;">
	   		<div class="list-group" id="listFriend">
			  <a href="#" class="list-group-item active" type="apply" id="showApplyPanelBtn">
			  	<span class="badge">1</span>
			  	<span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
			   	 好友申请
			  </a>
			
			</div>
	    </div>
	    
	    <!--好友申请面板  -->
	    <div style="width:700px;margin-left:370px;" id="friendAppPanel">
	    	<div class="panel panel-primary">
	    		  <div class="panel-footer">添加好友</div>
	    		  		
				  <div class="panel-body" style="min-height:300px;">
				  		<input type="text" class="form-control" id="friendName" placeholder="请输入好友昵称" style="width:550px;float:left;">
				 		<button type="submit" class="btn btn-primary" style="float:right;" id="sendApply">发送好友申请</button>
			      		<br>
			      		<br>
			      		<br>
			      		<!-- 好友申请列表 -->
			      		<table class="table table-condensed" id="table" style="text-align:center;">
			      			
			      		</table>
			      </div>
			</div>
	    </div>
	    <!--右边聊天内容  -->
	    <div style="width:700px;margin-left:370px;display:none;" id="messagePanel">
	    	<div class="panel panel-primary">
	    		  <div class="panel-footer" id="infomation"></div>
				  <div class="panel-body">
			    		<!--聊天内容  -->
				    	<div style="width:650px;height:280px;border:1px solid gray;margin-left:10px;overflow:auto;">
				    		<br>
				    		
				    		<table class="table" id="informationList">
							   <!-- <tr><td>
							    		<p style="float:left;">
								    		<img alt="" src="head/head1.jpg" class="head_img">
								    		<div class="message">2017考研党，希望要到学长的联系方式，谢谢~2017考研党，希望要到学长的联系方式，谢谢~4
								    		2017考研党，希望要到学长的联系方式，谢谢~2017考研党，希望要到学长的联系方式，谢谢~2017考研党，希望要到学长的联系方式，谢谢~
								    		</div>
							    		</p>
							    		<p style="color:gray;">&nbsp;&nbsp;2016-3-7 13:01:18</p>
							    </td></tr>
					    		<tr><td>
							    		<p style="float:left;">
								    		<img alt="" src="head/head1.jpg" class="head_img">
								    		<div class="message">在吗在吗</div>
							    		</p>
							    		<p style="color:gray;">&nbsp;&nbsp;2016-3-7 13:01:18</p>
							    </td></tr> -->
					    		
				    		</table>
				    		
				    		
				    	</div>
					    <textarea class="text_style" id="content"></textarea>
					    <br>
					    <button id="send" style="width:82px;height:30px;background:#427cc4;border:1px solid #386eb1;border-radius:2px;color:#fff;float:right;margin-right:10px;">发送</button>
			     </div>
			</div>
	    </div>
		
		
	</div>
</body>
</html>