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
<title>文件分享</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript">
	$(function(){
		var fromUser = "<s:property value='entity.fromUser'/>";
		//如果是加密文件。则需要验证
		if("<s:property value='entity.type'/>" == "1"){
			$("#sharefilePanel").hide();
		}else{
			$("#validatePwd").hide();
		}
		listAllShareFile();
		
		//发送好友申请
		$("#sendFriendApply").click(function(){
			$.ajax({  
				type:'post',      
				url:'friend!sendapplybyid.action?id=' + fromUser,  
				data:'',  
				cache:false,  
				dataType:'text',  
				success:function(data){  
					alert(data);
				}  
			});  
		});
		
		$("#getFileBtn").click(function(){
			var pwd = $("#pwd").val();
			if( pwd == "<s:property value='entity.pwd'/>"){
				$("#sharefilePanel").show();
				$("#validatePwd").hide();
			}else{
				alert("提取码不正确！")
			}
		});
		
		function listAllShareFile(){
			var filesJson = "<s:property value='filesJson'/>";
			var files = eval("(" + filesJson + ")");
			if( files.length <= 0){
				$("#shareFileContent").html("<h4 style='color:red;'>文件不存在!</h4>");
			}else{
				$(files).each(function(index, item){
					var html = "";
					html +=       "<tr class=\"colum\">";
			  		html +=	       "<td  class='nameInfo'>";
			  		//html +=			"<input class=\"selection\" type=\"checkbox\">&nbsp;&nbsp;&nbsp;";
			  		if( item.type == 1){//普通文件
			  			html +=		    "" + getIcon(item.ext) + "&nbsp;&nbsp;&nbsp;";
			  			html +=		    "<a href=\"javascript:void(0)\"  class=\"enter\"  type=\"file\"  fileId='" + item.id + "'>" + item.filename + "</a>";
			  			html +=         "</td>";
				  		html +=         "<td>" + item.size + "</td>";
			  		}else if( item.type == 2){//文件夹
			  			html +=		    "<image src=\"images/folder.ico\" style=\"width:20px;height:20px;\">&nbsp;&nbsp;&nbsp;";
			  			html +=		    "<a href=\"javascript:void(0)\"  class=\"enter\"  type=\"folder\"  fileId='" + item.id + "'>" + item.filename + "</a>";
			  			html +=         "</td>";
				  		html +=         "<td style=''> - </td>";
			  		}
			  		html +=         "<td>" + item.updatetime +  "</td>";
			  		html +=        "</tr>";
			  		$("#table").append(html);
				});
			}
		}
		
		
		//获取图标类型
		function getIcon(ext){
			var str = "";
			if(ext == null || ext == "" ||  ext == "unknown"){
				str = "<span class='glyphicon glyphicon glyphicon-question-sign' aria-hidden='true'></span>";
			}else if( ext == ".jpg" || ext == ".gif" || ext == ".png"){
				str = "<span class='glyphicon glyphicon glyphicon-picture' aria-hidden='true'></span>";
			}else if(ext == ".doc" || ext == ".txt" || ext == ".pdf" || ext == ".docx"){
				str = "<span class='glyphicon glyphicon glyphicon-file' aria-hidden='true'></span>";
			}else if( ext == ".mp4"  || ext == ".webm" || ext == ".wav" || ext == ".flv" || ext == ".f4v"){
				str = "<span class='glyphicon glyphicon glyphicon-film' aria-hidden='true'></span>";
			}else if( ext == ".mp3"){
				str = "<span class='glyphicon glyphicon glyphicon-volume-up' aria-hidden='true'></span>";
			}else if( ext == ".zip"){
				str = "<span class='glyphicon glyphicon glyphicon-question-sign' aria-hidden='true'></span>";
			}
			return str;
		}
		
		$(document).on("click",  ".enter",function(){
			var type = $(this).attr("type");
			var fileId = $(this).attr("fileId");
			if( type == "folder"){//是文件夹
				$("#fileNav").append("<li class='active'><a class='navHref' href='#'  fileId='" + fileId + "'>" + $(this).text() + "</a></li>");
				parentId = $(this).attr("fileId")
				reloadFiles(parentId);
			}else{
				window.open( "preview.jsp?id=" + fileId + "&fileName=" + $(this).text());
			}
		});
		
		//重新刷新文件列表
		function reloadFiles(pId){
			$(".colum").html("");
			listFile(pId);
		}
		
		//查看所有文件
		$(document).on("click", ".allFiles", function(){
			$(".colum").html("");
			//清除路径显示
			$(this).parent().parent().children().remove();
			$("#fileNav").append("<li><a href=\"#\"  class=\"allFiles\"  first='1'>全部文件</a></li>");
			parentId = null;
			listAllShareFile();
		} );
		
		//列出文件列表
		function listFile(parentId){
			var url = "<%=basePath %>file!listUserFile.action";
			if( parentId != null){
				url += "?parentId=" + parentId;
			}
			
			$.ajax({  
				type:'post',      
				url:url,  
				data:'',  
				cache:false,  
				dataType:'text',  
				success:function(data){  
					$("#loading").remove();
					var array = eval(data);
					$(array).each(function(index, item){
						var html = "";
						html +=       "<tr  class=\"colum\">";
				  		html +=	       "<td  class='nameInfo'>";
				  		html +=			"<input class=\"selection\" type=\"checkbox\">&nbsp;&nbsp;&nbsp;";
				  		if( item.type == 1){//普通文件
				  			html +=		    "" + getIcon(item.ext) + "&nbsp;&nbsp;&nbsp;";
				  			html +=		    "<a href=\"javascript:void(0)\"  class=\"enter\"  type=\"file\"  fileId='" + item.id + "'>" + item.fileName + "</a>";
				  			html +=         "</td>";
					  		html +=         "<td>" + item.size + "</td>";
				  		}else if( item.type == 2){//文件夹
				  			html +=		    "<image src=\"images/folder.ico\" style=\"width:20px;height:20px;\">&nbsp;&nbsp;&nbsp;";
				  			html +=		    "<a href=\"javascript:void(0)\"  class=\"enter\"  type=\"folder\"  fileId='" + item.id + "'>" + item.fileName + "</a>";
				  			html +=         "</td>";
					  		html +=         "<td style=''> - </td>";
				  		}
				  		html +=         "<td>" + item.updateTime +  "</td>";
				  		html +=        "</tr>";
				  		
				  		$("#table").append(html);
					});
				}  
			});  
		}
		
		//赞,踩
		$(".glyphicon-thumbs-up,.glyphicon-thumbs-down").click(function(){
			var type = $(this).attr("type");
			var fid = $(this).attr("fid");
			$.ajax({  
				type:'post',      
				url:'share!zancai.action?id=' + fid +"&type=" + type,  
				data:'',  
				cache:false,  
				dataType:'text',  
				success:function(data){  
					if( data == "false"){
						alert("失败")
					}else{
						alert("成功")
					}
				}  
			});  
		});
		//保存到自己的网盘
		$("#saveFile").click(function(){
			var fid = $(this).attr("fid");
			$.ajax({  
				type:'post',      
				url:'share!savesharefiletomine.action?fromUser=' + fromUser + "&id=" + fid,  
				data:'',  
				cache:false,  
				dataType:'text',  
				success:function(data){  
					if( data == "false"){
						alert("您是该文件的分享者，无需保存");
					}else{
						alert("保存成功!");
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
					</form>
			</div>
		</div>
		
		<center id="validatePwd">
			<br>
			<span>此文件为加密文件，请输入提取密码:</span>
			<br><br>
			<div>
				<input type="text" class="form-control" style="width:250px;" id="pwd">
				<br>
				<button class="btn btn-primary" style="" id="getFileBtn">提取文件</button>
			</div>
		</center>
		
		<center>
			<div style="width:850px;height:500px;background:url(images/bg.jpg);margin-top:20px;" id="sharefilePanel">
				<br>
				
				<span style="">分享时间:&nbsp;&nbsp;&nbsp;<s:property value='entity.date'/></span>
				<div style="float:right;">
					<button class="btn btn-primary"	id="saveFile" fid="<s:property value='entity.id'/>">
						<span class="glyphicon glyphicon glyphicon-arrow-up" aria-hidden="true" ></span>保存至我的网盘
					</button>
					<%-- <button class="btn btn-primary"  id="download">
						<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>下载
					</button> --%>
					<div class="btn-group"  style="margin-right:30px;"  id="operationBtns">
						<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<span class="glyphicon glyphicon glyphicon-th-large" aria-hidden="true"></span>
						分享至 <span class="caret"></span>
						</button>
						<ul class="dropdown-menu">
							<li><a href="javascript:void(0)"  id="">
								<span class="glyphicon glyphicon glyphicon-trash" aria-hidden="true"></span> 
								朋友圈</a>
							</li>
							
						</ul>
						
						
					</div>
					&nbsp;&nbsp;
				</div>
				<br><br><br><br>
				
				
				<!--分享文件的内容  -->
				<div style="width:850px;" id="shareFileContent">
					<!-- 文件导航栏 -->
				  	<ol class="breadcrumb"  style="background-color:#FFFFFF;" id="fileNav">
					  <li><a href="#"  class="allFiles"  first='1'>全部文件</a></li>
					</ol>
					<!--表格头部  -->
					<div style="width:98%;margin-left:13px;margin-top:-20px;background-color:#F7F7F7;border-radius: 2px;line-height: 41px;height:41px;border: 1px solid #d2d2d2;">
						<div  style="width:54%;float:left;border-left: 0;border-right: 1px solid #e5e5e5;">
							&nbsp;
		  					<span id="fileName">文件名</span>
		  				</div>
		  				<div  style="width:13%;float:left;border-left: 1px solid #fff;border-right: 1px solid #e5e5e5;"><span id="size">大小</span></div>
		  				<div  style="width:32%;float:left;border-left: 1px solid #fff;border-right: 0;"><span id="date">日期</span></div>
					</div>
				  	
				  	<!--文件列表  -->
				  	<div style="width:98%;height:76%;margin-left:16px;margin-top:-20px;overflow-x:hidden;position: relative;">
					  	<table class="table table-hover table-condensed" id="table" style="width:100%;">
					  		<thead id="tableHead">
					  			
					  		</thead>
					  		<tr style="width:100%;">
				  				<td style="width:54%;"></td>
				  				<td style="width:13%;"></td>
				  				<td style="width:32%;"></td>
				  			</tr>
					  	</table>
				  	</div>
				</div>
			</div>
			
			<div style="width:100px;height:50px;float:left;margin-top:-500px;">
				<img alt="" src="head/head1.jpg" style="width:100px;height:100px;">
				<br>
				<span style="font-size:20px;color:blue;"><s:property value='entity.shareUserName'/></span>
				<br><br>
				<a class="glyphicon glyphicon-thumbs-up" aria-hidden="true" fid="<s:property value='entity.id'/>"  type="1"></a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<a class="glyphicon glyphicon-thumbs-down" aria-hidden="true" fid="<s:property value='entity.id'/>"  type="2"></a>
				<br><br>
				<button class="btn btn-primary"  id="sendFriendApply" style="width:100px;">
					
					<span class="glyphicon glyphicon glyphicon-plus" aria-hidden="true" id=""></span>加为好友
				</button>
			</div>
			
		</center>
	</div>
</body>
</html>