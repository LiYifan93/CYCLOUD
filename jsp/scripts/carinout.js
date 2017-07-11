$('button[name="refresh"]').hide()
$('#refresh').click(function() {
	$('#searchLocalId').val('')
    $('#searchUin').val('')
   	$('#searchRoadId').val('')
 	$('#searchType').val('')
 	$('#searchPlate').val('')
	$('#searchStatus').val('')
	$('#searchDeviceId').val('')
	$('#searchIoTime').val('')
	$('#searchIoTimeType').val('')
   	$('#searchIoTime1').val('')
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
	var start = new Date($('#searchIoTime').val()).getTime()
	var end = new Date($('#searchIoTime1').val()).getTime()
		if(start >end){
			alert('开始日期需要小于结束日期')
		}else{
			$('#table').bootstrapTable('refresh')
			$('#modal-search').modal('hide')
		}
})

function picFormatter(value, row, index) {
    return [
        '<div><a href="'+ row.pic + '">' + row.pic + '</a></div>'
    ].join('');
}

function typeFormatter(value, row, index) {
    if (value == 0) {
        b = "进场"
    } else if (value == 1) {
        b = "出场"
    }
    return b
}

function statusFormatter(value, row, index) {
    if (status == 0) {
        a = '已进场'
    } else if (status == 1) {
        a = '已出场'
    } else if (status == 2) {
        a = '在场'
    } else if (status == 3) {
        a = '未知'
    } 
    return a
}

var editId
// //   对应操作的事件处理函数
window.operateEvents = {
    'click .edit': function(e, value, row, index) {
    	$('#editLocalId').val(row.localId)
        $('#editUin').val(row.uin)
       	$('#editRoadId').val(row.roadId)
     	$('#editType').val(row.type)
     	$('#editPlate').val(row.plate)
    	$('#editStatus').val(row.status)
    	$('#editDeviceId').val(row.deviceId)
    	$('#editIoTime').val(row.ioTime)
    	editId = row.id
    },
    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath + '/web/carinout/deleteById?id=' + row.id,
                data: row,
                dataType: 'JSON',
                success: function(res) {
                    if (res.code == 1) {
                        $('#table').bootstrapTable('remove', { field: 'id', values: [row.id] })
                        $('#table').bootstrapTable('refresh')
                        showSuccess(res.message)
                        $('.remove').unbind('click')
                    } else {
                        showInfo(res.message)
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
        url: contextPath + '/web/carinout/update?id=' + editId,
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
    return  false
})
