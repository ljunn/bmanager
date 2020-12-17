<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>管理 - 登录</title>
    <script src="/lib/vue.js" ></script>
    <script src="/lib/antdesign/antd.min.js" ></script>
    <link rel="stylesheet" href="/lib/layui/css/layui.css"></link>
    <link rel="stylesheet" href="/lib/antdesign/antd.min.css"></link>

    <link rel="stylesheet" href="/css/login.css"></link>
    <script src="/lib/moment.min.js"></script>
    <script src="/lib/layui/layui.js"></script>
    <script src="/lib/jquery.min.js"></script>
    <style>
        @media screen and (max-width: 1024px) {
            .video-player{display: none;}
            .login{
                height:100%;width:100%;
                padding: 20px;
                background-color:rgba(0,0,0,0.5);
                border-radius: 4px;
                position:absolute;left: 0;top: 0; margin:0;z-index:99;
            }
            .login h1{ text-align:center; color:#fff; font-size:24px; margin-bottom:20px; }
            .form_code .code{  right:0; top:1px; cursor:pointer; }
            .login_btn{ width:100%; height:80px;}
            .layui-input{height:80px;font-size:40px;border-radius: 4px;}
        }
    </style>
</head>
<body>
<div id="app">
    <video class="video-player" preload="auto" autoplay="autoplay" loop="loop" data-height="1080" data-width="1920" height="1080" width="1920">
        <source src="/video/login.mp4" type="video/mp4">
    </video>
    <div class="video_mask"></div>
    <div class="login">
        <h1>后台管理登录</h1>
        <form class="layui-form" method="post" action="/users/login">
            <div class="layui-form-item">
                <input class="layui-input" name="username" placeholder="用户名" lay-verify="required" type="text" autocomplete="off">
            </div>
            <div class="layui-form-item">
                <input class="layui-input" name="password" placeholder="密码" lay-verify="required" type="password" autocomplete="off">
            </div>
            <input class="layui-btn login_btn" type="submit"></input>
        </form>
    </div>
</div>

<script>
    var vue=new Vue({
        el:'#app',
        data:{
            status:<#if status?if_exists>
                false
            <#else>
            true
            </#if>
        },
        methods:{
            showLoginFailed(){
                if (this.status==false){
                    this.$message.error('用户名或者密码错误');
                }
            }
        },
        created(){
            this.showLoginFailed();
        }
    });

    //video背景
    $(window).resize(function(){
        if($(".video-player").width() > $(window).width()){
            $(".video-player").css({"height":$(window).height(),"width":"auto","left":-($(".video-player").width()-$(window).width())/2});
        }else{
            $(".video-player").css({"width":$(window).width(),"height":"auto","left":-($(".video-player").width()-$(window).width())/2});
        }
    }).resize();

</script>

</body>
</html>