<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>登录页面</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="${contextPath}/jsp/libs/dist/css/AdminLTE.min.css"> 
    <link rel="stylesheet" href="${contextPath}/jsp/libs/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${contextPath}/jsp/libs/bootstrapValidator/bootstrapValidator.css">
    <script src="${contextPath}/jsp/libs/jquery/jquery.js"></script>
    <script src="${contextPath}/jsp/libs/bootstrap/js/bootstrap.min.js"></script>
    <script src="${contextPath}/jsp/libs/bootstrapValidator/bootstrapValidator.js"></script>
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

<body class="hold-transition login-page" style="background:url('${contextPath}/jsp/images/bg.png') no-repeat top left;background-size:100% 100%;position: relative;">
    <div class="login-box" style="padding-top:10%;margin:0 auto">
        <div class="login-logo">
            <a  style="color:white;text-decoration:none" href="http://www.cy-card.com/"><b>畅盈</b>云平台</a>
        </div>
        <!-- /.login-logo -->
        <div class="login-box-body" style="border-radius:10px;">
            <p class="login-box-msg">登录页面</p>
			
            <form  method="POST" action="${contextPath}/login/sigin">
                <div class="form-group has-feedback">
                <!-- pattern="/[a-zA-Z0-9]{3,16}/" -->
                    <input type="text" name="userName" class="form-control" minlength="3" maxlength="16" placeholder="请输入账号">
                </div>
                <div class="form-group has-feedback">
                <!--pattern="^[a-zA-Z]{5,17}" -->
                    <input type="password" name="password" class="form-control" minlength="3" maxlength="16" placeholder="请输入密码">
                </div>
                
                <div class="form-group has-feedback">
                    <div class="col-xs-6" style="padding:0">
                        <input type="text" name="captcha" class="form-control" minlength="4" maxlength="4"  placeholder="请输入验证码">
                    </div>

                    <div class="col-xs-6" style="cursor:pointer;">
                        <img id="image" src="${contextPath}/login/getErCode" onclick="img()" alt="验证码">
                    </div>
                    <script>
                        function img() {
                            $('#image').attr('src', "${contextPath}/login/getErCode?a=" + Math.random());
                        }
                    </script>

                </div>

                <div style="margin-top:70px;">
                    <button type="submit" class="btn btn-primary btn-block btn-flat">
                        	登陆
                    </button>
                </div>
            </form>
            <div class="" style="margin-top: 20px;">
                <div>
	                <a>
	                	<p class="modify" style="text-align:center" >忘记密码</p>
	                </a>
                </div>
            </div>
        </div>
    </div>

	<div style="text-align:center;color:grey;background-color:white;position:absolute;bottom: 0; width:100%">
		   <a href="http://www.miitbeian.gov.cn">
		      <text>备案号：粤ICP备12083272号-5</text>
		    </a>
	</div>
    <script>
     	$('.modify').click(function(){
     		alert('请联系管理员!')
     	})
     	
     	var height = window.screen.height
     	$('body').height(height)
     	$('form').bootstrapValidator({
            message: '输入值不合法',
            feedbackIcons: {/*输入框不同状态，显示图片的样式*/
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {/*验证*/
                userName: {/*键名username和input name值对应*/
                    message: '账号不合法',
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '账号不能为空'
                        },
                        stringLength: {/*长度提示*/
                            min: 3,
                            max: 16,
                            message: '账号长度必须在3到16之间'
                        },/*最后一个没有逗号*/
                        regexp: {/* 只需加此键值对，包含正则表达式，和提示 */
                            regexp: /^[a-zA-Z0-9_\.]+$/,
                            message: '账号只能是数字、字母、 点和下划线'
                        },
                    }
                },
                password: {
                    message:'密码无效',
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        stringLength: {
                            min: 3,
                            max: 16,
                            message: '密码长度必须在3到16之间'
                        },
                        regexp: {/* 只需加此键值对，包含正则表达式，和提示 */
                            regexp: /^[a-zA-Z0-9_\.]+$/,
                            message: '密码只能是数字、字母、 点和下划线'
                        },
                    }
                },
                captcha: {
                    validators: {
                        notEmpty: {
                            message: '验证码不能为空'
                        },
                        stringLength: {
                            min: 4,
                            max: 4,
                            message: '请输入正确的验证码长度'
                        },
                        regexp: {
                            regexp: /^[\w]{4}$/,
                            message: '请输入正确的验证码(包含数字字母)'
                        }
                        
                    }
                }
            }
        });
    </script>

</body>

</html>