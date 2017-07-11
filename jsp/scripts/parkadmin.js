$('button[name="refresh"]').hide()
$('#refresh').click(function() {
	$('#searchUin').val('')
    $('#searchLocalId').val('')
 	$('#searchSex').val('')
	$('#searchName').val('')
	$('#searchPhone').val('') 
    $('button[name="refresh"]').click()
})


function sexFormatter(value, row, index) {
	return value == 0? '男':'女'
}


//搜索
$('#search').on('submit',function(ev){
	ev.preventDefault()
	$('#table').bootstrapTable('refresh')
	$('#modal-search').modal('hide')
})

var editId
// // //   对应操作的事件处理函数
window.operateEvents = {
    'click .edit': function(e, value, row, index) {
    	$('#editUin').val(row.uin)
        $('#editLocalId').val(row.localId)
     	$('#editSex').val(row.sex)
    	$('#editName').val(row.name)
    	$('#editPhone').val(row.phone)
    	editId = row.id
    },

    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath + '/web/parkadmin/deleteById?id=' + row.id,
                data: row,
                dataType: 'JSON',
                success: function(res) {
                    if (res.code == 1) {
                        $('#table').bootstrapTable('remove', { field: 'id', values: [row.id] })
                        $('#table').bootstrapTable('refresh')
                        showSuccess(res.message)
                        $('.remove').unbind('click')
                    } else {
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
    }
};

$('#edit').on('submit', function(ev) {
    ev.preventDefault()
    var data = $(this).serialize()
    console.log(data)
    $.ajax({
        type: 'post',
        url: contextPath + '/web/parkadmin/update?id=' + editId,
        data: data,
        dataType: 'JSON',
        success: function(res) {
            if (res.code == 1) {
                showSuccess(res.message)
                $('#modal-edit').modal('hide')
                $('#table').bootstrapTable('refresh')
            } else {
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