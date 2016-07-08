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
<title>记事本</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript">
	$(function(){
		
		//加载列表
		$("#createNote").click(function(){
			$("#createNotePanel").modal();
		});
		//笔记详细查看
		$(document).on("click", ".thumbnail", function(){
			var id = $(this).attr("id");
			if( id != "createNote"){
				var nid = $(this).attr("nid");
				$.ajax({  
					type:'post',      
					url:'note!get.action?id=' + nid,  
					cache:false,  
					dataType:'text',  
					success:function(data){ 
						var obj = eval("(" + data + ")");
						$("#titleDetail").text(obj.title);
						$("#contentDetail").text(obj.content);
						$("#notedetailpanel").modal();
					}  
				}); 	
			}
		});
		//创建
		$("#create").click(function(){
			var title = $("#title").val();
			var content = $("#content").val();
			if( title == null || title == ""){
				return ;
			}
			if( content == null || content == ""){
				return ;
			}
			$.ajax({  
				type:'post',      
				url:'note!create.action?title=' + encodeURI(title) + '&content=' + encodeURI(content),  
				cache:false,  
				dataType:'text',  
				success:function(data){  
					if( data == false){
						alert("创建失败!");
					}else{
						$("#createNotePanel").hide();
						location.reload();
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
						<span style='font-size:15px;'> - 记事本</span>
					</form>
			</div>
		</div>
		<br><br>
		
		<!-- 笔记列表 -->
		<div class="row" id="noteList">
		  <div class="col-xs-6 col-md-3">
		    <a href="#" class="thumbnail" style="text-align:center;" id="createNote">
		      <span>新建笔记</span>                 
		    </a>
		  </div>
		  
		 <s:iterator value="data">
		 	  <div class="col-xs-6 col-md-3">
			    <a href="#" class="thumbnail" style="text-align:center;" nid = "<s:property value='id'/>">
			      <span><s:property value="title"/></span>
			    </a>
			  </div>
		 </s:iterator>
		  
		</div>
		
	</div>
	<!-- 新建笔记对话框 -->
	<div class="modal fade" id="createNotePanel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"> 
		<div class="modal-dialog"> 
			<div class="modal-content"> 
				<div class="modal-header"> 
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> 
					<h4 class="modal-title" id="myModalLabel">新建笔记</h4> 
				</div> 
				<div class="modal-body">
						  <div class="form-group">
						    <label for="exampleInputEmail1">标题</label>
						    <input type="text" class="form-control" id="title" name="title" placeholder="">
						  </div>
						  <div class="form-group">
						    <label for="exampleInputPassword1">内容</label>
						    <textarea type="text" class="form-control" id="content" placeholder="" style="height:300px;"></textarea>
						  </div>
						  <button class="btn btn-default" id="create">创建</button>
				</div> 
				 
			</div>
		</div> 
	</div>
	<!-- 新建笔记对话框 -->
	<!-- 笔记内容显示对话框 -->
	<div class="modal fade" id="notedetailpanel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"> 
		<div class="modal-dialog"> 
			<div class="modal-content"> 
				<div class="modal-header"> 
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> 
					<h4 class="modal-title" id="myModalLabel">新建笔记</h4> 
				</div> 
				<div class="modal-body">
					  <div class="form-group">
					    <label for="exampleInputEmail1">标题</label>
					    <br>
					    <span id="titleDetail"></span>
					  </div>
					  <div class="form-group">
					    <label for="exampleInputPassword1">内容</label>
					    <br>
					    <span id="contentDetail"></span>
					  </div>
				</div> 
				 
			</div>
		</div> 
	</div>
	<!-- 笔记内容显示对话框 -->
	
</body>
</html>