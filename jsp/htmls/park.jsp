<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>初始化信息</title>
<link rel="stylesheet"
	href="${contextPath}/jsp/libs/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${contextPath}/jsp/libs/fonts/font-awesome.min.css">
<!--日期控件-->
<link rel="stylesheet"
	href="${contextPath}/jsp/libs/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css">
	
	<style>
    	.middle{
    		vertical-align: middle !important;
    	}
    </style>
</head>

<body style="padding-top: 50px;">
	 <nav class="navbar navbar-brand navbar-fixed-top" style="background-color: white">
        <section class="content-header">
            <ol class="breadcrumb" style="background: white; font-size: 15px;">
                <li><a><i class="fa fa-dashboard"></i> 当前位置</a></li>
                <li><a>车场信息</a></li>
                <li class="active">初始化信息</li>
            </ol>
        </section>
    </nav>
		<div class="container" style="margin-top:50px;border:1px solid grey;padding:20px 10px" >
				<div class=" form-horizontal">
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="lotTotal" class="control-label col-md-3" >总车位数</label>
								<div class="col-md-8">
									<input type="number" id="lotTotal" disabled name="lotTotal"
										class="form-control">
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="firstProvinceId" class="control-label col-md-3">优先识别省份Id</label>
								<div class="col-md-8">
									<input type="number" id="firstProvinceId" disabled name="firstProvinceId"
										class="form-control">
								</div>
							</div>
						</div>
					
					</div>
					
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="monthCardNum" class="control-label col-md-3">月卡车位数</label>
								<div class="col-md-8">
									<input type="number" id="monthCardNum" name="monthCardNum" disabled
										class="form-control">
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="whiteCarNum" class="control-label col-md-3">白名单车位数</label>
								<div class="col-md-8">
									<input type="number" id="whiteCarNum" name="whiteCarNum" disabled
										class="form-control">
								</div>
							</div>
						</div>
					
					</div>
						
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="outTimeDelay" class="control-label col-md-3">出场延时(分钟)</label>
								<div class="col-md-8">
									<input type="number" id="outTimeDelay" name="outTimeDelay" disabled
										class="form-control">
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="lotType" class="control-label col-md-3">车位类型 </label>
								<div class="col-md-8">
									<select id="lotType" disabled name="lotType"
										class="form-control">
										<option value="0">地面</option>
										<option value="1">地下</option>
										<option value="2">占道</option>
										<option value="3">室内</option>
										<option value="4">室外</option>
										<option value="5">室内外</option>
									</select>
								</div>
							</div>
						</div>
					</div>	
					
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="isApp" class="control-label col-md-3">小程序支付</label>
								<div class="col-md-8">
									<select id="isApp" disabled name="isApp"
										class="form-control">
										<option value="0">不支持</option>
										<option value="1">支持</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="parkType" class="control-label col-md-3">停车场类型</label>
								<div class="col-md-8">
									<select id="parkType" disabled name="parkType"
										class="form-control">
										<option value="0">免费</option>
										<option value="1">付费</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="stopType" class="control-label col-md-3">车库类型</label>
								<div class="col-md-8">
									<select id="stopType" disabled name="stopType"
										class="form-control">
										<option value="0">平面排列</option>
										<option value="1">立体排列</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="isBook" class="control-label col-md-3">预约</label>
								<div class="col-md-8">
									<select id="isBook" disabled name="isBook"
										class="form-control">
										<option value="0">不可预约</option>
										<option value="1">可预约</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="isNavi" class="control-label col-md-3">导航</label>
								<div class="col-md-8">
									<select id="isNavi" disabled name="isNavi"
										class="form-control">
										<option value="0">不支持</option>
										<option value="1">支持</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="isMonthlyPay" class="control-label col-md-3">月卡</label>
								<div class="col-md-8">
									<select id="isMonthlyPay" disabled name="isMonthlyPay"
										class="form-control">
										<option value="0">支持</option>
										<option value="1">不支持</option>
									</select>
								</div>
							</div>
						</div>
					</div>
						
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="isStoreCard" class="control-label col-md-3">储值卡</label>
								<div class="col-md-8">
									<select id="isStoreCard" disabled name="isStoreCard"
										class="form-control">
										<option value="0">支持</option>
										<option value="1">不支持</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="isNight" class="control-label col-md-3">夜晚停车</label>
								<div class="col-md-8">
									<select id="isNight" disabled name="isNight"
										class="form-control">
										<option value="0">支持</option>
										<option value="1">不支持</option>
									</select>
								</div>
							</div>
						</div>
					</div>	
					
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="isEpay" class="control-label col-md-3">电子支付</label>
								<div class="col-md-8">
									<select id="isEpay" disabled name="isEpay"
										class="form-control">
										<option value="0">支持</option>
										<option value="1">不支持</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="isView" class="control-label col-md-3">地图显示</label>
								<div class="col-md-8">
									<select id="isView" disabled name="isView"
										class="form-control">
										<option value="0">不支持</option>
										<option value="1">支持</option>
									</select>
								</div>
							</div>
						</div>
					</div>	
						
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="isCarType" class="control-label col-md-3">大小车</label>
								<div class="col-md-8">
									<select id="isCarType" disabled name="isCarType"
										class="form-control">
										<option value="0">不区分</option>
										<option value="1">区分</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="recordNumber" class="control-label col-md-3">备案号</label>
								<div class="col-md-8">
									<input type="text" id="recordNumber" name="recordNumber" disabled
										class="form-control">
								</div>
							</div>
						</div>
					</div>	
					
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="remarks" class="control-label col-md-3">备注</label>
								<div class="col-md-8">
									<textarea rows="3" cols="45" class="form-control" name="remarks" id="remarks" disabled></textarea>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							
						</div>
				</div>			
						
				</div>
			</div>

	<script src="${contextPath}/jsp/libs/jquery/jquery.js"></script>
	<script src="${contextPath}/jsp/libs/bootstrap/js/bootstrap.min.js"></script>
	<script src="${contextPath}/jsp/libs/modal.js"></script>
	<script>
		var url = location.href
		var departmentId = url.split('?')[1]
		$.ajax({
			type : 'POST',
			dataType : 'json',
			url : '${contextPath}/web/park/find?departmentId=' + departmentId,
			success : function(res) {
				if (res.code == 1) {
					$('#lotTotal').val(res.data.lotTotal)
					$('#firstProvinceId').val(res.data.firstProvinceId)
					$('#monthCardNum').val(res.data.monthCardNum)
					$('#whiteCarNum').val(res.data.whiteCarNum)
					$('#outTimeDelay').val(res.data.outTimeDelay)
					$('#lotType').val(res.data.lotType)
					$('#isApp').val(res.data.isApp)
					$('#parkType').val(res.data.parkType)
					$('#stopType').val(res.data.stopType)
					$('#isBook').val(res.data.isBook)
					$('#isNavi').val(res.data.isNavi)
					$('#isMonthlyPay').val(res.data.isMonthlyPay)
					$('#isStoreCard').val(res.data.isStoreCard)
					$('#isNight').val(res.data.isNight)
					$('#isEpay').val(res.data.isEpay)
					$('#isView').val(res.data.isView)
					$('#isCarType').val(res.data.isCarType)
					$('#recordNumber').val(res.data.recordNumber)
					$('#remarks').val(res.data.remarks)
				} else
					showFailure(res.message)
			},
			error : function(err) {
				showFailure('服务端链接错误，请稍后再试！')
			}
		})
	</script>

</body>


</html>