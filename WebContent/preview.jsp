<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
 --%>
 <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String id = request.getParameter("id");
String fileName = request.getParameter("fileName");

String ext = "";
if( fileName.contains("."))
	ext = fileName.substring(fileName.lastIndexOf("."), fileName.length() );
%>   
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件浏览 - <%=fileName %></title>

<link rel="stylesheet" href="css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>

<script src="plugins/jwplayer/jwplayer.js" type="text/javascript"></script>  

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
		var ext = "<%=ext %>";		
		var file = "<%=basePath %>file!fileDownload" ; //
		var isVideo = false ;
		var isPic = false ;
		var width = 800 , height = 450;
		
		if( ext == ".mp4"){
			file += ".mp4";
			isVideo = true ;
		}else if( ext == ".mp3"){
			file += ".mp3";
			height = 100 ;
			isVideo = true ;
		}else if(ext ==  ".wav"){
			file += ".wav";
			isVideo = true ;
		}else if( ext == ".flv" || ext == ".f4v"){
			file += ".flv";
			isVideo = true ;
		}else if( ext == ".webm"){
			file += ".webm";
			isVideo = true ;
		}else if( ext == ".jpg" || ext == ".png" || ext == ".gif" || ext == ".jpeg"){
			isPic = true ;
		}
		
		
		file += "?id=<%=id %>&fileName=<%=fileName %>&flag=play";
		
		if( isPic){
			$("#image").show();
		}

		if( isVideo ){
			$("#player").show();
			jwplayer('playerzmblbkjP').setup({
		        playlist: [{image:'',file:file}],
		        fallback: 'false',
		        width: width, 
				  height: height
			});
		}
		/* if( isVideo == true && isPic == true)
			$("#hiddenHit").show(); */
	});
</script>
</head>
<body style="height:100%;">

<div class="container-fluid"  style="height:94%;">
		<div class="bg-primary" style="width:100%;height:60px;argin-top:-2px;">
				<div class="bg-primary" style="width:100%;height:60px;argin-top:-2px;">
							<form class="navbar-form navbar-left"  >
								<span style='font-size:30px;'>网盘</span>
							</form>
				</div>
		</div>
		<div class="panel panel-primary" style="height:98%;width:100%;overflow-x:hidden;">
			
			<div class="panel-body">		
				<center >
						<h4>文件浏览 - <%=fileName %></h4>
						
					   	<a class="btn btn-default" href="<%=basePath %>file!fileDownload.action?id=<%=id %>&fileName=<%=fileName %>">下载</a>
					
						<div  id="image"  style="display:none;">
					  		<img style="border: 1px solid #000000;" alt="" src="<%=basePath %>file!fileDownload.action?id=<%=id %>&fileName=<%=fileName %>">
						</div>
						<br>
						
						<!-- 						
						<div id="hiddenHit"　style="display:none;'"><br><span style="font-size:24px;color:red;">暂不支持浏览该格式文件！</span></div>
						-->						
						<div id="player" style="width:700px;height:300px;position:relative;display:none;">
					        <object name="playerzmblbkjP" width="100%" height="100%" id="playerzmblbkjP" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" style="position:absolute;top:0;left:0;">
					            <param name="movie" value="jwplayer.flash.swf">
					            <param name="src" value="jwplayer.flash.swf">
					            <param name="AllowScriptAccess" value="always">
					        </object>
					    </div>
					    
					    
				</center>
				 	
				</div>
			</div>
</div>
</body>
</html>