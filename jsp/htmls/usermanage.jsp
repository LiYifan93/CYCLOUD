<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>角色管理</title>
    <link href="${contextPath}/jsp/libs/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${contextPath}/jsp/libs/fonts/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${contextPath}/jsp/libs/bootstrap-table/bootstrap-table.css" />
    <!--日期控件-->
    <link rel="stylesheet" href="${contextPath}/jsp/libs/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="${contextPath}/jsp/libs/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" type="text/css" href="${contextPath}/jsp/libs/bootstrap-duallistbox/bootstrap-duallistbox.css">
    <link rel="stylesheet" href="${contextPath}/jsp/libs/bootstrapValidator/bootstrapValidator.css">
    <script src="${contextPath}/jsp/libs/jquery/jquery.js"></script>
    <script src="${contextPath}/jsp/libs/bootstrap/js/bootstrap.js " charset="UTF-8"></script>
    <script src="${contextPath}/jsp/libs/bootstrap-duallistbox/jquery.bootstrap-duallistbox.js"></script>
    <script src="${contextPath}/jsp/libs/bootstrapValidator/bootstrapValidator.js"></script>	
    
    <!--[if lt IE 9]>
    <script src="http://apps.bdimg.com/libs/html5shiv/3.7/html5shiv.min.js"></script>
    <script src="http://apps.bdimg.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<style>
    	.middle{
    		vertical-align: middle !important;
    	}
    	.has-feedback {
		    position: relative;
		}
    	.form-control-feedback {
		    position: absolute;
		    top: 0;
		    right: 0;
		    z-index: 2;
		    display: block;
		    width: 34px;
		    height: 34px;
		    line-height: 34px;
		    text-align: center;
		    pointer-events: none;
		} 
		
		input:invalid {
		    border-color: red;
		}
		input,
		input:valid {
		    border-color: #ccc;
		}
    </style>
</head>

<body style="padding-top: 50px;">

    <nav class="navbar navbar-brand navbar-fixed-top" style="background-color: white">
        <section class="content-header">
            <ol class="breadcrumb" style="background: white; font-size: 15px;">
                <li><a><i class="fa fa-dashboard"></i> 当前位置</a></li>
                <li><a>权限管理</a></li>
                <li class="active">用户管理</li>
            </ol>
        </section>
    </nav>
    
    <div id="modal-search" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" aria-label="Close">
									&times;
								</button>
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;">请填写搜索条件</h4>
                </div>

                <div class="modal-body ">
                	<form  class="form-horizontal"> 
                        <div class="form-group">
                            <label for="searchUserName" class="control-label col-md-3">账号</label>
                            <div class="col-md-8">
                                <input type="text" id="searchUserName" name="userName"  minlength="3" maxlength="16" pattern="[a-zA-Z0-9_\.]+$" title="账号只能是3-16位的数字、字母、 点和下划线" class="form-control" class="form-control" placeholder="请输入账号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchNickName" class="control-label col-md-3">昵称</label>
                            <div class="col-md-8">
                                <input type="text" id="searchNickName" name="nickName" minlength="3" maxlength="10" title="昵称只能是3-10位的字符"  pattern="[A-Za-z0-9_\-\u4e00-\u9fa5]+" class="form-control" placeholder="请输入昵称">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="searchSex" class="control-label col-md-3">性别</label>
                            <div class="col-md-8">
                                <select name="sex" id="searchSex" class="form-control" style="width:100%">
                                   <option selected value="">所有</option>
                                   <option value="0">男</option>
                                   <option value="1">女</option>
                               </select>
                            </div>
                        </div>
                        
                        <div class="form-group" style="display:none">
                            <label for="searchUserType" class="control-label col-md-3">类别</label>
                            <div class="col-md-8">
                                <select name="userType" id="searchUserType" class="form-control" style="width:100%">
                                   <option selected value="">所有</option>
                                   <option value="0">管理员</option>
                                   <option value="1">普通用户</option>
                               </select>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="searchEmail" class="control-label col-md-3">邮箱</label>
                            <div class="col-md-8">
                                <input type="email" id="searchEmail" name="email"  title="请输入正确的邮箱格式，如：123@qq.com" pattern="^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+" class="form-control" placeholder="请输入邮箱">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="searchPhone" class="control-label col-md-3">电话</label>
                            <div class="col-md-8">
                                <input type="tel" id="searchPhone" name="phone" title="请输入正确的电话号码，如0551-5555555" pattern="([0-9]{3,4}-)?[0-9]{7,8}" class="form-control" placeholder="请输入电话">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="searchMobile" class="control-label col-md-3">手机号</label>
                            <div class="col-md-8">
                                <input type="tel" id="searchMobile" name="mobile" maxlength="11" minlength="11" title="请输入正确的手机号码" pattern="^((\+?86)|(\(\+86\)))?(13[012356789][0-9]{8}|15[012356789][0-9]{8}|18[02356789][0-9]{8}|147[0-9]{8}|1349[0-9]{7})$" class="form-control" placeholder="请输入手机号">
                            </div>
                        </div>
                        
                        <!-- <div class="form-group">
                            <label for="searchDepartmentId" class="control-label col-md-3">所属部门</label>
                            <div class="col-md-8">
                                <input type="text" id="searchDepartmentId" name="departmentId" class="form-control" placeholder="请输入所属部门">
                            </div>
                        </div> -->
                        
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" id="searchButton" class="btn btn-success">确定</button>
                        </div>
                     </form>
                </div>
            </div>
        </div>
    </div>
    
     <div id="modal-add" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" aria-label="Close">
									&times;
								</button>
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;">请填写添加事件</h4>
                </div>

                <div class="modal-body ">
                	<form id="add" class="form-horizontal">
                        <div class="form-group has-feedback">
                            <label for="userName" class="control-label col-md-3">账号</label>
                            <div class="col-md-8">
                                <input type="text" name="userName" minlength="3" maxlength="16" pattern="[a-zA-Z0-9_\.]+$" title="账号只能是3-16位的数字、字母、 点和下划线" required  class="form-control" placeholder="请输入账号">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="password" class="control-label col-md-3">密码</label>
                            <div class="col-md-8">
                                <input type="text" name="password" minlength="3" maxlength="16" pattern="[a-zA-Z0-9_\.]+$" title="密码 只能是3-16位的数字、字母、 点和下划线" required class="form-control" placeholder="请输入密码">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="nickName" class="control-label col-md-3">昵称</label>
                            <div class="col-md-8">
                                <input type="text" name="nickName" minlength="3" maxlength="10" title="昵称只能是3-10位的字符" pattern="[A-Za-z0-9_\-\u4e00-\u9fa5]+" class="form-control" required placeholder="请输入昵称">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="sex" class="control-label col-md-3">性别</label>
                            <div class="col-md-8">
                                <select name="sex" class="form-control" required style="width:100%">
                                   <option value="0">男</option>
                                   <option value="1">女</option>
                               </select>
                            </div>
                        </div>
                        
                        <div class="form-group" style="display:none">
                            <label for="userType" class="control-label col-md-3" required>类别</label>
                            <div class="col-md-8">
                                <select name="userType"  class="form-control" style="width:100%">
                                  <!--  <option value="0">管理员</option> -->
                                   <option selected value="1">普通用户</option>
                               </select>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="email" class="control-label col-md-3" >邮箱</label>
                            <div class="col-md-8">
                                <input type="email" name="email" class="form-control" required  title="请输入正确的邮箱格式，如：123@qq.com" pattern="^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+"  placeholder="请输入操作员编号">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="phone" class="control-label col-md-3">电话</label>
                            <div class="col-md-8">
                                <input type="tel"  name="phone"  title="请输入正确的电话号码，如0551-5555555" pattern="([0-9]{3,4}-)?[0-9]{7,8}" class="form-control" required placeholder="请输入电话">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="mobile" class="control-label col-md-3">手机号</label>
                            <div class="col-md-8">
                                <input type="tel"  name="mobile" class="form-control" maxlength="11" minlength="11" title="请输入正确的手机号码" pattern="^((\+?86)|(\(\+86\)))?(13[012356789][0-9]{8}|15[012356789][0-9]{8}|18[02356789][0-9]{8}|147[0-9]{8}|1349[0-9]{7})$" required placeholder="请输入手机号">
                            </div>
                        </div>
                        
                        <div class="form-group " id="d_add">
                            <label for="departmentId" class="control-label col-md-3">停车场ID</label>
                            <div class="col-md-8">
                                <input type="text" class="departmentId" name="departmentId" required class="form-control" placeholder="请输入停车场ID">
                            </div>
                        </div>
                        
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="submit"  class="btn btn-success">确定</button>
                        </div>
                        
                     </form>
                </div>
            </div>
        </div>
    </div>
    
     <div id="modal-edit" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" aria-label="Close">
									&times;
								</button>
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;">请填写编辑事件</h4>
                </div>

                <div class="modal-body ">
                	<form id="edit" class="form-horizontal">
                        <div class="form-group">
                            <label for="userName" class="control-label col-md-3">账号</label>
                            <div class="col-md-8">
                                <input type="text" id="editUserName" name="userName"  minlength="3" maxlength="16" pattern="[a-zA-Z0-9_\.]+$" title="账号只能是3-16位的数字、字母、 点和下划线" class="form-control" class="form-control" placeholder="请输入账号">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="password" class="control-label col-md-3">密码</label>
                            <div class="col-md-8">
                                <input type="text" id="editPassword" name="password" minlength="3" maxlength="16" pattern="[a-zA-Z0-9_\.]+$" title="密码 只能是3-16位的数字、字母、 点和下划线" class="form-control" placeholder="请输入密码">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="nickName" class="control-label col-md-3">昵称</label>
                            <div class="col-md-8">
                                <input type="text" id="editNickName" name="nickName" minlength="3" maxlength="10" title="昵称只能是3-10位的字符"  pattern="[A-Za-z0-9_\-\u4e00-\u9fa5]+" class="form-control" placeholder="请输入昵称">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="sex" class="control-label col-md-3">性别</label>
                            <div class="col-md-8">
                                <select id="editSex" name="sex" class="form-control" style="width:100%">
                                   <option value="0">男</option>
                                   <option value="1">女</option>
                               </select>
                            </div>
                        </div>
                        
                        <div class="form-group" style="display:none">
                            <label for="userType" class="control-label col-md-3">类别</label>
                            <div class="col-md-8">
                                <select  id="editUserType" name="userType"  class="form-control" style="width:100%">
                                   <!-- <option value="0">管理员</option> -->
                                   <option selected value="1">普通用户</option>
                               </select>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="email" class="control-label col-md-3">邮箱</label>
                            <div class="col-md-8">
                                <input type="email" id="editEmail" name="email" class="form-control" title="请输入正确的邮箱格式，如：123@qq.com" pattern="^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+" placeholder="请输入操作员编号">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="phone" class="control-label col-md-3">电话</label>
                            <div class="col-md-8">
                                <input type="tel" id="editPhone"  name="phone" class="form-control" title="请输入正确的电话号码，如0551-5555555" pattern="([0-9]{3,4}-)?[0-9]{7,8}"  placeholder="请输入电话">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="mobile" class="control-label col-md-3">手机号</label>
                            <div class="col-md-8">
                                <input type="tel" id="editMobile" name="mobile" class="form-control" maxlength="11" minlength="11" title="请输入正确的手机号码" pattern="^((\+?86)|(\(\+86\)))?(13[012356789][0-9]{8}|15[012356789][0-9]{8}|18[02356789][0-9]{8}|147[0-9]{8}|1349[0-9]{7})$" placeholder="请输入手机号">
                            </div>
                        </div>
                        
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="submit"  class="btn btn-success">确定</button>
                        </div>                        
                     </form>
                </div>
            </div>
        </div>
    </div>
    
    <div  id="modal-role" class="modal fade" >
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"   aria-label="Close">
									&times;
								</button>
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;">请分配角色</h4>
                </div>
                <div class="modal-body">
                    <form id="demoform"  style="text-align:center">
				        <select multiple="multiple" size="10" name="duallistbox_demo1[]" class="r_list">
					    </select>
				        <br>
				         <div class="modal-footer">
		                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		                    <button type="submit" class="btn btn-primary">保存</button>
		                </div>
				    </form>
				    <script>
				    </script>
                </div>
               
            </div>
        </div>
    </div>
    
    <div class="container " style="margin-top: 50px">
        <div id="toolbar">
            <div class="btn-group">
            	 <button type="button" class="btn btn-default dropdown-toggle" style="border-radius: 10%;margin: 0 20px 0 0" title="导出" data-toggle="modal" data-target="#modal-export">
                     <i class="glyphicon glyphicon-export icon-share"></i>
                </button>
                <input type="button" id="refresh" class="btn btn-default pull-left " style="border-radius: 10%;margin: 0 20px 0 0"  value="刷新">
                <input type="button" class="btn btn-default pull-left operate search" style="border-radius: 10% ;margin:0 20px 0 0 ;line-height:normal"  data-toggle="modal" data-target="#modal-search" value="搜索">
                <input type="button" class="btn btn-default pull-left operate  add" style="border-radius: 10%;margin:0 20px 0 0" data-toggle="modal" data-target="#modal-add" value="添加">
            </div>
        </div>
        <!--
				bootstrapTable:在table标签属性里面配置参数，也可以通过js配置url：配置请求的路径；toggle: 初始化Table；
				pagination: 是否启用分页；size: 每页显示的数据条数；list：每页显示的行数； pagination-loop: 是否启用启用分页条无限循环；
				side-pagination: 分页位置(server服务器分页；client客户端分页)； response-handler: 格式化从服务器获取到的数据；
				 query-params:传递参数； cache: 是否启用服务器缓存； show-columns: 是否显示 内容列下拉框； refresh: 起否启用刷新； number: 初始化加载第一页，默认第一页
			-->
        <table id="table"  data-toggle="table" data-pagination="true" data-page-size="10" data-page-list="[10,20,30,All]" data-pagination-loop="false" data-side-pagination="server" data-response-handler="responseHandler"
            data-query-params="paginationParam" data-cache="false" data-toolbar="#toolbar" data-show-toggle="true"  data-show-refresh="true" data-method="post" data-page-number="1" data-content-type="application/x-www-form-urlencoded; charset=UTF-8">
            <thead>
                <tr>
                    <!--fidld: 需与后台返回数据保持一直； checkbox: 为true显示该列； visible: 为false隐藏该列； align、valign: 水平、垂直居中-->
                    <th data-field="check" data-class="middle" data-checkbox="true" data-align="center" data-valign="middle"></th>
                    <th data-field="userName" data-align="center" data-valign="middle">账号</th>
                    <th data-field="password" data-align="center" data-valign="middle">密码</th>
                    <th data-field="nickName" data-align="center" data-valign="middle">昵称</th>
                    <th data-field="sex" data-formatter="sexFormatter"  data-align="center" data-valign="middle">性别</th>
                    <th data-field="userType" data-formatter="userTypeFormatter" data-align="center" data-valign="middle">类型</th>
                    <th data-field="email" data-align="center" data-valign="middle">邮箱</th>
                    <th data-field="phone" data-align="center" data-valign="middle">电话</th>
                    <th data-field="mobile" data-align="center" data-valign="middle">手机号码</th>                    
                    <!-- <th data-field="departmentId" data-align="center" data-valign="middle">所属部门</th> -->
                    <th data-field="details" data-formatter="operateFormatter" data-events="operateEvents" data-align="center" data-valign="middle" data-width="70px">&nbsp;操&#x3000;作  &nbsp;</th>
                </tr>
            </thead>
        </table>
    </div>
    
    
	
    <script src="${contextPath}/jsp/libs/bootstrap-table/bootstrap-table.js?1 " charset="UTF-8"></script>
    <script src="${contextPath}/jsp/libs/bootstrap-table/bootstrap-table-zh-CN.js " charset="UTF-8"></script>
    <script src="${contextPath}/jsp/libs/bootstrap-datetimepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script>
    <script src="${contextPath}/jsp/libs/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script> 
    <script src="${contextPath}/jsp/libs/modal.js"></script>
    <script>   		
   		    var dataUrl = "${contextPath}/web/usermanage/findAll?departmentId="
   	   		var contextPath = "${contextPath}";
   	   		var addUrl = '${contextPath}/web/usermanage/add'
			// 格式化向服务器发送的参数
   	   			function paginationParam(params) {
   	   			    var currPage = Math.floor((params.offset + params.limit) / params.limit);
   	   			    return {
   	   			        'offset': currPage,
   	   			        'limit': params.limit,
   	   			        'userName':$('#searchUserName').val(),
   	   			  		'nickName':$('#searchNickName').val(),
   	   					'sex':$('#searchSex').val(),
   	   					'userType':$('#searchUserType').val(),
   	 					'email':$('#searchEmail').val(),
   	 					'phone':$('#searchPhone').val(),
   	 					'mobile':$('#searchMobile').val(),
   	 					
   	   			    }
   	   			}
    </script>   
    <script src="${contextPath}/jsp/scripts/url.js"></script>
    <script src="${contextPath}/jsp/scripts/usermanage.js?4"type="text/javascript"></script>
</body>

</html>