$('button[name="refresh"]').hide()
$('#refresh').click(function() {
    $('#searchLocalId').val('')
    $('#searchUin').val('')
    $('#searchName').val('')
    $('#searchCarPhone').val('')
    $('#searchAddress').val('')
    $('#searchPlate').val('')
    $('#searchCarType').val('')
    $('#searchOwnerShip').val('')
    $('#searchFeeType').val('')
    $('#searchStartTime').val('')
    $('#searchStartTimeType').val('')
    $('#searchStartTime1').val('')
    $('#searchTransferTime').val('')
    $('#searchTransferType').val('')
    $('#searchTransfer1').val('')
    $('#searchEndTime').val('')
    $('#searchEndTimeType').val('')
    $('#searchEndTime1').val('')
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

function end(v){
	if(v == 2){
		$('.e_time').removeClass('col-md-6').addClass('col-md-3')
		$('.e_hid_den').show()
	}else{
		$('.e_time').removeClass('col-md-3').addClass('col-md-6')
		$('.e_hid_den').hide()
	}
}


//搜索
$('#search').on('submit',function(ev){
	ev.preventDefault()
	var startDate = new Date($('#searchStartDate').val()).getTime()
	var startDate1 = new Date($('#searchStartDate1').val()).getTime()
	var transferTime = new Date($('#searchTransferTime').val()).getTime()
	var transferTime1 = new Date($('#searchTransferTime1').val()).getTime()
	var endDate = new Date($('#searchEndDate').val()).getTime()
	var endDate1 = new Date($('#searchEndDate1').val()).getTime()
	
	if(startDate >startDate1){
		alert('开始日期需要小于结束日期')
	}else{
		if(transferTime > transferTime1){
			alert('交接开始日期需要小于交接结束日期')
		}else{
				if(endDate>endDate1){
					alert('开始日期需要小于结束日期')
				}else{
					$('#table').bootstrapTable('refresh')
					$('#modal-search').modal('hide')
				}
		}
	}
	
})

var editId
// //   对应操作的事件处理函数
window.operateEvents = {
    'click .edit': function(e, value, row, index) {
        $('#editUin').val(row.uin)
        $('#editLocalId').val(row.localId)
        $('#editRemark').val(row.remark)
        $('#editRealFee').val(row.realFee)
        $('#editReceiveFee').val(row.receiveFee)
        $('#editStartTime').val(row.startTime)
        $('#editTransferTime').val(row.transferTime)
        $('#editEndTime').val(row.endTime)
        editId = row.id
       
    },

    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath + '/web/transfer/deleteById?id=' + row.id,
                data: row,
                dataType: 'JSON',
                success: function(res) {
                    if (res.code == 1) {
                        $('#table').bootstrapTable('remove', { field: 'id', values: [row.id] })
                        $('#table').bootstrapTable('refresh')
                        $('.remove').unbind('click')
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
$('#edit').on('submit', function(ev) {
    ev.preventDefault()
    var data = $(this).serialize()
    $.ajax({
        type: 'post',
        url: contextPath + '/web/transfer/update?id=' + editId,
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