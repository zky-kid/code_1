<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pie</title>
<script src="${pageContext.request.contextPath}js/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/highcharts.js"></script>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/modules/series-label.js"></script>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/modules/exporting.js"></script>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/modules/export-data.js"></script>
<script src="${pageContext.request.contextPath}/plugin/Highcharts-8.0.4/code/modules/accessibility.js"></script>
</head>
<body>
5、数据标签连接线<br>

数据标签连接线指数据标签与扇区之间的连线，主要作用是在扇区过多时更好的表示出扇区与数据标签一一对应的关系。<br>

数据标签链接线可以通过将线条宽度（connectorWidth）设置为 0 来关闭，通过将距离（distance）参数设置为赋值来显示在扇区内部。<br>

另外还可以动态的控制数据标签是否显示来达到减少文字、连接线的干扰。<br>

数据标签连接线其他配置参数还包括：<br>
•是否使用曲线连线：softConnector<br>
•边距：connectorPadding<br>
•颜色：connectorColor<br>

用一个具体的实例来说明数据标签连接线的配置和用法<br>

<div id="container" style="min-width:400px;height:400px"></div>
<script>
$(function () {
    var colors = Highcharts.getOptions().colors,
        categories = ['IE', 'Firefox', 'Chrome', 'Safari', 'Opera'],
        data = [{
            y: 55.11,
            color: colors[0],
            drilldown: {
                name: 'IE 版本',
                categories: ['IE 6.0', 'IE 7.0', 'IE 8.0', 'IE 9.0'],
                data: [10.85, 7.35, 33.06, 2.81],
                color: colors[0]
            }
        }, {
            y: 21.63,
            color: colors[1],
            drilldown: {
                name: 'Firefox 版本',
                categories: ['Firefox 2.0', 'Firefox 3.0', 'Firefox 3.5', 'Firefox 3.6', 'Firefox 4.0'],
                data: [0.20, 0.83, 1.58, 13.12, 5.43],
                color: colors[1]
            }
        }, {
            y: 11.94,
            color: colors[2],
            drilldown: {
                name: 'Chrome 版本',
                categories: ['Chrome 5.0', 'Chrome 6.0', 'Chrome 7.0', 'Chrome 8.0', 'Chrome 9.0',
                             'Chrome 10.0', 'Chrome 11.0', 'Chrome 12.0'],
                data: [0.12, 0.19, 0.12, 0.36, 0.32, 9.91, 0.50, 0.22],
                color: colors[2]
            }
        }, {
            y: 7.15,
            color: colors[3],
            drilldown: {
                name: 'Safari 版本',
                categories: ['Safari 5.0', 'Safari 4.0', 'Safari Win 5.0', 'Safari 4.1', 'Safari/Maxthon',
                             'Safari 3.1', 'Safari 4.1'],
                data: [4.55, 1.42, 0.23, 0.21, 0.20, 0.19, 0.14],
                color: colors[3]
            }
        }, {
            y: 2.14,
            color: colors[4],
            drilldown: {
                name: 'Opera 版本',
                categories: ['Opera 9.x', 'Opera 10.x', 'Opera 11.x'],
                data: [ 0.12, 0.37, 1.65],
                color: colors[4]
            }
        }],
        browserData = [],
        versionsData = [],
        i,
        j,
        dataLen = data.length,
        drillDataLen,
        brightness;
    // 构建数据数组
    for (i = 0; i < dataLen; i += 1) {
        // 添加浏览器数据
        browserData.push({
            name: categories[i],
            y: data[i].y,
            color: data[i].color
        });
        // 添加版本数据
        drillDataLen = data[i].drilldown.data.length;
        for (j = 0; j < drillDataLen; j += 1) {
            brightness = 0.2 - (j / drillDataLen) / 5;
            versionsData.push({
                name: data[i].drilldown.categories[j],
                y: data[i].drilldown.data[j],
                color: Highcharts.Color(data[i].color).brighten(brightness).get()
            });
        }
    }
    // 创建图表
    Highcharts.chart('container', { //$('#container').highcharts({
        chart: {
            type: 'pie'
        },
        title: {
            text: '2011年4月浏览器市场份额'
        },
        subtitle: {
            text: '内环为浏览器品牌占比，外环为具体的版本'
        },
        yAxis: {
            title: {
                text: '总百分比市场份额'
            }
        },
        plotOptions: {
            pie: {
                shadow: false,
                center: ['50%', '50%']
            }
        },
        tooltip: {
            valueSuffix: '%'
        },
        series: [{
            name: '浏览器',
            data: browserData,
            size: '60%',
            dataLabels: {
                formatter: function () {
                    return this.y > 5 ? this.point.name : null;
                },
                color: 'white',
                distance: -30          // 距离值为负时显示在在扇区里面
            }
        }, {
            name: '版本',
            data: versionsData,
            size: '80%',
            innerSize: '60%',
            dataLabels: {
                softConnector: false,   // 是否使用曲线
                connectorColor: 'red', // 连接线颜色，默认是扇区颜色
                distance: 20, // 数据标签与扇区距离
                connectorPadding: 20,  // 数据标签与连接线的距离
                formatter: function () {
                    // 通过函数判断是否显示数据标签，为了防止数据标签过于密集
                    return this.y > 1 ? '<b>' + this.point.name + ':</b> ' + this.y + '%'  : null;
                }
            }
        }]
    });
});


</script>
</body>
</html>