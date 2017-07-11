$('button[name="refresh"]').hide()
$('#refresh').click(function() {
	$('#searchPayNo').val('')
    $('#searchLocalId').val('')
    $('#searchUin').val('')
    $('#searchChargeCode').val('')
    $('#searchMonth').val('')
    $('#searchPayType').val('')
    $('#searchReceiveFee').val('')
    $('#searchRealFee').val('')
    $('#searchReason').val('')
    $('#searchPayTime').val('')
    $('#searchPayTimeType').val('')
    $('#searchPayTime1').val('')
    $('#searchEffectiveTime').val('')
 	$('#searchStatus').val('')
	$('#searchOrderTime').val('')
	$('#searchOrderTimeType').val('')
    $('#searchOrderTime1').val('')
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
	var payTime = new Date($('#searchPayTime').val()).getTime()
	var payTime1 = new Date($('#searchPayTime1').val()).getTime()
	var orderTime = new Date($('#searchOrderTime').val()).getTime()
	var orderTime1 = new Date($('#searchOrderTime1').val()).getTime()
	if(payTime>payTime1){
		alert('支付开始日期需要小于支付结束日期')
	}else{
		if(orderTime>orderTime1){
			alert('订单开始日期需要小于订单结束日期')
		}else{
			$('#table').bootstrapTable('refresh')
			$('#modal-search').modal('hide')
		}
	}
	
})

//形成table的时候的转换格式
function payTFormatter(value, row, index) {
	   if(value == 0){
	    	a = "线下支付"
	    }else if(value == 1){
	    	a = "小程序支付"
	    }else if(value == 2){
	    	a = "扫码支付"
	    }else if(value == 3){
	    	a = "其他"
	    }
	    return  a
	}

function statusFormatter(value, row, index) {
    if(value == 0){
   	b = "待支付"
   }else if(value == 1){
   	b = "已支付"
   }else if(value == 2){
   	b = "超时"
   }
   return  b
}


var editId
// // //   对应操作的事件处理函数
window.operateEvents = {
    'click .edit': function(e, value, row, index) {
    	$('#editPayNo').val(row.payNo)
        $('#editLocalId').val(row.localId)
        $('#editUin').val(row.uin)
        $('#editChargeCode').val(row.chargeCode)
        $('#editMonth').val(row.month)
        $('#editPayType').val(row.payType)
        $('#editReceiveFee').val(row.receiveFee)
        $('#editRealFee').val(row.realFee)
        $('#editReason').val(row.reason)
        $('#editPayTime').val(row.payTime)
        $('#editEffectiveTime').val(row.effectiveTime)
     	$('#editStatus').val(row.status)
    	$('#editOrderTime').val(row.orderTime)
    	editId = row.id
        

    },

    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath + '/web/monthcardrechargeorder/deleteById?id=' + row.id,
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
        url: contextPath + '/web/monthcardrechargeorder/update?id=' + editId,
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