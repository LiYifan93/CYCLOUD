$('button[name="refresh"]').hide()
$('#refresh').click(function(){
	$('#searchPlate').val('')
	$('#searchType').val('')
	$('#searchStartTime').val('')
	$('#searchStartTimeType').val('')
	$('#searchStartTime1').val('')
	$('#searchEndTime').val('')
	$('#searchEndTimeType').val('')
	$('#searchEndTime1').val('')
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
	var start = new Date($('#searchStartTime').val()).getTime()
	var start1 = new Date($('#searchStartTime1').val()).getTime()
	var end = new Date($('#searchEndTime').val()).getTime()
	var end1 = new Date($('#searchEndTime1').val()).getTime()
	if(start >start1){
		alert('开始日期需要小于结束日期')
	}else{
		if(end >end1){
			alert('开始日期需要小于结束日期')
		}else{
			$('#table').bootstrapTable('refresh')
			$('#modal-search').modal('hide')
		}
		
	}
	
})
function typeFormatter(value, row, index) {
     if(value == 0){
    	a = "挂失车"
    }else if(value == 1){
    	a = "通缉车"
    }else a = "其他"
    return  a
}

function isSynchFormatter(value, row, index) {
    return value == 0 ? "不同步" : "同步";
}

var editId
// //   对应操作的事件处理函数
window.operateEvents = {
    'click .edit': function(e, value, row, index) {
        $('#editPlate').val(row.plate)
        $('#editType').val(row.type)
        $('#editStartTime').val(row.startTime)
        $('#editEndTime').val(row.endTime)
        $('#editIsSynch').val(row.isSynch)
        $('#editRemarks').val(row.remarks)
        editId = row.id
    },

    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath+'/web/blacklist/deleteById?id=' + row.id,
                data: row,
                dataType: 'JSON',
                success: function(res) {
                	if(res.code == 1){
                		$('#table').bootstrapTable('remove', { field: 'id', values: [row.id] })
                        showSuccess(res.message)
                        $('.remove').unbind('click')
                	}
                	else{
                		showFailure(res.message)
                		$('.remove').unbind('click')
                	}
                },
                error: function(err) {
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
    $.ajax({
        type: 'post',
        url: contextPath+'/web/blacklist/update?id=' + editId,
        data: data,
        dataType: 'JSON',
        success: function(res) {
            if (res.code == 1) {
            	$('#modal-edit').modal('hide')
            	showSuccess(res.message)
                $('#table').bootstrapTable('refresh')
            } else{ 
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