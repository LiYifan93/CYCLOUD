$('button[name="refresh"]').hide()
$('#refresh').click(function() {
    $('#searchLocalId').val('')
    $('#searchUin').val('')
    $('#searchPassId').val('')
    $('#searchDate').val('')
    $('#searchDateType').val('')
    $('#searchDate1').val('')
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

//搜索
$('#search').on('submit',function(ev){
	ev.preventDefault()
	var start = new Date($('#searchDate').val()).getTime()
	var end = new Date($('#searchDate1').val()).getTime()
		if(start >end){
			alert('开始日期需要小于结束日期')
		}else{
			$('#table').bootstrapTable('refresh')
			$('#modal-search').modal('hide')
		}
})

function imgPathFormatter(value, row, index) {
    return  [
        '<div><a  href="+row.imgPath +" >' + row.imgPath + '</a></div>'
        ].join('');
}


var editId
// //   对应操作的事件处理函数
window.operateEvents = {
    'click .edit': function(e, value, row, index) {
        $('#editUin').val(row.uin)
        $('#editLocalId').val(row.localId)
        $('#editDate').val(row.date)
        $('#editPassId').val(row.passId)
        $('#editReason').val(row.reason)
        editId = row.id
       
    },

    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath + '/web/opengaterecords/deleteById?id=' + row.id,
                data: row,
                dataType: 'JSON',
                success: function(res) {
                    if (res.code == 1) {
                        $('.remove').unbind('click')
                        $('#table').bootstrapTable('remove', { field: 'id', values: [row.id] })
                        $('#table').bootstrapTable('refresh')
                        showSuccess(res.message)
                    } else {
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

//编辑
$('#edit').on('submit', function(ev) {
    ev.preventDefault()
    var data = $(this).serialize()
    $.ajax({
        type: 'post',
        url: contextPath + '/web/opengaterecords/update?id=' + editId,
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