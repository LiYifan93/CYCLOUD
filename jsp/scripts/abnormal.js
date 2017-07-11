$('button[name="refresh"]').hide()
$('#refresh').click(function() {
    $('#searchLocalId').val('')
    $('#searchUin').val('')
    $('#searchAbnormalTime').val('')
    $('#searchAbnormalTimeType').val('')
    $('#searchAbnormalTime1').val('')
    $('button[name="refresh"]').click()
})

//查找日期修改
function change(v){
	if(v == 2){
		$('.s_time').removeClass('col-md-6').addClass('col-md-3')
		$('.hid_den').show()
	}else{
		$('.s_time').removeClass('col-md-3').addClass('col-md-6')
		$('.hid_den').hide()
	}
}

//搜索比较前后日期大小
$('#search').on('submit',function(ev){
	ev.preventDefault()
	var start = new Date($('#searchAbnormalTime').val()).getTime()
	var end = new Date($('#searchAbnormalTime1').val()).getTime()
	if(start >end){
		alert('异常开始日期需要小于异常结束日期')
	}else{
		$('#table').bootstrapTable('refresh')
		$('#modal-search').modal('hide')
	}
	
})





var editId 
// // //   对应操作的事件处理函数
window.operateEvents = {
    'click .edit': function(e, value, row, index) {
        $('#editUin').val(row.uin)
        $('#editLocalId').val(row.localId)
        $('#editAbnormalTime').val(row.abnormalTime)
        $('#editAbnormalReason').val(row.abnormalReason)
        editId = row.id
    },

    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath + '/web/abnormal/deleteById?id=' + row.id,
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
        url: contextPath + '/web/abnormal/update?id=' + editId,
        data: data,
        dataType: 'JSON',
        success: function(res) {
            if (res.code == 1) {
                $('#modal-edit').modal('hide')
                $('#table').bootstrapTable('refresh')
                showSuccess(res.message)
            } else {
                $('#modal-edit').modal('hide')
                showFailure(res.message)
            }
        },
        error: function(res) {
        	showFailure('服务端链接错误，请稍后再试！')
            $('#modal-edit').modal('hide')
        }
    })
    return false
})