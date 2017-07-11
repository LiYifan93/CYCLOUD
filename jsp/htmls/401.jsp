<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>401</title>
<link rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${contextPath}/jsp/css/404.css">
</head>

<body>
	<div class="bg">
		<div class="cont">
			<div class="c1">
				<img src="${contextPath}/jsp/images/404/lock.png" class="img1" />
			</div>
			<h2>抱歉---您没有访问权限，请联系管理员</h2>
			<div class="c2">
				<a href="${contextPath}/login" target="_parent" class="home">重新登录</a>
			</div>
		</div>
	</div>
</body>

</html>