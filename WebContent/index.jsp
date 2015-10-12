<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>云盘</title>

<link rel="stylesheet" href="css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>

<script type="text/javascript">
	$(function(){
			$("#selection").click(function(){
				$(".selection").each(function(index, item){
					if($(this).attr("checked") == "checked"){
						$(this).removeattr("checked");
					}else{
						$(this).attr("checked", "checked");
					}
				});
			});
			
			$(".enter").bind("click", function(){
				var type = $(this).attr("type");
				if( type == "folder"){//是文件夹
					$("#navInfo").text($("#navInfo").text() + " > " + $(this).text());
					reloadFiles();
				}else{
					
				}
			});
			
			$("#createFolder").click(function(){
				   $("#identifier").modal();
					//html = "<hr><td><input class='selection' type='checkbox'>&nbsp;&nbsp;&nbsp;新建文件夹</td><td>--</td><td>2015-12-21</td></tr>"
					//$("#tableHead").append(html);
			});
			
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
			<div class="panel panel-primary" style="height:550px;">
			  	<div class="panel-footer">
			  		<button class="btn btn-primary">上传文件</button>
					<button class="btn"  id="createFolder">新建文件夹</button>
			  	</div>
			  	<div class="panel-body"  id="navInfo">全部文件</div>
			  	
			  	<table class="table table-hover" style="width:98%;margin-left:16px;"  id="table">
			  		<thead  id="tableHead"  >
			  			<tr>
			  				<td><input id="selection" type="checkbox">&nbsp;&nbsp;&nbsp;文件名</td>
			  				<td>大小</td><td>修改日期</td>
			  			</tr>
			  		</thead>
			  		<!--文件内容  -->
			  		<tr  class="colum">
			  			<td>
			  					<input class="selection" type="checkbox">&nbsp;&nbsp;&nbsp;
			  					<image src="images/folder.ico" style="width:20px;height:20px;">
			  					<a href="javascript:void(0)"  class="enter"  type="folder">新建文件夹</a>
			  			</td>
			  			<td> - </td>
			  			<td>2015-10-2  12:00:11</td>
			  		</tr>
			  		<tr  class="colum">
			  			<td>
			  					<input class="selection" type="checkbox">&nbsp;&nbsp;&nbsp;
			  					<image src="images/video.ico" style="width:20px;height:20px;">
			  					<a href="javascript:void(0)" class="enter"  type="pdf">java编程思想.pdf</a>
			  			</td>
			  			<td>20m</td>
			  			<td>2014-10-22  10:22:33</td>
			  		</tr>
			  	</table>
			</div>
	</div>
	
	<!--创建文件夹对话框  -->
	<div class="modal fade"  id="identifier" tabindex="-1" role="dialog"   aria-labelledby="myModalLabel" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close"  data-dismiss="modal" aria-hidden="true">&times;</button>
	               <h5>请输入文件夹名称</h5>
	         </div>
	         <div class="modal-body">
	         			<input type="text">
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-default"  data-dismiss="modal">取消
	            </button>
	            <button type="button" class="btn btn-primary">创建</button>
	         </div>
	      </div><!-- /.modal-content -->
	</div>
</body>
</html>