$('button[name="refresh"]').hide()
$('#refresh').click(function() {
	 $('#searchLocalId').val('')
     $('#searchUin').val('')
  	 $('#searchRoadId').val('')
     $('#searchPlate').val('')
	 $('#searchPayNo').val('')   	
     $('#searchStatus').val('')			
     $('#searchPayType').val('')
     $('#searchChargeCode').val('')
     $('#searchEffectiveTime').val('')
     $('#searchReceiveFee').val('')
     $('#searchInTime').val('')
     $('#searchInTimeType').val('')
     $('#searchInTime1').val('')
     $('#searchOutTime').val('')
     $('#searchOutTimeType').val('')
     $('#searchOutTime1').val('')
     $('#searchOrderTime').val('')
     $('#searchOrderTimeType').val('')
     $('#searchOrderTime1').val('')
     $('#searchPayTime').val('')
     $('#searchPayTimeType').val('')
     $('#searchPayTime1').val('')
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

function pay(v){
	if(v == 2){
		$('.p_time').removeClass('col-md-6').addClass('col-md-3')
		$('.p_hid_den').show()
	}else{
		$('.p_time').removeClass('col-md-3').addClass('col-md-6')
		$('.p_hid_den').hide()
	}
}
//搜索
$('#search').on('submit',function(ev){
	ev.preventDefault()
	var inTime = new Date($('#searchInTime').val()).getTime()
	var inTime1 = new Date($('#searchInTime1').val()).getTime()
	var outTime = new Date($('#searchOutTime').val()).getTime()
	var outTime1 = new Date($('#searchOutTime1').val()).getTime()
	var orderTime = new Date($('#searchOrderTime').val()).getTime()
	var orderTime1 = new Date($('#searchOrderTime1').val()).getTime()
	var payTime = new Date($('#searchPayTime').val()).getTime()
	var payTime1 = new Date($('#searchPayTime1').val()).getTime()
	if(inTime >inTime1){
		alert('入场开始日期需要小于入场结束日期')
	}else{
		if(outTime >outTime1){
			alert('出场开始日期需要小于出场结束日期')
		}else{
			if(orderTime>orderTime1){
				alert('订单开始日期需要小于订单结束日期')
			}else{
				if(payTime>payTime1){
					alert('支付开始日期需要小于支付结束日期')
				}else{
					$('#table').bootstrapTable('refresh')
					$('#modal-search').modal('hide')
				}
			}
		}
	}
	
})


function payTypeFormatter(value, row, index) {
	if (value == 0) {
        a = "现金支付"
    } else if (value == 1) {
        a = "微信转账"
    } else if (value == 2) {
        a = "扫码支付"
    } else if (value == 3) {
        a = "小程序支付"
    } else if (value == 4) {
        a = "预支付"
    } else a = "其他"
    return a
}

function statusFormatter(value, row, index) {
	if (value == 0) {
        b = "待支付"
    } else if (value == 1) {
        b = "已支付"
    } else if (value == 2) {
        b = "超时"
    } else b = "其他"
    return b
}



var editId
// // //   对应操作的事件处理函数
window.operateEvents = {
    'click .edit': function(e, value, row, index) {
    	$('#editLocalId').val(row.localId)
        $('#editUin').val(row.uin)
     	 $('#editRoadId').val(row.roadId)
        $('#editPlate').val(row.plate)
   	    $('#editPayNo').val(row.payNo)   	
        $('#editStatus').val(row.status)			
        $('#editPayType').val(row.payType)
        $('#editChargeCode').val(row.chargeCode)
        $('#editEffectiveTime').val(row.effectiveTime)
        $('#editReceiveFee').val(row.receiveFee)
        $('#editRealFee').val(row.realFee)
        $('#editReason').val(row.reason)
        $('#editInTime').val(row.inTime)
        $('#editOutTime').val(row.outTime)
        $('#editOrderTime').val(row.orderTime)
        $('#editPayTime').val(row.payTime)
        editId  = row.id
    },

    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath + '/web/chargeorder/deleteById?id=' + row.id,
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
        url: contextPath + '/web/chargeorder/update?id=' + editId,
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
            $('#modal-edit').modal('hide')
            showFailure('服务端链接错误，请稍后再试！')
        }
    })
    return false 
})
