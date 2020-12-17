<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>车辆管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <script src="/lib/vue.js" ></script>
    <script src="/lib/antdesign/antd.min.js" ></script>
    <script src="/lib/axios.min.js" ></script>
    <script src="/lib/layui/layui.js" ></script>
    <link rel="stylesheet" href="/lib/antdesign/antd.min.css"></link>



    <script src="/lib/moment.min.js"></script>
    <script src="/lib/jquery.min.js"></script>
    <script src="/lib/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/index.css"></link>
    <link rel="stylesheet" href="/lib/layui/css/layui.css"></link>
    <link rel="stylesheet" href="/lib/jqgrid/ui.jqgrid-bootstrap.css">


    <script src="/lib/jqgrid/grid.locale-cn.js"></script>
    <script src="/lib/jqgrid/jquery.jqGrid.min.js"></script></head>
<body>
<div id="app">
    <div v-show="show">
        <table class="layui-hide" id="demo" lay-filter="demo"></table>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-sm" lay-event="add">添加</button>
            </div>
        </script>

        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
        </script>
    </div>

    <div v-show="!show">
        <form class="layui-form" action="/bus/addOrUpdate">

                <div class="layui-form-item">
                    <label class="layui-form-label">编号</label>
                    <div class="layui-input-block">
                        <input type="text" name="id"  v-model="bus.id" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">名称</label>
                    <div class="layui-input-block">
                        <input type="text" name="name"  v-model="bus.name" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">车辆型号</label>
                    <div class="layui-input-block">
                        <input type="text" name="types"  v-model="bus.types" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">司机</label>
                    <div class="layui-input-block">
                        <select name="siji" v-model="bus.siji">
                            <option v-for="item in siji"  :value="item.id"  >{{item.name}}</option>
                        </select>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">线路</label>
                    <div class="layui-input-block">
                        <select name="buslines" v-model="bus.buslines">
                            <option v-for="item in lines" :value="item.id" >{{item.id}}</option>
                        </select>
                    </div>
                </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                </div>
            </div>
        </form>
    </div>

</div>

<script >
    layui.use('table', function(){
        var table = layui.table;

        table.render({
            elem: '#demo'
            ,url:'/bus/list'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print']
            ,title: '车辆数据表'
            ,cols: [[
                {field:'id', title:'编号'},
                {field:'name', title:'名称'},
                {field:'types', title:'车辆型号'},
                {field:'siji', title:'司机'},
                {field:'buslines', title:'线路'},
                {fixed:'right',title:'操作',toolbar:'#barDemo'}
            ]]
            ,page: true
        });


        //头工具栏事件
        table.on('toolbar(demo)', function(obj){
            switch(obj.event){
                case 'add':
                    vue.handleAdd();
                    break;
            };
        });

        //监听行工具事件
        table.on('tool(demo)', function(obj){
            var data = obj.data;
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    vue.handleDelete(data.id);
                    obj.del();
                    layer.close(index);
                });
            } else if(obj.event === 'edit'){
                vue.handleEdit(data);
            } else if(obj.event === 'add'){
                vue.handleAdd();
            }
        });
    })



    var vue=new Vue({
        el:'#app',
        data:{
            show:true,
            bus :{},
            siji:{},
            lines:{}
        },
        methods:{
            async initData(){
                var that=this;
                await axios.get('/siji/list').then(function (response) {
                    that.siji= response.data.data
                }).catch(function (error) {
                    console.log(error)
                });

                await axios.get('/buslines/list').then(function (response) {
                    that.lines= response.data.data
                }).catch(function (error) {
                    console.log(error)
                });

                await that.update();
            },
            handleAdd(){
                this.show=false;
                this.bus={};
            },
            handleEdit(bus){
                this.show=false;
                this.bus=bus;
            },
            handleDelete(id){
                axios.get("/bus/delete?id="+id).then(function (response) {
                    this.$message.error('删除成功！');
                }).catch(function (error) {
                    console.log(error)
                });
            },
            returnMain(){
                this.show=true;
            },
            update(){
                layui.use(['form'], function(){
                    var form = layui.form;
                    form.render();
                })
            }
        },
        mounted(){
            this.initData();

        }
    })
</script>


</body>
</html>