$('button[name="refresh"]').hide()
$('#refresh').click(function(){
	$('#searchDepartmentName').val('')
	$('#searchUnicode').val('')
	$('#searchDepartmentTypeId').val('')
    $('#searchZipCode').val('')
    $('#searchEmail').val('')
 	$('#searchPhone').val('')
	$('#searchMobile').val('')
	$('#searchProvinceId').val('')
	$('#searchCityId').val('')
	$('#searchCountyId').val('')
	$('#searchAddress').val('')
	$('button[name="refresh"]').click()
})

// 操作
function operateFormatter(value, row, index) {
    return [
    	 '<div>',
         '<a class="edit operate"   href="javascript:void(0)" title="编辑"  data-toggle="modal" data-target="#modal-edit">',
         '<i class="fa fa-pencil-square-o "></i>',
         '</a>&nbsp;',
         '<a class="admin operate" href="javascript:void(0)"  data-toggle="modal" data-target="#modal-admin" title="超级管理员" >',
         '<span class="glyphicon glyphicon-user" aria-hidden="true"></span>',
         '</a>&nbsp; ',
         '<a class="remove operate"  href="javascript:void(0)" title="单个删除" >',
         '<i class="fa fa-close"></i>',
         '</a>&nbsp;',
         '</div>'
    ].join('');
}


//搜索
$('#search').on('submit',function(ev){
	ev.preventDefault()
	$('#table').bootstrapTable('refresh')
	$('#modal-search').modal('hide')
})


var editId

var adminId
////   对应操作的事件处理函数
window.operateEvents = {
    'click .edit': function(e, value, row, index) {
    	console.log(row)
        $('#editDepartmentName').val(row.departmentName)
        $('#editUnicode').val(row.unicode)
        $('#editDepartmentTypeId').val(row.departmentTypeId)
        $('#editZipCode').val(row.zipCode)
        $('#editEmail').val(row.email)
        $('#editPhone').val(row.phone)
        $('#editMobile').val(row.mobile)
        $('#editAddress').val(row.address)
        $("#edit_address").distpicker('destroy');
		$("#edit_address").distpicker({
		    autoSelect: false,
		    placeholder: true
		});
		$('#editProvinceId').val(row.provinceId)
		$('#editProvinceId').trigger("change")
        $('#editCityId').val(row.cityId)
        $('#editCityId').trigger("change")
        $('#editCountyId').val(row.countyId)
        $('#editCountyId').trigger("change")
		
        editId = row.id
        
    },  
    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath+'/department/delete?id='+ row.id,
                data: row,
                dataType: 'JSON',
                success: function(res) {
                	if(res.code == 1){
                		$('#table').bootstrapTable('remove', { field: 'id', values: [row.id] })
                		$('#table').bootstrapTable('refresh')
                        showSuccess(res.message)
                        $('.remove').unbind('click')
                	}
                	else{
                		showFailure(res.message)
                		$('.remove').unbind('click')
                	}
                },
                error: function(res) {
                	showFailure('服务端链接错误，请稍后再试！')
                	$('.remove').unbind('click')
                }

            })
        }
        return false
    },
    'click .admin':function(e, value, row, index){
    	adminId = row.id
    	$('#userName').val('')
        $('#password').val('')
        $('#nickName').val('')
        $('#sex').val('')
        $('#email').val('')
        $('#phone').val('')
        $('#mobile').val('')
    	//获取默认的管理员信息
    	$.ajax({
    		url:contextPath+'/web/usermanage/findAdmin?departmentId='+ adminId,
        	type:'post',
        	dataType:'json',
        	success: function(res) {
                 if (res.code == 1) {
                   $('#userName').val(res.data.userName)
                   $('#password').val(res.data.password)
                   $('#nickName').val(res.data.nickName)
                   $('#sex').val(res.data.sex)
                   $('#email').val(res.data.email)
                   $('#phone').val(res.data.phone)
                   $('#mobile').val(res.data.mobile)
                 } else{ 
                	 showFailure('请添加管理员！')
                   }
              },
              error: function(res) {
            	  showFailure('服务端链接错误，请稍后再试！')
             }
    	})	
    }
};

//编辑
$('#edit').on('submit', function(ev) {
    ev.preventDefault()
    var data = $(this).serialize()
    $.ajax({
        type: 'post',
        url: contextPath+'/department/update?id=' + editId,
        data: data,
        dataType: 'JSON',
        success: function(res) {
            if (res.code == 1) {
                $('#modal-edit').modal('hide')
                $('#table').bootstrapTable('refresh')
                showSuccess(res.message)
            } else{ 
            	$('#modal-edit').modal('hide')
            	showFailure(res.message)
            }
        },
        error: function(res) {
            $('#modal-edit').modal('hide')
            showFailure('服务端链接错误，请稍后再试！')
        }
    })
    return false
})

//默认管理员 编辑
$('#admin').on('submit',function(ev){
    		ev.preventDefault()
            var data = $(this).serialize()
    		$.ajax({
        		url:contextPath+'/web/usermanage/addAdmin?departmentId='+ adminId,
            	data:data,
            	type:'post',
        		dataType:'json',
        		success: function(res) {
                    if (res.code == 1) {
                        $('#modal-admin').modal('hide')
                        showSuccess(res.message)
                    } else{ 
                    	$('#modal-admin').modal('hide')
                    	showFailure(res.message)
                    }
                },
                error: function(res) {
                	$('#modal-admin').modal('hide')
                	showFailure('服务端链接错误，请稍后再试！')
                }
        	})
        	return false
    	})
