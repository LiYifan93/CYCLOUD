$('button[name="refresh"]').hide()
$('#refresh').click(function() {
    $('#searchLocalId').val('')
    $('#searchUin').val('')
    $('#searchCarName').val('')
    $('#searchCarPhone').val('')
    $('#searchPlate').val('')
    $('#searchCarType').val('')
    $('#searchCardCode').val('')
    $('#searchIsNew').val('')
    $('#searchFeeType').val('')
    $('#searchLotNum').val('')
   	$('#searchCardType').val('')
    $('#searchNewDate').val('')
    $('#searchNewDateType').val('')
    $('#searchNewDate1').val('')
    $('#searchIsSynch').val('')
    $('#searchStatus').val('')
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
	var newDate = new Date($('#searchNewDate').val()).getTime()
	var newDate1 = new Date($('#searchNewDate1').val()).getTime()
	if(newDate>newDate1){
		alert('充值开始日期需要小于充值结束日期')
	}else{
			$('#table').bootstrapTable('refresh')
			$('#modal-search').modal('hide')
		}
})

function isSynchFormatter(value, row, index) {
    return value == 0 ? "未同步" : "同步";
}

function isNFormatter(value, row, index) {
    return value == 0 ? "新增" : "更新";
}

function statusFormatter(value, row, index) {
    if (value == 0) {
        a = "无效"
    } else if (value == 1) {
        a = "有效"
    } else if (value == -1) {
        a = "过期"
    } else a = ""
    return a
}


function cardTypeFormatter(value, row, index) {
    if (value == 0) {
        b = "车牌"
    } else if (value == 1) {
        b = "车位"
    } else b = ""
    return b
}

function carTypeFormatter(value, row, index) {
    if (value == 0) {
        c = "小车"
    } else if (value == 1) {
        c = "大车"
    } else if (value == 2) {
        c = "超大车"
    } else if (value == 3) {
        c = "摩托车"
    } else if (value == 4) {
        c = "其他"
    } else c = ""
    return c
}


var editId
// //   对应操作的事件处理函数

window.operateEvents = {
    'click .edit': function(e, value, row, index) {
        $('#editLocalId').val(row.localId)
        $('#editUin').val(row.uin)
        $('#editCarName').val(row.carName)
        $('#editCarPhone').val(row.carPhone)
        $('#editPlate').val(row.plate)
        $('#editCarType').val(row.carType)
        $('#editCardCode').val(row.cardCode)
        $('#editFeeType').val(row.feeType)
        $('#editIsNew').val(row.isNew)
        $('#editLotNum').val(row.lotNum)
        $('#editCardType').val(row.cardType)
        $('#editStatus').val(row.status)
        $('#editNewDate').val(row.newDate)
        $('#editIsSynch').val(row.isSynch)
        $('#editIsNew').val(row.isNew)
        $('#editRemarks').val(row.remarks)
        editId = row.id
       
    },

    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath + '/web/monthlycard/deleteById?id=' + row.id,
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
        url: contextPath + '/web/monthlycard/update?id=' + editId,
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