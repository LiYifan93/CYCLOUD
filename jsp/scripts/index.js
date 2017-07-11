$('#userId').hide()
//获取登录信息
$.ajax({
	url : 'login/user',
	type : 'post',
	success : function(res) {
		if(res.code == 1){
			$('.userName').text(res.data.userName)
			$('#userId').text(res.data.id)
			/*$('.img').attr('src',res.data.headPic)*/
			$('iframe').attr('src',contextPath + '/web/overview?departmentId=' + res.data.departmentId)
		}else showFailure(res.message)
	},
	error : function(err) {
		showFailure('服务端链接错误，请稍后再试！')
	}
})

//获取个人信息
$('#userMes').on('click',function(){
	var data = {
		id:$('#userId').text()
	}
	$.ajax({
		url : 'login/personal',
		type : 'post',
		data:data,
		success : function(res) {
			if(res.code == 1){
				$('#userName').val(res.data.userName)
				$('#nickName').val(res.data.nickName)
				$('#sex').val(res.data.sex)
				$('#email').val(res.data.email)
				$('#phone').val(res.data.phone)
				$('#mobile').val(res.data.mobile)
				$('#departmentId').val(res.data.departmentId)
				$('#userType').val(res.data.userType)
			}else showFailure(res.message)
		},
		error:function(err) {
			showFailure('服务端链接错误，请稍后再试！')
		}
	})
})

//退出
$('#signOut').on('click',function(){
	$.ajax({
		url : 'login/logout',
		type : 'post',
		success : function(res) {
			alert('退出成功')
			location.href = contextPath+'/login/login'
		},
		error:function(err) {
			alert('退出失败,请检查网络链接')
			
		}
	})
})

//头像修改

 // 抓取上传图片，转换代码结果，显示图片的dom
var img_upload = document.getElementById("img_upload");
var base64_code = document.getElementById("base64_code");
var img_area = document.getElementById("img_area");
 // 添加功能出发监听事件
img_upload.addEventListener('change', readFile, false);


var data = ''
function readFile() {
    var file = this.files[0];
    console.log(file)
    if (!/image\/\w+/.test(file.type)) {
        alert("请确保文件为图像类型");
        return false;
    }
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function() {
    	data = this.result
        /*base64_code.innerHTML = this.result;*/
        img_area.innerHTML = '<label for="" class="control-label col-md-3">图片展示</label><div class="col-md-8"><img style="width:200px;height:200px;border:3px solid red" src="' + this.result + '" alt=""/></div>';
       }
}
$('#headPic').on('submit',function(ev){
	 ev.preventDefault() 
	 console.log(data)
	 $.ajax({
		 url: '',
	     data: {data:data},
	     contentType : false,
	     processData: false,
	     success: function(res){
	        if(res.code == 1){
	        	console.log(res.data)
	        	$('.img').attr('src',res.data.headPic)
	        }
	        else{
	        	$('#headPicture').modal('hide')
	        	showFailure(res.message)
	         }
	      },
	      error:function(err){
	    	  $('#headPicture').modal('hide')
	          showFailure('服务端链接错误，请稍后再试！')
	      }
	 })
})

// 设置屏幕适应大小
function changeFrameHeight() {
	var ifm = document.getElementById("ace");
	ifm.height = window.screen.height;
}

window.onload = function() {
	changeFrameHeight();
}

//形成导航树
// $('#menu').hide()
var setting = {
	view : {
		dblClickExpand : false, // 双击节点时，是否自动展开父节点的标识
		showLine : false, // 是否显示节点之间的连线
		showIcon : true,
		fontCss : {
			'color' : 'white',
			'font-weight' : 'normal'
		}, // 字体样式函数
		selectedMulti : false,
		showIcon: showIconForTree,
		addDiyDom: addDiyDom
	// 设置是否允许同时选中多个节点
	},
	check : {
		chkStyle : "checkbox", // 复选框类型
		enable : false
	// 每个节点上是否显示 CheckBox
	},
	data : {
		simpleData : { // 简单数据模式
			enable : true,
			idKey : "id",
			pIdKey : "pId",
			rootPId : ""
		}
	},
	callback : {
		beforeClick : function(treeId, treeNode) {

			zTree = $.fn.zTree.getZTreeObj("menu_tree_left");
			if (!treeNode.isParent) {
				zTree.checkNode(treeNode, !treeNode.checked, true, true); // 单击勾选，再次单击取消勾选
			}
		},
		onClick : onClick,
		
	},
	async : {
		enable : true,
		dataType : 'json',
		url : 'tree',
		autoParam : [ "id" ],
	}
};

//展示节点图标
function showIconForTree(treeId, treeNode) {
	return treeNode.level != 2;
};

//节点名称太长的处理
function addDiyDom(treeId, treeNode) {
    var spaceWidth = 5;
    var switchObj = $("#" + treeNode.tId + "_switch"),
    checkObj = $("#" + treeNode.tId + "_check"),
    icoObj = $("#" + treeNode.tId + "_ico");
    switchObj.remove();
    checkObj.remove();
    icoObj.parent().before(switchObj);
    icoObj.parent().before(checkObj);

    var spantxt = $("#" + treeNode.tId + "_span").html();
    if (spantxt.length > 17) {
        spantxt = spantxt.substring(0, 17) + "...";
        $("#" + treeNode.tId + "_span").html(spantxt);
    }

}


//形成功能区菜单
function onClick(event, treeId, treeNode) {
	$
			.ajax({
				type : 'POST',
				dataType : 'json',
				url: 'function?departmentId=' + treeNode.id ,
				success : function(res) {
					if(res.code == 1){
						//隐藏功能区						
						if(res.data === "undefined" || res.data.length < 1 ){
							showFailure("请联系管理员分配权限！")
						}
						
						var data = res.data
						var html = ''
						var m = ''
						for ( var i in data) {
							html += '<li class="dropdown"><a href="'
									+ data[i].url
									+ '" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">'
									+ data[i].name
							html += '<span class="caret"></span></a><ul class="dropdown-menu">'
							for ( var j in data[i].list) {
								html += '<li><a href="' + data[i].list[j].url+'?'+ treeNode.id+'?'+ data[i].list[j].id
										+ '"target="ace" > '
										+ data[i].list[j].name + '</a></li>'
							}
							html += '</ul> </li> '
						}
						$('#menu').append(html)
						
						$('iframe').attr('src',contextPath + '/web/overview?departmentId=' + treeNode.id)
					
					}
					else{
						showFailure(res.message)
					}
					
				},
				error:function(err){
					showFailure('服务端链接错误，请稍后再试！')
				}
			})

	zTree = $.fn.zTree.getZTreeObj("menu_tree_left");
	// 图标点击下拉合并菜单
	if ($(event.target).hasClass('ico_close')
			|| $(event.target).hasClass('ico_open')) {
		zTree.expandNode(treeNode); // 如果是父节点，则展开该节点
	} else {
		return;
	};
}

$(function() {
	var zNodes = []
	$.fn.zTree.init($("#menu_tree_left"), setting, zNodes);
});

$('#menu_tree_left').on('click', function() {
	
	$('#menu').empty()
	
})