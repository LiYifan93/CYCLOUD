<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <title>订单记录</title>
    <link href="${contextPath}/jsp/libs/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${contextPath}/jsp/libs/fonts/font-awesome.min.css">

    <link rel="stylesheet" type="text/css" href="${contextPath}/jsp/libs/bootstrap-table/bootstrap-table.css" />
    <!--日期控件-->
    <link rel="stylesheet" href="${contextPath}/jsp/libs/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
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
                <li><a><i class="fa fa-dashboard"></i> 当前位置</a></li>
                <li><a>订单中心</a></li>
                <li class="active">订单记录</li>
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

                <div class="modal-body form-horizontal">
                	<form id="search">
                        <div class="form-group">
                            <label for="searchLocalId" class="control-label col-md-3">本地编号</label>
                            <div class="col-md-8">
                                <input type="text" id="searchLocalId" name="localId" class="form-control" placeholder="请输入本地编号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchUin" class="control-label col-md-3">操作员编号</label>
                            <div class="col-md-8">
                                <input type="text" id="searchUin" name="uin" class="form-control" placeholder="请输入操作员编号">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="searchInTime" class="control-label col-md-3">入场时间</label>

                            <div class="col-md-6 controls input-append date dateTime s_time" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="startTime" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="searchInTime" name="inTime" required class="form-control" placeholder="入场时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="startTime" value="" />

                            <div class="col-md-2">
                                <select id="searchInTimeType" name="inTimeType" class="form-control"  onchange="change(this.options[this.options.selectedIndex].value)" style="width: 100%;">
									<option selected value=''>所有</option>
									<option value='1'>小于</option>
									<option value='2'>介于</option>
									<option value='3'>等于</option>
                                    <option value='4'>大于</option>
                            	</select>
                            </div>
							<div class="hid_den" style="display:none">
	                            <div class="col-md-3 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="endTime" data-link-format="yyyy-mm-dd hh:ii:ss">
	                                <input size="16" type="text" value="" readonly id="searchInTime1" name="inTime1" required class="form-control" placeholder="结束时间(可选)">
	                                <span class="add-on"><i class="icon-remove"></i></span>
	                                <span class="add-on"><i class="icon-th"></i></span>
	                            </div>
	                            <input type="hidden" id="endTime" value="" />
	                        </div>
						</div>
                        <div class="form-group">
                            <label for="searchOutTime" class="control-label col-md-3 ">出场时间</label>

                            <div class="col-md-6 controls input-append date dateTime c_time" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="startTime" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="searchOutTime" name="outTime" required class="form-control" placeholder="入场时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="startTime" value="" />

                            <div class="col-md-2">
                                <select id="searchOutTimeType" name="outTimeType" class="form-control" onchange="get(this.options[this.options.selectedIndex].value)" style="width: 100%;">
									<option selected value=''>所有</option>
									<option value='1'>小于</option>
									<option value='2'>介于</option>
									<option value='3'>等于</option>
                                    <option value='4'>大于</option>
                            	</select>
                            </div>
							<div class="c_hid_den" style="display:none">
	                            <div class="col-md-3 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="endTime" data-link-format="yyyy-mm-dd hh:ii:ss">
	                                <input size="16" type="text" value="" readonly id="searchOutTime1" name="outTime1" required class="form-control" placeholder="结束时间(可选)">
	                                <span class="add-on"><i class="icon-remove"></i></span>
	                                <span class="add-on"><i class="icon-th"></i></span>
	                            </div>
	                            <input type="hidden" id="endTime" value="" />
	                        </div>
						</div>
                        <div class="form-group">
                            <label for="searchOrderTime" class="control-label col-md-3">订单生成时间</label>

                            <div class="col-md-6 controls input-append date dateTime e_time" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="startTime" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="searchOrderTime" name="orderTime" required class="form-control" placeholder="入场时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="startTime" value="" />

                            <div class="col-md-2">
                                <select id="searchOrderTimeType" name="orderTimeType" class="form-control " onchange="end(this.options[this.options.selectedIndex].value)"  style="width: 100%;">
									<option selected value=''>所有</option>
									<option value='1'>小于</option>
									<option value='2'>介于</option>
									<option value='3'>等于</option>
                                    <option value='4'>大于</option>
                            	</select>
                            </div>
							<div class="e_hid_den" style="display:none">
	                            <div class="col-md-3 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="endTime" data-link-format="yyyy-mm-dd hh:ii:ss">
	                                <input size="16" type="text" value="" readonly id="searchOrderTime1" name="orderTime1" required class="form-control" placeholder="结束时间(可选)">
	                                <span class="add-on"><i class="icon-remove"></i></span>
	                                <span class="add-on"><i class="icon-th"></i></span>
	                            </div>
	                            <input type="hidden" id="endTime" value="" />
	                        </div>
						</div>
                        <div class="form-group">
                            <label for="searchPayTime" class="control-label col-md-3">支付时间</label>

                            <div class="col-md-6 controls input-append date dateTime p_time" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="startTime" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="searchPayTime" name="payTime" required class="form-control" placeholder="入场时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="startTime" value="" />

                            <div class="col-md-2">
                                <select id="searchPayTimeType" name="payTimeType" class="form-control " onchange="pay(this.options[this.options.selectedIndex].value)" style="width: 100%;">
									<option selected value=''>所有</option>
									<option value='1'>小于</option>
									<option value='2'>介于</option>
									<option value='3'>等于</option>
                                    <option value='4'>大于</option>
                            	</select>
                            </div>
							<div class="p_hid_den" style="display:none">
	                            <div class="col-md-3 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="endTime" data-link-format="yyyy-mm-dd hh:ii:ss">
	                                <input size="16" type="text" value="" readonly id="searchPayTime1" name="payTime1" required class="form-control" placeholder="结束时间(可选)">
	                                <span class="add-on"><i class="icon-remove"></i></span>
	                                <span class="add-on"><i class="icon-th"></i></span>
	                            </div>
	                            <input type="hidden" id="endTime" value="" />
	                        </div>
						</div>
                        <div class="form-group">
                            <label for="searchRoadId" class="control-label col-md-3">通道ID</label>
                            <div class="col-md-8">
                                <input type="text" id="searchRoadId" name="roadId" class="form-control" placeholder="请输入通道ID">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchPlate" class="control-label col-md-3">车牌号</label>
                            <div class="col-md-8">
                                <input type="text" id="searchPlate" name="plate" title="请输入5-8位的车牌号码"  minlength="5" maxlength="8" pattern="^[\u4e00-\u9fa5][a-zA-Z](([DF](?![a-zA-Z0-9]*[IO])[0-9]{4})|([0-9]{5}[DF]))|^[冀豫云辽黑湘皖鲁苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼渝京津沪新京军空海北沈兰济南广成使领A-Z]{1}[a-zA-Z0-9]{5}[a-zA-Z0-9挂学警港澳]{1}$" class="form-control" placeholder="请输入车牌号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchPayNo" class="control-label col-md-3">订单编号</label>
                            <div class="col-md-8">
                                <input type="text" id="searchPayNo" name="payNo" class="form-control" placeholder="请输入车牌号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchPayNo" class="control-label col-md-3">订单状态</label>
                            <div class="col-md-8">
                                <select name="status" id="searchStatus" class="form-control" style="width:100%">
                                    <option selected value="">全部</option>
                                    <option value="0">待支付</option>
                                    <option value="1">已支付</option>
                                    <option value="2">超时</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchPayType" class="control-label col-md-3">支付类型</label>
                            <div class="col-md-8">
                                <select name="payType" id="searchPayType" class="form-control" style="width:100%">
                                    <option selected value="">全部</option>
                                    <option value="0">现金支付</option>
                                    <option value="1">微信转账</option>
                                    <option value="2">扫码支付</option>
                                    <option value="3">小程序支付</option>
                                    <option value="4">预支付</option>
                                    <option value="5">其他</option>
                                </select>
                            </div>
                        </div>

                         <div class="form-group">
                            <label for="searchChargeCode" class="control-label col-md-3">收费类型ID</label>
                            <div class="col-md-8">
                                <input type="text" id="searchChargeCode" name="chargeCode" class="form-control" placeholder="请输入收费类型ID">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchEffectiveTime" class="control-label col-md-3">有效时长(秒)</label>
                            <div class="col-md-8">
                                <input type="number" id="searchEffectiveTime" name="effectiveTime" class="form-control" placeholder="请输入有效时长">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchReceiveFee" class="control-label col-md-3">应收金额</label>
                            <div class="col-md-8">
                                <input type="number" id="searchReceiveFee" name="receiveFee" class="form-control" placeholder="请输入应收金额">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchRealFee" class="control-label col-md-3">实收金额</label>
                            <div class="col-md-8">
                                <input type="number" id="searchRealFee" name="realFee" class="form-control" placeholder="请输入有效时长">
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
                    <form id="add" class="form-horizontal" >
						<div class="form-group" id="d_add">
                            <label for="departmentId" class="control-label col-md-3">停车场ID</label>
                            <div class="col-md-8">
                                <input type="text" class="departmentId" name="departmentId" class="form-control" required placeholder="请输入停车场ID">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="localId" class="control-label col-md-3">本地编号</label>
                            <div class="col-md-8">
                                <input type="text" id="localId" name="localId" class="form-control" placeholder="请输入本地编号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="uin" class="control-label col-md-3">操作员编号</label>
                            <div class="col-md-8">
                                <input type="text" id="uin" name="uin" class="form-control" placeholder="请输入操作员编号">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="inTime" class="control-label col-md-3">入场时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly name="inTime" required class="form-control" placeholder="请输入入场时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                         <div class="form-group">
                            <label for="outTime" class="control-label col-md-3">出场时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly name="outTime" required class="form-control" placeholder="请输入出场时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                        <div class="form-group">
                            <label for="orderTime" class="control-label col-md-3">订单生成时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly name="orderTime" required class="form-control" placeholder="请输入订单生成时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                        <div class="form-group">
                            <label for="payTime" class="control-label col-md-3">支付时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly name="payTime" required class="form-control" placeholder="请输入支付时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                        <div class="form-group">
                            <label for="roadId" class="control-label col-md-3">通道ID</label>
                            <div class="col-md-8">
                                <input type="text" id="roadId" name="roadId" class="form-control" placeholder="请输入通道ID">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="plate" class="control-label col-md-3">车牌号</label>
                            <div class="col-md-8">
                                <input type="text" id="plate" name="plate" title="请输入5-8位的车牌号码"  minlength="5" maxlength="8" pattern="^[\u4e00-\u9fa5][a-zA-Z](([DF](?![a-zA-Z0-9]*[IO])[0-9]{4})|([0-9]{5}[DF]))|^[冀豫云辽黑湘皖鲁苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼渝京津沪新京军空海北沈兰济南广成使领A-Z]{1}[a-zA-Z0-9]{5}[a-zA-Z0-9挂学警港澳]{1}$" class="form-control" placeholder="请输入车牌号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="payNo" class="control-label col-md-3">订单编号</label>
                            <div class="col-md-8">
                                <input type="text" id="payNo" name="payNo" class="form-control" placeholder="请输入车牌号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="status" class="control-label col-md-3">订单状态</label>
                            <div class="col-md-8">
                                <select name="status" id="status" class="form-control" style="width:100%">
                                    <option selected value="">全部</option>
                                    <option value="0">待支付</option>
                                    <option value="1">已支付</option>
                                    <option value="2">超时</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="payType" class="control-label col-md-3">支付类型</label>
                            <div class="col-md-8">
                                <select name="payType" id="payType" class="form-control" style="width:100%">
                                    <option selected value="">全部</option>
                                    <option value="0">现金支付</option>
                                    <option value="1">微信转账</option>
                                    <option value="2">扫码支付</option>
                                    <option value="3">小程序支付</option>
                                    <option value="4">预支付</option>
                                    <option value="5">其他</option>
                                </select>
                            </div>
                        </div>

                         <div class="form-group">
                            <label for="chargeCode" class="control-label col-md-3">收费类型ID</label>
                            <div class="col-md-8">
                                <input type="text" id="chargeCode" name="chargeCode" class="form-control" placeholder="请输入收费类型ID">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="effectiveTime" class="control-label col-md-3">有效时长(秒)</label>
                            <div class="col-md-8">
                                <input type="number" id="effectiveTime" name="effectiveTime" class="form-control" placeholder="请输入有效时长">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="receiveFee" class="control-label col-md-3">应收金额</label>
                            <div class="col-md-8">
                                <input type="number" id="receiveFee" name="receiveFee" class="form-control" placeholder="请输入应收金额">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="realFee" class="control-label col-md-3">实收金额</label>
                            <div class="col-md-8">
                                <input type="number" id="realFee" name="realFee" class="form-control" placeholder="请输入有效时长">
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
                                <input type="text" id="editLocalId" name="localId" class="form-control" placeholder="请输入本地编号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editUin" class="control-label col-md-3">操作员编号</label>
                            <div class="col-md-8">
                                <input type="text" id="editUin" name="uin" class="form-control" placeholder="请输入操作员编号">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="editInTime" class="control-label col-md-3">入场时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="editInTime" name="inTime" required class="form-control" placeholder="请输入入场时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                         <div class="form-group">
                            <label for="editOutTime" class="control-label col-md-3">出场时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="editOutTime" name="outTime" required class="form-control" placeholder="请输入出场时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                        <div class="form-group">
                            <label for="editOrderTime" class="control-label col-md-3">订单生成时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="editOrderTime" name="orderTime" required class="form-control" placeholder="请输入订单生成时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                        <div class="form-group">
                            <label for="editPayTime" class="control-label col-md-3">支付时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="editPayTime" name="payTime" required class="form-control" placeholder="请输入支付时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                        <div class="form-group">
                            <label for="editRoadId" class="control-label col-md-3">通道ID</label>
                            <div class="col-md-8">
                                <input type="text" id="editRoadId" name="roadId" class="form-control" placeholder="请输入通道ID">
                            </div>
                        </div>
                        
                        

                        <div class="form-group">
                            <label for="editPlate" class="control-label col-md-3">车牌号</label>
                            <div class="col-md-8">
                                <input type="text" id="editPlate" name="plate" title="请输入5-8位的车牌号码"  minlength="5" maxlength="8" pattern="^[\u4e00-\u9fa5][a-zA-Z](([DF](?![a-zA-Z0-9]*[IO])[0-9]{4})|([0-9]{5}[DF]))|^[冀豫云辽黑湘皖鲁苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼渝京津沪新京军空海北沈兰济南广成使领A-Z]{1}[a-zA-Z0-9]{5}[a-zA-Z0-9挂学警港澳]{1}$" class="form-control" placeholder="请输入车牌号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editPayNo" class="control-label col-md-3">订单编号</label>
                            <div class="col-md-8">
                                <input type="text" id="editPayNo" name="payNo" class="form-control" placeholder="请输入车牌号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editStatus" class="control-label col-md-3">订单状态</label>
                            <div class="col-md-8">
                                <select name="status" id="editStatus" class="form-control" style="width:100%">
                                    <option selected value="">全部</option>
                                    <option value="0">待支付</option>
                                    <option value="1">已支付</option>
                                    <option value="2">超时</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editPayType" class="control-label col-md-3">支付类型</label>
                            <div class="col-md-8">
                                <select name="payType" id="editPayType" class="form-control" style="width:100%">
                                    <option selected value="">全部</option>
                                    <option value="0">现金支付</option>
                                    <option value="1">微信转账</option>
                                    <option value="2">扫码支付</option>
                                    <option value="3">小程序支付</option>
                                    <option value="4">预支付</option>
                                    <option value="5">其他</option>
                                </select>
                            </div>
                        </div>

                         <div class="form-group">
                            <label for="editChargeCode" class="control-label col-md-3">收费类型ID</label>
                            <div class="col-md-8">
                                <input type="text" id="editChargeCode" name="chargeCode" class="form-control" placeholder="请输入收费类型ID">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editEffectiveTime" class="control-label col-md-3">有效时长(秒)</label>
                            <div class="col-md-8">
                                <input type="number" id="editEffectiveTime" name="effectiveTime" class="form-control" placeholder="请输入有效时长">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editReceiveFee" class="control-label col-md-3">应收金额</label>
                            <div class="col-md-8">
                                <input type="number" id="editReceiveFee" name="receiveFee" class="form-control" placeholder="请输入应收金额">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editRealFee" class="control-label col-md-3">实收金额</label>
                            <div class="col-md-8">
                                <input type="number" id="editRealFee" name="realFee" class="form-control" placeholder="请输入实收金额">
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
                     <i class="glyphicon glyphicon-export icon-share "></i>
                </button>
                <input type="button" id="refresh" class="btn btn-default pull-left " style="border-radius: 10%;margin: 0 20px 0 0"  value="刷新">
                <input type="button" class="btn btn-default pull-left operate search" style="border-radius: 10% ;margin: 0 20px 0 0px ;line-height:normal" data-toggle="modal" data-target="#modal-search" value="搜索">
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
            data-query-params="paginationParam"  data-cache="false" data-sortable = true data-show-toggle="true"   data-toolbar="#toolbar"  data-show-refresh="true" data-method="post"  data-page-number="1" data-content-type="application/x-www-form-urlencoded; charset=UTF-8">
            <thead>
                <tr>
                <!-- data-sortable="true" data-order="desc" -->
                    <!--fidld: 需与后台返回数据保持一直； checkbox: 为true显示该列； visible: 为false隐藏该列； align、valign: 水平、垂直居中-->
                    <th data-field="check" data-class="middle"  data-checkbox="true" data-align="center" data-valign="middle"></th>
                    <th data-field="localId" data-align="center" data-valign="middle">本地编号</th>
                    <th data-field="uin" data-formatter="uinFormatter" data-align="center" data-valign="middle">操作员编号</th>
                    <th data-field="roadId" data-align="center" data-valign="middle">通道ID</th>
                    <th data-field="plate" data-align="center" data-valign="middle">车牌号</th>
                    <th data-field="payNo" data-align="center" data-valign="middle">订单编号</th>
                    <th data-field="status" data-formatter="statusFormatter" data-align="center" data-valign="middle">订单状态</th>
                    <th data-field="payType" data-formatter="payTypeFormatter" data-align="center" data-valign="middle">支付类型</th>
                    <th data-field="chargeCode" data-align="center" data-valign="middle">收费类型ID</th>
                    <th data-field="effectiveTime" data-align="center" data-valign="middle">有效时长(秒)</th>
                    <th data-field="receiveFee" data-align="center" data-valign="middle">应收金额(元)</th>
                    <th data-field="realFee" data-align="center" data-valign="middle">实收金额(元)</th>
                    <th data-field="inTime" data-align="center" data-valign="middle">入场时间</th>
                    <th data-field="outTime" data-align="center" data-valign="middle">出场时间</th>
                    <th data-field="orderTime" data-align="center" data-valign="middle">订单生成时间</th>
                    <th data-field="payTime" data-align="center" data-valign="middle">支付时间</th>
                    <!--formatter: 格式化该列，自定义内容； events: 事件处理函数-->
                    <th id="operate" data-field="details" data-formatter="operateFormatter" data-events="operateEvents" data-align="center" data-valign="middle" data-width="70px">操 作</th>
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
   		var dataUrl = "${contextPath}/web/chargeorder/searchByCondition?departmentId="
   		var contextPath = "${contextPath}";
   		var addUrl = '${contextPath}/web/chargeorder/add'
   		var exportUrl = "${contextPath}/web/chargeorder/exportExc"
   		
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
   					'plate':$('#searchPlate').val(),
   					'payNo':$('#searchPayNo').val(),   	
                    'status':$('#searchStatus').val(),				
                    'payType':$('#searchPayType').val(),
                    'chargeCode':$('#searchChargeCode').val(),
                    'receiveFee':$('#searchReceiveFee').val(),
                    'effectiveTime':$('#searchEffectiveTime').val(),
                    'inTime':$('#searchInTime').val(),
                    'inTimeType':$('#searchInTimeType').val(),
                    'inTime1':$('#searchInTime1').val(),
                    'outTime':$('#searchOutTime').val(),
                    'outTimeType':$('#searchOutTimeType').val(),
                    'outTime1':$('#searchOutTime1').val(),
                    'orderTime':$('#searchOrderTime').val(),
                    'orderTimeType':$('#searchOrderTimeType').val(),
                    'orderTime1':$('#searchOrderTime1').val(),
                    'payTime':$('#searchPayTime').val(),
                    'payTimeType':$('#searchPayTimeType').val(),
                    'payTime1':$('#searchPayTime1').val(),
   			    }
   			}
    </script>   
    <script src="${contextPath}/jsp/scripts/url.js?1"></script>
    <script src="${contextPath}/jsp/scripts/chargeorder.js?2"></script>

</body>

</html>