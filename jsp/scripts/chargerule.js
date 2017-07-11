$('button[name="refresh"]').hide()
$('#refresh').click(function() {
	$('#searchLocalId').val('')
    $('#searchType').val('')
 	$('#searchCode').val('')
	$('#searchName').val('')
	$('#searchMonthPrice').val('')
	$('#searchRules').val('') 
    $('button[name="refresh"]').click()
})

function departmentTypeIdFormatter(value, row, index){
	if(value == 1){
		 a = '云平台'
	 }else if(value == 2){
		 a = "代理商"
	 }else if(value == 3){
		 a = "渠道商"
	 }else  if(value == 4){
		 a = "建筑机构"
	 }else if(value == 5){
		 a = "停车场"
	 }else a = ''
		 return a 
}
// 操作
function operateFormatter(value, row, index) {
    return [
    	 '<div>',
         '<a class="detail operate" href="javascript:void(0)"  data-toggle="modal" data-target="#modal-edit" title="详情" >',
         ' <span class="glyphicon  glyphicon-th-list" aria-hidden="true"></span>',
         '</a>&nbsp; ',
         '<a class="remove operate"  href="javascript:void(0)" title="单个删除" >',
         '<i class="fa fa-close"></i>',
         '</a>&nbsp;',
         '</div>'
    ].join('');
}

//搜索
$('#search').on('submit',function(ev){
	ev.preventDefault()
	$('#table').bootstrapTable('refresh')
	$('#modal-search').modal('hide')
})


// // //   对应操作的事件处理函数
window.operateEvents = {
    'click .detail': function(e, value, row, index) {
    	$('#editLocalId').val(row.localId)
        $('#editType').val(row.type)
     	$('#editCode').val(row.code)
    	$('#editName').val(row.name)
    	$('#editMonthPrice').val(row.monthPrice)
    	$('#editRemarks').val(row.remarks)
    	
    	//解析自定义json格式数据
    	var rules = row.rules
    	rules = eval("("+ rules +")")
    	var html = ''
    	for (var key in rules) {
                html += key + ":" + rules[key] + '\r\n'
            }
        $('#editRules').val(html)
    },

    // 单个移除事件
    'click .remove': function(e, value, row, index) {
        var confirm = window.confirm("你确定删除当前选中的记录么?");
        if (confirm) {
            $.ajax({
                type: 'post',
                url: contextPath + '/web/chargerule/deleteById?id=' + row.id,
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

//
