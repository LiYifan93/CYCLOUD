$('button[name="refresh"]').hide()
$('#refresh').click(function() {
	$('#searchName').val('')
    $('button[name="refresh"]').click()
})

//搜索
$('#search').on('submit',function(ev){
	ev.preventDefault()
	$('#table').bootstrapTable('refresh')
	$('#modal-search').modal('hide')
})

// 操作
function operateFormatter(value, row, index) {
    return [
        '<div>',
        '<a class="edit operate"   href="javascript:void(0)" title="编辑"  data-toggle="modal" data-target="#modal-edit">',
        '<i class="fa fa-pencil-square-o "></i>',
        '</a>&nbsp;',
        '<a class="role operate" href="javascript:void(0)" title="分配权限"  data-toggle="modal" data-target="#modal-role">',
        '<i class="fa fa-user" aria-hidden="true"></i>',
        '</a>&nbsp;',
        '<a class="remove operate" id="operate" href="javascript:void(0)" title="单个删除" >',
        '<i class="fa fa-close"></i>', '</a>  ', '</div>'
    ].join('');
}
var editId
var roleId
// // 对应操作的事件处理函数
window.operateEvents = {
    'click .edit': function(e, value, row, index) {
        $('#editName').val(row.name)
        $('#editIntro').val(row.intro)
        editId = row.id
        
    },
    // 角色分配权限
    'click .role': function(e, value, row, index) {
    	
    	roleId = row.id
    	// 形成默认权限树
        var setting = {
                check: {
                    enable: true
                },
                data: {
                    simpleData: {
                        enable: true
                    }
                },
                async: {
                    enable: true,
                    url: contextPath + '/web/rolemanage/findPermission?id=' + roleId,
                    autoParam: ["id"],
                }
            };

            $(function() {
                var zNodes = []
                $.fn.zTree.init($("#treeDemo"), setting, zNodes);
               
          });
        // 处理重复提交的问题
        
    	
    },

    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath + '/web/rolemanage/delete?id=' + row.id,
                data: row,
                dataType: 'JSON',
                success: function(res) {
                    if (res.code == 1) {
                        $('#table').bootstrapTable('remove', {
                            field: 'id',
                            values: [row.id]
                        })
                        $('#table').bootstrapTable('refresh')
                        showSuccess(res.message)
                        $('.remove').unbind('click')
                    } else {
                        $('.remove').unbind('click')
                        showInfo(res.message)
                    }
                },
                error: function(res) {
                    $('.remove').unbind('click')
                    showFailure('服务端链接错误，请稍后再试！')
                }

            })
        }
        return false
    }
};
	
$('#edit').on('submit', function(ev) {
    ev.preventDefault()
    var data = $(this).serialize()
    $.ajax({
        type: 'post',
        url: contextPath + '/web/rolemanage/baseUpdate?id=' + editId,
        data: data,
        dataType: 'JSON',
        success: function(res) {
            if (res.code == 1) {
                showSuccess(res.message)
                $('#modal-edit').modal('hide')
                $('#table').bootstrapTable('refresh')
            } else {
                showInfo(res.message)
                $('#modal-edit').modal('hide')
            }
        },
        error: function(res) {
        	showFailure('服务端链接错误，请稍后再试！')
            $('#modal-edit').modal('hide')
        }
    })
    return false
})
        
        //提交所选中的id 
        $('#submit').click(function() {
        	$('#submit').attr('diabled',true)
           //选中
           var treeObj = $.fn.zTree.getZTreeObj("treeDemo"),
           nodes = treeObj.getCheckedNodes(true),
           data = [];
           //遍历形成数组
	       for (var i = 0; i < nodes.length; i++) {
	            data.push(nodes[i].id)
	       }
	       //去除数组中重复的字符
	       var json={}
	       for(var i = 0; i < data.length; i++){
	    	   json[data[i]] = data[i]
	       }
	       data = new Array()
	       for(var key in json){ 
	    	   data.push(key); 
	    	 } 
	      var a = {
	           'data': data.toString()//转换成字符串并提交
	       }
	      $.ajax({
	           url: contextPath + '/web/rolemanage/pupdata?id=' + roleId,
	           async: false,
	           data: a,
	           type: 'post',
	           dataType: 'json',
	           success: function(res) {
	               if (res.code == 1) {
		               	showSuccess(res.message)
		               	$('#modal-role').modal('hide')
	               } else {
		               	showInfo(res.message)
	                   $('#modal-role').modal('hide')
	               }
	           },
	           error: function(err) {
		           	showFailure('服务端链接错误，请稍后再试！')
	               $('#modal-role').modal('hide')
	           }
	       })
	       return false
        })

/*$('#dismiss').click(function(){
	$('#myModal').modal({
		  backdrop:'static',
		  keyboard: false
		})
})

$('#close').click(function(){
	$('#myModal').modal({
		  backdrop:'static',
		  keyboard: false
		})
})*/
