<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>角色管理</title>
    <link href="${contextPath}/jsp/libs/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${contextPath}/jsp/libs/fonts/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${contextPath}/jsp/libs/bootstrap-table/bootstrap-table.css" />
    <!--日期控件-->
    <link rel="stylesheet" href="${contextPath}/jsp/libs/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css">
    
    <link href="${contextPath}/jsp/libs/zTree/css/zTreeStyle.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="http://apps.bdimg.com/libs/html5shiv/3.7/html5shiv.min.js"></script>
    <script src="http://apps.bdimg.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
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
                <li><a>权限管理</a></li>
                <li class="active">角色管理</li>
            </ol>
        </section>

    </nav>

    <div id="modal-search" class="modal fade" aria-hidden="true" aria-labelledby="myModalLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" aria-label="Close">
									&times;
								</button>
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;">请填写搜索条件</h4>
                </div>

                <div class="modal-body form-horizontal">
                	<form id="search">
                    <div class="form-group">
                        <label for="searchLocalId" class="control-label col-md-3">角色名</label>
                        <div class="col-md-8">
                            <input type="text" id="searchName"  name="name" class="form-control" placeholder="请输入角色名">
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="submit" class="btn btn-success">确定</button>
                    </div>
                  </form>
                </div>
            </div>
        </div>
    </div> 

    <div id="modal-add" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" aria-label="Close">
									&times;
								</button>
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;">请填写添加事件</h4>
                </div>

                <div class="modal-body">
                    <form id="add" class="form-horizontal" >

                        <div class="form-group" id="d_add">
                            <label for="departmentId" class="control-label col-md-3">停车场ID</label>
                            <div class="col-md-8">
                                <input type="text" class="departmentId" name="departmentId" class="form-control" required placeholder="请输入停车场ID">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="searchLocalId" class="control-label col-md-3">角色名</label>
                            <div class="col-md-8">
                                <input type="text"  name="name" class="form-control" placeholder="请输入角色名">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="intro" class="control-label col-md-3">简述</label>
                            <div class="col-md-8">
                                <input type="text" name="intro" class="form-control" placeholder="请输入简述">
                            </div>
                        </div>
                        
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button id="addSubmit" type="submit" class="btn btn-success">确定</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div id="modal-export" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" id="close" class="close"  aria-hidden="true" aria-label="Close">
									&times;
								</button>
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;">请填写导出条件</h4>
                </div>
                <div class="modal-body">
                    <form id="export" class="form-horizontal" name="export">
                        <div class="form-group" id="d_export">
                            <label for="departmentId" class="control-label col-md-3">停车场ID</label>
                            <div class="col-md-8">
                                <input type="text" class="departmentId" name="departmentId" class="form-control" required >
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="offset" class="control-label col-md-3">选择页数</label>
                            <div class="col-md-8">
                                <input type="number" id="offset" name="offset" class="form-control" required placeholder="请输入页数">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="limit" class="control-label col-md-3">选择行数</label>
                            <div class="col-md-8">
                                <input type="number" id="limit" name="limit" class="form-control" required placeholder="请输入行数">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="submit" class="btn btn-success">确定</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div id="modal-role" class="modal fade" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                         <h4 class="modal-title" id="myModalLabel" style="text-align: center;">角色分配权限</h4>
                    </div>
                    <div class="modal-body">
	                     <div style="text-align:center;padding-left:10%" id="treeDemo" class="ztree"></div>
	                    <div class="modal-footer">
	                        <button type="button" class="btn btn-default" id="dismiss">取消</button>
	                        <button type="button" id="submit" class="btn btn-success">确定</button>
	                    </div>
                    </div>
                </div>
            </div>
        </div>
	
	<div id="modal-edit" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" aria-label="Close">
									&times;
								</button>
                    <h4 class="modal-title" id="myModalLabel" style="text-align: center;">请进行编辑</h4>
                </div>
                <div class="modal-body">
                    <form id="edit" class="form-horizontal" >                   
                        <div class="form-group">
                            <label for="searchLocalId" class="control-label col-md-3">角色名</label>
                            <div class="col-md-8">
                                <input type="text" id="editName"  name="name" class="form-control" placeholder="请输入角色名">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="intro" class="control-label col-md-3">描述信息</label>
                            <div class="col-md-8">
                                <input type="text" id="editIntro" name="intro" class="form-control" placeholder="请输入简述">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button id="editSubmit" type="submit" class="btn btn-success">确定</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

	<div id="rowId" style="teXt-align:center"></div>	
    <div class="container " style="margin-top: 50px">
         <div id="toolbar">
            <div class="btn-group">
           		 <input type="button" id="refresh" class="btn btn-default pull-left " style="border-radius: 10%;margin: 0 20px 0 0px"  value="刷新"> 
               <!--  <button type="button" class="btn btn-default dropdown-toggle export operate" title="导出" data-toggle="modal" data-target="#modal-export">
                     <i class="glyphicon glyphicon-export icon-share"></i>
                </button>
                <input type="button" class="btn btn-default pull-left operate search" style="border-radius: 10% ;margin: 0 0 0 20px ;line-height:normal"  data-toggle="modal" data-target="#modal-search" value="搜索"> -->
                <input type="button" class="btn btn-default pull-left operate  add" style="border-radius: 10%;margin: 0 20px 0 0px" data-toggle="modal" data-target="#modal-add" value="添加">
            </div>
        </div>
        <!--
				bootstrapTable:在table标签属性里面配置参数，也可以通过js配置url：配置请求的路径；toggle: 初始化Table；
				pagination: 是否启用分页；size: 每页显示的数据条数；list：每页显示的行数； pagination-loop: 是否启用启用分页条无限循环；
				side-pagination: 分页位置(server服务器分页；client客户端分页)； response-handler: 格式化从服务器获取到的数据；
				 query-params:传递参数； cache: 是否启用服务器缓存； show-columns: 是否显示 内容列下拉框； refresh: 起否启用刷新； number: 初始化加载第一页，默认第一页
			-->
         <table id="table"  data-toggle="table" data-pagination="true" data-page-size="10" data-page-list="[10,20,30,All]" data-pagination-loop="false" data-side-pagination="server" data-response-handler="responseHandler"
            data-query-params="paginationParam" data-cache="false" data-toolbar="#toolbar"  data-show-toggle="true"  data-show-refresh="true" data-method="post" data-page-number="1" data-content-type="application/x-www-form-urlencoded; charset=UTF-8">
            <thead>
                <tr>
                    <!--fidld: 需与后台返回数据保持一直； checkbox: 为true显示该列； visible: 为false隐藏该列； align、valign: 水平、垂直居中-->
                    <th data-field="check" data-class="middle" data-checkbox="true" data-align="center" data-valign="middle"></th>
                    <th data-field="name" data-align="center" data-valign="middle">角色名</th>
                    <th data-field="intro" data-align="center" data-valign="middle">描述信息</th>
                    <!-- <th data-field="createName" data-align="center" data-valign="middle">创建者</th> -->
                    <!--formatter: 格式化该列，自定义内容； events: 事件处理函数-->
                    <th data-field="details" data-formatter="operateFormatter" data-events="operateEvents" data-align="center" data-valign="middle" data-width="70px">操作</th>
                </tr>
            </thead>
        </table>
    </div>

    <script src="${contextPath}/jsp/libs/jquery/jquery.js"></script>
    <script src="${contextPath}/jsp/libs/bootstrap/js/bootstrap.js " charset="UTF-8"></script>
    <script src="${contextPath}/jsp/libs/bootstrap-table/bootstrap-table.js " charset="UTF-8"></script>
    <script src="${contextPath}/jsp/libs/bootstrap-table/bootstrap-table-zh-CN.js " charset="UTF-8"></script>
    <script src="${contextPath}/jsp/libs/bootstrap-datetimepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script>
    <script src="${contextPath}/jsp/libs/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
    <script src="${contextPath}/jsp/libs/zTree/js/jquery.ztree.core-3.5.min.js"></script>
    <script src="${contextPath}/jsp/libs/zTree/js/jquery.ztree.excheck-3.5.js"></script>
    <script src="${contextPath}/jsp/libs/modal.js"></script>
    <script>   		
   		    var dataUrl = "${contextPath}/web/rolemanage/findAll?departmentId="
   	   		var contextPath = "${contextPath}";
   	   		var addUrl = '${contextPath}/web/rolemanage/add'
			// 格式化向服务器发送的参数
   	   			function paginationParam(params) {
   	   			    // alert(params)
   	   			    var currPage = Math.floor((params.offset + params.limit) / params.limit);
   	   			    return {
   	   			        'offset': currPage,
   	   			        'limit': params.limit,
   	   			        'name':$('#searchName').val(),
   	   			    }
   	   			}
   	   		
   	   		
    </script>   
    <script src="${contextPath}/jsp/scripts/url.js?1"></script>
    <script src="${contextPath}/jsp/scripts/rolemanage.js?4"></script>

</body>

</html>