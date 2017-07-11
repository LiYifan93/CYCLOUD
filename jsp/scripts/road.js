$('button[name="refresh"]').hide()
$('#refresh').click(function() {
	$('#searchLocalId').val('')
    $('#searchName').val('')
 	$('#searchCode').val('')
	$('#searchType').val('')
	$('#searchLocation').val('') 
    $('button[name="refresh"]').click()
})


// 操作
function operateFormatter(value, row, index) {
    return [
    	 '<div>',
         '<a class="edit operate"   href="javascript:void(0)" title="编辑"  data-toggle="modal" data-target="#modal-edit">',
         '编辑',
         '</a>&nbsp;',
         '<a class="remove operate"  href="javascript:void(0)" title="单个删除" >',
         '删除',
         '</a>&nbsp;',
         '<a class="detail operate" href="javascript:void(0)"  data-toggle="modal" data-target="#modal-admin" title="详情" >',
         '详情',
         '</a>&nbsp; ',
         '</div>'
    ].join('');
}

var editId
// // //   对应操作的事件处理函数
window.operateEvents = {
    'click .edit': function(e, value, row, index) {
    	$('#searchLocalId').val(row.localId)
        $('#searchName').val(row.name)
     	$('#searchCode').val(row.code)
    	$('#searchType').val(row.type)
    	$('#searchLocation').val(row.location) 
    	$('#editRemarks').val(row.remarks)
    	
    	editId =row.id
       
    },

    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath + '/web/road/deleteById?id=' + row.id,
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
        url: contextPath + '/web/road/update?id=' + editId,
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
