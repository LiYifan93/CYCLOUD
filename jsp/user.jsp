<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>用户信息</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">  
    <link rel="stylesheet" href="${contextPath}/jsp/libs/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${contextPath}/jsp/libs/dist/css/AdminLTE.min.css">
</head>
<body>
    <div class="login-box">
         <div class="login-box-body">
            <p class="login-box-msg">个人信息</p>
        <form id="user">
            <div class="input-group" style="margin:10px ">
                <span class="input-group-btn">
                            <button class="btn btn-primary" type="button" disabled>名称</button>
                    </span>
                <input type="text" id="user" name="user" class="form-control" disabled placeholder="请填写用户名称">
            </div>

            <div class="input-group" style="margin:10px ">
                <span class="input-group-btn">
                            <button class="btn btn-primary" type="button" disabled>账号</button>
                    </span>
                <input type="text" id="userName" class="form-control" name="userName"  disabled placeholder="请填写账号">
            </div>

            <div class="input-group" style="margin:10px ">
                <span class="input-group-btn">
                            <button class="btn btn-primary" type="button" disabled>昵称</button>
                    </span>
                <input type="text" id="nickName" name="nickName" class="form-control"  disabled placeholder="请填写用户昵称">
            </div>

            <div class="input-group" style="margin:10px ">
                <span class="input-group-btn">
                            <button class="btn btn-primary" type="button" disabled>邮箱</button>
                    </span>
                <input type="email" id="email" class="form-control" name="email"  disabled placeholder="请填写用户邮箱">
            </div>

            <div class="input-group" style="margin:10px ">
                <span class="input-group-btn">
                            <button class="btn btn-primary" type="button" disabled>电话</button>
                    </span>
                <input type="text" id="phone" class="form-control" name="phone"  disabled placeholder="请填写用户电话">
            </div>

            <div class="input-group" style="margin:10px ">
                <span class="input-group-btn">
                            <button class="btn btn-primary" type="button" disabled>手机</button>
                    </span>
                <input type="tel" class="form-control" id="mobile" name="mobile"  disabled placeholder="请填写用户手机">
            </div>

            <div class="input-group" style="margin:10px ">
                <span class="input-group-btn">
                            <button class="btn btn-primary" type="button" disabled>性别</button>
                 </span>
                <select class="form-control" id="sex" name="sex">
                    <option value="0">男</option>
                    <option value="1">女</option>
                </select>
            </div>

            <div class="input-group" style="margin:10px ">
                <span class="input-group-btn">
                    <button class="btn btn-primary" type="button" disabled>部门</button>
                </span>
                <input type="text" id="departmentId" name="departmentId" class="form-control"   disabled placeholder="请填写用户部门">
            </div>

            <div class="input-group" style="margin:10px ">
                <span class="input-group-btn">
                     <button class="btn btn-primary" type="button" disabled>类型</button>
                </span>
                <select class="form-control" id="userType" name="userType" disabled>
                    <option value="0">管理员</option>
                    <option value="1">普通用户</option>
                </select>
            </div>

            <div style="margin:10px ">
                <div class="col-xs-1"></div>
                <button type="submit" class="btn btn-success col-xs-4">
                                                提交
                </button>
                <div class="col-xs-2"></div>
                <button id="signOut" class="btn btn-danger col-xs-4">
              		  退出登录
                </button>
                <div class="col-xs-1"></div>
            </div>


        </form>
        </div>

    </div>

    <script src="${contextPath}/jsp/libs/jquery/jquery.js"></script>
    <script src="${contextPath}/jsp/libs/bootstrap/js/bootstrap.min.js"></script>
    <script>
        window.onload = function() {
            $.ajax({
                type: 'post',
                url: '/login/personal',
                dataType: 'json',
                success: function(res) {
                    if (res.code == 1) {
                        console.log(res.data)
                        $('#user').val(res.data.user)
                        $('#userName').val(res.data.userName)
                        $('#nickName').val(res.data.nickName)
                        $('#email').val(res.data.email)
                        $('#phone').val(res.data.phone)
                        $('#mobile').val(res.data.mobile)
                        $('#sex').val(res.data.sex)
                        $('#departmentId').val(res.data.departmentId)
                        $('#userType').val(res.data.userType)
                    } else {
                        console.log(res.message)
                    }
                },
                error: function(err) {
                    console.log(err)
                }

            })
        }
        // 退出
        $('#signOut').click(function() {
            $.ajax({
                type: 'post',
                dataType: 'json',
                url: 'login/logout',
                success: function(res) {
                    alert(res)
                },
                error: function(res) {
                    alert(res)
                }
            })
        })
    </script>

</body>

</html>