<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>404</title>
<link rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${contextPath}/jsp/css/404.css">

</head>

<body>
	<div class="bg">
		<div class="cont">
			<div class="c1">
				<img src="${contextPath}/jsp/images/404/01.png" class="img1" />
			</div>
			<h2>哎呀...您访问的页面不存在</h2>
			<div class="c2">
				<a href="${contextPath}/login" target="_parent" class="home">重新登录</a>
			</div>
			<div class="c3">
				<a href="http://www.cy-card.com/" target="_parent" class="c3">畅盈科技</a>提醒您 -
				您可能输入了错误的网址，或者该网页已删除或移动
			</div>
		</div>
	</div>
</body>

</html>