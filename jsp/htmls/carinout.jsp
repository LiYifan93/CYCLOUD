<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>进出记录</title>
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
                <li><a href="#"><i class="fa fa-dashboard"></i> 当前位置</a></li>
                <li><a href="#">数据中心</a></li>
                <li class="active">进出记录</li>
            </ol>
        </section>

    </nav>

    <div id="modal-search" class="modal fade" aria-hidden="true" aria-labelledby="myModalLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" aria-label="Close">
									&times;
								</button>
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;">请填写搜索条件</h4>
                </div>

                <div class="modal-body form-horizontal">
                    <form id="search">  
                        <div class="form-group">
                            <label class="control-label col-md-3">本地编号</label>
                            <div class="col-md-8">
                                <input type="text" id="searchLocalId" name="localId" class="form-control" placeholder="请输入本地编号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3">操作员编号</label>
                            <div class="col-md-8">
                                <input type="text" id="searchUin" name="uin" class="form-control" placeholder="请输入操作员编号">
                            </div>
                        </div>

						<div class="form-group">

                            <label for="date" class="control-label col-md-3">进出时间段查询</label>

                            <div class="col-md-6 controls input-append date dateTime s_time" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="startTime" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" id="searchIoTime" readonly name="ioTime" required class="form-control" placeholder="请输入进出时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="startTime" value="" />


                            <div class="col-md-2">
                                <select id="searchIoTimeType" name="ioTimeType" class="form-control" onchange="change(this.options[this.options.selectedIndex].value)" style="width: 100%;">
									<option selected value=''>所有</option>
									<option value='1'>小于</option>
									<option value='2'>介于</option>
									<option value='3'>等于</option>
                                    <option value='4'>大于</option>
                            	</select>
                            </div>
                            <div class="hid_den" style="display:none">
	                            <div class="col-md-3 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="endDate" data-link-format="yyyy-mm-dd hh:ii:ss">
	                                <input size="16" type="text" value="" readonly id="searchIoTime1" name="ioTime1"  class="form-control" placeholder="结束时间(可选)">
	                                <span class="add-on"><i class="icon-remove"></i></span>
	                                <span class="add-on"><i class="icon-th"></i></span>
	                            </div>
	                            <input type="hidden" id="endDate" value="" />
	                        </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="searchRoadId" class="control-label col-md-3">通道编号</label>
                            <div class="col-md-8">
                                <input type="text" id="searchRoadId" name="roadId" class="form-control" placeholder="请输入通道编号">
                            </div>
                        </div>
                        
                         <div class="form-group">
                            <label class="control-label col-md-3">出入场类型</label>
                            <div class="col-md-8">
                                <select id="searchType" name="type" class="form-control " style="width: 100%;">
									<option value='0'>进场</option>
									<option value='1'>出场</option>
                                    <option selected="selected" value=''>所有</option>									
                            	</select>
                            </div>
                        </div>

                         <div class="form-group">
                            <label class="control-label col-md-3">车牌号</label>
                            <div class="col-md-8">
                                <input type="text" id="searchPlate" name="plate" title="请输入5-8位的车牌号码" minlength="5" maxlength="8" pattern="^[\u4e00-\u9fa5][a-zA-Z](([DF](?![a-zA-Z0-9]*[IO])[0-9]{4})|([0-9]{5}[DF]))|^[冀豫云辽黑湘皖鲁苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼渝京津沪新京军空海北沈兰济南广成使领A-Z]{1}[a-zA-Z0-9]{5}[a-zA-Z0-9挂学警港澳]{1}$" class="form-control" placeholder="请输入车牌号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3">进出场状态</label>
                            <div class="col-md-8">
                                <select id="searchStatus" name="status" class="form-control " style="width: 100%;">
									<option value='0'>已进场</option>
									<option value='1'>已出场</option>
                                    <option value='2'>在场</option>
									<option value='3'>未知</option>
                                    <option selected="selected" value=''>所有</option>									
                            	</select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3">设备信息</label>
                            <div class="col-md-8">
                                <input type="text" id="searchDeviceId" name="deviceId" class="form-control" placeholder="请输入设备信息">
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
                    <form id="add" class="form-horizontal" name="add">
                    
                   	    <div class="form-group " id="d_add">
                            <label for="departmentId" class="control-label col-md-3">停车场ID</label>
                            <div class="col-md-8">
                                <input type="text" class="departmentId" name="departmentId" class="form-control" placeholder="请输入停车场ID">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="localId" class="control-label col-md-3">本地编号</label>
                            <div class="col-md-8">
                                <input type="text" id="localId" name="localId" class="form-control" required placeholder="请输入本地编号">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="roadId" class="control-label col-md-3">通道编号</label>
                            <div class="col-md-8">
                                <input type="text" id="roadId" name="roadId" class="form-control" placeholder="请输入通道编号">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="uin" class="control-label col-md-3">操作员编号</label>
                            <div class="col-md-8">
                                <input type="text"  name="uin" class="form-control" required placeholder="请输入操作员编号">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="ioTime" class="control-label col-md-3">进出时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="ioTime" name="ioTime" required class="form-control" placeholder="请输入进出时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>
                        
                        <div class="form-group">
                            <label class="control-label col-md-3">出入场类型</label>
                            <div class="col-md-8">
                                <select id="type" name="type" class="form-control " style="width: 100%;">
									<option value='0'>进场</option>
									<option value='1'>出场</option>
                            	</select>
                            </div>
                        </div>

                         <div class="form-group">
                            <label class="control-label col-md-3">车牌号</label>
                            <div class="col-md-8">
                                <input type="text" id="plate" name="plate" title="请输入5-8位的车牌号码" minlength="5" maxlength="8" pattern="^[\u4e00-\u9fa5][a-zA-Z](([DF](?![a-zA-Z0-9]*[IO])[0-9]{4})|([0-9]{5}[DF]))|^[冀豫云辽黑湘皖鲁苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼渝京津沪新京军空海北沈兰济南广成使领A-Z]{1}[a-zA-Z0-9]{5}[a-zA-Z0-9挂学警港澳]{1}$" class="form-control" placeholder="请输入车牌号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3">进出场状态</label>
                            <div class="col-md-8">
                                <select id="status" name="status" class="form-control " style="width: 100%;">
									<option value='0'>已进场</option>
									<option value='1'>已出场</option>
                                    <option value='2'>在场</option>
									<option value='3'>未知</option>
                            	</select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3">进出图片地址</label>
                            <div class="col-md-8">
                                <input type="file" id="pic" name="pic" class="form-control" style="padding:0" placeholder="请输入进出图片地址">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3">设备信息</label>
                            <div class="col-md-8">
                                <input type="text" id="deviceId" name="deviceId" class="form-control" placeholder="请输入设备信息">
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
                    <form id="export" class="form-horizontal" name="export">
                    
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
                                <input type="text" id="editLocalId" name="localId" class="form-control" required placeholder="请输入数据编号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editUin" class="control-label col-md-3">操作员编号</label>
                            <div class="col-md-8">
                                <input type="text" id="editUin" name="uin" class="form-control" required placeholder="操作员编号">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="editPayTime" class="control-label col-md-3">进出时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="editIoTime" name="ioTime" required class="form-control" placeholder="请输入进出时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>
                        
                        <div class="form-group">
                            <label for="editRoadId" class="control-label col-md-3">通道编号</label>
                            <div class="col-md-8">
                                <input type="text" id="editRoadId" name="roadId" class="form-control" placeholder="请输入通道编号">
                            </div>
                        </div>
                        
                         <div class="form-group">
                            <label class="control-label col-md-3">出入场类型</label>
                            <div class="col-md-8">
                                <select id="editType" name="type" class="form-control " style="width: 100%;">
									<option value='0'>进场</option>
									<option value='1'>出场</option>
                            	</select>
                            </div>
                        </div>

                         <div class="form-group">
                            <label class="control-label col-md-3">车牌号</label>
                            <div class="col-md-8">
                                <input type="text" id="editPlate" name="plate"  title="请输入5-8位的车牌号码" minlength="5" maxlength="8" pattern="^[\u4e00-\u9fa5][a-zA-Z](([DF](?![a-zA-Z0-9]*[IO])[0-9]{4})|([0-9]{5}[DF]))|^[冀豫云辽黑湘皖鲁苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼渝京津沪新京军空海北沈兰济南广成使领A-Z]{1}[a-zA-Z0-9]{5}[a-zA-Z0-9挂学警港澳]{1}$" class="form-control" placeholder="请输入车牌号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3">进出场状态</label>
                            <div class="col-md-8">
                                <select id="editStatus" name="status" class="form-control " style="width: 100%;">
									<option value='0'>已进场</option>
									<option value='1'>已出场</option>
                                    <option value='2'>在场</option>
									<option value='3'>未知</option>
                            	</select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3">设备信息</label>
                            <div class="col-md-8">
                                <input type="text" id="editDeviceId" name="deviceId" class="form-control" placeholder="请输入设备信息">
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
    
    <div id="modal-uin" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" aria-label="Close">
									&times;
								</button>
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;">操作员信息</h4>
                </div>

                <div class="modal-body form-horizontal" >
                        <div class="form-group">
							<label for="editLocalId" class="control-label col-md-3">本地编号</label>
							<div class="col-md-8">
								<input type="text" id="uinLocalId" 
									name="localId" class="form-control" disabled>
							</div>
						</div>
						
						<div class="form-group">
							<label for="editUin" class="control-label col-md-3">操作员编号</label>
							<div class="col-md-8">
								<input type="text" id="uinUin"
									name="uin" class="form-control" disabled>
							</div>
						</div>
						
						<div class="form-group">
							<label for="editName" class="control-label col-md-3">用户名</label>
							<div class="col-md-8">
								<input type="text" id="uinName" minlength="3" maxlength="16" pattern="[a-zA-Z0-9_\.]+$" title="用户名只能是3-16位的数字、字母、 点和下划线"  name="name"
									class="form-control" disabled>
							</div>
						</div>

						<div class="form-group">
							<label for="editSex" class="control-label col-md-3">性别 </label>
							<div class="col-md-8">
								<select id="uinSex" name="sex"
									class="form-control" disabled>
									<option value="0">男</option>
									<option value="1">女</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="editPhone" class="control-label col-md-3">手机号</label>
							<div class="col-md-8">
								<input type="tel" id="uinPhone" name="phone" disabled  maxlength="11" minlength="11" title="请输入正确的手机号码" pattern="^((\+?86)|(\(\+86\)))?(13[012356789][0-9]{8}|15[012356789][0-9]{8}|18[02356789][0-9]{8}|147[0-9]{8}|1349[0-9]{7})$" 
									class="form-control">
							</div>
						</div>
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
                <input type="button" class="btn btn-default pull-left operate search" style="border-radius: 10% ;margin: 0 20px 0 0 ;line-height:normal"  data-toggle="modal" data-target="#modal-search" value="搜索">
                <!-- <input type="button" class="btn btn-default pull-left operate  add" style="border-radius: 10%;margin: 0 20px 0 0" data-toggle="modal" data-target="#modal-add" value="添加"> -->
                <!-- <input type="button" id="pass"  class="btn btn-default pull-left operate search" style="border-radius: 10% ;margin: 0 20px 0 0 ;line-height:normal" value="进场">
                <input type="button" id="out" class="btn btn-default pull-left " style="border-radius: 10%;margin: 0 20px 0 0"  value="出场">
                <input type="button" id="in" class="btn btn-default pull-left operate search" style="border-radius: 10% ;margin: 0 20px 0 0 ;line-height:normal" value="在场"> -->
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
                    <th data-field="localId" data-align="center" data-valign="middle">本地编号</th>
                    <th data-field="uin" data-formatter="uinFormatter" data-align="center" data-valign="middle">操作员编号</th>
                    <th data-field="roadId" data-align="center" data-valign="middle">通道编号</th>
                    <th data-field="type" data-formatter="typeFormatter" data-align="center" data-valign="middle">出入场类型</th>
                    <th data-field="plate"  data-align="center" data-valign="middle">车牌</th>
                    <th data-field="status" data-formatter="statusFormatter" data-align="center" data-valign="middle">进出场状态</th>
                    <th data-field="pic"  data-formatter="picFormatter" data-align="center" data-valign="middle">进出图片地址</th>
                    <th data-field="deviceId" data-align="center" data-valign="middle">设备信息</th>
                    <th data-field="ioTime" data-align="center" data-valign="middle">进出时间</th>
                    <!--formatter: 格式化该列，自定义内容； events: 事件处理函数-->
                    <th data-field="details" data-formatter="operateFormatter" data-events="operateEvents" data-align="center" data-valign="middle" data-width="70px">操 作</th>
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
     
   		var dataUrl = "${contextPath}/web/carinout/searchByCondition?departmentId="
   		var contextPath = "${contextPath}";
   		var addUrl = '${contextPath}/web/carinout/add'
   		var exportUrl = "${contextPath}/web/carinout/exportExc"
   		
//   	    格式化向服务器发送的参数
   			function paginationParam(params) {
   			    // alert(params)
   			    var currPage = Math.floor((params.offset + params.limit) / params.limit);
   			    return {
   			        'offset': currPage,
   			        'limit': params.limit,
   			        'localId':$('#searchLocalId').val(),
   			     	'uin':$('#searchUin').val(),
   			    	'roadId':$('#searchRoadId').val(),
   			  		'type':$('#searchType').val(),
   			  		'plate':$('#searchPlate').val(),
   					'status':$('#searchStatus').val(),
   					'deviceId':$('#searchDeviceId').val(),
   					'ioTime':$('#searchIoTime').val(),
   					'ioTimeType':$('#searchIoTimeType').val(),
   					'ioTime1':$('#searchIoTime1').val()
   			    }
   			}
   		
   		
   		
    </script>   
    <script src="${contextPath}/jsp/scripts/url.js?1"></script>
    <script src="${contextPath}/jsp/scripts/carinout.js?2"></script>
</body>

</html>