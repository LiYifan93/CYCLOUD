//获取所有部门名称
$.ajax({
	url: contextPath + '/department/dptype',
	type:'post',
	async:false,
	success:function(res){
		if(res.code == 1){
			var html=''
			for(var i=0;i<res.data.rows.length;i++){
				html +='<option value='+ res.data.rows[i].id+'>'+res.data.rows[i].name+'</option>'
			}
			$('#departmentTypeId').append(html)
			$('#searchDepartmentTypeId').append(html)
			$('#editDepartmentTypeId').append(html)
		}else showFailure(res.message)
	},
	error:function(err){
		showFailure('服务端链接错误，请稍后再试！')
	}
})