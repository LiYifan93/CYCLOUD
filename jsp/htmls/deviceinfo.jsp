<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>同步设备信息及设备状态</title>
    <link href="${contextPath}/jsp/libs/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${contextPath}/jsp/libs/fonts/font-awesome.min.css">

    <link rel="stylesheet" type="text/css" href="${contextPath}/jsp/libs/bootstrap-table/bootstrap-table.css" />
    <!--日期控件-->
    <link rel="stylesheet" href="${contextPath}/jsp/libs/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css">

    <!--[if lt IE 9]>
    <script src="http://apps.bdimg.com/libs/html5shiv/3.7/html5shiv.min.js"></script>
    <script src="http://apps.bdimg.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
    	.middle{
    		vertical-align: middle !important;
    	}
    	input:invalid {
		    border-color: grey;
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
                <li><a>数据中心</a></li>
                <li class="active">设备信息及设备状态</li>
            </ol>
        </section>

    </nav>

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
                        <div class="form-group" id="d_add">
                            <label for="departmentId" class="control-label col-md-3">停车场ID：</label>
                            <div class="col-md-8">
                                <input type="text" class="departmentId" name="departmentId" class="form-control" required placeholder="请输入停车场ID">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="localId" class="control-label col-md-3">本地编号</label>
                            <div class="col-md-8">
                                <input type="text" id="localId" name="localId" class="form-control" required placeholder="请输入本地编号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="serialId" class="control-label col-md-3">设备编号</label>
                            <div class="col-md-8">
                                <input type="text" id="serialId" name="serialId" required class="form-control" placeholder="请输入设备编号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="name" class="control-label col-md-3">设备名称</label>
                            <div class="col-md-8">
                                <input type="text" id="name" name="name" class="form-control" required placeholder="请输入设备名称">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="status" class="control-label col-md-3">设备状态</label>
                            <div class="col-md-8">
                                <select name="status" id="status" class="form-control" style="width:100%">
                                   <option value="0">异常</option>
                                   <option value="1">正常</option>
                                   <option value="2">未知</option>
                               </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="type" class="control-label col-md-3">设别类型</label>
                            <div class="col-md-8">
                                <select name="type" id="type" class="form-control" style="width:100%">
                                   <option value="0">电脑</option>
                                   <option value="1">相机</option>
                                   <option value="2">显示屏</option>
                                   <option value="1">广告屏</option>
                                   <option value="2">其它</option>
                               </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="ip" class="control-label col-md-3">IP</label>
                            <div class="col-md-8">
                                <input type="text" id="ip" name="ip" title="请输入正确的IP,如：192.168.0.1" pattern="^(?:(?:2[0-4][0-9]\.)|(?:25[0-5]\.)|(?:1[0-9][0-9]\.)|(?:[1-9][0-9]\.)|(?:[0-9]\.)){3}(?:(?:2[0-5][0-5])|(?:25[0-5])|(?:1[0-9][0-9])|(?:[1-9][0-9])|(?:[0-9]))$" required class="form-control" placeholder="请输入IP">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="passType" class="control-label col-md-3">出入口</label>
                            <div class="col-md-8">
                                <select name="passType" id="passType"  class="form-control" style="width:100%">
                                   <option value="0">入口</option>
                                   <option value="1">出口</option>
                               </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="location" class="control-label col-md-3">详细位置信息</label>
                            <div class="col-md-8">
                                <input type="text" id="location" name="location" required class="form-control" placeholder="请输入详细位置信息">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="synchrTime" class="control-label col-md-3">上次同步时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly name="synchrTime" required class="form-control" placeholder="请输入上次同步时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                        <div class="form-group">
                            <label for="reason" class="control-label col-md-3">异常原因</label>
                            <div class="col-md-8">
                                <input type="text" id="reason" name="reason" required class="form-control" placeholder="请输入异常原因">
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

    <div id="modal-export" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" aria-label="Close">
									&times;
								</button>
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;">请填写导出条件</h4>
                </div>

                <div class="modal-body">
                    <form id="export" class="form-horizontal" >

                        <div class="form-group" id="d_export">
                            <label for="departmentId" class="control-label col-md-3">停车场ID</label>
                            <div class="col-md-8">
                                <input type="text" class="departmentId" name="departmentId" class="form-control" required placeholder="请输入停车场ID">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="offset" class="control-label col-md-3">选择页数</label>
                            <div class="col-md-8">
                                <input type="number" id="offset" name="offset" class="form-control" required placeholder="请输入页数">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="limit" class="control-label col-md-3">选择行数</label>
                            <div class="col-md-8">
                                <input type="number" id="limit" name="limit" class="form-control" required placeholder="请输入行数">
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
                            <label for="editLocalId" class="control-label col-md-3">本地编号</label>
                            <div class="col-md-8">
                                <input type="text" id="editLocalId" name="localId" class="form-control" required placeholder="请输入本地编号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editSerialId" class="control-label col-md-3">设备编号</label>
                            <div class="col-md-8">
                                <input type="text" id="editSerialId" name="serialId" required class="form-control" placeholder="请输入设备编号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editName" class="control-label col-md-3">设备名称</label>
                            <div class="col-md-8">
                                <input type="text" id="editName" name="name" class="form-control" required placeholder="请输入设备名称">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editStatus" class="control-label col-md-3">设备状态</label>
                            <div class="col-md-8">
                                <select name="status" id="editStatus" class="form-control" style="width:100%">
                                   <option value="0">异常</option>
                                   <option value="1">正常</option>
                                   <option value="2">未知</option>
                               </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editType" class="control-label col-md-3">设别类型</label>
                            <div class="col-md-8">
                                <select name="type" id="editType" class="form-control" style="width:100%">
                                   <option value="0">电脑</option>
                                   <option value="1">相机</option>
                                   <option value="2">显示屏</option>
                                   <option value="1">广告屏</option>
                                   <option value="2">其它</option>
                               </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editIp" class="control-label col-md-3">IP</label>
                            <div class="col-md-8">
                                <input type="text" id="editIp" name="ip" title="请输入正确的IP,如：192.168.0.1" pattern="^(?:(?:2[0-4][0-9]\.)|(?:25[0-5]\.)|(?:1[0-9][0-9]\.)|(?:[1-9][0-9]\.)|(?:[0-9]\.)){3}(?:(?:2[0-5][0-5])|(?:25[0-5])|(?:1[0-9][0-9])|(?:[1-9][0-9])|(?:[0-9]))$" required class="form-control" placeholder="请输入IP">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editPassType" class="control-label col-md-3">出入口</label>
                            <div class="col-md-8">
                                <select name="passType" id="editPassType"  class="form-control" style="width:100%">
                                   <option value="0">入口</option>
                                   <option value="1">出口</option>
                               </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editLocation" class="control-label col-md-3">详细位置信息</label>
                            <div class="col-md-8">
                                <input type="text" id="editLocation" name="location" required class="form-control" placeholder="请输入详细位置信息">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="synchrTime" class="control-label col-md-3">上次同步时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly name="synchrTime" required class="form-control" placeholder="请输入上次同步时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                        <div class="form-group">
                            <label for="editReason" class="control-label col-md-3">异常原因</label>
                            <div class="col-md-8">
                                <input type="text" id="editReason" name="reason" required class="form-control" placeholder="请输入异常原因">
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

    <div class="container " style="margin-top: 50px">
        <div id="toolbar">
            <div class="btn-group">
                <button type="button" class="btn btn-default dropdown-toggle export operate" style="border-radius: 10%;margin: 0 20px 0 0" title="导出" data-toggle="modal" data-target="#modal-export">
                     <i class="glyphicon glyphicon-export icon-share"></i>
                </button>
                <input type="button" id="refresh" class="btn btn-default pull-left " style="border-radius: 10%;margin: 0 20px 0 0"  value="刷新">
                <input type="button" class="btn btn-default pull-left operate add" style="border-radius: 10%;margin:0 20px 0 0" data-toggle="modal" data-target="#modal-add" value="添加">
            </div>
        </div>
        <!--
				bootstrapTable:在table标签属性里面配置参数，也可以通过js配置url：配置请求的路径；toggle: 初始化Table；
				pagination: 是否启用分页；size: 每页显示的数据条数；list：每页显示的行数； pagination-loop: 是否启用启用分页条无限循环；
				side-pagination: 分页位置(server服务器分页；client客户端分页)； response-handler: 格式化从服务器获取到的数据；
				 query-params:传递参数； cache: 是否启用服务器缓存； show-columns: 是否显示 内容列下拉框； refresh: 起否启用刷新； number: 初始化加载第一页，默认第一页
			-->
			
			<!-- data-sort-order="asc" data-sortable="false" -->
        <table  id="table"  data-toggle="table" data-pagination="true" data-page-size="10" data-page-list="[10,20,30,All]" data-pagination-loop="false" data-side-pagination="server" data-response-handler="responseHandler"
            data-query-params="paginationParam" data-cache="false"   data-toolbar="#toolbar"  data-show-toggle="true" data-show-refresh="true" data-method="post"  data-search="false" data-page-number="1" data-content-type="application/x-www-form-urlencoded; charset=UTF-8">
            <thead>
                <tr>
                    <!--fidld: 需与后台返回数据保持一直； checkbox: 为true显示该列； visible: 为false隐藏该列； align、valign: 水平、垂直居中-->
                    <th data-field="check" data-class="middle" data-checkbox="true" data-align="center" data-valign="middle"></th>
                    <th data-field="localId" data-align="center" data-valign="middle">本地编号</th>
                    <th data-field="serialId" data-align="center" data-valign="middle">设备编号</th>
                    <th data-field="name"  data-align="center" data-valign="middle">设备名称</th>
                    <th data-field="status" data-formatter="statusFormatter"  data-align="center" data-valign="middle">设备状态</th>
                    <th data-field="type" data-formatter="typeFormatter" data-align="center" data-valign="middle">设别类型</th>
                    <th data-field="ip" data-align="center" data-valign="middle">IP</th>
                    <th data-field="passType" data-formatter="passTypeFormatter" data-align="center" data-valign="middle">出入口</th>
                    <th data-field="location" data-align="center" data-valign="middle">详细位置信息</th>
                    <th data-field="synchTime" data-align="center" data-valign="middle">上次同步时间</th>
                    <th data-field="reason" data-align="center" data-valign="middle">异常原因</th>
                    <!--formatter: 格式化该列，自定义内容； events: 事件处理函数-->
                    <th data-field="details" data-formatter="operateFormatter" data-events="operateEvents" data-align="center" data-valign="middle" data-width="70px">操 作 </th>
                </tr>
            </thead>

        </table>
    </div>

    <script src="${contextPath}/jsp/libs/jquery/jquery.js"></script>
    <script src="${contextPath}/jsp/libs/bootstrap/js/bootstrap.js " charset="UTF-8"></script>
    <script src="${contextPath}/jsp/libs/bootstrap-table/bootstrap-table.js " charset="UTF-8"></script>
    <script src="${contextPath}/jsp/libs/bootstrap-table/bootstrap-table-zh-CN.js " charset="UTF-8"></script>
    <script src="${contextPath}/jsp/libs/bootstrap-datetimepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script>
    <script src="${contextPath}/jsp/libs/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
    <script src="${contextPath}/jsp/libs/modal.js"></script>
    <script>
   		var dataUrl = "${contextPath}/web/deviceinfo/getByDepartmentId?departmentId="
   		var contextPath = "${contextPath}";  
   		var searchUrl = '${contextPath}/web/deviceinfo/searchByCondition'
   		var addUrl = '${contextPath}/web/deviceinfo/add'
   		var exportUrl = "${contextPath}/web/deviceinfo/exportExc"
   		
//   	    格式化向服务器发送的参数
   			function paginationParam(params) {
   			    var currPage = Math.floor((params.offset + params.limit) / params.limit);
   			    return {
   			        'offset': currPage,
   			        'limit': params.limit,
   			    }
   			}
    </script>   
    <script src="${contextPath}/jsp/scripts/url.js"></script>
    <script src="${contextPath}/jsp/scripts/deviceinfo.js?2"></script>

</body>

</html>