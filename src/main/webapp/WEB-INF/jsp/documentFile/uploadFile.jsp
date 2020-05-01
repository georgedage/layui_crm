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
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
    <legend>文件上传</legend>
</fieldset>
<form class="layui-form" method="post">
    <div style="padding: 20px; background-color: #F2F2F2;">
        <div class="layui-row layui-col-space15">
            <div class="layui-inline">
                <label class="layui-form-label">上传文件：</label>
                <div class="layui-input-inline">
                    <button type="button" class="layui-btn" id="test1"><i class="layui-icon"></i>上传文件</button>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">文件描述</label>
                <div class="layui-input-inline">
                    <input type="text" name="filemsg" lay-verify="required" autocomplete="off" placeholder="请输入文件描述"
                           class="layui-input">
                </div>
            </div>
            <button class="layui-btn" lay-submit lay-filter="formBtn"
                    style="margin-left: 120px">立即添加
            </button>
        </div>
    </div>
</form>

<script src="<%=contextPath%>/layui/layui.js"></script>
<script>
    layui.use(['upload', 'form'], function () {
        var $ = layui.jquery
        var form = layui.form
            , upload = layui.upload;
        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1'
            , url: '<%=contextPath%>/download/uploadImg'
            , before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $('#demo1').attr('src', result); //图片链接（base64）
                });
            }
            , done: function (res) {
                //如果上传失败
                if (res.code > 0) {
                    return layer.msg('上传失败');
                }
                //上传成功
                layer.msg('上传成功！', {time: 1 * 1000});
            }
            , error: function () {
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function () {
                    uploadInst.upload();
                });
            }
        });

        //监听提交点击事件
        form.on('submit(formBtn)', function (data) {
            console.log(JSON.stringify(data.field));
            //像服务端发送请求
            $.ajax({
                url: '<%=contextPath%>/download/docSave',
                data: JSON.stringify(data.field),
                type:'POST',
                contentType: 'application/json',  //数据类型格式
                success: function (result) {
                    console.log("-------------------->"+result);
                    if (result == "success") {
                        layer.msg('添加成功！', {time: 1 * 1000}, function () {
                            location.reload();
                        });
                    } else {
                        layer.msg('添加失败！', {icon: 5});
                    }
                },
                error: function (errorMsg) {
                    alert("数据异常！" + errorMsg);
                    location.reload();
                },
            });
            return false;
        });
    });

</script>
</body>
</html>
