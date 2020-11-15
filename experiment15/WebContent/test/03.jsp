<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Highcharts中更新series的5种方法</title>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/highcharts.js"></script>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/modules/series-label.js"></script>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/modules/exporting.js"></script>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/modules/export-data.js"></script>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/modules/accessibility.js"></script>
</head>
<body>
	<!-- 图表容器 DOM -->
	<h2>Highcharts中更新series的5种方法</h2>
	最后发布于2017-06-20 17:34:20 
	<hr>
	用Highcharts画图时，经常需要更新所画的图表，最常见的就是改变数据以更新图表。
	在Highcarts中，数据对应的参数是series。这儿就以图1的柱状图为例，列举如何更新series的5种方法，以供参考。源代码可从这儿访问。
    <div id="container" style="width: 600px;height:400px;"></div>
    <div>
    	<button onclick="processSeriesUpdate()">series update</button> <button onclick="processChartUpdate()">chart update</button> 
    	<button onclick="processAddSeries()">AddSeries</button> <button onclick="processRemoveAddSeries()">Remove & AddSeries</button> 
    	<button onclick="processRemoveAddSeries2()">Remove & AddSeries2</button>
    </div>
    <p>&nbsp;</p>
    <p>1. series.update<br>
      Highcarts图表中，可以有多个series。当我们想更新其中某一个series时，可以直接调用其update方法。效果如图2所示。<br>
chart.series[0].update({    	data: [29.9, 71.5, 306.4, 429.2, 144.0, 176.0, 135.6, 248.5, 216.4, 194.1, 95.6, 54.4]    });<br>
————————————————<br>
2. chart.update<br>
如果想一次性更新多个series，那么就可以直接使用chart.update。除了series，其他参数也可以同时进行更新。要注意的是，chart.update只允许更新原来的series，不允许新增series。比如在这个例子里，只能更新原来的一个或两个series，哪怕多加series，也不会起作用。效果如图3所示。<br>
chart.update({        series: [{        type: 'column',        name: 's1',        data: [129.9, 171.5, 306.4, 429.2, 144.0, 176.0, 135.6, 248.5, 216.4, 194.1, 95.6, 54.4]    	},{        type: 'column',        name: 's2',        data: [69.9, 51.5, 176.4, 121.2, 124.0, 476.0, 935.6, 248.5, 266.4, 191.1, 99.6, 53.4]    	}]    });</p>
    <p>3. chart.addSeries</p>
    <p>如果想要新增series，就得使用chart.addSeries了。一次只能加一个series。注意这个方法有性能问题，当series的长度很长， 且一次性加好多series的时候，图表的反应会很慢。效果如图4所示。</p>
    <p> chart.addSeries({        type: 'column',        name: 's3',        data: [129.9, 171.5, 1106.4, 1129.2, 144.0, 176.0, 135.6, 1148.5, 216.4, 194.1, 95.6, 54.4]    	});</p>
    <p>4. series.remove &amp; chart.addSeries<br>
      当我想完全替换原来的series，而不仅仅是在上面做更新和新增的时候，可以采用series.remove和chart.addSeries结合的方法。也就是说，要先去掉所有原来的series，再逐个加入新的。同样，这个方法有性能问题。效果如图5所示。</p>
    <p> seriesData = [{        type: 'column',        name: 's1 new',        data: [234.9, 171.5, 1106.4, 1129.2, 144.0, 176.0, 135.6, 1148.5, 216.4, 194.1, 195.6, 454.4]    	}];    while (chart.series.length &gt; 0) {      chart.series[0].remove(true);    }    for (var i = 0; i &lt; seriesData.length; i++) {          chart.addSeries(seriesData[i]);    }</p>
    <p>5. series.remove/chart.addSeries &amp; chart.update</p>
    <p>第4种方法由于使用了chart.addSeries，导致性能上可能会出现问题。这儿就用一种替换的方法来实现同样的效果。关键就是要比较原来series的数目和新的series的数目，当两个数目不同时，通过series.remove或者chart.addSeries使其相等，再统一调用一次chart.update实现图表的更新。源代码如下。当新的series数目大于原来的时候，效果如图6所示。<br>
      seriesData = [{        type: 'column',        name: 's1 new',        data: [234.9, 171.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 195.6, 454.4]    	},{        type: 'column',        name: 's2 new',        data: [234.9, 171.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 195.6, 454.4]    	},{        type: 'column',        name: 's3 new',        data: [234.9, 171.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 195.6, 454.4]    	}];          var diff = chart.series.length - seriesData.length;    if(diff &gt; 0){    	for (var i = chart.series.length; i &gt; diff; i--){      	chart.series[i-1].remove(true);      }    } else if (diff &lt; 0){    	for (var i = chart.series.length; i &lt; seriesData.length; i ++){      	chart.addSeries({});      }    }                chart.update({    	series:seriesData    });<br>
      ————————————————<br>
      https://blog.csdn.net/eengel/article/details/73497208</p>
    <p>https://blog.csdn.net/eengel/article/details/73497208    </p>
<script>
        // 图表配置
        var options = {
            chart: {
                type: 'column'                          //指定图表的类型，默认是折线图（line）  type: line
            },
            title: {
                text: 'Update'                 // 标题
            },
            xAxis: {
                categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']   // x 轴分类
            },
            yAxis: {

            },
            series: [{                              // 数据列
                name: 's1',                        // 数据列名
                data: [49.9, 56.9, 362.4, 128.3, 49.8, 79.0, 38.9, 142.3, 165.9, 190.3, 90.2, 72.9]                     // 数据
            }, {
                name: 's2',
                data: [10.3, 27.8, 206.4, 529.3, 109.0, 200.5, 35.4, 148.9, 56.9, 106.8, 55.8, 59.2]
            }]
        };
        // 图表初始化函数
        var chart = Highcharts.chart('container', options);
        function processSeriesUpdate(){
        	chart.series[0].update({
        		data: [29.9, 71.5, 306.4, 429.2, 144.0, 176.0, 135.6, 248.5, 216.4, 194.1, 95.6, 54.4]
        	});        	
        }
        function processChartUpdate(){
            chart.update({
            	series: [{
            		type: 'column',
            		name: 's1',
            		data: [129.9, 171.5, 306.4, 429.2, 144.0, 176.0, 135.6, 248.5, 216.4, 194.1, 95.6, 54.4]
            	},{
            		type: 'column',
            		name: 's2',
            		data: [69.9, 51.5, 176.4, 121.2, 124.0, 476.0, 935.6, 248.5, 266.4, 191.1, 99.6, 53.4]
            	}]
            });
        }
        function processAddSeries(){
            chart.addSeries({
            	type: 'column',
            	name: 's3',
            	data: [129.9, 171.5, 1106.4, 1129.2, 144.0, 176.0, 135.6, 1148.5, 216.4, 194.1, 95.6, 54.4]
            });
        }  
        function processRemoveAddSeries(){
            seriesData = [{
            	type: 'column',
            	name: 's1 new',
            	data: [234.9, 171.5, 1106.4, 1129.2, 144.0, 176.0, 135.6, 1148.5, 216.4, 194.1, 195.6, 454.4]
            }];
            while (chart.series.length > 0) {
            	chart.series[0].remove(true);
            }
            for (var i = 0; i < seriesData.length; i++) {
            	chart.addSeries(seriesData[i]);
            }
        }
        function processRemoveAddSeries2(){
        	seriesData = [{
        		type: 'column',
        		name: 's1 new',
        		data: [234.9, 171.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 195.6, 454.4]
        	},{
        		type: 'column',
        		name: 's2 new',
        		data: [234.9, 171.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 195.6, 454.4] 
        	},{ 
        		type: 'column',
        		name: 's3 new',
        		data: [234.9, 171.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 195.6, 454.4]
        	}]; 
        	var diff = chart.series.length - seriesData.length;    
        	if(diff > 0){
        		for (var i = chart.series.length; i > diff; i--){
        			chart.series[i-1].remove(true);
        		}
        	} else if (diff < 0){
        		for (var i = chart.series.length; i < seriesData.length; i ++){
        			chart.addSeries({});
        		}
        	}
        	chart.update({    	series:seriesData    });
        }        
      </script>
</body>
</html>