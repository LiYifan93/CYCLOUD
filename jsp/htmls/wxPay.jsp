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
<link rel="stylesheet" href="${contextPath}/jsp/libs/bootstrapValidator/bootstrapValidator.css">
	<style>
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
    </style>
</head>

<body class="hold-transition login-page">
	<div class="login-box">
		<div class="login-logo">
			<a href="http://www.cy-card.com/"><b>畅盈</b>云平台</a>
		</div>
		<!-- /.login-logo -->
		<div class="login-box-body"
			style="border-radius: 10px; box-shadow: 10px 10px 10px gray">
			<p class="login-box-msg">查询页面</p>

			<form id="search" method="POST"
				action="${contextPath}/paytest/getOrder">
				<div class="form-group has-feedback">
					<input type="text" name="plate" class="form-control"
						placeholder="请输入车牌号">
				</div>
				<div class="row">
					<div class="col-xs-12">
						<button type="submit" class="btn btn-primary btn-block btn-flat">
							查询</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<script src="${contextPath}/jsp/libs/jquery/jquery.js"></script>
	<script src="${contextPath}/jsp/libs/bootstrap/js/bootstrap.js "
		charset="UTF-8"></script>
	<script src="${contextPath}/jsp/libs/bootstrapValidator/bootstrapValidator.js"></script>	
	<script src="${contextPath}/jsp/libs/modal.js"></script>
	<script>
	$('form').bootstrapValidator({
        message: '输入值不合法',
        feedbackIcons: {/*输入框不同状态，显示图片的样式*/
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {/*验证*/
        	plate: {/*键名username和input name值对应*/
                message: '车牌号不合法',
                validators: {
                    notEmpty: {/*非空提示*/
                        message: '车牌号不能为空'
                    },
                    stringLength: {/*长度提示*/
                        min: 5,
                        max: 8,
                        message: '车牌长度必须在5到8之间'
                    },/*最后一个没有逗号*/
                    regexp: {/* 只需加此键值对，包含正则表达式，和提示 */
                        regexp: /^[\u4e00-\u9fa5][a-zA-Z](([DF](?![a-zA-Z0-9]*[IO])[0-9]{4})|([0-9]{5}[DF]))|^[冀豫云辽黑湘皖鲁苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼渝京津沪新京军空海北沈兰济南广成使领A-Z]{1}[a-zA-Z0-9]{5}[a-zA-Z0-9挂学警港澳]{1}$/,
                        message: '请输入正确的车牌号码'
                    },
                }
            }
        }
    });
	</script>
</body>

</html>

