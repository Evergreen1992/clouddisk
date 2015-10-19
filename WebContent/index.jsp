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

<title>云盘</title>

<link rel="stylesheet" href="css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<!--文件上传引入  -->
<link rel="stylesheet" href="css/jquery.fileupload.css">
<link rel="stylesheet" href="css/jquery.fileupload-ui.css">
<script type="text/javascript" src="js/jquery.iframe-transport.js"></script>
<script type="text/javascript" src="js/jquery.ui.widget.js"></script>
<script type="text/javascript" src="js/jquery.fileupload.js"></script>

<script type="text/javascript">
	$(function(){
			var parentId = null ;//当前目录id
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
				
				//删除文件
				$("#deleteFiles").click(function(){
					var ids = "";
					alert(1);
					$(".selection").each(function(index, item){
						if($(this).is(":checked")){
							ids += ("," +  $(this).next().next().val());
						}
					});
					alert(ids);
					if( ids == ""){
						alert("请选择要删除的文件!");
					}else{
						var data = "id=" + ids ;
						$.ajax({  
							type:'post',      
							url:'<%=basePath %>file!delete.action',  
							data:data,  
							cache:false,  
							dataType:'text',  
							success:function(data){  
								if( data == true){
									alert("删除成功!");
								}else{
									alert("删除失败!");
								}
							}  
						});  
					}
				});
				
				if( count >= 1){
					$("#fileName").text("已选择" + count );
					//<div id="operationInfo"><span id="fileName">文件名</span></div>
					//$("#operationInfo").html("<span>已选择" + count + "</span><button class='btn-primary'>操作</button>" );
					$("#size").text("");
					$("#date").text("");
				}else{
					$("#fileName").text("文件名");
					$("#size").text("大小");
					$("#date").text("修改日期");
				}
			});
			
			$(document).on("click", ".navHref", function(){
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
					window.open( "preview.jsp");
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
				//$(this).append($("#operationBtns"));
				//$(this).children("a").show();
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
					html +=	  					"<image src=\"images/folder.ico\" style=\"width:20px;height:20px;\"></image><span></span>";
					html +=  					"&nbsp;<input type='text' value='新建文件夹' style='border:1px solid green;color:blue;'>";
					html +=                     "&nbsp;&nbsp;&nbsp;&nbsp;<button class='btn btn-success btn-xs' name='submit_create_btn'>确定</button>";
					html +=                     "&nbsp;&nbsp;<button class='btn btn-danger btn-xs'  name='cancel_create_btn'>取消</button>";
					html +=  			        "</td>";
					html +=	  			        "<td> - </td>";
					html +=	  			        "<td>2015-10-2  12:00:11</td>";
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
	            url: '<%=basePath %>file!uploadFile.action',  
	            sequentialUploads: true  
	        }).bind('fileuploadprogress', function (e, data) {  
	        	 	var progress = parseInt(data.loaded / data.total * 100, 10);  
	             $("#process").css('width',progress + '%');  
	             $("#process").html(progress + '%');  
	        }).bind('fileuploaddone', function (e, data) {  

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
			
			function appendBtn(){
				var html = "";
				html += "<div class=\"btn-group\"  style=\"margin-right:30px;display:none;\"  id=\"operationBtns\">";
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
			
			//列出文件列表
			function listFile(parentId){
				$("#table").append("<center  id='loading'>正在加载，请稍后...</center>");
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
					  			html +=		    "<image src=\"images/music.ico\" style=\"width:20px;height:20px;\">";
					  			html +=		    "<a href=\"javascript:void(0)\"  class=\"enter\"  type=\"file\"  fileId='" + item.id + "'>" + item.fileName + "</a>";
					  			//html += appendBtn();
					  			html +=         "</td>";
						  		html +=         "<td>10M </td>";
					  		}else if( item.type == 2){//文件夹
					  			html +=		    "<image src=\"images/folder.ico\" style=\"width:20px;height:20px;\">";
					  			html +=		    "<a href=\"javascript:void(0)\"  class=\"enter\"  type=\"folder\"  fileId='" + item.id + "'>" + item.fileName + "</a>";
					  			//html += appendBtn();
					  			html +=         "</td>";
						  		html +=         "<td>&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;    </td>";
					  		}
					  		html +=         "<td>" + item.updateTime + "</td>";
					  		html +=        "</tr>";
					  		
					  		$("#table").append(html);
						});
					}  
				});  
			}
	});
</script>
</head>
<body>
	<div class="container-fluid">
			<!--导航  -->
			<div class="bg-primary" style="width:100%;height:60px;argin-top:-2px;">
					<form class="navbar-form navbar-left" role="search"  >
						<span style='font-size:20px;'>网络云盘</span>
					</form>
					<form class="navbar-form navbar-right" role="search"  style="margin-right:5px;">
						  <div class="form-group">
						    	<input type="text" class="form-control" placeholder="Search">
						  </div>
						  <button type="button" class="btn btn-default navbar-btn">搜索</button>
					</form>
			</div>
			
		     <!-- 面板 -->
			<div class="panel panel-primary" style="height:550px;width:100%;overflow-x:hidden;">
			  	<div class="panel-footer">
			  		<button class="btn btn-primary"	id="uploadBtn">上传文件</button>
					<button class="btn btn-success"  id="createFolder">新建文件夹</button>
					<div class="btn-group"  style="margin-right:30px;"  id="operationBtns">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						操作 <span class="caret"></span>
						</button>
						<ul class="dropdown-menu">
						<li><a href="javascript:void(0)"  id="deleteFiles">删除</a></li>
						<li><a href="#">下载</a></li>
						<li><a href="#">重命名</a></li>
						</ul>
					</div>
			  	</div>
			  	
			  	<!-- 文件导航栏 -->
			  	<ol class="breadcrumb"  style="background-color:#FFFFFF;" id="fileNav">
				  <li><a href="#"  class="allFiles"  first='1'>全部文件</a></li>
				</ol>
			  	
			  	<!--文件列表  -->
			  	<table class="table table-hover table-condensed" style="width:98%;margin-left:16px;margin-top:-20px;"  id="table">
			  		<thead  id="tableHead"  >
			  			<tr  class="info table-bordered">
			  				<td  style="width:50%;">
			  					<input id="selection" type="checkbox">&nbsp;&nbsp;&nbsp;&nbsp;
			  					<span id="fileName">文件名</span>
			  				</td>
			  				<td  style="width:20%;"><span id="size">大小</span></td>
			  				<td  style="width:30%;"><span id="date">修改日期</span></td>
			  			</tr>
			  		</thead>
			  	
			  	</table>
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
								<input type="file" class="btn btn-default" name="file"  id="fileUploadStart">
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
	    
	</body>
</html>