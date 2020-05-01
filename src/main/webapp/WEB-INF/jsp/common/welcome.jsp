<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=contextPath%>/layui/css/layui.css" media="all">
    <script type="text/javascript" src="<%=contextPath%>/static/jquery-2.1.3.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts-gl/dist/echarts-gl.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts-stat/dist/ecStat.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/dist/extension/dataTool.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/map/js/china.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/map/js/world.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/dist/extension/bmap.min.js"></script>
    <script>
        function showTime() {
            nowtime = new Date();
            year = nowtime.getFullYear();
            month = nowtime.getMonth() + 1;
            date = nowtime.getDate();
            document.getElementById("mytime").innerText = year + "年" + month + "月" + date + " " + nowtime.toLocaleTimeString();
        }
        setInterval("showTime()", 100);
    </script>
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend style="text-align: center">欢迎访问CRM员工管理系统</legend>
</fieldset>
<div style="padding: 20px; background-color: #F2F2F2;">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md6">
            <div class="layui-card">
                <h3 style="font-size: 25px; font-weight: bolder;">目前管理系统人数统计</h3>
                <div id="container" style="height: 450px"></div>

                <script type="text/javascript">
                    var dom = document.getElementById("container");
                    var myChart = echarts.init(dom);
                    var app = {};
                    option = null;
                    option = {
                        xAxis: {
                            type: 'category',
                            data: ['管理部', '技术部', '大数据部', '运维部', '测试部']
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            data: [10, 200, 150, 80, 50],
                            type: 'bar',
                            showBackground: true,
                            backgroundStyle: {
                                color: 'rgba(220, 220, 220, 0.8)'
                            }
                        }]
                    };
                    ;
                    if (option && typeof option === "object") {
                        myChart.setOption(option, true);
                    }
                </script>
            </div>
        </div>
        <div class="layui-col-md6">
            <div class="layui-card">
                <div id="container2" style="height: 450px"></div>
                <script type="text/javascript">
                    var dom = document.getElementById("container2");
                    var myChart = echarts.init(dom);
                    var app = {};
                    option = null;
                    option = {
                        backgroundColor: '#2c343c',

                        title: {
                            text: '今日出勤人数统计',
                            left: 'center',
                            top: 20,
                            textStyle: {
                                color: '#ccc'
                            }
                        },

                        tooltip: {
                            trigger: 'item',
                            formatter: '{a} <br/>{b} : {c} ({d}%)'
                        },

                        visualMap: {
                            show: false,
                            min: 0,
                            max: 200,
                            inRange: {
                                colorLightness: [0, 1]
                            }
                        },
                        series: [
                            {
                                name: '今日出勤人数',
                                type: 'pie',
                                radius: '55%',
                                center: ['50%', '50%'],
                                data: [
                                    {value: 10, name: '管理部出勤'},
                                    {value: 200, name: '技术部出勤'},
                                    {value: 150, name: '大数据部出勤'},
                                    {value: 80, name: '运维部出勤'},
                                    {value: 48, name: '测试部出勤'}
                                ].sort(function (a, b) { return a.value - b.value; }),
                                roseType: 'radius',
                                label: {
                                    color: 'rgba(255, 255, 255, 0.3)'
                                },
                                labelLine: {
                                    lineStyle: {
                                        color: 'rgba(255, 255, 255, 0.3)'
                                    },
                                    smooth: 0.2,
                                    length: 10,
                                    length2: 20
                                },
                                itemStyle: {
                                    color: '#c23531',
                                    shadowBlur: 200,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                },

                                animationType: 'scale',
                                animationEasing: 'elasticOut',
                                animationDelay: function (idx) {
                                    return Math.random() * 200;
                                }
                            }
                        ]
                    };;
                    if (option && typeof option === "object") {
                        myChart.setOption(option, true);
                    }
                </script>
            </div>
        </div>
    </div>
</div>
<script src="<%=contextPath%>/layui/layui.js"></script>
<script>
    layui.use('laydate', function () {
        var laydate = layui.laydate;
        //直接嵌套显示
        laydate.render({
            elem: '#test-n1'
            , position: 'static'
        });
        laydate.render({
            elem: '#test-n2'
            , position: 'static'
            , lang: 'en'
        });
    });
</script>
</body>
</html>
