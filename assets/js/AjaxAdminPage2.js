class AdminPageNumTwo {
	constructor(){
		this.openPage();
	}
	openPage(){
		jQuery('#page_2_link').on('click', function(e){
			e.preventDefault();
			$.ajax({
				type: "POST",
				url: root_url + "AjaxCalls/index",
				data: "ajax_fn=showAdminPageNumTwo",
				success: function(data){
					console.log(data);
					// var response = JSON.parse(data);
					$("html").html(data);
					// console.log(response);
					// var keys = Object.keys(response);
					// if (keys[0].match(/^msg\d$/)) {
					// 	$(self).parents('div.form-wrapper').find('span.msg-span').text(response[keys[0]]);
					// 	var msg_span = $('div.form-wrapper span');
					// 	if (msg_span.text() == "Success.") {
					// 		$(self).parents('div.form-wrapper').find('input').not(':input[type=submit]').val('');
					// 		$(self).parents('div.form-wrapper').find('textarea').val('');
					// 		$('input:checked').prop('checked', false);
					// 		msg_span.addClass('text-success');
					// 	} else {
					// 		msg_span.addClass('text-danger');
					// 	}
					// } else if (keys[0].match(/^unav_book_msg\d$/)){
					// 	$.each(response, function(key, value){
					// 		var key_num = key.replace('unav_book_msg', '');
					// 		$('#title' + key_num).addClass('err-border');
					// 		$('#title' + key_num).after('<span class="val text-danger position-absolute"><small>'+value+'</small></span>');
					// 	});
					// }
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
			     	alert("some error"+errorThrown);
			 	}
			});
		});
	}
}