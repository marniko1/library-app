class ShowNewRentalProposals {
	constructor(){
		this.hideOptionDiv();
		this.unhideOptionDiv();
	}
	unhideOptionDiv(){
		jQuery('.new-rent-input').on('keyup',function(e){
			var self = this;
			var proposals_div = $(this).parents('.form-group').find('.proposals');
			var filter_value = $(this).val().trim();
			var ul = $(this).parents('.form-group').find('.proposals ul');
			var label_text = $(e.target).parents('.form-group').find('label').text();
			if (label_text == 'Client: ') {
				var fn = 'Client';
			} else {
				var fn = 'book';
			}
			setTimeout(function(){
				$.ajax({
					type: "POST",
					url: root_url + "AjaxCalls/index",
					data: "ajax_fn=makeNewRental" + fn + "Filter&search_value=" + filter_value,
					success: function(data){
						var response = JSON.parse(data);
						var div_html = '';
						if (label_text == 'Client: ') {
							$.each(response, function(i, val){
								div_html += `<li class="pl-1">${response[i].client} <i class="ml-5">stock ${response[i].stock}</i></li>`
							});
						} else {
							$.each(response, function(i, val){
								div_html += `<li class="pl-1">${response[i].title} <i class="ml-5">stock ${response[i].current_stock}</i></li>`
							});
						}
						$(ul).html(div_html);
						jQuery('.proposals li').on('click', function(e){
							var li_text = $(this).text();
							var text_to_remove = ' ' + $(this).find('i').text();
							var text = li_text.replace(text_to_remove, '').trim();
							$(self).val(text);
							$(this).parents('.mt-5').find('.proposals').addClass('d-none');
						});
					},
					error: function(XMLHttpRequest, textStatus, errorThrown) {
				     	alert("some error"+errorThrown);
				 	}
				});
			},1000);
			$(this).parents('.form-group').find('.proposals').removeClass('d-none');
		});
	}
	// hideOptionDiv() {
	// 	jQuery('.new-rent-input').focusout(function(e){
	// 		setTimeout(function(){
	// 			$(e.target).parents('.mt-5').find('.proposals').addClass('d-none');
	// 		}, 300);
	// 	});
	// }
	hideOptionDiv() {
		jQuery('html').on('click', function(e){
				var div = $(e.target).parents('.form-group').find('.proposals');
				if (div.length !== 0) {
					$(e.target).parents('.mt-5').find('.proposals').not(div).addClass('d-none');
				} else {
					$('.proposals').addClass('d-none');
				}
		});
	}
	takeLiValueInInput() {
		jQuery('.proposal li').on('click', function(e){
			console.log(this);
			var li_text = $(e.target).text();
			console.log(li_text);
		});
	}
}