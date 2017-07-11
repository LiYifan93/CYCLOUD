<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="Expires"   CONTENT="0">
	<meta http-equiv="Cache-Control"   CONTENT="no-cache">
	<meta http-equiv="Pragma"   CONTENT="no-cache">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>月卡充值</title>
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
    </style>

</head>

<body style="padding-top: 50px; ">
    <nav class="navbar navbar-brand navbar-fixed-top " style="background-color: white">
        <section class="content-header ">
            <ol class="breadcrumb " style="background: white; font-size: 15px; ">
                <li><a><i class="fa fa-dashboard "></i> 当前位置</a></li>
                <li><a>充值中心</a></li>
                <li class="active ">月卡充值</li>
            </ol>
        </section>

    </nav>

    <div id="modal-search" class="modal fade" aria-hidden="true" aria-labelledby="myModalLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" aria-label="Close">&times;</button>
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;">请填写搜索条件</h4>
                </div>

                <div class="modal-body form-horizontal">
                <form id="search">
                        <div class="form-group">
                            <label for="searchLocalId" class="control-label col-md-3">本地编号</label>
                            <div class="col-md-8">
                                <input type="text" id="searchLocalId" name="localId" class="form-control" placeholder="请输入数据编号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchUin" class="control-label col-md-3">操作员编号</label>
                            <div class="col-md-8">
                                <input type="text" id="searchUin" name="uin" class="form-control" placeholder="请输入数据编号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchMonthCardLocalId" class="control-label col-md-3">月卡号</label>
                            <div class="col-md-8">
                                <input type="text" id="searchMonthCardLocalId" name="monthCardLocalId" class="form-control" placeholder="请输入月卡号">
                            </div>
                        </div>

                        <div class="form-group">

                            <label for="date" class="control-label col-md-3">开始时间段查询</label>

                            <div class="col-md-6 controls input-append date dateTime s_time" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="startTime" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="searchStartDate" name="startDate" class="form-control" placeholder="开始时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="searchStartDate" value=""/>


                            <div class="col-md-2">
                                <select id="searchStartDateType" name="startDateType" class="form-control " onchange="change(this.options[this.options.selectedIndex].value)" style="width: 100%;">
									<option selected value=''>所有</option>
									<option value='1'>小于</option>
									<option value='2'>介于</option>
									<option value='3'>等于</option>
                                    <option value='4'>大于</option>
                            	</select>
                            </div>
                            <div class="hid_den" style="display:none">
	                            <div class="col-md-3 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="endTime" data-link-format="yyyy-mm-dd hh:ii:ss">
	                                <input size="16" type="text" value="" readonly id="searchStartDate1" name="startDate1" class="form-control" placeholder="结束时间(可选)">
	                                <span class="add-on"><i class="icon-remove"></i></span>
	                                <span class="add-on"><i class="icon-th"></i></span>
	                            </div>
	                            <input type="hidden" id="searchEndDate" value="" />
	                        </div>
						</div>
                        <div class="form-group">

                            <label for="date" class="control-label col-md-3">结束时间段查询</label>

                            <div class="col-md-6 controls input-append date dateTime c_time" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="startTime" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="searchEndDate" name="endDate" class="form-control" placeholder="开始时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="startTime" value="" />


                            <div class="col-md-2">
                                <select id="searchEndDateType" name="endDateType" class="form-control" onchange="get(this.options[this.options.selectedIndex].value)"  style="width: 100%;">
									<option selected value=''>所有</option>
									<option value='1'>小于</option>
									<option value='2'>介于</option>
									<option value='3'>等于</option>
                                    <option value='4'>大于</option>
                            	</select>
                            </div>
                            <div class="c_hid_den" style="display:none">
	                            <div class="col-md-3 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="endTime" data-link-format="yyyy-mm-dd hh:ii:ss">
	                                <input size="16" type="text" value="" readonly id="searchEndDate1" name="endDate1" class="form-control" placeholder="结束时间(可选)">
	                                <span class="add-on"><i class="icon-remove"></i></span>
	                                <span class="add-on"><i class="icon-th"></i></span>
	                            </div>
	                            <input type="hidden" id="searchEndDate" value="" />
	                        </div>
						</div>
                        <div class="form-group">
                            <label for="searchIsSynch" class="control-label col-md-3">是否同步</label>
                            <div class="col-md-8">
                                <select id="searchIsSynch" name="isSynch" class="form-control " style="width: 100%;">
									<option selected value=''>所有</option>
									<option value='0'>未同步</option>
                                    <option value='1'>已同步</option>									
                            	</select>
                            </div>
                        </div>
                        
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="submit" class="btn btn-success">搜索</button>
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
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" aria-label="Close">&times;</button>
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;">请填写添加事件</h4>
                </div>

                <div class="modal-body">
                    <form id="add" class="form-horizontal">
                        <div class="form-group" id="d_add">
                            <label for="departmentId" class="control-label col-md-3">停车场ID</label>
                            <div class="col-md-8">
                                <input type="text" class="departmentId" name="departmentId" class="form-control" required placeholder="请输入停车场ID">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="localId" class="control-label col-md-3">本地编号</label>
                            <div class="col-md-8">
                                <input type="text" id="localId" name="localId" class="form-control" required placeholder="请输入数据编号">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="uin" class="control-label col-md-3">操作员编号</label>
                            <div class="col-md-8">
                                <input type="text" id="uin" name="uin" class="form-control" required placeholder="请输入操作员编号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="monthCardLocalId" class="control-label col-md-3">月卡号</label>
                            <div class="col-md-8">
                                <input type="text" id="monthCardLocalId" name="monthCardLocalId" required class="form-control" placeholder="请输入月卡号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="startDate" class="control-label col-md-3">开始时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="searchStartDate" name="startDate" required class="form-control" placeholder="请输入开始时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                        <div class="form-group">
                            <label for="endDate" class="control-label col-md-3">结束时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="searchEndDate" name="endDate" required class="form-control" placeholder="请输入结束时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                        <div class="form-group">
                            <label for="isSynch" class="control-label col-md-3">是否同步</label>
                            <div class="col-md-8">
                                <select id="searchIsSynch" name="isSynch" class="form-control " style="width: 100%;">
									<option value='0'>不同步</option>
									<option value='1'>同步</option>									
                            	</select>
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
                    <form id="export" class="form-horizontal">
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
                    <form id="edit" class="form-horizontal" >

                        <div class="form-group">
                            <label for="editLocalId" class="control-label col-md-3">本地编号</label>
                            <div class="col-md-8">
                                <input type="text" id="editLocalId" name="localId" class="form-control" required placeholder="请输入本地编号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editUinId" class="control-label col-md-3">操作员编号</label>
                            <div class="col-md-8">
                                <input type="text" id="editUinId" name="uin" class="form-control" required placeholder="请输入操作员编号">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="editMonthCardLocalId" class="control-label col-md-3">月卡号</label>
                            <div class="col-md-8">
                                <input type="text" id="editMonthCardLocalId" name="monthCardLocalId" required class="form-control" placeholder="请输入月卡号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editStartDate" class="control-label col-md-3">开始时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" id="editStartDate" name="startDate" required class="form-control" placeholder="请输入开始时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                        <div class="form-group">
                            <label for="editEndDate" class="control-label col-md-3">结束时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" id="editEndDate" name="endDate" required class="form-control" placeholder="请输入结束时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                        <div class="form-group">
                            <label for="editIsSynch" class="control-label col-md-3">是否同步</label>
                            <div class="col-md-8">
                                <select id="editIsSynch" name="isSynch" class="form-control " style="width: 100%;">
									<option value='0'>未同步</option>
                                    <option value='1'>同步</option>									
                            	</select>
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
                <button type="button" class="btn btn-default dropdown-toggle operate export" style="border-radius: 10%;margin: 0 20px 0 0" title="导出" data-toggle="modal" data-target="#modal-export">
                     <i class="glyphicon glyphicon-export icon-share"></i>
                </button>
                <input type="button" id="refresh" class="btn btn-default pull-left " style="border-radius: 10%;margin: 0 20px 0 0"  value="刷新">
                <input type="button" class="btn btn-default pull-left operate search" style="border-radius: 10% ;margin:0 20px 0 0px;line-height:normal" data-toggle="modal" data-target="#modal-search" value="搜索">
                <input type="button" class="btn btn-default pull-left operate add" style="border-radius: 10%;margin:0 20px 0 0px" data-toggle="modal" data-target="#modal-add" value="添加">
            </div>
        </div>
        <!--
				bootstrapTable:在table标签属性里面配置参数，也可以通过js配置url：配置请求的路径；toggle: 初始化Table；
				pagination: 是否启用分页；size: 每页显示的数据条数；list：每页显示的行数； pagination-loop: 是否启用启用分页条无限循环；
				side-pagination: 分页位置(server服务器分页；client客户端分页)； response-handler: 格式化从服务器获取到的数据；
				 query-params:传递参数； cache: 是否启用服务器缓存； show-columns: 是否显示 内容列下拉框； refresh: 起否启用刷新； number: 初始化加载第一页，默认第一页
			-->
        <table id="table" data-toggle="table" data-pagination="true" data-page-size="10" data-page-list="[10,20,30,All]" data-pagination-loop="false" data-side-pagination="server" data-response-handler="responseHandler"
            data-query-params="paginationParam" data-cache="false" data-show-toggle="true"  data-show-refresh="true" data-toolbar="#toolbar" data-method="post" data-page-number="1" data-content-type="application/x-www-form-urlencoded; charset=UTF-8">
            <thead>
                <tr>
                    <!--fidld: 需与后台返回数据保持一直； checkbox: 为true显示该列； visible: 为false隐藏该列； align、valign: 水平、垂直居中-->
                    <th data-field="check" data-class="middle" data-checkbox="true"  data-align="center" data-valign="middle"></th>
                    <th data-field="localId" data-align="center" data-valign="middle">本地编号</th>
                    <th data-field="uin" data-formatter="uinFormatter" data-align="center" data-valign="middle">操作员编号</th>
                    <th data-field="monthCardLocalId" data-align="center" data-valign="middle">月卡号</th>
                    <th data-field="startDate" data-align="center" data-valign="middle">开始时间</th>
                    <th data-field="endDate" data-align="center" data-valign="middle">结束时间</th>
                    <th data-field="isSynch"  data-formatter="isSynchFormatter"  data-align="center" data-valign="middle">是否同步</th>
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
   		var dataUrl = "${contextPath}/web/monthcardrecharge/searchByCondition?departmentId="
   		var contextPath = "${contextPath}";
   		var addUrl = '${contextPath}/web/monthcardrecharge/add'
   		var exportUrl = "${contextPath}/web/monthcardrecharge/exportExc"
   		
//   	    格式化向服务器发送的参数
   			function paginationParam(params) {
   			    var currPage = Math.floor((params.offset + params.limit) / params.limit);
   			    return {
   			        'offset': currPage,
   			        'limit': params.limit,
   			        'localId':$('#searchLocalId').val(),
   			     	'uin':$('#searchUin').val(),
   			  		'monthCardLocalId':$('#searchMonthCardLocalId').val(),
   					'feeType':$('#searchFeeType').val(),
   					'startDate':$('#searchStartDate').val(),
   					'startDateType':$('#searchStartDateType').val(),
   					'startDate1':$('#searchStartDate1').val(),
   					'endDate':$('#searchEndDate').val(),
   					'endDateType':$('#searchEndDateType').val(),
   					'endDate1':$('#searchEndDate1').val(),
   					'isSynch':$('#searchIsSynch').val(),
   			    }
   			}
    </script>   
    <script src="${contextPath}/jsp/scripts/url.js?1"></script>
    <script src="${contextPath}/jsp/scripts/monthcardrecharge.js?1"></script>

</body>

</html>