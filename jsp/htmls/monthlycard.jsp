<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>月卡记录</title>
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
                <li><a>数据中心</a></li>
                <li class="active">月卡记录</li>
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
                            <label for="searchLocalId" class="control-label col-md-3">本地编号</label>
                            <div class="col-md-8">
                                <input type="text" id="searchLocalId"  name="localId" class="form-control" placeholder="请输入本地编号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchUin" class="control-label col-md-3">操作员编号</label>
                            <div class="col-md-8">
                                <input type="text" id="searchUin" name="uin" class="form-control" placeholder="请输入操作员编号">
                            </div>
                        </div>

						<div class="form-group">
                            <label for="date" class="control-label col-md-3">充值时间段查询</label>
                            <div class="col-md-6 controls input-append date dateTime s_time" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="startTime" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="searchNewDate" name="newDate" class="form-control" placeholder="请输入开始时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="StartDate" value="" />


                            <div class="col-md-2">
                                <select  id="searchNewDateType" name="startDateType" class="form-control" onchange="change(this.options[this.options.selectedIndex].value)"  style="width: 100%;">
									<option selected value=''>所有</option>
									<option value='1'>小于</option>
									<option value='2'>介于</option>
									<option value='3'>等于</option>
                                    <option value='4'>大于</option>
                            	</select>
                            </div>
                            <div class="hid_den" style="display:none">
	                            <div class="col-md-3 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="endTime" data-link-format="yyyy-mm-dd hh:ii:ss">
	                                <input size="16" type="text" value="" readonly id="searchNewDate1"  name="newDate1" class="form-control" placeholder="结束时间(可选)">
	                                <span class="add-on"><i class="icon-remove"></i></span>
	                                <span class="add-on"><i class="icon-th"></i></span>
	                            </div>
	                            <input type="hidden" id="EndDate" value="" />
	                        </div>
                        </div>
                        <div class="form-group">
                            <label for="searchCarName" class="control-label col-md-3">车主姓名</label>
                            <div class="col-md-8">
                                <input type="text" id="searchCarName" name="carName" minlength="2" maxlength="16" title="请输入正确的姓名" pattern="^[\u4e00-\u9fa5.]{1,7}$|^[\dA-Za-z_]{1,14}$" class="form-control" placeholder="请输入车主姓名">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchCarPhone" class="control-label col-md-3">车主手机号码</label>
                            <div class="col-md-8">
                                <input type="tel" id="searchCarPhone" name="carPhone" maxlength="11" minlength="11" title="请输入正确的手机号码" pattern="^((\+?86)|(\(\+86\)))?(13[012356789][0-9]{8}|15[012356789][0-9]{8}|18[02356789][0-9]{8}|147[0-9]{8}|1349[0-9]{7})$"    class="form-control" placeholder="请输入车主手机号码">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchPlate" class="control-label col-md-3">车牌号码</label>
                            <div class="col-md-8">
                                <input type="text" id="searchPlate" name="plate" title="请输入5-8位的车牌号码" minlength="5" maxlength="8" pattern="^[\u4e00-\u9fa5][a-zA-Z](([DF](?![a-zA-Z0-9]*[IO])[0-9]{4})|([0-9]{5}[DF]))|^[冀豫云辽黑湘皖鲁苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼渝京津沪新京军空海北沈兰济南广成使领A-Z]{1}[a-zA-Z0-9]{5}[a-zA-Z0-9挂学警港澳]{1}$" class="form-control" placeholder="请输入车牌号码">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchCarType" class="control-label col-md-3">车类型</label>
                            <div class="col-md-8">
                                <select id="searchCarType"  name="carType" class="form-control " style="width: 100%;">
									<option value='0'>小车</option>
									<option value='1'>大车</option>
									<option value='2'>超大车</option>
									<option value='3'>摩托车</option>
                                    <option value='' selected>所有</option>
                            	</select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchCardCode" class="control-label col-md-3">卡号</label>
                            <div class="col-md-8">
                                <input type="text" id="searchCardCode" name="cardCode" class="form-control" placeholder="请输入卡号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchFeeType" class="control-label col-md-3">收费类型</label>
                            <div class="col-md-8">
                            	<input type="text" id="searchFeeType"  name="feeType" class="form-control" placeholder="请输入收费类型">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchLotNum" class="control-label col-md-3">关联车位ID</label>
                            <div class="col-md-8">
                            	<input type="text" id="searchLotNum"  name="lotNum" class="form-control" placeholder="请输入关联车位ID">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchIsSynch" class="control-label col-md-3">是否同步</label>
                            <div class="col-md-8">
                                <select id="searchIsSynch" name="isSynch" class="form-control " style="width: 100%;">
									<option selected value=''>所有</option>
									<option value='1'>未同步</option>
                                    <option value='2'>已同步</option>									
                            	</select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchCardType" class="control-label col-md-3">月卡类型</label>
                            <div class="col-md-8">
                                <select id="searchCardType" name="cardType" class="form-control " style="width: 100%;">
									<option selected value=''>所有</option>
									<option value='0'>车牌</option>
                                    <option value='1'>车位</option>									
                            	</select>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="searchIsNew" class="control-label col-md-3">是否新增</label>
                            <div class="col-md-8">
                                <select id="searchIsNew" name="isNew" class="form-control " style="width: 100%;">
									<option selected value=''>所有</option>
									<option value='0'>新增</option>
                                    <option value='1'>更新</option>									
                            	</select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchStatus" class="control-label col-md-3">月卡状态</label>
                            <div class="col-md-8">
                                <select id="searchStatus" name="status" class="form-control " style="width: 100%;">
                                    <option selected value=''>所有</option>
									<option value='0'>无效</option>
									<option value='1'>有效</option>									
                            	</select>
                            </div>
                        </div>
						
						<!-- id="searchButton" -->
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
                                <input type="text" id="localId" name="localId" class="form-control" required placeholder="请输入本地编号">
                            </div>
                        </div>
                        
                         <div class="form-group">
                            <label for="newDate" class="control-label col-md-3">充值时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly name="newDate" required class="form-control" placeholder="请输入充值时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                        <div class="form-group">
                            <label for="uin" class="control-label col-md-3">操作员编号</label>
                            <div class="col-md-8">
                                <input type="text" id="uin" name="uin" class="form-control" required placeholder="请输入操作员编号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="carName" class="control-label col-md-3">车主姓名</label>
                            <div class="col-md-8">
                                <input type="text" id="carName" name="carName" minlength="2" maxlength="16" title="请输入正确的姓名" pattern="^[\u4e00-\u9fa5.]{1,7}$|^[\dA-Za-z_]{1,14}$" required class="form-control" placeholder="请输入车主姓名">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="carPhone" class="control-label col-md-3">车主手机号码</label>
                            <div class="col-md-8">
                                <input type="text" id="carPhone"  name="carPhone" required maxlength="11" minlength="11" title="请输入正确的手机号码" pattern="^((\+?86)|(\(\+86\)))?(13[012356789][0-9]{8}|15[012356789][0-9]{8}|18[02356789][0-9]{8}|147[0-9]{8}|1349[0-9]{7})$" class="form-control" placeholder="请输入车主手机号码">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="plate" class="control-label col-md-3">车牌号码</label>
                            <div class="col-md-8">
                                <input type="text" id="plate" name="plate" title="请输入5-8位的车牌号码" minlength="5" maxlength="8" pattern="^[\u4e00-\u9fa5][a-zA-Z](([DF](?![a-zA-Z0-9]*[IO])[0-9]{4})|([0-9]{5}[DF]))|^[冀豫云辽黑湘皖鲁苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼渝京津沪新京军空海北沈兰济南广成使领A-Z]{1}[a-zA-Z0-9]{5}[a-zA-Z0-9挂学警港澳]{1}$" required class="form-control" placeholder="请输入车牌号码">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="carType" class="control-label col-md-3">车类型</label>
                            <div class="col-md-8">
                                <select id="carType" name="carType" class="form-control " style="width: 100%;">
									<option value='0'>小车</option>
									<option value='1'>大车</option>
                                    <option value='2'>超大车</option>
									<option value='3'>摩托车</option>
									<option value='4'>其他</option>
                            	</select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="cardCode" class="control-label col-md-3">卡号</label>
                            <div class="col-md-8">
                                <input type="text" id="cardCode" name="cardCode" required class="form-control" placeholder="请输入卡号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="feeType" class="control-label col-md-3">收费类型</label>
                            <div class="col-md-8">
                            	<input type="text" name="feeType" required class="form-control" placeholder="请输入收费类型">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="lotNum" class="control-label col-md-3">关联车位ID</label>
                            <div class="col-md-8">
                            	<input type="text" name="lotNum" required class="form-control" placeholder="请输入关联车位ID">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="cardType" class="control-label col-md-3">月卡状态</label>
                            <div class="col-md-8">
                                <select id="cardType" name="cardType" class="form-control " style="width: 100%;">
									<option value='0'>车牌</option>
									<option value='1'>车位</option>
                            	</select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="status" class="control-label col-md-3">月卡状态</label>
                            <div class="col-md-8">
                                <select id="status" name="status" class="form-control " style="width: 100%;">
									<option value='0'>无效</option>
									<option value='1'>有效</option>
                                    <option value='-1'>过期</option>
                            	</select>
                            </div>
                        </div>

                       

                        <div class="form-group">
                            <label for="isSynch" class="control-label col-md-3">是否同步</label>
                            <div class="col-md-8">
                                <select id="isSynch" name="isSynch" class="form-control " style="width: 100%;">
									<option value='0'>未同步</option>
                                    <option value='1'>已同步</option>
                            	</select>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="isNew" class="control-label col-md-3">是否新增</label>
                            <div class="col-md-8">
                                <select id="isNew" name="isNew" class="form-control " style="width: 100%;">
									<option value='0'>新增</option>
                                    <option value='1'>更新</option>
                            	</select>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="remarks" class="control-label col-md-3">备注信息</label>
                            <div class="col-md-8">
                                <textarea rows="5" id="remarks" name="remarks" class="form-control" cols="45"></textarea>
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
                    <form id="edit" class="form-horizontal">

                        <div class="form-group">
                            <label for="editLocalId" class="control-label col-md-3">本地编号</label>
                            <div class="col-md-8">
                                <input type="text" id="editLocalId" name="localId" class="form-control" required placeholder="请输入本地编号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editUin" class="control-label col-md-3">操作员编号</label>
                            <div class="col-md-8">
                                <input type="text" id="editUin" name="uin" class="form-control" required placeholder="请输入操作员编号">
                            </div>
                        </div>
                        
                         <div class="form-group">
                            <label for="editNewDate" class="control-label col-md-3">收费时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="editNewDate" name="newDate" required class="form-control" placeholder="请输入收费时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                        <div class="form-group">
                            <label for="editCarName" class="control-label col-md-3">车主姓名</label>
                            <div class="col-md-8">
                                <input type="text" id="editCarName" name="carName" minlength="2" maxlength="16" title="请输入正确的姓名" pattern="^[\u4e00-\u9fa5.]{1,7}$|^[\dA-Za-z_]{1,14}$" required class="form-control" placeholder="请输入车主姓名">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editCarPhone" class="control-label col-md-3">车主手机号码</label>
                            <div class="col-md-8">
                                <input type="tel" id="editCarPhone" name="carPhone" required maxlength="11" minlength="11" title="请输入正确的手机号码" pattern="^((\+?86)|(\(\+86\)))?(13[012356789][0-9]{8}|15[012356789][0-9]{8}|18[02356789][0-9]{8}|147[0-9]{8}|1349[0-9]{7})$" class="form-control" placeholder="请输入车主手机号码">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editPlate" class="control-label col-md-3">车牌号码</label>
                            <div class="col-md-8">
                                <input type="text" id="editPlate" name="plate" title="请输入5-8位的车牌号码"  minlength="5" maxlength="8" pattern="^[\u4e00-\u9fa5][a-zA-Z](([DF](?![a-zA-Z0-9]*[IO])[0-9]{4})|([0-9]{5}[DF]))|^[冀豫云辽黑湘皖鲁苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼渝京津沪新京军空海北沈兰济南广成使领A-Z]{1}[a-zA-Z0-9]{5}[a-zA-Z0-9挂学警港澳]{1}$" required class="form-control" placeholder="请输入车牌号码">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editCarType" class="control-label col-md-3">车类型</label>
                            <div class="col-md-8">
                                <select id="editCarType" name="carType" class="form-control " style="width: 100%;">
									<option value='0'>小车</option>
									<option value='1'>大车</option>
                                    <option value='2'>超大车</option>
									<option value='3'>摩托车</option>
                                    <option value='4'>其他</option>									
                            	</select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editCardCode" class="control-label col-md-3">卡号:</label>
                            <div class="col-md-8">
                                <input type="text" id="editCardCode" name="cardCode" required class="form-control" placeholder="请输入卡号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editFeeType" class="control-label col-md-3">收费类型</label>
                            <div class="col-md-8">
                            	<input type="text" id="editFeeType" name="feeType" required class="form-control" placeholder="请输入收费类型">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editLotNum" class="control-label col-md-3">关联车位ID</label>
                            <div class="col-md-8">
                            	<input type="text" id="editLotNum" name="lotNum" required class="form-control" placeholder="请输入关联车位ID">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editCardType" class="control-label col-md-3">月卡类型</label>
                            <div class="col-md-8">
                                <select id="editCardType" name="cardType" class="form-control " style="width: 100%;">
									<option value='0'>车牌</option>
									<option value='1'>车位</option>
                            	</select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editStatus" class="control-label col-md-3">月卡状态</label>
                            <div class="col-md-8">
                                <select id="editStatus" name="status" class="form-control " style="width: 100%;">
									<option value='0'>无效</option>
									<option value='1'>有效</option>
                                    <option value='-1'>过期</option>									
                            	</select>
                            </div>
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
                        
                        <div class="form-group">
                            <label for="editIsNew" class="control-label col-md-3">是否新增</label>
                            <div class="col-md-8">
                                <select id="editIsNew" name="isNew" class="form-control " style="width: 100%;">
									<option value='0'>未同步</option>
									<option value='1'>同步</option>
                            	</select>
                            </div>
                        </div>
                        
                         <div class="form-group">
                            <label for="editRemarks" class="control-label col-md-3">备注信息</label>
                            <div class="col-md-8">
                                <textarea rows="5" id="editRemarks" name="remarks" class="form-control" cols="45"></textarea>
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
                <button type="button" class="btn btn-default dropdown-toggle" style="border-radius: 10%;margin: 0 20px 0 0" title="导出" data-toggle="modal" data-target="#modal-export">
                     <i class="glyphicon glyphicon-export icon-share"></i>
                </button>
                <input type="button" id="refresh" class="btn btn-default pull-left " style="border-radius: 10%;margin: 0 20px 0 0"  value="刷新">
                <input type="button" class="btn btn-default pull-left" style="border-radius: 10% ;margin: 0 20px 0 0 ;line-height:normal" data-toggle="modal" data-target="#modal-search" value="搜索">
                <input type="button" class="btn btn-default pull-left" style="border-radius: 10%;margin: 0 20px 0 0" data-toggle="modal" data-target="#modal-add" value="添加">
            </div>
        </div>
        <!--
				bootstrapTable:在table标签属性里面配置参数，也可以通过js配置url：配置请求的路径；toggle: 初始化Table；
				pagination: 是否启用分页；size: 每页显示的数据条数；list：每页显示的行数； pagination-loop: 是否启用启用分页条无限循环；
				side-pagination: 分页位置(server服务器分页；client客户端分页)； response-handler: 格式化从服务器获取到的数据；
				 query-params:传递参数； cache: 是否启用服务器缓存； show-columns: 是否显示 内容列下拉框； refresh: 起否启用刷新； number: 初始化加载第一页，默认第一页
			-->
        <table id="table" data-toggle="table" data-pagination="true" data-page-size="10" data-page-list="[10,20,30,All]" data-pagination-loop="false" data-side-pagination="server" data-response-handler="responseHandler"
            data-query-params="paginationParam" data-cache="false" data-show-refresh="true" data-toolbar="#toolbar" data-show-toggle="true" data-method="post"  data-page-number="1" data-content-type="application/x-www-form-urlencoded; charset=UTF-8">
            <thead>
                <tr>
                    <!--fidld: 需与后台返回数据保持一直； checkbox: 为true显示该列； visible: 为false隐藏该列； align、valign: 水平、垂直居中-->
                    <th data-field="check" data-class="middle" data-checkbox="true" data-align="center" data-valign="middle"></th>
                    <th data-field="localId" data-align="center" data-valign="middle">本地编号</th>
                    <th data-field="uin" data-formatter="uinFormatter" data-align="center" data-valign="middle">操作员编号</th>
                    <th data-field="carName" data-align="center" data-valign="middle">车主姓名</th>
                    <th data-field="carPhone" data-align="center" data-valign="middle">车主手机号码</th>
                    <th data-field="plate" data-align="center" data-valign="middle">车牌号码</th>
                    <th data-field="carType" data-formatter="carTypeFormatter" data-align="center" data-valign="middle">车类型</th>
                    <th data-field="cardCode" data-align="center" data-valign="middle">卡号</th>
                    <th data-field="isSynch" data-formatter="isSynchFormatter" data-align="center" data-valign="middle">是否同步</th>
                    <th data-field="feeType" data-align="center" data-valign="middle">收费类型</th>
                    <th data-field="isNew" data-formatter="isNFormatter" data-align="center" data-valign="middle">是否新增</th>
                    <th data-field="lotNum" data-align="center" data-valign="middle">关联车位ID</th>
                    <th data-field="cardType" data-formatter="cardTypeFormatter"  data-align="center" data-valign="middle">月卡类型</th>
                    <th data-field="status" data-formatter="statusFormatter" data-align="center" data-valign="middle">月卡状态</th>
                    <th data-field="newDate" data-align="center" data-valign="middle">充值时间</th>
                   	<th data-field="remarks" data-align="center" data-valign="middle">备注</th>
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
   		var dataUrl = "${contextPath}/web/monthlycard/searchByCondition?departmentId="
   		var contextPath = "${contextPath}";  	
   		var addUrl = '${contextPath}/web/monthlycard/add'
   		var exportUrl = "${contextPath}/web/monthlycard/exportExc"
        
        //  格式化向服务器发送的参数
   			function paginationParam(params) {
   			    var currPage = Math.floor((params.offset + params.limit) / params.limit);
   			    return {
   			        'offset': currPage,
   			        'limit': params.limit,
   			        'localId':$('#searchLocalId').val(),
   			     	'uin':$('#searchUin').val(),
   			     	'carName':$('#searchCarName').val(),
   			  		'carPhone':$('#searchCarPhone').val(),
   					'plate':$('#searchPlate').val(),
   					'carType':$('#searchCarType').val(),
   					'cardCode':$('#searchCardCode').val(),
   					'feeType':$('#searchFeeType').val(),
   					'isNew':$('#searchIsNew').val(),
   					'lotNum':$('#searchLotNum').val(),
   					'cardType':$('#searchCardType').val(),
   					'newDate':$('#searchNewDate').val(),
                    'newDateType':$('#searchNewDateType').val(),
                    'newDate1':$('#searchNewDate1').val(),
                    'isSynch':$('#searchIsSynch').val(),
                    'status':$('#searchStatus').val(),
   			    }
   			}
   		
    </script>   
    <script src="${contextPath}/jsp/scripts/url.js"></script>
    <script src="${contextPath}/jsp/scripts/monthlycard.js?2"></script>

</body>

</html>