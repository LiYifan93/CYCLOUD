<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>服务</title>
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
                <li class="active">支付设置</li>
            </ol>
        </section>

    </nav>
	<div style="padding-top:30px">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel"
						style="text-align: center;">支付设置</h4>
				</div>

				<div class="modal-body">
					<form id="service" class="form-horizontal">
					
						<div class="form-group" style="display:none">
							<label for="id" class="control-label col-md-3">Id</label>
							<div class="col-md-8">
								<input type="text" id="id" name="id" required class="form-control">
							</div>
						</div>
						<div class="form-group">
							<label for="appId" class="control-label col-md-3">服务号appId</label>
							<div class="col-md-8">
								<input type="text" id="appId" name="appId" required class="form-control">
							</div>
						</div>

						<div class="form-group">
							<label for="appSecret" class="control-label col-md-3">服务号秘钥</label>
							<div class="col-md-8">
								<input type="text" id="appSecret" name="appSecret" required class="form-control">
							</div>
						</div>

						<div class="form-group">
							<label for="mchId" class="control-label col-md-3">支付商户号</label>
							<div class="col-md-8">
								<input type="text" id="mchId" name="mchId" required class="form-control">
							</div>
						</div>

						<div class="form-group">
							<label for="paternerKey" class="control-label col-md-3">接口秘钥</label>
							<div class="col-md-8">
								<input type="text" id="paternerKey"  name="paternerKey" required
									class="form-control">
							</div>
						</div>
						
						<div class="form-group">
							<label for="body" class="control-label col-md-3">商品描述</label>
							<div class="col-md-8">
								<input type="text" id="body"  name="body" required class="form-control">
							</div>
						</div>
						
						<!-- <div class="form-group">
							<label for="body" class="control-label col-md-3">支付链接</label>
							<div class="col-md-8">
								<input type="text" id="body"  name="body" required class="form-control">
							</div>
						</div> -->
						<text id="id"></text>	
						
						<div class="modal-footer">
                            <button type="submit" class="btn btn-success">编辑</button>
                        </div>
					</form>
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
			url : '${contextPath}/web/wxmerchant/find?departmentId=' + departmentId,
			success : function(res) {
				if (res.code == 1) {
					$('#appId').val(res.data.appId)
					$('#appSecret').val(res.data.appSecret)
					$('#mchId').val(res.data.mchId)
					$('#paternerKey').val(res.data.paternerKey)
					$('#body').val(res.data.body)
					$('#id').val(res.data.id)
					/* $('#appId').val(res.data.appId) */
				} else
					showFailure(res.message)
			},
			error : function(err) {
				showFailure('服务端链接错误，请稍后再试！')
			}
		})
		
		$('#service').on('submit',function(ev){
			ev.preventDefault()
			var data = $(this).serialize()
			$.ajax({
				type : 'POST',
				dataType : 'json',
				data:data,
				url : '${contextPath}/web/wxmerchant/update',
				success : function(res) {
					if (res.code == 1) {
						showSuccess(res.message)
					} else
						showFailure(res.message)
				},
				error : function(err) {
					showFailure('服务端链接错误，请稍后再试！')
				}
			})
		})
		
	</script>

</body>

</html>