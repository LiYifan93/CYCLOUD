$('button[name="refresh"]').hide()
$('#refresh').click(function(){
	$('#searchLocalId').val('')
	$('#searchUin').val('')
	$('#searchPlate').val('')
	$('#searchName').val('')
   	$('#searchPhone').val('')
   	$('#searchCode').val('')
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
    	a = "小车"
    }else if(value == 1){
    	a = "大车"
    }else if(value == 2){
    	a = "超大车"
    }else if(value == 3){
    	a = "摩托车"
    }else  a = "其他"
    return  a
}

function isSynchFormatter(value, row, index) {
    return value == 0 ? "不同步" : "同步";
}

var editId
// //   对应操作的事件处理函数
window.operateEvents = {
    'click .edit': function(e, value, row, index) {
        $('#editLocalId').val(row.localId)
        $('#editUin').val(row.uin)
        $('#editPlate').val(row.plate)
        $('#editName').val(row.name)
   		$('#editPhone').val(row.phone)
   		$('#editCode').val(row.code)
        $('#editType').val(row.type)
         $('#editIsSynch').val(row.isSynch)
        $('#editStartTime').val(row.startTime)
        $('#editEndTime').val(row.endTime)
        editId = row.id
        

    },

    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath+'/web/whitelist/deleteById?id=' + row.id,
                data: row,
                dataType: 'JSON',
                success: function(res) {
                	if(res.code == 1){
                		$('#table').bootstrapTable('remove', { field: 'id', values: [row.id] })
                        showSuccess(res.message)
                        $('.remove').off('click')
                	}
                	else{
                		showFailure(res.message)
                		$('.remove').off('click')
                	}
                },
                error: function(err) {
                	showFailure('服务端链接错误，请稍后再试！')
                	$('.remove').off('click')
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
        url: contextPath+'/web/whitelist/update?id=' + editId,
        data: data,
        dataType: 'JSON',
        success: function(res) {
            if (res.code == 1) {
            	showSuccess(res.message)
                $('#modal-edit').modal('hide')
                $('#table').bootstrapTable('refresh')
            } else{ 
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




  

