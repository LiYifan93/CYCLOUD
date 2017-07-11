$('button[name="refresh"]').hide()
$('#refresh').click(function() {
    $('#searchLocalId').val('')
    $('#searchUin').val('')
    $('#searchStoreCardId').val('')
    $('#searchPlate').val('')
    $('#searchStartDate').val('')
    $('#searchStartDateType').val('')
    $('#searchStartDate1').val('')
    $('#searchRechargeDate').val('')
    $('#searchRechargeDateType').val('')
    $('#searchRechargeDate1').val('')
    $('#searchEndDate').val('')
    $('#searchEndDateType').val('')
    $('#searchEndDate1').val('')
    $('#searchIsSynch').val('')
    $('#searchRechargeFee').val('')
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
	var rechargeDate = new Date($('#searchRechargeDate').val()).getTime()
	var rechargeDate1 = new Date($('#searchRechargeDate1').val()).getTime()
	var endDate = new Date($('#searchEndDate').val()).getTime()
	var endDate1 = new Date($('#searchEndDate1').val()).getTime()
	
	if(startDate >startDate1){
		alert('开始日期需要小于结束日期')
	}else{
		if(rechargeDate > rechargeDate1){
			alert('充值开始日期需要小于充值结束日期')
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

function isSynchFormatter(value, row, index) {
    return value == 0 ? "不同步" : "同步";
}

// //   对应操作的事件处理函数
window.operateEvents = {
    'click .edit': function(e, value, row, index) {
        $('#editLocalId').val(row.localId)
        $('#editUin').val(row.uin)
        $('#editPlate').val(row.plate)
        $('#editStoreCardId').val(row.storeCardId)
        $('#editRechargeDate').val(row.rechargeDate)
        $('#editStartDate').val(row.startDate)
        $('#editEndDate').val(row.endDate)
        $('#editIsSynch').val(row.isSynch)
        $('#editRechargeFee').val(row.rechargeFee)
        $('#edit').on('submit', function(ev) {
            ev.preventDefault()
            var data = $(this).serialize()
            $.ajax({
                type: 'post',
                url: contextPath + '/web/storecardrecharge/update?id=' + row.id,
                data: data,
                dataType: 'JSON',
                success: function(res) {
                    if (res.code == 1) {
                        showSuccess(res.message)
                        $('#edit').off('submit')
                        $('.edit').unbind('click')
                        $('#modal-edit').modal('hide')
                        $('#table').bootstrapTable('refresh')
                    } else {
                        showFailure(res.message)
                        $('#edit').off('submit')
                        $('.edit').unbind('click')
                        $('#modal-edit').modal('hide')
                    }
                },
                error: function(res) {
                	showFailure('服务端链接错误，请稍后再试！')
                    $('#edit').off('submit')
                    $('.edit').unbind('click')
                    $('#modal-edit').modal('hide')
                }
            })
        })
    },

    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath + '/web/storecardrecharge/deleteById?id=' + row.id,
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
                    showFailure(res.message)
                    $('.remove').unbind('click')
                }
            })
        }
        return false
    }
};