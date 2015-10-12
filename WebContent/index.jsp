<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>云盘</title>

<link rel="stylesheet" href="css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>

<script type="text/javascript">
	$(function(){
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
			
			$(document).on("click",  ".enter",function(){
				var type = $(this).attr("type");
				if( type == "folder"){//是文件夹
					$("#fileNav").append("<li class='active'>" + $(this).text() + "</li>");
					reloadFiles();
				}else{
					window.open( "preview.jsp");
				}
			});
			
			$(document).on("click", "button[name=cancel_create_btn]",  function(){
				$(this).parent().parent().remove();
			});
			
			$(document).on("click", "button[name=submit_create_btn]",  function(){
				//$(this).parent().parent().remove();
				alert("创建")
			});
			
			//鼠标经过
			$(document).on("mouseover", ".colum", function(){
					//$(this).children('td').children('a').append("<button class='btn　btn-primary 　btn-xs'>操作</button>")
			});
			
			//鼠标经过
			$(document).on("mouseout", ".colum", function(){
				//$(this).children().eq(3).
			});
						
			//新建文件夹
			$("#createFolder").click(function(){
					html =          "<tr  class=\"colum\">";
					html +=			  			"<td class='nameInfo'>";
					html +=	  					"<input class=\"selection\" type=\"checkbox\">&nbsp;&nbsp;&nbsp;&nbsp;";
					html +=	  					"<image src=\"images/folder.ico\" style=\"width:20px;height:20px;\">";
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
			function reloadFiles(){
				$(".colum").html("");
			}
	});
</script>
</head>
<body>
	<div class="container-fluid">
			<!--导航  -->
			<div class="bg-primary" style="width:100%;height:60px;argin-top:-2px;">
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
			  		<button class="btn btn-primary">上传文件</button>
					<button class="btn"  id="createFolder">新建文件夹</button>
			  	</div>
			  	
			  	<!-- 文件导航栏 -->
			  	<ol class="breadcrumb"  style="background-color:#FFFFFF;" id="fileNav">
				  <li><a href="#">全部文件</a></li>
				</ol>
			  	
			  	<!--文件列表  -->
			  	<table class="table table-hover table-condensed" style="width:98%;margin-left:16px;margin-top:-20px;"  id="table">
			  		<thead  id="tableHead"  >
			  			<tr  class="info table-bordered">
			  				<td  style="width:50%;"><input id="selection" type="checkbox">&nbsp;&nbsp;&nbsp;&nbsp;<span id="fileName">文件名</span></td>
			  				<td  style="width:20%;"><span id="size">大小</span></td>
			  				<td  style="width:30%;"><span id="date">修改日期</span></td>
			  			</tr>
			  		</thead>
			  		<!--文件内容  -->
			  		<tr  class="colum">
			  			<td  class='nameInfo'>
			  					<input class="selection" type="checkbox">&nbsp;&nbsp;&nbsp;
			  					<image src="images/folder.ico" style="width:20px;height:20px;">
			  					<a href="javascript:void(0)"  class="enter"  type="folder">大数据云计算</a>
			  								  					
			  					<!--操作按钮  -->
			  					<!-- <div class="btn-group"  style="margin-right:30px;">
								  <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								    操作 <span class="caret"></span>
								  </button>
								  <ul class="dropdown-menu">
								    <li><a href="#">删除</a></li>
								    <li><a href="#">下载</a></li>
								    <li><a href="#">重命名</a></li>
								  </ul>
								</div> -->
			  			</td>
			  			<td> - </td>
			  			<td>2015-10-2  12:00:11</td>
			  		</tr>
			  		
			  		
			  	</table>
			</div>
	</div>
	
	<!--对话框  -->
	
	</body>
</html>