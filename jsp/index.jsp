<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="Expires"   CONTENT="0">
	<meta http-equiv="Cache-Control"   CONTENT="no-cache">
	<meta http-equiv="Pragma"   CONTENT="no-cache">
    <!--<meta http-equiv="X-UA-Compatible" content="IE=edge">-->
    <title>畅盈 | 云平台</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="renderer" content="webkit">
    <link rel="stylesheet" href="${contextPath}/jsp/libs/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="${contextPath}/jsp/libs/fonts/font-awesome.min.css">
    <link rel="stylesheet" href="${contextPath}/jsp/libs/ionicons.min.css">
    <link rel="stylesheet" href="${contextPath}/jsp/libs/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
    <link rel="stylesheet" href="${contextPath}/jsp/libs/dist/css/AdminLTE.min.css?1">
    <link rel="stylesheet" href="${contextPath}/jsp/libs/dist/css/skins/_all-skins.min.css">
    <link href="${contextPath}/jsp/libs/zTree/css/zTreeStyle1.css" rel="stylesheet" />
    <link rel="stylesheet" href="${contextPath}/jsp/css/index.css?5">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper" style="height: auto">
        <header class="main-header ">
            <a href="http://www.cy-card.com/ " class="logo">
                <span class="logo-mini"><b>CYKJ</b></span>
                <span class="logo-lg"><b>畅盈云平台</b></span>
            </a>	
            <nav class="navbar navbar-default">
                <div class="container-fluid">
                    <div id="funct" class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a  href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
		            		功能区
		        		 </a>
                    </div>
					<!-- 功能区 -->
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav" id="menu">
                        
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
        <aside class="main-sidebar mainbody-left">
            <section class="sidebar" >
                <!--用户信息-->
                <div class="user-panel" style="cursor:pointer">
                    <a data-toggle="modal" data-target="#headPic">
                       <div class="pull-left image">
                           <img class="img" src="${contextPath}/jsp/images/404/404.jpg" style="border-radius:50%;" class="img-circle" alt="User Image">
                       </div>
                    </a>
                    <div class="pull-left info">
                        <p class="userName">用户</p>
                        <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                        <text id="userId"></text>
                    </div>
                   
                   
                </div>
                <div id="userMes"  style="margin:10px; cursor:pointer;color:white" data-toggle="modal" data-target="#userMessage">
                	个人信息
                </div>
                <!--树状图-->
                <ul class="sidebar-menu" style="height: auto; overflow:visible">
                    <li class="header">导航栏</li>
                    <%-- <li><a href="${contextPath}/jsp/htmls/chart.jsp" target="ace">统计图</a></li> --%>
                    <li id="menu_tree_left" class="ztree"></li>
                </ul>
                <!--退出-->
                <!--<button type="button" class="btn btn-warning" style="width:100%">退出</button>-->
            </section>
        </aside>
        <div class="content-wrapper">
            <iframe id="ace" name="ace"  frameborder="0"  height="100%" width="100%" onload="changeFrameHeight()"></iframe>
        </div>
        
        <div class="footer" style="text-align:center;color:grey;background-color:white;">
		    <a href="http://www.miitbeian.gov.cn">
		      <text>备案号：粤ICP备12083272号-5</text>
		    </a>
	    </div>
        
    </div>
    
    <div id="headPic" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content" style="border-radius:10px">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" aria-label="Close">
									&times;
								</button>
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;">修改头像</h4>
                </div>

                <div class="modal-body">
                	<form id="headPic" action=#" method="POST" enctype="multipart/form-data" class="form-horizontal"">
                        <div class="form-group">
                            <label for="headPic" class="control-label col-md-3">头像上传</label>
                            <div class="col-md-8">
                                <input type="file" id="img_upload" class="form-control" style="padding-top:0">
                            </div>
                        </div>
                        
                        <div id="img_area" class="form-group"></div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="submit" class="btn btn-success">确定</button>
                        </div>
                     </form>
                </div>
            </div>
        </div>
    </div>
    
    <div id="userMessage" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content" style="border-radius:10px">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" aria-label="Close">
									&times;
								</button>
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;">个人信息</h4>
                </div>

                <div class="modal-body form-horizontal">
                
                        <div class="form-group">
                            <label for="user" class="control-label col-md-3">账号</label>
                            <div class="col-md-8">
                                <input type="text" id="userName" name="userName" class="form-control"  disabled placeholder="请填写用户姓名">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="limit" class="control-label col-md-3">昵称</label>
                            <div class="col-md-8">
                                <input type="text" id="nickName" name="nickName" class="form-control" disabled placeholder="请填写用户昵称">
                            </div>
                        </div>
                        
                         <div class="form-group">
                            <label for="sex" class="control-label col-md-3">性别</label>
                            <div class="col-md-8">
                                <select class="form-control" id="sex"  disabled name="sex">
				                    <option value="0">男</option>
				                    <option value="1">女</option>
				                </select>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="email" class="control-label col-md-3">邮箱</label>
                            <div class="col-md-8">
                                <input type="email" id="email" class="form-control" name="email" disabled placeholder="请填写用户邮箱">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="phone" class="control-label col-md-3">电话</label>
                            <div class="col-md-8">
                                <input type="text" id="phone" class="form-control" name="phone" disabled placeholder="请填写用户电话">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="mobile" class="control-label col-md-3">手机号</label>
                            <div class="col-md-8">
                                <input type="tel" class="form-control" id="mobile" name="mobile" disabled placeholder="请填写用户手机">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="departmentId" class="control-label col-md-3">所属部门</label>
                            <div class="col-md-8">
                               <!-- <input type="text" id="departmentId" name="departmentId" class="form-control" placeholder="请填写用户部门"> -->
                               <select class="form-control" id="departmentTypeId" disabled name="departmentId" >
				                </select>
                            </div>
                        </div>
                       
                        <div class="form-group">
                            <label for="sex" class="control-label col-md-3">类型</label>
                            <div class="col-md-8">
                                <select class="form-control" id="userType" disabled name="userType" >
				                    <option value="0">管理员</option>
				                    <option value="1">普通用户</option>
				                </select>
                            </div>
                        </div>
                        
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" id="signOut" class="btn btn-success">退出登录</button>
                        </div>
                </div>
            </div>
        </div>
    </div>
    	
    <script src="${contextPath}/jsp/libs/jquery/jquery.js "></script>
    <script src="${contextPath}/jsp/libs/bootstrap/js/bootstrap.min.js "></script>
    <script src="${contextPath}/jsp/libs/dist/js/app.min.js "></script>
    <script src="${contextPath}/jsp/libs/zTree/js/jquery.ztree.core-3.5.min.js"></script>
    <script src="${contextPath}/jsp/libs/zTree/js/jquery.ztree.excheck-3.5.js"></script>
	<script src="${contextPath}/jsp/libs/modal.js"></script>
    <script>
    	var contextPath = "${contextPath}";
    </script>	
    <script type="text/javascript" src="${contextPath}/jsp/scripts/dbtype.js" ></script>
    <script src="${contextPath}/jsp/scripts/index.js"></script>
</body>

</html>