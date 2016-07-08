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
<title>文件统计</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/highcharts.js"></script>
<script type="text/javascript" src="js/highcharts-3d.js"></script>
<script type="text/javascript" src="highcharts-3d.src.js"></script>
<script type="text/javascript">
$(function () {
	var chart = new Highcharts.Chart({
        chart: {
            renderTo: 'container',
            type: 'column',
            margin: 75,
            options3d: {
                enabled: true,
                alpha: 15,
                beta: 15,
                depth: 50,
                viewDistance: 25
            }
        },
        title: {
            text: '文件类型数量统计'
        },
        subtitle: {
            text: '如下图所示:'
        },
        plotOptions: {
            column: {
                depth: 25
            }
        },
        series: [{
            data: <s:property value='data_1'/>
        }]
    });
    
    //图表2
    $('#container1').highcharts({
        chart: {
            type: 'pie',
            options3d: {
                enabled: true,
                alpha: 45,
                beta: 0
            }
        },
        title: {
            text: '各类型文件数量比例统计'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                depth: 35,
                dataLabels: {
                    enabled: true,
                    format: '{point.name}'
                }
            }
        },
        series: [{
            type: 'pie',
            name: '数量',
            data: [
                
                {
                    name: 'Chrome',
                    y: 12.8,
                    sliced: true,
                    selected: true
                },
                <s:property value='data_2'/>
            ]
        }]
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
						<span style='font-size:15px;'> - 文件统计</span>
					</form>
			</div>
		</div>
		
		
		<center>
			<div id="container" style="width:900px;height:500px"></div> 
			<div id="container1" style="width:900px;height:500px"></div> 
		</center>
		
		
	</div>
</body>
</html>