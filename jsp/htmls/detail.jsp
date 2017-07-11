<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>部门详情</title>
<link rel="stylesheet"
	href="${contextPath}/jsp/libs/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${contextPath}/jsp/libs/fonts/font-awesome.min.css">
<!--日期控件-->
<link rel="stylesheet"
	href="${contextPath}/jsp/libs/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css">
</head>

<body >
	<div >
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel"
						style="text-align: center;">部门详情</h4>
				</div>

				<div class="modal-body">
					<form id="add" class="form-horizontal">
						<div class="form-group">
							<label for="departmentName" class="control-label col-md-3">部门名称</label>
							<div class="col-md-8">
								<input type="text" id="departmentName" disabled
									name="departmentName" class="form-control">
							</div>
						</div>

						<div class="form-group">
							<label for="departmentTypeId" class="control-label col-md-3">部门类别</label>
							<div class="col-md-8">
								<select  id="departmentTypeId" disabled name="departmentTypeId"
									class="form-control ">
									
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="zipCode" class="control-label col-md-3">邮编</label>
							<div class="col-md-8">
								<input type="text" id="zipCode" disabled name="zipCode"
									class="form-control">
							</div>
						</div>

						<div class="form-group">
							<label for="email" class="control-label col-md-3">邮箱</label>
							<div class="col-md-8">
								<input type="email" id="email" name="email" disabled
									class="form-control">
							</div>
						</div>

						<div class="form-group">
							<label for="phone" class="control-label col-md-3">电话</label>
							<div class="col-md-8">
								<input type="text" id="phone" name="phone" disabled
									class="form-control">
							</div>
						</div>

						<div class="form-group">
							<label for="mobile" class="control-label col-md-3">手机号</label>
							<div class="col-md-8">
								<input type="text" id="mobile" disabled name="mobile"
									class="form-control">
							</div>
						</div>
						<div class="form-group">
							<label for="provinceId" class="control-label col-md-3">所在省</label>
							<div class="col-md-8">
								<input type="text" class="form-control" disabled
									name="provinceId" id="provinceId">
							</div>
						</div>
						<div class="form-group">
							<label for="cityId" class="control-label col-md-3">所在市</label>
							<div class="col-md-8">
								<input type="text" class="form-control" disabled id="cityId">
							</div>
						</div>
						<div class="form-group">
							<label for="countyId" class="control-label col-md-3">所在县/区</label>
							<div class="col-md-8">
								<input type="text" class="form-control" disabled id="countyId">
							</div>
						</div>

						<div class="form-group">
							<label for="address" class="control-label col-md-3">详细地址</label>
							<div class="col-md-8">
								<input type="text" id="address" disabled name="address"
									class="form-control">
							</div>
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
		var contextPath = "${contextPath}";
	</script>	
	<script type="text/javascript" src="${contextPath}/jsp/scripts/dbtype.js" ></script>
	<script>
		var url = location.href
		var departmentId = url.split('?')[1]
		$.ajax({
			type : 'POST',
			dataType : 'json',
			url : '${contextPath}/department/get?' + departmentId,
			success : function(res) {
				if (res.code == 1) {
					$('#departmentName').val(res.data.departmentName)
					$('#departmentTypeId').val(res.data.departmentTypeId)
					$('#zipCode').val(res.data.zipCode)
					$('#email').val(res.data.email)
					$('#phone').val(res.data.phone)
					$('#mobile').val(res.data.mobile)
					$('#provinceId').val(res.data.provinceId)
					$('#cityId').val(res.data.cityId)
					$('#countyId').val(res.data.countyId)
					$('#address').val(res.data.address)
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