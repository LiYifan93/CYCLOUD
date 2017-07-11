<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>echart</title>
<link rel="stylesheet"
	href="${contextPath}/jsp/libs/bootstrap/css/bootstrap.css">
</head>

<body>

	<nav class="navbar navbar-brand navbar-fixed-top "
		style="background-color: white">
		<section class="content-header ">
			<ol class="breadcrumb " style="background: white; font-size: 15px;">
				<li><a><i class="fa fa-dashboard "></i> 当前位置</a></li>
				<li><a>统计图</a></li>
			</ol>
		</section>

	</nav>
	
	<div>
		<div class="col-md-8 col-md-offset-4">
			<form id="departmentMessage" style="margin-top:87px; margin-bottom:20px">
			    <label for="status">状态</label>
			    <select class="form-control"  style="display:inline;width:auto;padding-right:12%" disabled name="status" id="status">
			    	<option value="0">正常</option>
			    	<option value="1">异常</option>
			    	<option value="2">未知</option>
			    </select>
			    <label for="restLot">剩余车位(位)</label>
			    <input type="number"   class="form-control" style="display:inline;width:auto;" disabled  name="restLot" id="restLot" >
			  <button type="submit" class="btn btn-default">刷新</button>
			</form>
		</div>
	</div> 

	<div class="row" >
		<div class="col-md-6">
			<div style="text-align: center; margin-bottom: 10px">
				<input type="button" id="parkToday" class="btn btn-default btn-sm"
					value="今天"> <input type="button" id="parkPreSeven"
					class="btn btn-default btn-sm" value="最近七天"> <input
					type="button" id="parkMonth" class="btn btn-default btn-sm"
					value="本月">
			</div>

			<div id="park" style="height: 300px;margin-top:10px "></div>
		</div>
		<div class="col-md-6">
			<div style="text-align: center; margin-bottom: 10px">
				<input type="button" id="feeToday" class="btn btn-default btn-sm"
					value="今天"> <input type="button" id="feePreSeven"
					class="btn btn-default btn-sm" value="最近七天"> <input
					type="button" id="feeMonth" class="btn btn-default btn-sm"
					value="本月">
			</div>

			<div id="fee" style="height: 300px"></div>

		</div>
	</div>

	<div class="row">
		<div class="col-md-6">
			<div style="text-align: center; margin-bottom: 10px">
				<input type="button" id="monthCardToday"
					class="btn btn-default btn-sm" value="今天"> <input
					type="button" id="monthCardPreSeven" class="btn btn-default btn-sm"
					value="最近七天"> <input type="button" id="monthCardMonth"
					class="btn btn-default btn-sm" value="本月">
			</div>

			<div id="monthCard" style="height: 300px"></div>
		</div>

		<div class="col-md-6">
			<div style="text-align: center; margin-bottom: 10px">
				<input type="button" id="feeTypeToday"
					class="btn btn-default btn-sm" value="今天"> <input
					type="button" id="feeTypePreSeven" class="btn btn-default btn-sm"
					value="最近七天"> <input type="button" id="feeTypeMonth"
					class="btn btn-default btn-sm" value="本月">
			</div>

			<div id="feeType" style="height: 300px"></div>
		</div>

	</div>


	<script src="${contextPath}/jsp/libs/jquery/jquery.js"></script>
	<script src="${contextPath}/jsp/libs/bootstrap/js/bootstrap.js"></script>
	<script src="${contextPath}/jsp/libs/echarts.min.js"></script>
	<script src="${contextPath}/jsp/libs/modal.js"></script>
	<script>
		var url = location.href
		var departmentId = url.split('?')[1]
		
		//获取停车场状态信息
		$.ajax({
			url:'${contextPath}/web/overview/information',
			data : departmentId,
			dataType:'json',
			type:'post',
			success:function(res){
				if(res.code == 1){
					$('#restLot').val(res.data.restLot)
					$('#status').val(res.data.status)
					
				} else showFailure(res.message)
			},
			error:function(err){
				showFailure('停车场信息获取失败 ，请稍后再试！')
			}
		})
		
		//刷新重新获取数据
		$('#departmentMessage').on('submit',function(ev){
			ev.preventDefault()
			$.ajax({
				url:'${contextPath}/web/overview/information',
				data : departmentId,
				dataType:'json',
				type:'post',
				success:function(res){
					if(res.code == 1){
						showSuccess(res.message)
						$('#status').val(res.data[0].status)
						$('#plate').val(res.data[0].plate)
					} else if(res.code == -1){
						showFailure(res.message)
					} 
				},
				error:function(err){
					showFailure('停车场信息获取失败 ，请稍后再试！')
				}
			})
		})
		
		
		

		//折线图参数设置
		var option = {
			title : {
				text : '车辆在场数量'
			},
			tooltip : {
				trigger : 'axis',
				formatter : '时间：{b}<br>数量：{c}'
			},

			toolbox : {
				iconStyle : {
					normal : {
						textPosition : 'top'
					}
				},
				show : true,
				feature : {
					mark : {
						show : true
					},
					dataView : {
						show : true,
						readOnly : false
					},
					magicType : {
						show : true,
						type : [ 'line', 'bar' ]
					},
					restore : {
						show : true
					},
					saveAsImage : {
						show : true
					}
				}
			},
			legend : {
				data : [ '销量' ]
			},
			dataZoom : [ {
				show : true,
				realtime : true,
				start : 0,
				end : 40
			}, {
				type : 'inside',
				realtime : true,
				start : 65,
				end : 85
			} ],
			xAxis : {
				data : [],
				"axisLabel" : {
					interval : 0
				}
			},
			yAxis : {},
			series : [ {
				name : '销量',
				type : 'line',
				data : []
			} ]
		}

		/*--------------------------------  */
		//车辆在场数量		
		var park = echarts.init(document.getElementById('park'));
		park.setOption(option)
		function onClick(url, title) {
			$.ajax({
				type : 'POST',
				data : departmentId,
				dataType : 'json',
				url : url,
				success : function(res) {
					if (res.code == 1) {
						var data = {}
						data.name = []
						data.value = []
						for (var i = 0; i < res.data.length; i++) {
							data.name.push(res.data[i].label)
							data.value.push(res.data[i].value)
						}
						park.setOption({
							xAxis : {
								data : data.name
							},
							series : [ {
								name : '销量',
								data : data.value
							} ],
							title : {
								text : title
							},

						})
						window.onresize = park.resize;
					}else showFailure(res.message)
				},
				error : function(err) {
					showFailure('服务端链接错误，请稍后再试！')
				}
			})
		}
		$('#parkToday').click(function() {
			$('#parkToday').css({
				"color" : "#fff",
				"background" : "#3C8DBC"
			})
			$('#parkMonth').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			$('#parkPreSeven').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			url = '${contextPath}/web/overview/vehicleIn?type=0'
			title = '车辆在场数量'
			onClick(url, title)
		})
		$('#parkMonth').click(function() {
			$('#parkToday').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			$('#parkMonth').css({
				"color" : "#fff",
				"background" : "#3C8DBC"
			})
			$('#parkPreSeven').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			url = '${contextPath}/web/overview/vehicleIn?type=2'
			title = '车辆在场数量'
			onClick(url, title)
		})
		$('#parkPreSeven').click(function() {
			$('#parkToday').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			$('#parkPreSeven').css({
				"color" : "#fff",
				"background" : "#3C8DBC"
			})
			$('#parkMonth').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			url = '${contextPath}/web/overview/vehicleIn?type=1'
			title = '车辆在场数量'
			onClick(url, title)
		})

		/* -------------------------- */
		//收费金额统计
		var fee = echarts.init(document.getElementById('fee'));
		fee.setOption(option)
		function feeOnClick(feeUrl, feeTitle) {
			$.ajax({
				type : 'POST',
				data : departmentId,
				dataType : 'json',
				url : feeUrl,
				success : function(res) {
					if (res.code == 1) {
						var data = {}
						data.name = []
						data.value = []
						for (var i = 0; i < res.data.length; i++) {
							data.name.push(res.data[i].label)
							data.value.push(res.data[i].value)
						}
						fee.setOption({
							xAxis : {
								data : data.name
							},
							series : [ {
								name : '销量',
								data : data.value
							} ],
							title : {
								text : feeTitle
							},

						})
						window.onresize = fee.resize;
					}else  showFailure(res.message)
				},
				error : function(res) {
					showFailure('服务端链接错误，请稍后再试！')
				}
			})
		}
		$('#feeToday').click(function() {
			$('#feeToday').css({
				"color" : "#fff",
				"background" : "#3C8DBC"
			})
			$('#feeMonth').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			$('#feePreSeven').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			feeUrl = '${contextPath}/web/overview/feeCount?type=0'
			feeTitle = '收费金额统计'
			feeOnClick(feeUrl, feeTitle)
		})

		$('#feeMonth').click(function() {
			$('#feeToday').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			$('#feeMonth').css({
				"color" : "#fff",
				"background" : "#3C8DBC"
			})
			$('#feePreSeven').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			feeUrl = '${contextPath}/web/overview/feeCount?type=2'
			feeTitle = '收费金额统计'
			feeOnClick(feeUrl, feeTitle)
		})

		$('#feePreSeven').click(function() {
			$('#feeToday').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			$('#feePreSeven').css({
				"color" : "#fff",
				"background" : "#3C8DBC"
			})
			$('#feeMonth').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			feeUrl = '${contextPath}/web/overview/feeCount?type=1'
			feeTitle = '收费金额统计'
			feeOnClick(feeUrl, feeTitle)
		})
		/* --------------------------------------------------------------- */

		//收费金额统计
		var monthCard = echarts.init(document.getElementById('monthCard'));
		monthCard.setOption(option)
		function monthCardOnClick(monthCardUrl, monthCardTitle) {
			$.ajax({
				type : 'POST',
				data : departmentId,
				dataType : 'json',
				url : monthCardUrl,
				success : function(res) {
					if (res.code == 1) {
						var data = {}
						data.name = []
						data.value = []
						for (var i = 0; i < res.data.length; i++) {
							data.name.push(res.data[i].label)
							data.value.push(res.data[i].value)
						}
						monthCard.setOption({
							xAxis : {
								data : data.name
							},
							series : [ {
								name : '销量',
								data : data.value
							} ],
							title : {
								text : monthCardTitle
							},

						})
						window.onresize = monthCard.resize;
					}else showFailure(res.message)
				},
				error : function(err) {
					showFailure('服务端链接错误，请稍后再试！')
				}
			})
		}
		$('#monthCardToday').click(function() {
			$('#monthCardToday').css({
				"color" : "#fff",
				"background" : "#3C8DBC"
			})
			$('#monthCardMonth').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			$('#monthCardPreSeven').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			monthCardUrl = '${contextPath}/web/overview/monthCardCount?type=0'
			monthCardTitle = '月卡收费金额统计'
			monthCardOnClick(monthCardUrl, monthCardTitle)
		})

		$('#monthCardMonth').click(function() {
			$('#monthCardToday').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			$('#monthCardMonth').css({
				"color" : "#fff",
				"background" : "#3C8DBC"
			})
			$('#monthCardPreSeven').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			monthCardUrl = '${contextPath}/web/overview/monthCardCount?type=2'
			monthCardTitle = '月卡收费金额统计'
			monthCardOnClick(monthCardUrl, monthCardTitle)
		})

		$('#monthCardPreSeven').click(function() {
			$('#monthCardToday').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			$('#monthCardPreSeven').css({
				"color" : "#fff",
				"background" : "#3C8DBC"
			})
			$('#monthCardMonth').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			monthCardUrl = '${contextPath}/web/overview/monthCardCount?type=1'
			monthCardTitle = '月卡收费金额统计'
			monthCardOnClick(monthCardUrl, monthCardTitle)
		})

		/* ----------------支付方式统计----------------------- */
		var pieOption = {

			tooltip : {
				trigger : 'item',
				formatter : ' 名称：{b}<br>次数：{c}<br>百分比：{d}%'
			},

			toolbox : {
				show : true,
				feature : {
					mark : {
						show : true
					},
					dataView : {
						show : true,
						readOnly : false
					},

					restore : {
						show : true
					},
					saveAsImage : {
						show : true
					}
				}
			}
		}

		var feeType = echarts.init(document.getElementById('feeType'));
		feeType.setOption(pieOption)
		function feeTypeOnClick(feeTypeUrl, feeTypeTitle) {
			$.ajax({
				type : 'POST',
				data : departmentId,
				dataType : 'json',
				url : feeTypeUrl,
				success : function(res) {
					if (res.code == 1) {
						var data = {}
						data.name = []
						data.value = []
						for (var i = 0; i < res.data.length; i++) {
							data.name.push(res.data[i].name)
							data.value.push(res.data[i].value)
						}
						feeType.setOption({
							title : {
								text : feeTypeTitle,
								x : 'center'
							},
							legend : {
								orient : 'vertical',
								left : 'left',
								data : data.name
							},
							series : [ {
								name : '访问来源',
								type : 'pie',
								radius : [ 0, '30%' ],
								center : [ '50%', '60%' ],
								data : res.data,
								itemStyle : {
									emphasis : {
										shadowBlur : 10,
										shadowOffsetX : 0,
										shadowColor : 'rgba(0, 0, 0, 0.5)'
									}
								}
							} ]

						})
						window.onresize = feeType.resize;
					} else showFailure(res.message)
				},
				error : function(err) {
					showFailure('服务端链接错误，请稍后再试！')
				}
			})
		}

		$('#feeTypeToday').click(function() {
			$('#feeTypeToday').css({
				"color" : "#fff",
				"background" : "#3C8DBC"
			})
			$('#feeTypeMonth').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			$('#feeTypePreSeven').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			feeTypeUrl = '${contextPath}/web/overview/feeType?type=0'
			feeTypeTitle = '支付方式统计'
			feeTypeOnClick(feeTypeUrl, feeTypeTitle)
		})

		$('#feeTypeMonth').click(function() {
			$('#feeTypeToday').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			$('#feeTypeMonth').css({
				"color" : "#fff",
				"background" : "#3C8DBC"
			})
			$('#feeTypePreSeven').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			feeTypeUrl = '${contextPath}/web/overview/feeType?type=2'
			feeTypeTitle = '支付方式统计'
			feeTypeOnClick(feeTypeUrl, feeTypeTitle)
		})

		$('#feeTypePreSeven').click(function() {
			$('#feeTypeToday').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			$('#feeTypePreSeven').css({
				"color" : "#fff",
				"background" : "#3C8DBC"
			})
			$('#feeTypeMonth').css({
				"color" : "#3C8DBC",
				"background" : "#fff"
			})
			feeTypeUrl = '${contextPath}/web/overview/feeType?type=1'
			feeTypeTitle = '支付方式统计'
			feeTypeOnClick(feeTypeUrl, feeTypeTitle)
		})

		window.onload = function() {
			$('#parkToday').css({
				"color" : "#fff",
				"background" : "#3C8DBC"
			})
			url = '${contextPath}/web/overview/vehicleIn?type=0'
			title = '车辆在场数量'
			onClick(url, title)

			$('#feeToday').css({
				"color" : "#fff",
				"background" : "#3C8DBC"
			})
			feeUrl = '${contextPath}/web/overview/feeCount?type=0'
			feeTitle = '收费金额统计'
			feeOnClick(feeUrl, feeTitle)

			$('#monthCardToday').css({
				"color" : "#fff",
				"background" : "#3C8DBC"
			})
			monthCardUrl = '${contextPath}/web/overview/monthCardCount?type=0'
			monthCardTitle = '月卡收费金额统计'
			monthCardOnClick(monthCardUrl, monthCardTitle)

			$('#feeTypeToday').css({
				"color" : "#fff",
				"background" : "#3C8DBC"
			})
			feeTypeUrl = '${contextPath}/web/overview/feeType?type=0'
			feeTypeTitle = '支付方式统计'
			feeTypeOnClick(feeTypeUrl, feeTypeTitle)
		}
	</script>
</body>

</html>