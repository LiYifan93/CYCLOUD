<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title> 黑名单</title>
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
                <li class="active">黑名单</li>
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
                            <label class="control-label col-md-3">车牌号</label>
                            <div class="col-md-8">
                                <input type="text" id="searchPlate" name="plate" title="请输入5-8位的车牌号码" minlength="5" maxlength="8" title="请输入5-8位的车牌号" pattern="^[\u4e00-\u9fa5][a-zA-Z](([DF](?![a-zA-Z0-9]*[IO])[0-9]{4})|([0-9]{5}[DF]))|^[冀豫云辽黑湘皖鲁苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼渝京津沪新京军空海北沈兰济南广成使领A-Z]{1}[a-zA-Z0-9]{5}[a-zA-Z0-9挂学警港澳]{1}$"  class="form-control" placeholder="请输入车牌号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3">车类型</label>
                            <div class="col-md-8">
                                <select id="searchType" name="type" class="form-control " style="width: 100%;">
									<option value='0'>挂失车</option>
									<option value='1'>通缉车</option>
                                    <option value='2'>其它</option>
                                    <option selected="selected" value=''>所有</option>									
                            	</select>
                            </div>
                        </div>

                        <div class="form-group">

                            <label for="date" class="control-label col-md-3">开始时间段查询</label>

                            <div class="col-md-6 controls input-append date dateTime s_time" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="startTime" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" id="searchStartTime" readonly name="startTime" required class="form-control" placeholder="请输入开始时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="startTime" value="" />


                            <div class="col-md-2">
                                <select id="searchStartTimeType" name="startTimeType" class="form-control " onchange="change(this.options[this.options.selectedIndex].value)" style="width: 100%;">
									<option selected value=''>所有</option>
									<option value='1'>小于</option>
									<option value='2'>介于</option>
									<option value='3'>等于</option>
                                    <option value='4'>大于</option>
                            	</select>
                            </div>
                            
                            <div class="hid_den" style="display:none">
	                            <div class="col-md-3 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="endDate" data-link-format="yyyy-mm-dd hh:ii:ss">
	                                <input size="16" type="text" value="" readonly id="searchStartTime1" name="startTime1"   class="form-control" placeholder="结束时间(可选)">
	                                <span class="add-on"><i class="icon-remove"></i></span>
	                                <span class="add-on"><i class="icon-th"></i></span>
	                            </div>
	                            <input type="hidden" id="endDate" value="" />
	                         </div>
                        </div>

                        <div class="form-group">
                            <label for="date" class="control-label col-md-3">结束时间段查询</label>
                            <div class="col-md-6 controls input-append date dateTime c_time" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="endTime" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="searchEndTime" name="endTime" class="form-control" placeholder="请输入开始时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="endTime" value="" />

                            <div class="col-md-2">
                                <select id="searchEndTimeType" id="searchEndTimeType" onchange="get(this.options[this.options.selectedIndex].value)"   name="endTimeType" class="form-control " style="width: 100%;">
									<option selected value=''>所有</option>
									<option value='1'>小于</option>
									<option value='2'>介于</option>
									<option value='3'>等于</option>
                                    <option value='4'>大于</option>
                            	</select>
                            </div>
                            <div class="c_hid_den" style="display:none">
	                            <div class="col-md-3 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="endTime" data-link-format="yyyy-mm-dd hh:ii:ss">
	                                <input size="16" type="text" value="" id="searchEndTime1" readonly name="endTime1" class="form-control" placeholder="结束时间(可选)">
	                                <span class="add-on"><i class="icon-remove"></i></span>
	                                <span class="add-on"><i class="icon-th"></i></span>
	                            </div>
	                            <input type="hidden" id="endDate" value="" />
	                        </div>
                        </div>
                        <div class="form-group">
                            <label for="searchIsSynch" class="control-label col-md-3">是否同步</label>
                            <div class="col-md-8">
                                <select id="searchIsSynch" name="isSynch" class="form-control " style="width: 100%;">
                                	<option selected value=''>所有</option>
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
                            <label class="control-label col-md-3">车牌号</label>
                            <div class="col-md-8">
                                <input type="text" name="plate" title="请输入5-8位的车牌号码" minlength="5" maxlength="8" title="请输入5-8位的车牌号" pattern="^[\u4e00-\u9fa5][a-zA-Z](([DF](?![a-zA-Z0-9]*[IO])[0-9]{4})|([0-9]{5}[DF]))|^[冀豫云辽黑湘皖鲁苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼渝京津沪新京军空海北沈兰济南广成使领A-Z]{1}[a-zA-Z0-9]{5}[a-zA-Z0-9挂学警港澳]{1}$"  class="form-control" required placeholder="请输入车牌号">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="control-label col-md-3">开始时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly name="startTime" required class="form-control" placeholder="请输入开始时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3">结束时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly name="endTime" required class="form-control" placeholder="请输入结束时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-3">车类型</label>
                            <div class="col-md-8">
                                <select name="type" class="form-control " style="width: 100%;">
									<option value='0'>挂失车</option>
									<option value='1'>通缉车</option>
                                    <option value='2'>其它</option>									
                            	</select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="isSynch" class="control-label col-md-3">是否同步</label>
                            <div class="col-md-8">
                                <select id="isSynch" name="isSynch" class="form-control " style="width: 100%;">
									<option value='0'>不同步</option>
									<option value='1'>同步</option>
                            	</select>
                            </div>
                        </div>
                        
                        <div class="form-group">
							<label for="remarks" class="control-label col-md-3">备注</label>
							<div class="col-md-8">
								<textarea rows="3" cols="45" class="form-control" id="remarks" name="remarks" ></textarea>
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
                                <input type="text" class="user" name="user" class="form-control" required placeholder="请输入停车场ID">
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
                    <form id="edit" class="form-horizontal" name="edit">
                        <div class="form-group">
                            <label for="editPlate" class="control-label col-md-3">车牌号</label>
                            <div class="col-md-8">
                                <input type="text" id="editPlate" name="plate" title="请输入5-8位的车牌号码" minlength="5" maxlength="8" title="请输入5-8位的车牌号" pattern="^[\u4e00-\u9fa5][a-zA-Z](([DF](?![a-zA-Z0-9]*[IO])[0-9]{4})|([0-9]{5}[DF]))|^[冀豫云辽黑湘皖鲁苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼渝京津沪新京军空海北沈兰济南广成使领A-Z]{1}[a-zA-Z0-9]{5}[a-zA-Z0-9挂学警港澳]{1}$"  class="form-control" required placeholder="请输入车牌号">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editType" class="control-label col-md-3">车类型</label>
                            <div class="col-md-8">
                                <select id="editType" name="type" class="form-control " style="width: 100%;">
									<option value='0'>挂失车</option>
									<option value='1'>通缉车</option>
                                    <option value='2'>其它</option>
                            	</select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="editStartTime" class="control-label col-md-3">开始时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="editStartTime" name="startTime" required class="form-control" placeholder="请输入开始时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>

                        <div class="form-group">
                            <label for="editEndTime" class="control-label col-md-3">结束时间</label>
                            <div class="col-md-8 controls input-append date dateTime" data-date-format="yyyy-mm-dd hh:ii:ss" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd hh:ii:ss">
                                <input size="16" type="text" value="" readonly id="editEndTime" name="endTime" required class="form-control" placeholder="请输入结束时间">
                                <span class="add-on"><i class="icon-remove"></i></span>
                                <span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" />
                        </div>
                        
                        <div class="form-group">
                            <label for="editIsSynch" class="control-label col-md-3">是否同步</label>
                            <div class="col-md-8">
                                <select id="editIsSynch" name="isSynch" class="form-control " style="width: 100%;">
									<option value='0'>不同步</option>
									<option value='1'>同步</option>
                            	</select>
                            </div>
                        </div>
                        
                        <div class="form-group">
							<label for="editRemarks" class="control-label col-md-3">备注</label>
							<div class="col-md-8">
								<textarea rows="3" cols="45" class="form-control" id="editRemarks" name="remarks"  ></textarea>
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
                <input type="button" class="btn btn-default pull-left operate search" style="border-radius: 10% ;margin: 0 20px 0 0 ;line-height:normal"  data-toggle="modal" data-target="#modal-search" value="搜索">
                <input type="button" class="btn btn-default pull-left operate  add" style="border-radius: 10%;margin: 0 20px 0 0" data-toggle="modal" data-target="#modal-add" value="添加">
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
                    <th data-field="plate" data-align="center" data-valign="middle">车牌号</th>
                    <th data-field="type" data-formatter="typeFormatter"  data-align="center" data-valign="middle">车类型</th>
                    <th data-field="startTime" data-align="center" data-valign="middle">开始时间</th>
                    <th data-field="endTime" data-align="center" data-valign="middle">结束时间</th>
                   	<th data-field="isSynch" data-formatter="isSynchFormatter" data-align="center" data-valign="middle">是否同步</th>
                    <th data-field="remarks" data-align="center" data-valign="middle">备注信息</th>
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
     
   		var dataUrl = "${contextPath}/web/blacklist/searchByCondition?departmentId="
   		var contextPath = "${contextPath}";
   		console.log(contextPath);    		
   		var addUrl = '${contextPath}/web/blacklist/add'
   		var exportUrl = "${contextPath}/web/blacklist/exportExc"
   		
			//格式化向服务器发送的参数
   			function paginationParam(params) {
   			    // alert(params)
   			    var currPage = Math.floor((params.offset + params.limit) / params.limit);
   			    return {
   			        'offset': currPage,
   			        'limit': params.limit,
   			  		'plate':$('#searchPlate').val(),
   					'type':$('#searchType').val(),
   					'startTime':$('#searchStartTime').val(),
   					'startTimeType':$('#searchStartTimeType').val(),
   					'startTime1':$('#searchStartTime1').val(),
   					'endTime':$('#searchEndTime').val(),
   					'endTimeType':$('#searchEndTimeType').val(),
   					'endTime1':$('#searchEndTime1').val(),
   					"isSynch":$('#searchIsSynch').val()
   			    }
   			}
   		
   		
   		
    </script>   
    <script src="${contextPath}/jsp/scripts/url.js?12"></script>
    <script src="${contextPath}/jsp/scripts/blacklist.js?2"></script>
</body>

</html>