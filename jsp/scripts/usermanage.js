$('button[name="refresh"]').hide()
$('button.remove[title="Remove"]').hide()
$('#refresh').click(function(){
	$('#searchUserName').val('')
 	$('#searchSex').val('')
	$('#searchEmail').val('')
	$('#searchPhone').val('') 
	$('#searchMobile').val('') 
	$('button[name="refresh"]').click()
})

//搜索
$('#searchButton').click(function(){
	$('#table').bootstrapTable('refresh')
	$('#modal-search').modal('hide')
})
function sexFormatter(value, row, index){
	 if(value == 0){
		 a = '男'
	 }else if(value == 1){
		 a = "女"
	 }else a = ''
		 return a 
}

function userTypeFormatter(value, row, index) {
    if(value == 0){
		 b = '管理员'
	 }else if(value == 1){
		 b = "普通用户"
	 }else b = ''
		 return b 
}


// 操作
function operateFormatter(value, row, index) {
    return [
    	'<div>',
        '<a class="edit operate"   href="javascript:void(0)" title="编辑"  data-toggle="modal" data-target="#modal-edit">',
        '<i class="fa fa-pencil-square-o "></i>',
        '</a>&nbsp;',
        '<a class="role operate" href="javascript:void(0)" title="分配角色"  data-toggle="modal" data-target="#modal-role">',
        '<i class="fa fa-user" aria-hidden="true"></i>',
        '</a>&nbsp;',
        '<a class="remove operate" id="operate" href="javascript:void(0)" title="单个删除" >',
        '<i class="fa fa-close"></i>',
        '</a>  ',
        '</div>'
    ].join('');
}

var editId
var roleId 


////   对应操作的事件处理函数
window.operateEvents = {
    'click .edit': function(e, value, row, index) {
        $('#editUserName').val(row.userName)
        $('#editPassword').val(row.password)
        $('#editNickName').val(row.nickName)
        $('#editSex').val(row.sex)
        $('#editUserType').val(row.userType)
        $('#editEmail').val(row.email)
        $('#editPhone').val(row.phone)
        $('#editMobile').val(row.mobile)
        editId = row.id
    },  
//    分配权限
    'click .role': function(e, value, row, index) {
    	roleId = row.id
    	console.log('aaa')
    	//获取用户角色
    	roleMan(roleId)
    	$(this).off('click')
    },

    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath+'/web/usermanage/delete?id=' + row.id,
                data: row,
                dataType: 'JSON',
                success: function(res) {
                	if(res.code == 1){
                		$('#table').bootstrapTable('remove', { field: 'id', values: [row.id] })
                		$('#table').bootstrapTable('refresh')
                		$('.remove').unbind('click')
                        showSuccess(res.message)
                	}
                	else{
                		$('.remove').unbind('click')
                		showFailure(res.message)
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
        url: contextPath+'/web/usermanage/update?id=' + editId,
        data: data,
        dataType: 'JSON',
        success: function(res) {
            if (res.code == 1) {
            	showSuccess(res.message)
                $('#modal-edit').modal('hide')
                $('#table').bootstrapTable('refresh')
            } else{ 
            	showFailure(res.message)
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

function roleMan(id){
	$.ajax({
		url:contextPath + '/web/usermanage/findUserRole?id='+ roleId,
		type:'post',
		dataType: 'JSON',
		success:function(res){
			if(res.code == 1){
				var html = ''
				for(var i=0;i<res.data.length;i++){
					html +='<option '+ res.data[i].selected + ' ' + 'value="'+ res.data[i].id+'">'+res.data[i].name+'</option>'
				}
				$('select[name="duallistbox_demo1[]"]').html(html)
				$('select[name="duallistbox_demo1[]"]').bootstrapDualListbox('refresh', true);
			}else 
				showFailure(res.message)
		},
		error:function(XMLHttpRequest, textStatus, errorThrown) {
			 showFailure('服务端链接错误，请稍后再试！')
		}
	})
	return  false
}

		//提交选中的id
		var demo1 = $('select[name="duallistbox_demo1[]"]').bootstrapDualListbox({
			nonSelectedListLabel: '已有角色',
            selectedListLabel: '未有角色',
            preserveSelectionOnMove: 'moved',
            moveOnSelect: false, //出现一个剪头，表示可以一次选择一个
            filterTextClear: '展示所有',
            moveSelectedLabel: "添加",
            moveAllLabel: '添加所有',
            removeSelectedLabel: "移除",
            removeAllLabel: '移除所有',
            infoText: '共{0}个',
            showFilterInputs: false,
		});
		
        $("#demoform").submit(function() {
        	$('#modal-role').modal('hide')
            console.log($('[name="duallistbox_demo1[]"]').val());
            var data = $('[name="duallistbox_demo1[]"]').val()
            if(data == null){
            	a={
                		data:''
                }
            }else{
            	 var html = ''
                     for(var i=0;i<data.length;i++){
                     	html+=data[i]+','
                     }
                     a={
                     		data:html
                     }
            }
           
            $.ajax({
            	url:contextPath + '/web/usermanage/pupdata?id='+ roleId,
				type:'post',
				data:a,
				dataType: 'JSON',
				success:function(res){
					if(res.code == 1){
						$('select[name="duallistbox_demo1[]"]').html('')
						showSuccess(res.message)
					}else{
						$('select[name="duallistbox_demo1[]"]').html('')
						showFailure(res.message)
					}
					
				},
				error:function(err){
					$('select[name="duallistbox_demo1[]"]').html('')
					showFailure('服务端链接错误，请稍后再试！')
				}
            })
            return false;
        });
