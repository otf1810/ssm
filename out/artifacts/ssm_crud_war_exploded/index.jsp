<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>index</title>
    <script type="text/javascript"
            src="static/js/jquery-1.12.4.min.js"></script>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
          rel="stylesheet">
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 员工修改模态框-->
<div class="modal fade" id="update_emp_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">lastName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="update_lastName_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input class="form-control" name="email" id="update_email" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="1" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="0"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">department</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="deptId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="update_emp_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工新增模态框 -->
<div class="modal fade" id="add_emp_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">lastName</label>
                        <div class="col-sm-10">
                            <input class="form-control" name="lastName" id="input_lastName" placeholder="lastName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input class="form-control" name="email" id="input_email" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_male" value="1" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_female" value="0"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">department</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="deptId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save_emp_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">

    <div class="row">
        <h1>SSM-CRUD</h1>
    </div>

    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增
            </button>
            <button type="button" class="btn btn-danger" id="emp_del_btn">删除</button>
        </div>
    </div>

    <div class="row">
        <table class="table table-striped" id="emp_table">
            <thead>
            <tr>
                <th>
                    <input type="checkbox" class="check_all"/>
                </th>
                <th>empId</th>
                <th>lastName</th>
                <th>gender</th>
                <th>email</th>
                <th>deptName</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>

    <div class="row">
        <div class="col-md-6" id="page_info_area"></div>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>

</div>
</body>

</html>

<script type="text/javascript">
    var TotalRecord, currentPage;
    $(function () {
        //第一次加载进入首页
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${ APP_PATH }/emps",
            data: "pageNum=" + pn,
            type: "GET",
            success: function (result) {
                // 1.加载员工信息
                build_emps_table(result);
                // 2.加载分页信息
                build_page_info(result);
                // 3.加载分页条
                build_page_nav(result);
            }

        });
    }

    function build_emps_table(result) {
        //每次加载员工信息，先清除原来的信息
        $("#emp_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.id);
            var lastNameTd = $("<td></td>").append(item.lastName);
            var genderTd = $("<td></td>").append(item.gender == "1" ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-xs edit_btn").append("编辑");
            editBtn.attr("edit_id", item.id);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-xs del_btn").append("删除");
            delBtn.attr("del_id", item.id);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(lastNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo($("#emp_table tbody"))
        });

    }

    function build_page_info(result) {
        //每次加载分页信息，先清除原来的信息
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第" + result.extend.pageInfo.pageNum
            + "页" + "共" + result.extend.pageInfo.pages + "页" + "总" +
            result.extend.pageInfo.total + "条记录");
        TotalRecord = result.extend.pageInfo.total;
    }

    function build_page_nav(result) {
        currentPage = result.extend.pageInfo.pageNum;
        //每次加载分页条，先清除原来的信息
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>")
            .append("首页"));
        var prePageLi = $("<li></li>").append($("<a></a>")
            .append("&laquo;"));
        if (!result.extend.pageInfo.hasPreviousPage) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            firstPageLi.click(function () {
                to_page(1)
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1)
            })
        }

        var lastPageLi = $("<li></li>").append($("<a></a>")
            .append("末页"));
        var nextPageLi = $("<li></li>").append($("<a></a>")
            .append("&raquo;"));
        if (!result.extend.pageInfo.hasNextPage) {
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        } else {
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages)
            });
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1)
            });
        }
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var currentPage = $("<li></li>").append($("<a></a>").append(item));
            currentPage.click(function () {
                to_page(item);
            })
            if (item == result.extend.pageInfo.pageNum)
                currentPage.addClass("active");
            ul.append(currentPage);
        })
        ul.append(nextPageLi).append(lastPageLi);
        ul.appendTo($("#page_nav_area"));
    }

    $("#emp_add_modal_btn").click(function () {
        //清除提示信息和样式
        $("#input_lastName").parent().removeClass("has-success has-error");
        $("#input_email").parent().removeClass("has-success has-error");
        $("#input_lastName").next("span").text("");
        $("#input_email").next("span").text("");
        //清除之前输入的信息
        $("#add_emp_modal form")[0].reset();
        //获取部门信息
        getDepts($("#add_emp_modal select"));
        //显示员工添加的模块框
        $("#add_emp_modal").modal();
    })

    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "${ APP_PATH }/depts",
            type: "GET",
            success: function (result) {
                // console.log(result);
                $.each(result.extend.depts, function () {
                    var deptOption = $("<option></option>").append(this.deptName).attr("value", this.id);
                    deptOption.appendTo(ele);
                });
            }
        })
    }

    function show_validate_msg(ele, status, msg) {
        ele.parent().removeClass("has-success has-error");
        ele.next("span").text("");
        if ("success" == status) {
            ele.parent().addClass("has-success");
        } else if ("error" == status) {
            ele.parent().addClass("has-error");
        }
        ele.next("span").text(msg);
    }

    $("#input_lastName").change(function () {
        var lastName = this.value;
        $.ajax({
            url: "${ APP_PATH }/checkLastName",
            data: "lastName=" + lastName,
            type: "GET",
            success: function (result) {
                if (result.code == "100") {
                    show_validate_msg($("#input_lastName"), "success", "用户名可用！");
                    $("#save_emp_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg($("#input_lastName"), "error", result.extend.va_msg);
                    $("#save_emp_btn").attr("ajax-va", "error");
                }
            }
        })
    })

    $("#input_email").change(function () {
        var email = this.value;
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg($("#input_email"), "error", "邮箱格式不正确！");
            $("#save_emp_btn").attr("ajax-va", "error");
        } else {
            show_validate_msg($("#input_email"), "success", "邮箱可用！");
            $("#save_emp_btn").attr("ajax-va", "success");
        }
    })

    //获取JSON数据的长度
    function getJsonLength(jsonData) {
        var length = 0;
        for (var ever in jsonData) {
            length++;
        }
        return length;
    }

    $("#save_emp_btn").click(function () {

        if ($(this).attr("ajax-va") == "error")
            return false;

        var data = decodeURIComponent($("#add_emp_modal form").serialize(), true);
        // alert(data);
        $.ajax({
            url: "${ APP_PATH }/emp",
            data: data,
            type: "POST",
            success: function (result) {
                //如果JSR303有错误信息，则显示
                if (getJsonLength(result.extend.errors) > 0) {
                    show_validate_msg($("#input_email"), "error", result.extend.errors.email);
                    show_validate_msg($("#input_lastName"), "error", result.extend.errors.lastName);
                } else {
                    //关闭模态框
                    $("#add_emp_modal").modal("hide");
                    //跳到员工表最后一页
                    to_page(TotalRecord);
                }
            }
        })
    })

    $(document).on("click", ".edit_btn", function () {
        //清除样式
        $("#update_email").parent().removeClass("has-success has-error");
        $("#update_email").next("span").text("");
        //打开模态框
        $("#update_emp_modal").modal();
        //获取部门名称
        getDepts($("#update_emp_modal select"));
        //获取当前员工
        getEmp($(this).attr("edit_id"));
        //将当前员工的ID绑定到模态框的“更新”按钮上
        $("#update_emp_btn").attr("edit_id", $(this).attr("edit_id"));

    })

    function getEmp(id) {
        $.ajax({
            url: "${ APP_PATH }/emp/" + id,
            type: "GET",
            success: function (result) {
                // console.log(result.extend.emp);
                var empData = result.extend.emp;
                $("#update_lastName_static").text(empData.lastName);
                $("#update_email").val(empData.email);
                $("#update_emp_modal input[name=gender]").val([empData.gender])
                $("#update_emp_modal select").val(empData.deptId);
            }
        })
    }

    $("#update_email").change(function () {
        var email = this.value;
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg($("#update_email"), "error", "邮箱格式不正确！");
            $("#update_emp_btn").attr("ajax-va", "error");
        } else {
            show_validate_msg($("#update_email"), "success", "邮箱可用！");
            $("#update_emp_btn").attr("ajax-va", "success");
        }
    })

    $("#update_emp_btn").click(function () {
        var data = decodeURIComponent($("#update_emp_modal form").serialize(), true);
        $.ajax({
            url: "${ APP_PATH }/emp/" + $(this).attr("edit_id"),
            type: "PUT",
            data: data,
            success: function (result) {
                //关闭模态框
                $("#update_emp_modal").modal("hide");
                //返回到当前员工的页面
                to_page(currentPage);
            }
        })
    })

    $(document).on("click", ".del_btn", function () {
        var lastName = $(this).parents("tr").find("td:eq(2)").text();
        var id = $(this).attr("del_id");
        // alert(lastName + " " + id);
        if (confirm("确认删除[" + lastName + "]吗？")) {
            $.ajax({
                url: "${ APP_PATH }/emp/" + id,
                type: "DELETE",
                success: function (result) {
                    //返回到当前员工的页面
                    to_page(currentPage);
                }
            })
        } else {
            return false;
        }
    })

    //全选和全不选
    $(".check_all").click(function () {
        $(".check_item").prop("checked", $(this).prop("checked"));
    });

    $(document).on("click", ".check_item", function () {
        // alert($(".check_item:checked").length)
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $(".check_all").prop("checked", flag);
    })

    $("#emp_del_btn").click(function () {
        var lastNames = "";
        var ids = "";
        // $(".check_item:checked")
        $.each($(".check_item:checked"), function () {
            lastNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            ids += $(this).parents("tr").find("td:eq(1)").text() + "-";
        })
        lastNames = lastNames.substring(0,lastNames.length-1);
        ids = ids.substring(0,ids.length-1);
        if (confirm("确认要删除【" + lastNames + "】吗？")) {
            $.ajax({
                url: "${ APP_PATH }/emp/"+ids,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            })
        } else {
            return false;
        }
    })

</script>
