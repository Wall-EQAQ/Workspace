<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <% pageContext.setAttribute("APP_PATH",request.getContextPath()); %>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>FirstCRUD</h1>
        </div>
        <div class="col-md-4 col-lg-offset-8">
            <button id="increaseBtn" type="button" class="btn btn-primary">
                新增
            </button>
            <button id="deleteBtn" type="button" class="btn btn-danger">
                删除
            </button>
        </div>
        <div class="col-md-12">
            <table id="emp_table" class="table table-hover">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <%--显示分页信息--%>
        <div class="row">
            <%--显示分页文字信息--%>
            <div id="page_info_area" class="col-md-6">

            </div>
            <%--分页条Navbar--%>
            <div id="page_nav_area" class="col-md-6">

            </div>
        </div>
    </div>

</div>
<!-- 添加员工Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empName" name="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" id="male" name="gender" value="M" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" id="female" name="gender" value="F">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empEmail" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empEmail" name="email" placeholder="xiaoming@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="deptName" class="col-sm-2 control-label">部门名</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="deptName" name="dId"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save_emp">保存</button>
            </div>
        </div>
    </div>
</div>
<%--//员工修改模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_update_static" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" id="maleUpdate" name="gender" value="M" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" id="femaleUpdate" name="gender" value="F">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empEmail_update" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empEmail_update" name="email" placeholder="xiaoming@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门名</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="dept_update" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="update_emp">修改</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var totalRecord;
    //当DOM加载完成之后就去执行这个函数
    $(function () {
        to_page(1);
    });
    function to_page(pageNumber) {
        //发送ajax请求，从数据库中查出数据
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pageNumber="+pageNumber,
            type:"GET",
            success:function(result) {
                //1解析并显示员工数据
                build_emps_table(result);
                //2分页文字显示
                build_page_info(result);
                //3分页条信息显示
                build_nav_info(result);
            }
        });
    }
    //1.构建出员工列表
    function build_emps_table(result) {
        $("#emp_table tbody").empty();
        var emps=result.objectMap.pageInfo.list;
        $.each(emps,function (index,item) {
            //向页面中动态添加遍历出的数据
            var empIdTd=$("<td></td>").append(item.empId);
            var empNameTd=$("<td></td>").append(item.empName);
            var genderTd=$("<td></td>").append(item.gender=="M"?"男":"女");
            var emailTd=$("<td></td>").append(item.email);
            var deptNameTd=$("<td></td>").append(item.department.deptName);



            var editBtn=$("<button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性，用来表示员工id
            editBtn.attr("edit-id",item.empId);
            var delBtn=$("<button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span>").addClass("glyphicon glyphicon-trash")).append("删除");
            var empTable=$("<tr></tr>")
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(editBtn)
                .append(" ")
                .append(delBtn)
                .appendTo("#emp_table tbody");
        });
    }
    //2.分页文字信息显示
    function build_page_info(result) {
        $("#page_info_area").empty();
        var emps=result.objectMap.pageInfo;
        $("#page_info_area").append("当前是第"+emps.pageNum+"页 "+"总"+emps.pages+"页 "+"共"+emps.total+"条记录");
        totalRecord=emps.total;
    }
    //3分页条信息显示
    function build_nav_info(result) {
        $("#page_nav_area").empty();
        var navLable=$("<nav>");
        var ul=$("<ul>").addClass("pagination");
        var firstPage=$("<li>").append($("<a>").append("首页").attr("href","#"));
        var prePage=$("<li>").append($("<a>").append("&laquo;"));
        var nextPage=$("<li>").append($("<a>").append("&raquo;"));
        var lastPage=$("<li>").append($("<a>").append("末页").attr("href","#"));

        if (result.objectMap.pageInfo.hasPreviousPage==false){
            firstPage.addClass("disabled");
            prePage.addClass("disabled");
        }else {
            firstPage.click(function () {
                to_page(1);
            });
            prePage.click(function () {
                to_page(result.objectMap.pageInfo.pageNum-1);
            });
        }
        if (result.objectMap.pageInfo.hasNextPage==false){
            nextPage.addClass("disabled");
            lastPage.addClass("disabled");
        }else {
            nextPage.click(function () {
                to_page(result.objectMap.pageInfo.pageNum+1);
            });
            lastPage.click(function () {
                to_page(result.objectMap.pageInfo.pages);
            });
        }
        ul.append(firstPage).append(prePage);
        $.each(result.objectMap.pageInfo.navigatepageNums,function (index,item) {

            var numLi=$("<li>").append($("<a>").append(item));
            if (result.objectMap.pageInfo.pageNum==item){
                numLi.addClass("active");
            }
            numLi.click(function () {
               to_page(item);
               console.log(item);
            });
            ul.append(numLi);
        });
        ul.append(nextPage).append(lastPage);
        navLable.append(ul).appendTo("#page_nav_area");

    }
    //获取部门编号，显示在下拉列表中
    function getDepartments(ele) {
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                $.each(result.objectMap.deptInfo,function (index,item) {
                    //"objectMap":{"departmentInfo":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}
                    var optionEle=$("<option>").append(item.deptName).attr("value",item.deptId);
                    optionEle.appendTo(ele);
                })
            }
        });
    }
    //清空表单样式及内容
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-success has-error");
        //找到提示信息的help-block,清空内容
        $(ele).find(".help-block").text("");
    }

    //点击新增，弹出模态框;
    $("#increaseBtn").click(function () {
        //jQuery没有reset方法，该方法属于DOM对象所以需要加上 [0]
        //$("#empAddModal form")[0].reset();
        //清除表单数据
        reset_form("#empAddModal form");
        //发送ajax请求，获取部门信息显示在下拉列表中
        getDepartments("#empAddModal select");
        $("#empAddModal").modal({
            backdrop:"static"
        });

    });
    //显示校验结果的提示信息(成功或者失败)
    function show_validate_msg(ele,status,message){
        //移除被选元素的直接上级父元素的class
        $(ele).parent().removeClass("has-success has-error");
        //提示信息的文本内容也应该清空
        $(ele).next("span").text("");
        if ("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(message);
        }else if ("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(message);
        }
    }
    //后台校验用户名是否可用
    $("#empName").change(function () {
        //1前台校验用户名
        var empName = $("#empName").val();//或者        var empName=this.value;
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            show_validate_msg("#empName", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
            return false;
        } else {
            show_validate_msg("#empName", "success", " ");
        }
        //前台校验通过之后，再去后台校验用户名是否已经注册
        $.ajax({
            url: "${APP_PATH}/checkname",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 200) {
                    show_validate_msg("#empName", "success", " ");
                    $("#save_emp").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName", "error", "用户名已被注册");
                    $("#save_emp").attr("ajax-va", "error");
                }
            }
        });
    });
    //校验邮箱是否可用
    $("#empEmail").change(function () {
        //先前台校验
        var empEmail = $("#empEmail").val();  //var empEmail=this.value;
        var regEmail = /^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(empEmail)) {
            show_validate_msg("#empEmail", "error", "请输入正确的邮箱");
            return false;
        } else {
            show_validate_msg("#empEmail", "success", " ");
        }
        //前台校验成功，再去后台ajax校验
        $.ajax({
            url: "${APP_PATH}/checkemail",
            data: "empEmail=" + empEmail,
            type: "POST",
            success: function (result) {
                if (result.code == 200) {
                    //输入正确就不用提示信息
                    show_validate_msg("#empEmail", "success", " ");
                    $("#save_emp").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empEmail", "error", "该邮箱已被注册");
                    $("#save_emp").attr("ajax-va", "error");
                }
            }
        });
    });
    //保存员工
    $("#save_emp").click(function () {
        if($(this).attr("ajax-va")=="error"){
            return false;
        }
        $.ajax({
            url:"${APP_PATH}/emp",
            data:$("#empAddModal form").serialize(),
            type:"POST",
            success:function (result) {
                    console.log($("#empAddModal form").serialize());
                    //员工保存成功，关闭模态框
                    $("#empAddModal").modal("hide");
                    //去最后一页，显示刚才保存的数据
                    to_page(totalRecord);
            }
        });
    });
    //修改员工信息
    $(document).on("click",".edit_btn",function () {
        //弹出模态框
        //1.查出部门信息
        getDepartments("#empUpdateModal select");
        //2.查询员工信息并显示
        getEmp($(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                console.log(result);
                var empData=result.objectMap.emp;
                //为p标签的文本框添加内容
                $("#empName_update_static").text(empData.empName);
                //为input输入框添加内容
                $("#empEmail_update").val(empData.email);
                //找到name属性值为gender的input输入框
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select[id=dept_update]").val([empData.dId]);
            }
        })
    }

</script>
</body>
</html>
