<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>动态图曲线</title>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/highcharts.js"></script>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/modules/series-label.js"></script>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/modules/exporting.js"></script>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/modules/export-data.js"></script>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/modules/accessibility.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
$(function() { // $(document).ready(function() {
	Highcharts.setOptions({
		global: {
			useUTC: false
		}
	});
	var chart;
	chart = new Highcharts.Chart({
		chart: {
			renderTo: 'container',
			type: 'spline',
			marginRight: 10,
			events: {
				load: function() {
					// set up the updating of the chart each second
					var series = this.series[0];
					setInterval(function() {
						var x = (new Date()).getTime(), // current time
							y = Math.random();
						series.addPoint([x, y], true, true);
					}, 1000);
				}
			}
		},
		title: {
			text: '<b>Java小强制作</b>'
		},
		xAxis: {
			type: 'datetime',
			tickPixelInterval: 150
		},
		yAxis: {
			title: {
				text: '单位：M'
			},
			plotLines: [{
				value: 0,
				width: 1,
				color: '#808080'
			}]
		},
		tooltip: {
			formatter: function() {
					return '<b>'+ this.series.name +'</b><br/>'+
					Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
					Highcharts.numberFormat(this.y, 2);
			}
		},
		legend: {
			enabled: false
		},
		exporting: {
			enabled: false
		},
		series: [{
			name: 'Random data',
			data: (function() {
				// generate an array of random data
				var data = [],
					time = (new Date()).getTime(),
					i;

				for (i = -19; i <= 0; i++) {
					data.push({
						x: time + i * 1000,
						y: Math.random()
					});
				}
				return data;
			})()
		}]
	});
});
</script>
	</head>
	<body>
	<div id="container" style="width: 800px;height: 400px"></div>
	<hr>https://www.iteye.com/blog/cuisuqiang-1555440
	</body>
</body>
</html>