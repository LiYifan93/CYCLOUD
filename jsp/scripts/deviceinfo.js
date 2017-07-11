$('button[name="refresh"]').hide()
$('#refresh').click(function() {
    $('button[name="refresh"]').click()
})

function statusFormatter(value, row, index) {
	if (value == 0) {
        c = "异常"
    } else if (value == 1) {
        c = "正常"
    } else c = "未知"
    return c
}

function passTypeFormatter(value, row, index) {
    if (value == 0) {
        a = "入口"
    } else if (value == 1) {
        a = "出口"
    } else a = "其它"
    return a
}

function typeFormatter(value, row, index) {
    if (value == 0) {
        b = "电脑"
    } else if (value == 1) {
        b = "相机"
    } else if (value == 2) {
        b = "显示屏"
    } else if (value == 3) {
        b = "广告屏"
    } else  b = "其他"
    return b
}

//搜索
$('#search').on('submit',function(ev){
	ev.preventDefault()
	$('#table').bootstrapTable('refresh')
	$('#modal-search').modal('hide')
})


var editId
// //   对应操作的事件处理函数
window.operateEvents = {
    'click .edit': function(e, value, row, index) {
        $('#editLocalId').val(row.localId)
        $('#editSerialId').val(row.serialId)
        $('#editName').val(row.name)
        $('#editStatus').val(row.status)
        $('#editType').val(row.type)
        $('#editIp').val(row.ip)
        $('#editPassType').val(row.passType)
        $('#editlocation').val(row.location)
        $('#editSynchTime').val(row.synchTime)
        $('#editReason').val(row.reason)
        editId = row.id

    },

    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath + '/web/deviceinfo/deleteById?id=' + row.id,
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
    $.ajax({
        type: 'post',
        url: contextPath + '/web/deviceinfo/update?id=' + editId,
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
            showFailure(res.message)
            $('#modal-edit').modal('hide')
        }
    })
    return false
})