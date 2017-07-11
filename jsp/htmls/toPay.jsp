<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>查询页面</title>
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<link rel="stylesheet"
	href="${contextPath}/jsp/libs/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${contextPath}/jsp/libs/dist/css/AdminLTE.min.css">

</head>

<body class="hold-transition login-page">
	<div class="login-box">
		<div class="login-logo">
			<a href="http://www.cy-card.com/"><b>畅盈</b>云平台</a>
		</div>
		<!-- /.login-logo -->
		<div class="login-box-body"
			style="border-radius: 10px; box-shadow: 10px 10px 10px gray">
			<p class="login-box-msg">正在支付...</p>
		</div>
	</div>
	<script src="${contextPath}/jsp/libs/jquery/jquery.js"></script>
	<script src="${contextPath}/jsp/libs/bootstrap/js/bootstrap.js "
		charset="UTF-8"></script>
	<script src="${contextPath}/jsp/libs/modal.js"></script>
	<script src="${contextPath}/jsp/libs/jweixin-1.0.0.js"></script>
	<script type="text/javascript">
		/* 	{
		 "appId":${params.appId}, //公众号名称，由商户传入 
		 "timeStamp":${params.timeStamp}, //时间戳，自1970年以来的秒数     
		 "nonceStr":${params.nonceStr}, //随机串     
		 "package":${params.package2},
		 "signType":${params.signType}, //微信签名方式：     
		 "paySign":${params.paySign} //微信签名 
		 } */
		var params = ${pay_attr};
		
		function onBridgeReady() {
			WeixinJSBridge.invoke('getBrandWCPayRequest', params,
					function(res) {
						if (res.err_msg == "get_brand_wcpay_request:ok") {
							alert("支付成功");
						} // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。 
					});
		}
		function pay() {
			if (typeof WeixinJSBridge == "undefined") {
				if (document.addEventListener) {
					document.addEventListener('WeixinJSBridgeReady',
							onBridgeReady, false);
				} else if (document.attachEvent) {
					document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
					document
							.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
				}
			} else {
				onBridgeReady();
			}
		}
		$(document).ready(function() {
			pay();
		})
	</script>
</body>

</html>

