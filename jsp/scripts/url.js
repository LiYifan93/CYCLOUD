		var url = location.href
		var id = url.split('?')[1]
		var fId = url.split('?')[2]
		var data_url = dataUrl + id 
		//将add model 的停车场ID设值、隐藏
		$(".departmentId").val(id);
		$("#d_add").hide();
		$("#d_export").hide();	
		$('#table').attr('data-url',data_url)		
		$('#table').bootstrapTable({
		onLoadSuccess:function(){
			$(".operate").hide()
			$.ajax({
				url: contextPath+'/function/menu?id=' + fId,
				dataType:'json',
				type:'POST',
				success:function(res){
					var flag = false;
					for(var i =0;i<res.data.length;i++){
						if(res.data[i] == '新增'){$('.add').show()}
						if(res.data[i] == '导出'){$('.export').show()}
						if(res.data[i] == '搜索'){$('.search').show()}
						if(res.data[i] == '删除'){$('.remove').show();flag=true;}
						if(res.data[i] == '编辑'){$('.edit').show();flag=true;}
						if(res.data[i] == '角色权限'){$('.role').show();flag=true;}
						if(res.data[i] == '分配超管'){$('.admin').show();flag=true;}
						if(res.data[i] == '详情'){$('.detail').show();flag=true;}
						if(res.data[i] == '订单'){$('.order').show();flag=true;}
					}
					
					if(!flag){
						 $('#table').bootstrapTable('hideColumn', 'details');
					}
					
				},
				error:function(err){
					showFailure('服务端链接错误，请稍后再试！')
				}
			})
		}
})

// // 日历

$('.dateTime').datetimepicker({
    language: 'zh-CN',
    weekStart: 1,
    todayBtn: 1,
    autoclose: 1,
    todayHighlight: 1,
    startView: 2,
    forceParse: 0,
    showSecond: 1,
    minuteStep: 1,
});
var date = new Date()
$(".dateTime").datetimepicker('setEndDate', date)

// <！--格式化Table语言，需引入中文语言包-->
$.extend($.fn.bootstrapTable.defaults, $.fn.bootstrapTable.locales['zh-CN']);
//  格式化服务器返回的数据
function responseHandler(data) {
    return {
        'total': data.data.total,
        'rows': data.data.rows
    }
}

// 操作
function operateFormatter(value, row, index) {
    return [
        '<a class="edit operate"   href="javascript:void(0)" title="编辑"  data-toggle="modal" data-target="#modal-edit">',
        '<i class="fa fa-pencil-square-o "></i>',
        '</a>&nbsp;',
        '<a class="remove operate" id="operate" href="javascript:void(0)" title="单个删除" >',
        '<i class="fa fa-close"></i>',
        '</a>  ',
        '</div>'
    ].join('');
}
//添加
$('#add').on('submit',function(ev) {
    ev.preventDefault()
    var data = $(this).serialize()
    $.ajax({
            url: addUrl,
            data: data,
            type: 'post',
            dataType: 'JSON',
            cache:false,
            success:function(res) {
                if (res.code == 1) {
                    $('#modal-add').modal('hide')
                    $(this).off('submit')
                    $('#table').bootstrapTable('refresh')
                   showSuccess(res.message)
                }else{ 
                	showFailure(res.message)
                	$('#modal-add').modal('hide')
                }
            },
            error:function(res) {
            	showFailure('服务端链接错误，请稍后再试！')
                $('#modal-add').modal('hide')
            }
        })
})

// 导出事件
$(function() {
    // 批量导出ID
    $('#export').submit(function(ev) {
        ev.preventDefault()
        var parkId = $('#export #parkId').val()
        var data = $(this).serialize()
        $('#modal-export').modal('hide')
        window.location.href = exportUrl+ '?'+ data
    })
})

function uinFormatter(value, row, index) {
    return  [
        '<div><a  onclick="uin($(this).text())">' + row.uin + '</a></div>'
        ].join('');
}

function uin(e){
	$.ajax({
		type:'post',
		dataType:'json',
		url:contextPath + '/web/parkadmin/findByUin',
		data:{
				uin:e,
				departmentId:id
		},
		success:function(res){
			if(res.code == 1){
				console.log(res.data)
				$('#uinLocalId').val(res.data.localId)
				$('#uinUin').val(res.data.uin)
				$('#uinName').val(res.data.name)
				$('#uinSex').val(res.data.sex)
				$('#uinPhone').val(res.data.phone)
				$('#modal-uin').modal('show')
			}else{
				showFailure(res.message)
			}
		},
		error:function(){
			showFailure('服务端链接错误')
		}
	})
}