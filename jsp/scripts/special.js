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
    $('#searchInTime').val('')
    $('#searchInTimeType').val('')
    $('#searchInTime1').val('')
    $('#searchOutTime').val('')
    $('#searchOutTimeType').val('')
    $('#searchOutTime1').val('')
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
		$('.s_time1').removeClass('col-md-6').addClass('col-md-3')
		$('.hi_dden').show()
	}else{
		$('.s_time1').removeClass('col-md-3').addClass('col-md-6')
		$('.hi_dden').hide()
	}
}

//搜索
$('#search').on('submit',function(ev){
	ev.preventDefault()
	var inTime = new Date($('#searchInTime').val()).getTime()
	var inTime1 = new Date($('#searchInTime1').val()).getTime()
	var outTime = new Date($('#searchOutTime').val()).getTime()
	var outTime1 = new Date($('#searchOutTime1').val()).getTime()
		if(inTime >inTime1){
			alert('入场开始日期需要小于入场结束日期')
		}else{
			if(outTime >outTime1){
				alert('出场开始日期需要小于出场结束日期')
			}else{
				$('#table').bootstrapTable('refresh')
				$('#modal-search').modal('hide')
			}
		}
})


function carTypeFormatter(value, row, index) {
    if (value == 0) {
        a = "小车"
    } else if (value == 1) {
        a = "大车"
    } else if (value == 2) {
        a = "超大车"
    } else if (value == 3) {
        a = "摩托车"
    } else if (value == 4) {
        a = "其他"
    } else a = " "
    return a
}

function ownerShipFormatter(value, row, index) {
    if (value == 0) {
        b = "警车"
    } else if (value == 1) {
        b = "军车"
    } else if (value == 2) {
        b = "消防车"
    } else if (value == 3) {
        b = "救护车"
    } else if (value == 3) {
        b = "其他"
    } else b = " "
    return b
}

var editId
// //   对应操作的事件处理函数
window.operateEvents = {
    'click .edit': function(e, value, row, index) {
        $('#editUin').val(row.uin)
        $('#editLocalId').val(row.localId)
        $('#editName').val(row.name)
        $('#editCarPhone').val(row.carPhone)
        $('#editAddress').val(row.address)
        $('#editPlate').val(row.plate)
        $('#editCarType').val(row.carType)
        $('#editOwnerShip').val(row.ownership)
        $('#editFeeType').val(row.feeType)
        $('#editInTime').val(row.inTime)
        $('#editOutTime').val(row.outTime)
        editId = row.id
        
    },

    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath + '/web/special/deleteById?id=' + row.id,
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
        url: contextPath + '/web/special/update?id=' + editId,
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