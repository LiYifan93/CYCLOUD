$('.sure').hide()
$('#search').on('click',function(){
	//验证车牌号正则表达式
	var reg = /^[\u4E00-\u9FA5][\dA-Z]{6}$/;
		var data = $('#searchPlate').val()
		
		if(data = null){
			showFailure('请输入车牌号')
		}else{
			$.ajax({
				data:data,
				url:'',
				contentType:'json',
				type:'post',
				success:function(res){
					if(res.code == 1){
						console.log(res.data)
						$('#title').text('查询结果')
						$('#totalFee').val(res.data.totalFee)
						$('#inTime').val(res.data.inTime)
						$('#outTime').val(res.data.outTime)
						$('#status').val(res.data.status)
						$('#payType').val(res.data.payType)
						$('#remarks').val(res.data.remarks)
						$('.sure').show()
						$('.search').hide()
					}else{
						alert('服务端链接失败，请稍后再试！')
					}
					
				},
				error:function(err){
					alert('服务端链接失败，请稍后再试！')
				}
			})
		}						
})


function pay(){
	
}