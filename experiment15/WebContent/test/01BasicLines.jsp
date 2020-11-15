<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>折线图</title>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/highcharts.js"></script>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/modules/series-label.js"></script>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/modules/exporting.js"></script>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/modules/export-data.js"></script>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/modules/accessibility.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
</head>
<body>
	<!-- 图表容器 DOM -->
    <div id="container0" style="width: 600px;height:400px;"></div>
    <script>
        // 图表配置
        var options = {
            chart: {
                type: 'bar'                          //指定图表的类型，默认是折线图（line）  type: line
            },
            title: {
                text: '我的第一个图表'                 // 标题
            },
            xAxis: {
                categories: ['苹果', '香蕉', '橙子']   // x 轴分类
            },
            yAxis: {
                title: {
                    text: '吃水果个数'                // y 轴标题
                }
            },
            series: [{                              // 数据列
                name: '小明',                        // 数据列名
                data: [1, 0, 4]                     // 数据
            }, {
                name: '小红',
                data: [5, 7, 3]
            }]
        };
        // 图表初始化函数
        var chart = Highcharts.chart('container0', options);
    </script>
	<figure class="highcharts-figure">
	    <div id="container"></div>
	    <p class="highcharts-description">
	        Basic line chart showing trends in a dataset. This chart includes the <code>series-label</code> module, which adds a label to each line for enhanced readability.
	    </p>
	</figure>
	<script type="text/javascript">
		Highcharts.chart('container', {
		    title: {
		        text: 'Solar Employment Growth by Sector, 2010-2016'
		    },
		
		    subtitle: {
		        text: 'Source: thesolarfoundation.com'
		    },
		
		    yAxis: {
		        title: {
		            text: 'Number of Employees'
		        }
		    },
		
		    xAxis: {
		        accessibility: {
		            rangeDescription: 'Range: 2010 to 2017'
		        }
		    },
		
		    legend: {
		        layout: 'vertical',
		        align: 'right',
		        verticalAlign: 'middle'
		    },
		
		    plotOptions: {
		        series: {
		            label: {
		                connectorAllowed: false
		            },
		            pointStart: 2010
		        }
		    },
		
		    series: [{
		        name: 'Installation',
		        data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
		    }, {
		        name: 'Manufacturing',
		        data: [24916, 24064, 29742, 29851, 32490, 30282, 38121, 40434]
		    }, {
		        name: 'Sales & Distribution',
		        data: [11744, 17722, 16005, 19771, 20185, 24377, 32147, 39387]
		    }, {
		        name: 'Project Development',
		        data: [null, null, 7988, 12169, 15112, 22452, 34400, 34227]
		    }, {
		        name: 'Other',
		        data: [12908, 5948, 8105, 11248, 8989, 11816, 18274, 18111]
		    }],
		
		    responsive: {
		        rules: [{
		            condition: {
		                maxWidth: 500
		            },
		            chartOptions: {
		                legend: {
		                    layout: 'horizontal',
		                    align: 'center',
		                    verticalAlign: 'bottom'
		                }
		            }
		        }]
		    }
		
		});
		</script>
		<hr>
		在页面写一个折线图，然后进行数据的更新（只 更新 数据部分，而不是更新整个组件）<br>
		<div id="container2" style="max-width:100%;height:80%"></div>
		<script>
    $(function () {
       var data1 =  [{
            name: '安装，实施人员',
            data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 200000]
        }, {
            name: '其他',
            data: [12908, 5948, 8105, 11248, 8989, 11816, 18274, 18111]
        }];
        var data2 =  [ {
            name: '入侵检测流量统计',
            data: [null, null, 7988, 12169, 15112, 22452, 34400, 34227]
        }, {
            name: '其他',
            data: [12908, 5948, 8105, 11248, 8989, 11816, 18274, 18111]
        }];
        var chart = initTable(data1);
		//这就是最关键的代码了，通过update函数更新数据，这部分以后是用ajax来做的
        setTimeout(function() {
            chart.update({
                series: data2
            });
        }, 5000);
    });
    function update(chart){

    }
    function initTable(seriesData){
        var chart = Highcharts.chart('container2', {
            title: {
                text: '数据监控'
            },
            yAxis: {
                title: {
                    text: '流量/字节'
                }
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle'
            },
            credits:   {
                enabled : false //去除图表右下角的highcharts.com链接 不显示logo
         	},
            plotOptions: {
                series: {
                    label: {
                        connectorAllowed: false
                    },
                    pointStart: 2010
                }
            },
            series: seriesData,
            responsive: {
                rules: [{
                    condition: {
                        maxWidth: 500
                    },
                    chartOptions: {
                        legend: {
                            layout: 'horizontal',
                            align: 'center',
                            verticalAlign: 'bottom'
                        }
                    }
                }]
            }
        });
        return chart;
    }
</script>
<hr>https://blog.csdn.net/weixin_39452731/article/details/90616734<br>
<div id="container3" style="width: 550px; height: 400px; margin: 0 auto"></div>
<script>
	$(function() { // $(document).ready(function() {
    	//alert("OK");
	 //--主标题-->
    var title = {
       text: '每月平均温度'
    };
    //--副标题-->
    var subtitle = {
       text: '世界范围'
    };
    //--X轴显示-->
    var xAxis = {
       categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    };
    // Y轴显示，参数title支持text属性
    var yAxis = {
       title: {
          text: 'Temperature (\xB0C)'
       }
    };
    var credits = {
        enabled : false //去除图表右下角的highcharts.com链接
 	};
    var plotOptions = {
       line: {
          //是否允许数据标签-->
          dataLabels: {
             enabled: true
          },
          //是否允许数据图表中，数据点的鼠标跟踪气泡显示 false-->
          enableMouseTracking: true
       }
    };
    //series用于展示数据
    var series= [{
          name: '东京',
          data: [7.0, 6.9, 9.5, 14.5, 18.4, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
       }, {
          name: '伦敦',
          data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
       }
    ];
 
    var json = {};
  
    json.title = title;
    json.subtitle = subtitle;
    json.xAxis = xAxis;
    json.yAxis = yAxis;
    json.credits = credits;
    json.series = series;
    json.plotOptions = plotOptions;
    Highcharts.chart('container3',json); //$('#container3').highcharts(json);  已过时了。
 });
 </script>
 <hr>https://blog.csdn.net/yelin042/article/details/90728876<br>
 <div id="container4"></div>
 <script>
 $(function(){
	  Highcharts.chart('container4', {//   
	     xAxis: {
	         categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun']
	     },
	     series: [{
	         data: [29.9, 71.5, 106.4, 129.2, 144.0, 176.0]
	     }],
	     credits: {  
	         enabled: false     //不显示LOGO 
	     }  
	 });	 

 });
 
 
</script>
<hr>https://blog.csdn.net/bsh_csn/article/details/52639889<br>
    <div id="container5" style="width: 600px;height:400px;"></div>
    <script>
        // 图表配置
        var options = {
            chart: {
                //type: 'bar'       //指定图表的类型，默认是折线图（line）即：  type: line
            },
            title: {
                text: '表格数据'    // 标题
            },
            xAxis: {
                categories: [1, 2, 3, 4, 5, 6, 7],   // x 轴分类
                title: {
                    text: '模拟考试'                // y 轴标题
                }                
            },
            yAxis: {
                title: {
                    text: '成绩'                // y 轴标题
                }
            },
            series: [{                              // 数据列
                name: '小明',                        // 数据列名
                data: [85, 93, 95, 91, 97, 89, 84]                     // 数据
            }, {
                name: '小红',
                data: [75, 86, 80, 94, 90, 73, 96]
            }]
        };
        // 图表初始化函数
        var chart = Highcharts.chart('container5', options);
    </script>
</body>
</html>