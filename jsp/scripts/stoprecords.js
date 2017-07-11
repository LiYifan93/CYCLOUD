$('button[name="refresh"]').hide()
$('#refresh').click(function() {
	$('#searchLocalId').val('')
    $('#searchUin').val('')
 	$('#searchRoadId').val('')
	$('#searchPlate').val('')
	$('#searchDeviceId').val('')
	$('#searchIoTime').val('')
	$('#searchIoTimeType').val('')
	$('#searchIoTime1').val('')
	$('#searchOutLocalId').val('')
    $('#searchOutUin').val('')
 	$('#searchOutRoadId').val('')
	$('#searchOutPlate').val('')
	$('#searchOutDeviceId').val('')
	$('#searchOutIoTime').val('')
	$('#searchOutIoTimeType').val('')
	$('#searchOutIoTime1').val('')
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
	var ioTime = new Date($('#searchIoTime').val()).getTime()
	var ioTime1 = new Date($('#searchIoTime1').val()).getTime()
	var outIoTime = new Date($('#searchOutIoTime').val()).getTime()
	var outIoTime1 = new Date($('#searchOutIoTime1').val()).getTime()
		if(ioTime >ioTime1){
			alert('入场开始日期需要小于入场结束日期')
		}else{
			if(outIoTime >outIoTime1){
				alert('出场开始日期需要小于出场结束日期')
			}else{
				$('#table').bootstrapTable('refresh')
				$('#modal-search').modal('hide')
			}
		}
})
function picFormatter(value, row, index) {
    return [
        '<div><a href="'+ row.pic + '">' + row.pic + '</a></div>'
    ].join('');
}

function outPicFormatter(value, row, index) {
    return [
        '<div><a href="'+ row.outPic + '">' + row.outPic + '</a></div>'
    ].join('');
}


// 操作
function operateFormatter(value, row, index) {
    return [
    	 '<div>',
         '<a class="detail operate" href="javascript:void(0)"  data-toggle="modal" data-target="#modal-order" title="订单详情" >',
         '订单',
         '</a>&nbsp; ',
         '</div>'
    ].join('');
}

// // //   对应操作的事件处理函数
window.operateEvents = {
    'click .detail': function(e, value, row, index) {
       var id = row.chargrOrderId
       $.ajax({
    	   url:contextPath+ '/web/stoprecords/detail?chargrOrderId=' + id,
    	   data:id,
    	   type:'post',
    	   dataType:'json',
    	   success: function(res) {
               if (res.code == 1) {
                  $('#payNo').val(res.data.payNo)
                  $('#plate').val(res.data.plate)
                  $('#localId').val(res.data.localId)
                  $('#uin').val(res.data.uin)
                  $('#roadId').val(res.data.roadId)
                  $('#inTime').val(res.data.inTime)
                  $('#outTime').val(res.data.outTime)
                  $('#orderTime').val(res.data.orderTime)
                  $('#payType').val(res.data.payType)
                  $('#realFee').val(res.data.realFee)
                  $('#status').val(res.data.status)
                  $('#effectiveTime').val(res.data.effectiveTime)
               } else {
                   showFailure(res.message)
               }
           },
           error: function(res) {
        	   showFailure('服务端链接错误，请稍后再试！')
           }
       })

    }
};