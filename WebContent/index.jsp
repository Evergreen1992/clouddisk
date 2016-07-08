<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html >
<html lang="zh-CN">
<head>
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 

<title>网盘</title>

<link rel="stylesheet" href="css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<!--文件上传引入  -->
<link rel="stylesheet" href="css/jquery.fileupload.css">
<link rel="stylesheet" href="css/jquery.fileupload-ui.css">
<script type="text/javascript" src="js/jquery.iframe-transport.js"></script>
<script type="text/javascript" src="js/jquery.ui.widget.js"></script>
<script type="text/javascript" src="js/jquery.fileupload.js"></script>

<style type="text/css">
	body{
		width:100%;
		height:95%;
	}
	html{
		width:100%;
		height:95%;
	}
</style>

<script type="text/javascript">
	$(function(){
			var parentId = null ;//当前目录id
			var shareFileIds ;//共享文件id
			listFile();//显示文件列表	
		
			$("#selection").click(function(){
				var flag = false ;
				var count = 0 ;
				if($(this).is(":checked")){
					flag = true ;
				}
				$(".selection").each(function(index, item){
					if(flag == false ){
						//取消选择
						$(this).prop("checked", false);
					}else{
						//选择
						$(this).prop("checked", true);
						count ++ ;
					}
				});
			
				if( count >= 1){
					$("#fileName").text("已选择" + count );
					$("#size").text("");
					$("#date").text("");
				}else{
					$("#fileName").text("文件名");
					$("#size").text("大小");
					$("#date").text("修改日期");
				}
			});
			
			//获取选择文件的id
			function getSelectedIds(){
				var ids = "";
				$(".selection").each(function(index, item){
					if($(this).is(":checked")){
						ids += ("," +  $(this).next().next().attr("fileid"));//获取id
					}
				});
				return ids ;
			}
			
			$("#rename").click(function(){
				var ids = getSelectedIds();
				if( ids == ""){
					var html = "<span class='alert alert-danger alert-dismissible' role='alert' >";
			  		html += "<strong>请选择一个文件!</strong> ";
					html += "</span>";
					$("#infoPanel").show();
					$("#infoPanel").html(html);
					$("#infoPanel").fadeOut(2000);
					return ;
				}
				
				$("#renameWindow").modal();
			});
			
			//文件删除
			$("#deleteFiles").click(function(){
				var ids = getSelectedIds();
				
				if( ids == ""){
					//alert("请选择要删除的文件!");
					var html = "<span class='alert alert-danger alert-dismissible' role='alert' >";
				  		html += "<strong style='width:400px;'>请选择你要删除的文件!</strong> ";
						html += "</span>";
					$("#infoPanel").show();
					$("#infoPanel").html(html);
					$("#infoPanel").fadeOut(2000);
				}else{
					var data = "id=" + ids ;
					$.ajax({  
						type:'post',      
						url:'<%=basePath %>file!delete.action',  
						data:data,  
						cache:false,  
						dataType:'text',  
						success:function(data){  
							if( data == "true"){
								alert("删除成功!");
								$(".colum").html("");
								listFile(parentId);
							}else{
								alert("删除失败!");
							}
						}  
					});  
				}
			});
			
			//文件重命名
			$("#submitReName").click(function(){
				var name = $("#newName").val();
				if( name == null || name == ""){
					alert("请输入文件名！");
					return ;
				}
				
				$("#renameWindow").modal("hide");
				var data = "fileName=" + name +  "&id=" + getSelectedIds() ;
				$.ajax({  
					type:'post',      
					url:'<%=basePath %>file!rename.action',  
					data:data,  
					cache:false,  
					dataType:'text',  
					success:function(data){  
						if( data == "true"){
							$(".colum").html("");
							listFile(parentId);
						}else{
							alert("重命名失败!");
						}
					}  
				});  
			});
			
			$(document).on("click", ".navHref", function(){
				$(this).parent().nextAll().remove();
				$(".colum").html("");
				listFile($(this).attr("fileId"));
			});
			
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
			
			$(document).on("click", "button[name=cancel_create_btn]",  function(){
				$(this).parent().parent().remove();
			});
			
			$(document).on("click", "button[name=submit_create_btn]",  function(){
				var fileName = $(this).prev().val() ;
				var data = "type=2&size=&ext=&fileName=" + fileName + "";
				var tag = $(this);
				if( parentId != null)
					data += "&parentId=" + parentId;
				$.ajax({  
					type:'post',      
					url:'<%=basePath %>file!createFolder.action',  
					data:data,  
					cache:false,  
					dataType:'text',  
					success:function(data){  
						if( data != "false"){
							tag.prev().remove();
							tag.prev().append("<a href=\"javascript:void(0)\"  class=\"enter\"  type=\"folder\"  fileId='" + data + "'>" +fileName + "</a>");
							tag.next().remove();
							tag.remove();
						}else{
							alert("创建失败!");
						}
					}  
				});  
			});
			
			//鼠标经过
			$(document).on("mouseover", ".colum", function(){
				//$(this).append(appendBtn());
			});
			
			//鼠标经过
			$(document).on("mouseout", ".colum", function(){
				//$("#operationBtns").remove();
			});
						
			//新建文件夹
			$("#createFolder").click(function(){
					html =          "<tr  class=\"colum\">";
					html +=			  			"<td class='nameInfo'>";
					html +=	  					"<input class=\"selection\" type=\"checkbox\">&nbsp;&nbsp;&nbsp;";
					html +=	  					"<image src=\"images/folder.ico\" style=\"width:20px;height:20px;\"></image>&nbsp;&nbsp;&nbsp;<span></span>";
					html +=  					"&nbsp;<input type='text' value='新建文件夹' style='border:1px solid green;color:blue;'>";
					html +=                     "&nbsp;&nbsp;&nbsp;&nbsp;<button class='btn btn-success btn-xs' name='submit_create_btn'>确定</button>";
					html +=                     "&nbsp;&nbsp;<button class='btn btn-danger btn-xs'  name='cancel_create_btn'>取消</button>";
					html +=  			        "</td>";
					html +=	  			        "<td> - </td>";
					html +=	  			        "<td> - </td>";
					html +=	  		"</tr>"
					$("#tableHead").append(html);
			});
			
			//重新刷新文件列表
			function reloadFiles(pId){
				$(".colum").html("");
				listFile(pId);
			}
			
			$("#uploadBtn").click(function(){
				$("#uploadWindow").modal();
			});
			
			//文件上传
			$("#fileUploadStart").fileupload({  
	            url: '<%=basePath %>file!uploadFile.action?parentId=' + parentId,  
	            sequentialUploads: true ,
	        }).bind('fileuploadprogress', function (e, data) {  
	        	 	var progress = parseInt(data.loaded / data.total * 100, 10);  
	             $("#process").css('width',progress + '%');  
	             $("#process").html(progress + '%');  
	        }).bind('fileuploaddone', function (e, data) {  
					if( data.result != "false"){
						updateParentId(data.result, parentId);
					}
	        }); 
			 
			 function updateParentId(id, pId){
				 var url = "<%=basePath %>file!updateParentId.action?id=" + id ;
				 if(pId != null )
					 url += ("&parentId=" + pId);
				 $.ajax({  
						type:'post',      
						url:url,  
						data:'',  
						cache:false,  
						dataType:'text',  
						success:function(data){  
							if( data == "false"){
								alert("文件信息更新失败!");
							}else{
								$("#uploadWindow").modal("hide");
								$(".colum").html("");
								listFile(pId);
							}
						}  
				  });  
			 }
			//分享文件
			$("#shareFilesButton").click(function(){
				var ids = getSelectedIds();
				shareFileIds = ids ;
				
				if( ids == ""){
					var html = "<span class='alert alert-danger alert-dismissible' role='alert' >";
				  		html += "<strong style='width:400px;'>请选择你要分享的文件(夹)!</strong> ";
						html += "</span>";
					$("#infoPanel").show();
					$("#infoPanel").html(html);
					$("#infoPanel").fadeOut(2000);
				}else{
					$("#shareDiv").show();
					$("#shareResultDiv").hide();
					$("#pwdDivPanel").hide();
					
					$("#fileShare").modal();
				}
			});
			 
			//查看所有文件
			$(document).on("click", ".allFiles", function(){
				$(".colum").html("");
				//清除路径显示
				$(this).parent().parent().children().remove();
				$("#fileNav").append("<li><a href=\"#\"  class=\"allFiles\"  first='1'>全部文件</a></li>");
				parentId = null;
				listFile();
			} );
			
			function appendBtn(id){
				var html = "";
				html += "<div class=\"btn-group\"  style=\"margin-right:30px;display:none;\"  id=\"btn_" + id + "\">";
				html += "<button type=\"button\" class=\"btn btn-default btn-xs dropdown-toggle\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">";
				html +=    "操作 <span class=\"caret\"></span>";
				html +=  "</button>";
				html += " <ul class=\"dropdown-menu\">";
				html +=    "<li><a href=\"#\">删除</a></li>";
				html +=    " <li><a href=\"#\">下载</a></li>";
				html +=    " <li><a href=\"#\">重命名</a></li>";
				html +=  "</ul>";
				html += "</div>";
				return html;
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
			
			//文件搜索
			$("#fileSearchBtn").click(function(){
				var name = $("#fileSearchName").val();
				if(name == null || name == ""){
					var html = "<span class='alert alert-danger alert-dismissible' role='alert' >";
			  		html += "<strong>请输入文件名!</strong> ";
					html += "</span>";
					$("#infoPanel").show();
					$("#infoPanel").html(html);
					$("#infoPanel").fadeOut(2000);
					return ;
				}
				$("#fileSearchName").val("");
				$(".colum").html("");
				$("#table").append("<center  id='loading'>正在搜索中....</center>");
				var url = "<%=basePath %>file!search.action";
				var data = "fileName=" + name ;
				
				$.ajax({  
					type:'post',      
					url:url,  
					data: data,  
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
					  		$("#tableHead").append(html);
						});
					}  
				});  
			});
			//
			$(".list-group-item").click(function(){
				if( $(this).attr("active") == "1")
					return ;
				$(".colum").html("");
				listFileByType($(this).attr("type"));
			});
			
			//列出文件列表
			function listFileByType(type){
				var url = "<%=basePath %>file!listUserFile.action";
				if( type != null){
					url += "?listType=" + type;
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
					/* contentType:'charset=UTF-8', */
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
			//文件共享
			$("#shareFilePublic,#shareFilePrivate").click(function(){
				var type = $(this).attr("type");
				var url = "<%=basePath %>share!shareFile.action";
				
				if( type == "public"){
					url += "?type=0";
				}else if( type == "private"){
					url += "?type=1";
				}
				url += "&id=" + shareFileIds;
				$.ajax({  
					type:'post',      
					url:url,  
					data:'',  
					cache:false,  
					dataType:'text',  
					success:function(data){  						
						$("#shareUrl").val("<%=basePath%>" + data.split(",")[0]);
						$("#viewPwd").val(data.split(",")[1]);
						
						$("#shareDiv").hide();
						$("#shareResultDiv").show();
						if( type == "private"){
							$("#pwdDivPanel").show();
						}else{
							$("#pwdDivPanel").hide();
						}
					}  
				});
				
			});
	});
</script>
</head>
<body style="height:100%;position:relative;">
	<div class="container-fluid"  style="height:100%;">
			<!--导航  -->
			<div class="bg-primary" style="width:100%;height:60px;argin-top:-2px;">
					<form class="navbar-form navbar-left" role="search"  >
						<span style='font-size:30px;'>网盘</span>
						
					</form>
					<form class="navbar-form navbar-right" role="search"  style="margin-right:5px;">
						  <div class="form-group">
						    	<input type="text" class="form-control" id="fileSearchName" placeholder="Search">
						  </div>
						  <button type="button" class="btn btn-default navbar-btn"  id="fileSearchBtn">
						  <span class="glyphicon glyphicon glyphicon-search" aria-hidden="true"></span>   
						     搜索
						  </button>
						  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  <!--退出登录  -->
					      <div class="btn-group"  style="margin-right:30px;">
								
								<img alt="" src="head/head1.jpg" style="width:50px;height:50px;">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span type="button" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="cursor: pointer;">
									${sessionScope.loginUser.name }&nbsp;<span class="caret"></span>
								</span>
								<ul class="dropdown-menu">
									<li><a href="usercenter.jsp"  id="" target="_Blank">个人中心</a></li>
									<li role="separator" class="divider"></li>
									<li><a href="user!invalidate.action"  id="">退出登录</a></li>
								</ul>
								
						  </div>
					</form>
			</div>
			
		    <!-- 左边面板 -->
		    <div style="height:92%;width:15%;float:left;margin-top:1px;">
		   		<div class="list-group">
				  <a href="#" class="list-group-item active" type="1">
				  	
				  	<span class="glyphicon glyphicon glyphicon-home" aria-hidden="true"></span>
				   	 全部文件
				  </a>
				  <a href="#" class="list-group-item" type="2">
				  	<span class="glyphicon glyphicon glyphicon-picture" aria-hidden="true"></span>
				  	图片
				  </a>
				  <a href="#" class="list-group-item" type="3">
				  	<span class="glyphicon glyphicon glyphicon-file" aria-hidden="true"></span>
				  	文档
				  </a>
				  <a href="#" class="list-group-item" type="4">
				  	<span class="glyphicon glyphicon glyphicon-film" aria-hidden="true"></span>
				  	视频
				  </a>
				  <a href="#" class="list-group-item" type="5">
				  	<span class="glyphicon glyphicon glyphicon-volume-up" aria-hidden="true"></span>
				  	音乐
				  </a>
				  <a href="sharefiles.jsp" class="list-group-item"  target="_Blank">
				  	<span class="glyphicon glyphicon glyphicon-random" aria-hidden="true"></span>
				  	我的分享
				  </a>
				  <!-- <a href="mysubscribe.jsp" class="list-group-item" type="6" target="_Blank">
				  	<span class="glyphicon glyphicon-tasks" aria-hidden="true"></span>
				  	我的订阅
				  </a> -->
				  <a href="file!listCount.action" class="list-group-item" target="_Blank">
				  	<span class="glyphicon glyphicon-align-left" aria-hidden="true"></span>
				  	文件统计
				  </a>
				  <a href="message.jsp" class="list-group-item" target="_Blank">
				  	<span class="glyphicon glyphicon glyphicon-envelope" aria-hidden="true"></span>
				  	<span class="badge">1</span>
				  	站内信
				  </a>
				  <a href="friendscircle.jsp" class="list-group-item" target="_Blank">
				  	<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
				  	朋友圈
				  </a>
				  <a href="note!list.action" class="list-group-item" target="_Blank">
				  	<span class="glyphicon glyphicon-tasks" aria-hidden="true"></span>
				  	记事本
				  </a>
				</div>
		    </div>
		    <!--文件列表  -->
			<div class="panel panel-primary" style="height:92%;width:85%;float:right;margin-top:-5px;">
			  	<div class="panel-footer">
			  		<button class="btn btn-primary"	id="uploadBtn"><span class="glyphicon glyphicon glyphicon-arrow-up" aria-hidden="true"></span>上传文件</button>
					<button class="btn btn-success"  id="createFolder"><span class="glyphicon glyphicon glyphicon-plus" aria-hidden="true"></span>新建文件夹</button>
					
					<button class="btn btn-primary"	id="deleteFiles"><span class="glyphicon glyphicon glyphicon-trash" aria-hidden="true"></span>&nbsp;删除</button>
						
					<button class="btn btn-primary"	id="rename"><span class="glyphicon glyphicon glyphicon-credit-card" aria-hidden="true"></span>&nbsp;重命名</button>
					
					<button class="btn btn-primary"	id="shareFilesButton"><span class="glyphicon glyphicon glyphicon-random" aria-hidden="true"></span>&nbsp;共享文件</button>
				
					<div class="btn-group"  style="margin-right:30px;"  id="operationBtns">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<span class="glyphicon glyphicon glyphicon-th-large" aria-hidden="true"></span>
						其他操作 <span class="caret"></span>
						</button>
						<ul class="dropdown-menu">
							<li><a href="javascript:void(0)"  id="">
								<span class="glyphicon glyphicon glyphicon-trash" aria-hidden="true"></span> 
								...</a>
							</li>
							<li role="separator" class="divider"></li>
							<li><a href="#"  id="">
								<span class="glyphicon glyphicon glyphicon-credit-card" aria-hidden="true"></span>
								...</a>
							</li>
							<li role="separator" class="divider"></li>
							<li>
								<a href="#"  id="">
								<span class="glyphicon glyphicon glyphicon-random" aria-hidden="true"></span>
								
								...</a>
							</li>
						</ul>
						
						
					</div>
					<span  id="infoPanel"  >
						
					</span>
			  	</div>
			  	
			  	<!-- 文件导航栏 -->
			  	<ol class="breadcrumb"  style="background-color:#FFFFFF;" id="fileNav">
				  <li>&nbsp;<a href="#"  class="allFiles"  first='1'>全部文件</a></li>
				</ol>
				
				<!--表格头部  -->
				<div style="width:98%;margin-left:13px;margin-top:-20px;background-color:#F7F7F7;border-radius: 2px;line-height: 41px;height:41px;border: 1px solid #d2d2d2;">
					<div  style="width:54%;float:left;border-left: 0;border-right: 1px solid #e5e5e5;">
						&nbsp;
	  					<input id="selection" type="checkbox">&nbsp;&nbsp;&nbsp;
	  					<span id="fileName">文件名</span>
	  				</div>
	  				<div  style="width:13%;float:left;border-left: 1px solid #fff;border-right: 1px solid #e5e5e5;"><span id="size">大小</span></div>
	  				<div  style="width:32%;float:left;border-left: 1px solid #fff;border-right: 0;"><span id="date">修改日期</span></div>
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
	
	<!--文件上传对话框  -->			
	<div class="modal fade" id="uploadWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"> 
		<div class="modal-dialog"> 
			<div class="modal-content"> 
				<div class="modal-header"> 
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> 
					<h4 class="modal-title" id="myModalLabel">文件上传</h4> 
				</div> 
				<div class="modal-body">
						<!-- 文件上传表单 -->
						<form action="">
								<input type="file" class="btn btn-default" name="file"  id="fileUploadStart" >
								
								<br>
								<div id="process" class="progress-bar progress-bar-success" style="width:0%;"></div>
						</form>
				 </div> 
				 
				<div class="modal-footer"> 
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div> 
	</div>
	<!--文件上传对话框结束  -->    
	
	
	<!--文件重命名对话框  -->			
	<div class="modal fade" id="renameWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"> 
		<div class="modal-dialog"> 
			<div class="modal-content"> 
				<div class="modal-header"> 
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> 
					<h4 class="modal-title" id="myModalLabel">请输入文件名</h4> 
				</div> 
				<div class="modal-body">
						<!-- 文件上传表单 -->
						<form action="">
								<input type="text" class="form-control" name="name"  id="newName" >
						</form>
				 </div> 
				 
				<div class="modal-footer"> 
					<button type="button" class="btn btn-success"  id="submitReName">确定</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div> 
	</div>
	<!--文件重命名对话框结束  -->    
	
	
	<!--文件分享对话框  -->			
	<div class="modal fade" id="fileShare" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"> 
		<div class="modal-dialog"> 
			<div class="modal-content"> 
				<div class="modal-header"> 
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> 
					<h4 class="modal-title" id="myModalLabel">
						<span class="glyphicon glyphicon glyphicon-random" aria-hidden="true"></span>
						分享文件(夹):
					</h4> 
				</div> 
				<div class="modal-body">
					<div class="list-group" id="shareDiv">
						  <a href="#" class="list-group-item active" active="1" id="shareFilePublic" type="public">
						  	<span class="glyphicon glyphicon glyphicon-random" aria-hidden="true"></span>
						   	创建公开链接
						  </a>
						  <a href="#" class="list-group-item" active="1" id="shareFilePrivate" type="private">
						  	<span class="glyphicon glyphicon glyphicon-lock" aria-hidden="true"></span>
						  	创建私密链接
						  </a>
						  <br>
						  <input type='checkbox' checked='checked'>&nbsp;&nbsp;同时分享到朋友圈
					 </div>
					 <div id="shareResultDiv" style="display:none;">
					 	<div class="alert alert-success" role="alert"><strong>成功创共享链接!</strong></div>
					 	<input type="text" id="shareUrl" class="form-control" style="width:500px;" value="">
					 	
					 	<div id="pwdDivPanel" style="display:none;">
					 		提取密码:
					 		<input id="viewPwd" type="text" class="form-control" style="width:300px;" value="">
						</div>
					 </div>
				 </div> 
				 
				<div class="modal-footer"> 
					
				</div>
			</div>
		</div> 
	</div>
	<!--文件分享对话框结束  -->    
	</body>
</html>