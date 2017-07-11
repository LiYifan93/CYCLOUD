<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>信息</title>
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<link rel="stylesheet"
	href="${contextPath}/jsp/libs/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${contextPath}/jsp/libs/dist/css/AdminLTE.min.css">
<style>
 #message .col-xs-12 {
	margin: 10px auto;
	text-align: center;
	font-size: 18px;
}

#message .col-xs-12 p {
	margin: 0;
}

#message .col-xs-12 p span {
	font-size: 16px;
	color: orangered;
}
</style>

</head>

<body class="hold-transition login-page">
	<div class="login-box" style="box-shadow: 1px 10px 10px gray;">
		<div class="login-box-body" style="border-radius: 10px;">
			<p class="login-box-msg" style="font-size: 20px">确认订单详情</p>

			<form id="message" method="post" action="getPay">
				<div class="row">
					<div class="col-xs-12">
						<p>
							开始时间：<span id="startDate">${WsOrder.data.inTime }</span>
						</p>
					</div>
					<div class="col-xs-12">
						<p>
							结束时间：<span id="endDate">${WsOrder.data.outTime }</span>
						</p>
					</div>
					<div class="col-xs-12">
						<p>
							我的车牌：<span id="plate">${WsOrder.data.plate }</span>
						</p>
					</div>
					<div class="col-xs-12">
						<p>
							应付停车费用：<span id="money">${WsOrder.data.totalFee/100 }</span>元
						</p>
					</div>
					<div class="col-xs-12">
						<p>
							收费类型：<span id="payType">${WsOrder.data.payType }</span>
						</p>
					</div>
					<div class="col-xs-12">
						<button type="submit" class="btn btn-primary btn-block btn-flat"
							style="border-radius: 5px">立即支付</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<script src="${contextPath}/jsp/libs/jquery/jquery.js"></script>
	<script src="${contextPath}/jsp/libs/bootstrap/js/bootstrap.min.js"></script>
</body>

</html>