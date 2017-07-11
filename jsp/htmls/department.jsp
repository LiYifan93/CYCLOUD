<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>创建部门</title>
    <link rel="stylesheet" href="${contextPath}/jsp/libs/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${contextPath}/jsp/libs/fonts/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${contextPath}/jsp/libs/bootstrap-table/bootstrap-table.css" />
    <!--日期控件-->
    <link rel="stylesheet" href="${contextPath}/jsp/libs/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css">
    <style>
    	.middle{
    		vertical-align: middle !important;
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
                <li><a>部门管理</a></li>
                <li class="active">部门管理</li>
            </ol>
        </section>
    </nav>
    
     <div id="modal-admin" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" aria-label="Close">
									&times;
								</button>
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;">超级管理员</h4>
                </div>

                <div class="modal-body ">
                	<form id="admin" class="form-horizontal">
                        <div class="form-group">
                            <label for="userName" class="control-label col-md-3">账号</label>
                            <div class="col-md-8">
                                <input type="text" id="userName" name="userName" required minlength="3" maxlength="16" pattern="[a-zA-Z0-9_\.]+$" title="用户名只能是3-16位的数字、字母、 点和下划线" class="form-control" placeholder="请输入账号">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="password" class="control-label col-md-3">密码</label>
                            <div class="col-md-8">
                                <input type="text" id="password" name="password" required minlength="3" maxlength="16" pattern="[a-zA-Z0-9_\.]+$" title="密码 只能是3-16位的数字、字母、 点和下划线"  class="form-control" placeholder="请输入密码">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="nickName" class="control-label col-md-3">昵称</label>
                            <div class="col-md-8">
                                <input type="text" id="nickName" name="nickName" required minlength="3" maxlength="10" title="昵称只能是3-10位的字符" pattern="[A-Za-z0-9_\-\u4e00-\u9fa5]+" class="form-control" placeholder="请输入昵称">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="sex" class="control-label col-md-3">性别</label>
                            <div class="col-md-8">
                                <select name="sex" id="sex" class="form-control" required style="width:100%">
                                   <option value="0">男</option>
                                   <option value="1">女</option>
                               </select>
                            </div>
                        </div>
                        
                        
                        <div class="form-group">
                            <label for="email" class="control-label col-md-3">邮箱</label>
                            <div class="col-md-8">
                                <input type="email" id="email" name="email" required title="请输入正确的邮箱格式，如：123@qq.com" pattern="^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+" class="form-control" placeholder="请输入操作员编号">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="phone" class="control-label col-md-3">电话</label>
                            <div class="col-md-8">
                                <input type="tel"  id="phone" name="phone"   title="请输入正确的电话号码，如0551-5555555" pattern="([0-9]{3,4}-)?[0-9]{7,8}"  class="form-control" placeholder="请输入电话">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="mobile" class="control-label col-md-3">手机号</label>
                            <div class="col-md-8">
                                <input type="tel" id="mobile" name="mobile" required class="form-control" maxlength="11" minlength="11" title="请输入正确的手机号码" pattern="^((\+?86)|(\(\+86\)))?(13[012356789][0-9]{8}|15[012356789][0-9]{8}|18[02356789][0-9]{8}|147[0-9]{8}|1349[0-9]{7})$" placeholder="请输入手机号">
                            </div>
                        </div>
                        
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="submit"  class="btn btn-success">修改</button>
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

                <div class="modal-body">
                    <form id="add" class="form-horizontal">
                    	 <div class="form-group" id="d_add" style="display:none">
                            <label for="departmentId" class="control-label col-md-3">停车场ID</label>
                            <div class="col-md-8">
                                <input type="text" class="departmentId" name="departmentId" class="form-control" required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="departmentName" class="control-label col-md-3">部门名称</label>
                            <div class="col-md-8">
                           		<input type="text" id="epartmentName" name="departmentName" class="form-control" required placeholder="请输入部门名称">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="unicode" class="control-label col-md-3">部门编号</label>
                            <div class="col-md-8">
                           		<input type="text" id="unicode" name="unicode" class="form-control" required placeholder="请输入部门编号">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="departmentTypeId" class="control-label col-md-3">部门类别</label>
                            <div class="col-md-8">
                           		<select  id="departmentTypeId" name="departmentTypeId" class="form-control">
                           		</select>	
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="zipCode" class="control-label col-md-3">邮编</label>
                            <div class="col-md-8">
                                <input type="text" id="zipCode" name="zipCode" title="请输入正确的邮编" pattern="[1-9]\d{5}(?!\d)" class="form-control" required placeholder="请输入邮编">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email" class="control-label col-md-3">邮箱</label>
                            <div class="col-md-8">
                                <input type="email" id="email" name="email" title="请输入正确的邮箱格式，如：123@qq.com" pattern="^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+"  class="form-control" required placeholder="请输入邮箱">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="phone" class="control-label col-md-3">电话</label>
                            <div class="col-md-8">
                                <input type="text" id="phone" name="phone" title="请输入正确的电话号码，如0551-5555555" pattern="([0-9]{3,4}-)?[0-9]{7,8}"  class="form-control" required placeholder="请输入电话">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="mobile" class="control-label col-md-3">手机号</label>
                            <div class="col-md-8">
                                <input type="text" id="mobile" name="mobile" maxlength="11" minlength="11" title="请输入正确的手机号码" pattern="^((\+?86)|(\(\+86\)))?(13[012356789][0-9]{8}|15[012356789][0-9]{8}|18[02356789][0-9]{8}|147[0-9]{8}|1349[0-9]{7})$" class="form-control" required placeholder="请输入手机号">
                            </div>
                        </div>

                        <div class="form-group" style="margin-bottom:0px;">
                            <label for="address" class="col-sm-3 control-label ">选择位置</label>
                            <div data-toggle="distpicker" class="col-sm-9 distpicker">
                                <div class="form-group" style="width:30%;float:left;margin-left:0px;">
                                    <label class="sr-only" for="provinceId">省</label>
                                    <select class="form-control" name="provinceId" id="province" required></select>
                                </div>
                                <div class="form-group" style="width:30% ;float:left;margin-left:25px;">
                                    <label class="sr-only" for="cityId">市</label>
                                    <select class="form-control" name="cityId" id="city" required></select>
                                </div>
                                <div class="form-group" style="width:30%;float:left;margin-left:25px;">
                                    <label class="sr-only" for="countyId">县/区</label>
                                    <select class="form-control" name="countyId" id="countyId" ></select>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="address" class="control-label col-md-3">详细地址</label>
                            <div class="col-md-8">
                                <input type="text" id="address" name="address" class="form-control" required placeholder="请输入详细地址">
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="submit" class="btn btn-success">确定</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    
    
    <div id="modal-search" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" aria-label="Close">
									&times;
								</button>
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;">请进行搜索</h4>
                </div>

                <div class="modal-body form-horizontal " >
                	<form id="search">
                        <div class="form-group">
                            <label for="departmentName" class="control-label col-md-3">部门名称</label>
                            <div class="col-md-8">
                               <input type="text" id="searchDepartmentName" name="departmentName" class="form-control"  placeholder="请输入部门名称">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="searchUnicode" class="control-label col-md-3">部门编号</label>
                            <div class="col-md-8">
                               <input type="text" id="searchUnicode" name="unicode" class="form-control"  placeholder="请输入部门编号">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="departmentTypeId" class="control-label col-md-3">部门类别</label>
                            <div class="col-md-8">
                                <select id='searchDepartmentTypeId' name="departmentTypeId" class="form-control" >
                                	<option selected  value="">全部</option>
                                	
                                </select>	
                            </div>
                        </div>
                        

                        <div class="form-group">
                            <label for="zipCode" class="control-label col-md-3">邮编</label>
                            <div class="col-md-8">
                                <input type="text" id="searchZipCode" name="zipCode"  title="请输入正确的邮编" pattern="[1-9]\d{5}(?!\d)" class="form-control"  placeholder="请输入邮编">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email" class="control-label col-md-3">邮箱</label>
                            <div class="col-md-8">
                                <input type="email" id="searchEmail" name="email" title="请输入正确的邮箱格式，如：123@qq.com" pattern="^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+" class="form-control" placeholder="请输入邮箱">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="phone" class="control-label col-md-3">电话</label>
                            <div class="col-md-8">
                                <input type="text" id="searchPhone" name="phone" title="请输入正确的电话号码，如0551-5555555" pattern="([0-9]{3,4}-)?[0-9]{7,8}"  class="form-control"  placeholder="请输入电话">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="mobile" class="control-label col-md-3">手机号</label>
                            <div class="col-md-8">
                                <input type="text" id="searchMobile" name="mobile" maxlength="11" minlength="11" title="请输入正确的手机号码" pattern="^((\+?86)|(\(\+86\)))?(13[012356789][0-9]{8}|15[012356789][0-9]{8}|18[02356789][0-9]{8}|147[0-9]{8}|1349[0-9]{7})$" class="form-control"  placeholder="请输入手机号">
                            </div>
                        </div>

                        <div class="form-group" style="margin-bottom:0px;">
                            <label for="address" class="col-sm-3 control-label">选择位置</label>
                            <div data-toggle="distpicker" class="col-sm-9 distpicker">
                                <div class="form-group" style="width:30%;float:left;margin-left:0px;">
                                    <label class="sr-only" for="province">省</label>
                                    <select class="form-control"id="searchProvinceId" data-province="" name="proviceId" ></select>
                                </div>
                                <div class="form-group" style="width:30% ;float:left;margin-left:25px;">
                                    <label class="sr-only" for="city">市</label>
                                    <select class="form-control" id="searchCityId" data-city="" name="cityId" ></select>
                                </div>
                                <div class="form-group" style="width:30%;float:left;margin-left:25px;">
                                    <label class="sr-only" for="countyId">县/区</label>
                                    <select class="form-control" id="searchCountyId"  data-district="" name="countyId" ></select>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="address" class="control-label col-md-3">详细地址</label>
                            <div class="col-md-8">
                                <input type="text" id="searchAddress" name="address" class="form-control"  placeholder="请输入详细地址">
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="submit"  class="btn btn-success">搜索</button>
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
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;">请进行编辑</h4>
                </div>

                <div class="modal-body">
                    <form id="edit" class="form-horizontal">
                        
                        <div class="form-group">
                            <label for="departmentName" class="control-label col-md-3">部门名称</label>
                            <div class="col-md-8">
                            	 <input type="text" id="editDepartmentName" name="departmentName" class="form-control" required placeholder="请输入名称">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="editUnicode" class="control-label col-md-3">部门编号</label>
                            <div class="col-md-8">
                            	 <input type="text" id="editUnicode" name="unicode" class="form-control" required placeholder="请输入部门编号">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="departmentTypeId" class="control-label col-md-3">部门类别</label>
                            <div class="col-md-8">
                           		<select  id="editDepartmentTypeId" name="departmentTypeId" class="form-control">
                           		</select>	
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="zipCode" class="control-label col-md-3">邮编</label>
                            <div class="col-md-8">
                                <input type="text" id="editZipCode" name="zipCode"  title="请输入正确的邮编" pattern="[1-9]\d{5}(?!\d)" class="form-control" required placeholder="请输入邮编">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email" class="control-label col-md-3">邮箱</label>
                            <div class="col-md-8">
                                <input type="text" id="editEmail" name="email" title="请输入正确的邮箱格式，如：123@qq.com" pattern="^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+" class="form-control" required placeholder="请输入邮箱">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="phone" class="control-label col-md-3">电话</label>
                            <div class="col-md-8">
                                <input type="text" id="editPhone" name="phone" title="请输入正确的电话号码，如0551-5555555" pattern="([0-9]{3,4}-)?[0-9]{7,8}"  class="form-control" required placeholder="请输入电话">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="mobile" class="control-label col-md-3">手机号</label>
                            <div class="col-md-8">
                                <input type="text" id="editMobile" name="mobile" maxlength="11" minlength="11" title="请输入正确的手机号码" pattern="^((\+?86)|(\(\+86\)))?(13[012356789][0-9]{8}|15[012356789][0-9]{8}|18[02356789][0-9]{8}|147[0-9]{8}|1349[0-9]{7})$" class="form-control" required placeholder="请输入手机号">
                            </div>
                        </div>

						<!-- data-toggle="distpicker" distpicker -->
                        <div class="form-group" style="margin-bottom:0px;">
                            <label for="address" class="col-sm-3 control-label">地理位置</label>
                            <div  id="edit_address"  class="col-sm-9 ">
                                <div class="form-group" style="width:30%;float:left;margin-left:0px;">
                                    <!-- <label class="sr-only" for="province">省</label> -->
                                    <select class="form-control" name="provinceId" id="editProvinceId"></select>
                                </div>
                                <div class="form-group" style="width:30% ;float:left;margin-left:20px;">
                                    <!-- <label class="sr-only" for="city">市</label> -->
                                    <select class="form-control" name="cityId" id="editCityId"></select>
                                </div>
                                <div class="form-group" style="width:30%;float:left;margin-left:20px;">
                                    <!-- <label class="sr-only" for="countyId">县/区</label> -->
                                    <select class="form-control" name="countyId" id="editCountyId"></select>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="address" class="control-label col-md-3">详细地址</label>
                            <div class="col-md-8">
                                <input type="text" id="editAddress" name="address" class="form-control" required placeholder="请输入详细地址">
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="submit" class="btn btn-success">确定</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

   <div id="modal-role" class="modal fade" >
            <div class="modal-dialog">
              <div class="modal-content">
                 <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                     <h4 class="modal-title">分配权限</h4>
                 </div>
                <div class="modal-body">
	               <div style="text-align:center;" id="treeDemo" class="ztree"></div>
	                	<div class="modal-footer">
	                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	                        <button type="submit" id="submit" class="btn btn-success">确定</button>
	                  </div>
                  </div>
              </div>
         </div>
     </div>
	
    <div class="container " style="margin-top: 50px">
        <div id="toolbar">
            <div class="btn-group">
                <!-- <button type="button" class="btn btn-default dropdown-toggle" data-toggle="modal" data-target="#modal-export">
                     <i class="glyphicon glyphicon-export icon-share"></i>
                </button> -->
                <input type="button" id="refresh" class="btn btn-default pull-left " style="border-radius: 10%;margin: 0 20px 0 0"  value="刷新">
                <input type="button" class="btn btn-default pull-left operate search" style="border-radius: 10% ;margin:  0 20px 0 0; line-height:normal" data-toggle="modal" data-target="#modal-search" value="搜索">
                <input type="button" class="btn btn-default pull-left operate add" style="border-radius: 10%;margin-left:  0 20px 0 0"" data-toggle="modal" data-target="#modal-add" value="添加">
            </div>
        </div>        
        <!--
				bootstrapTable:在table标签属性里面配置参数，也可以通过js配置url：配置请求的路径；toggle: 初始化Table；
				pagination: 是否启用分页；size: 每页显示的数据条数；list：每页显示的行数； pagination-loop: 是否启用启用分页条无限循环；
				side-pagination: 分页位置(server服务器分页；client客户端分页)； response-handler: 格式化从服务器获取到的数据；
				 query-params:传递参数； cache: 是否启用服务器缓存； show-columns: 是否显示 内容列下拉框； refresh: 起否启用刷新； number: 初始化加载第一页，默认第一页
			-->
        <table id="table"  data-toggle="table" data-pagination="true" data-page-size="10" data-page-list="[10,20,30,All]" data-pagination-loop="false" data-side-pagination="server" data-response-handler="responseHandler"
            data-query-params="paginationParam"  data-cache="false" data-show-toggle="true" data-toolbar="#toolbar" data-show-refresh="true" data-method="post" data-show-refresh="false" data-search="false" data-page-number="1" data-content-type="application/x-www-form-urlencoded; charset=UTF-8">
            <thead>
                <tr>
                    <!--fidld: 需与后台返回数据保持一直； checkbox: 为true显示该列； visible: 为false隐藏该列； align、valign: 水平、垂直居中-->
                    <!--  data-formatter="departmentTypeIdFormatter"  -->
                    <th data-field="check" data-class="middle" data-checkbox="true" data-align="center" data-valign="middle"></th>
                    <th data-field="departmentName"  data-align="center" data-valign="middle">部门名称</th>
                    <th data-field="unicode"  data-align="center" data-valign="middle">部门编号</th>
                    <th data-field="departmentTypeId"data-align="center" data-valign="middle">部门类别</th>
                    <th data-field="zipCode" data-align="center" data-valign="middle">邮编</th>
                    <th data-field="email" data-align="center" data-valign="middle">邮箱</th>
                    <th data-field="phone" data-align="center" data-valign="middle">电话</th>
                    <th data-field="mobile" data-align="center" data-valign="middle">手机号</th>
                    <th data-field="provinceId" data-align="center" data-valign="middle" data-width="150px">省</th>
                    <th data-field="cityId" data-align="center" data-valign="middle" data-width="150px">市</th>
                    <th data-field="countyId" data-align="center" data-valign="middle" data-width="150px">县/区</th>
                    <th data-field="address" data-align="center" data-valign="middle">详细地址</th>
                    <th data-field="createAt" data-align="center" data-valign="middle">创建时间</th>
                    <!--formatter: 格式化该列，自定义内容； events: 事件处理函数-->
                    <th data-field="details" data-class="middle" data-formatter="operateFormatter" data-events="operateEvents" data-align="center" data-valign="middle" data-width="120px">操 作</th>
                </tr>
            </thead>

        </table>
    </div>



    <script src="${contextPath}/jsp/libs/jquery/jquery.js"></script>
    <script src="${contextPath}/jsp/libs/bootstrap/js/bootstrap.min.js"></script>
    <script src="${contextPath}/jsp/libs/distpicker/distpicker.data.min.js"></script>
    <script src="${contextPath}/jsp/libs/distpicker/distpicker.min.js"></script>
    <script src="${contextPath}/jsp/libs/bootstrap-table/bootstrap-table.js " charset="UTF-8"></script>
    <script src="${contextPath}/jsp/libs/bootstrap-table/bootstrap-table-zh-CN.js " charset="UTF-8"></script>
    <script src="${contextPath}/jsp/libs/bootstrap-datetimepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script>
    <script src="${contextPath}/jsp/libs/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
    <script src="${contextPath}/jsp/libs/modal.js"></script>
    <script>
		var contextPath = "${contextPath}";
	</script>	
    <script type="text/javascript" src="${contextPath}/jsp/scripts/dbtype.js?1" ></script>
    <script>
		    $('.distpicker').distpicker({
		        autoSelect: false
		    });
   		 	var dataUrl = "${contextPath}/department/getAllPark?departmentId="
	   		var addUrl = '${contextPath}/department/addPark'
			// 格式化向服务器发送的参数
	   			function paginationParam(params) {
	   			    // alert(params)
	   			    var currPage = Math.floor((params.offset + params.limit) / params.limit);
	   			    return {
	   			        'offset': currPage,
	   			        'limit': params.limit,
	   			        'departmentName':$('#searchDepartmentName').val(),
	   			     	'unicode':$('#searchUnicode').val(),
	   			     	'departmentTypeId':$('#searchDepartmentTypeId').val(),
                        'zipCode':$('#searchZipCode').val(),
                        'email':$('#searchEmail').val(),
                        'phone':$('#searchPhone').val(),
                        'mobile':$('#searchMobile').val(),
                        'address':$('#searchAddress').val(),
                        'provinceId': $('#searchProvinceId').val(),
                    	'cityId':$('#searchCityId').val(),
                    	'countyId':$('#searchCountyId').val()
	   			    }
	   			}
	   		
    </script>   
    <script src="${contextPath}/jsp/scripts/url.js"></script>
    <script src="${contextPath}/jsp/scripts/department.js?6"></script>

</body>

</html>