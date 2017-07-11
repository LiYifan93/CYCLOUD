$('button[name="refresh"]').hide()
$('#refresh').click(function() {
    $('#searchLocalId').val('')
    $('#searchUin').val('')
    $('#searchMonthCardLocalId').val('')
    $('#searchFeeType').val('')
    $('#searchStartDate').val('')
    $('#searchStartDateType').val('')
    $('#searchStartDate1').val('')
    $('#searchEndDate').val('')
    $('#searchEndDateType').val('')
    $('#searchEndDate1').val('')
    $('#searchIsSynch').val('')
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

function get(v){
	if(v == 2){
		$('.c_time').removeClass('col-md-6').addClass('col-md-3')
		$('.c_hid_den').show()
	}else{
		$('.c_time').removeClass('col-md-3').addClass('col-md-6')
		$('.c_hid_den').hide()
	}
}
//搜索
$('#search').on('submit',function(ev){
	ev.preventDefault()
	var startDate = new Date($('#searchStartDate').val()).getTime()
	var startDate1 = new Date($('#searchStartDate1').val()).getTime()
	var endDate = new Date($('#searchEndDate').val()).getTime()
	var endDate1 = new Date($('#searchEndDate1').val()).getTime()
	if(startDate>startDate1){
		alert('开始日期需要小于结束日期')
	}else{
		if(endDate>endDate1){
			alert('开始日期需要小于结束日期')
		}else{
			$('#table').bootstrapTable('refresh')
			$('#modal-search').modal('hide')
		}
	}
	
})

function isSynchFormatter(value, row, index) {
    return value == 0 ? "未同步" : "同步";
}

var editId
// //   对应操作的事件处理函数
window.operateEvents = {
    'click .edit': function(e, value, row, index) {
        $('#editLocalId').val(row.localId)
        $('#editUinId').val(row.uin)
        $('#editMonthCardLocalId').val(row.monthCardLocalId)
        $('#editStartDate').val(row.startDate)
        $('#editEndDate').val(row.endDate)
        $('#editIsSynch').val(row.isSynch)
        editId = row.id
        
    },

    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath + '/web/monthcardrecharge/deleteById?id=' + row.id,
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

//编辑
$('#edit').on('submit', function(ev) {
    ev.preventDefault()
    var data = $(this).serialize()
    $.ajax({
        type: 'post',
        url: contextPath + '/web/monthcardrecharge/update?id=' + editId,
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