 var div = '<div id="tip" style="font-size: 20px;position: absolute;left: 50%;top: 30%;text-align:center;font-weight: bold; z-index: 9999;min-width: 200px;"></div>'
 $('body').append(div)

 function showTip(tip, type) {
     var $tip = $('#tip');
     $tip.attr('class', 'alert alert-' + type).text(tip).css('margin-left', -$tip.outerWidth() / 2).fadeIn(500).delay(2000).fadeOut(500);
 }

 function showInfo(msg) {
     showTip(msg, 'info');
 }

 function showSuccess(msg) {
     showTip(msg, 'success');
 }

 function showFailure(msg) {
     showTip(msg, 'danger');
 }