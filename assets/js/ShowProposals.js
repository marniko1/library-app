class ShowProposals {
	constructor(){
		this.hideOptionDiv();
		this.unhideOptionDiv();
	}
	unhideOptionDiv(){
		jQuery('.proposal-input').on('keyup',function(e){
			var self = this;
			var input_text = false;
			var proposals_div = $(this).parents('.form-group').find('.proposals');
			var filter_value = $(this).val().trim();
			var ul = $(this).parents('.form-group').find('.proposals ul');
			var label_text = $(e.target).parents('.form-group').find('label').text();
			var action = 'makeNewRental';
			if (label_text == 'Client: ') {
				var fn = 'Client';
			} else if (label_text == 'Writer: ' || $(this).attr('name') == 'writer'){
				var fn = 'Writer';
				action = 'makeNewBook';
			} else {
				var fn = 'Book';
			}
			
			setTimeout(function(){
				$.ajax({
					type: "POST",
					url: root_url + "AjaxCalls/index",
					data: "ajax_fn=" + action + fn + "Filter&search_value=" + filter_value,
					success: function(data){
						var response = JSON.parse(data);
						var div_html = '';
						if (label_text == 'Client: ') {
							$.each(response, function(i, val){
								div_html += `<li class="pl-1">${response[i].client} <i class="ml-5">stock ${response[i].stock}</i></li>`
							});
						} else if (label_text == 'Writer: ' || $(self).attr('name') == 'writer') {
							$.each(response, function(i, val){
								div_html += `<li class="pl-1">${response[i].writer}</li>`
							});
						} else {
							$.each(response, function(i, val){
								div_html += `<li class="pl-1">${response[i].title} <i class="ml-5">stock ${response[i].current_stock}</i></li>`
							});
						}
						// for validation make attr data-validate
						// ***************************************************
						$.each(response, function(key, value){
							if (value.writer == filter_value || value.title == filter_value || value.client == filter_value) {
								input_text = true;
							};
						});
						if (!input_text) {
							$(self).attr('data-validate', 'false');
						} else {
							$(self).attr('data-validate', 'true');
						}
						// ***************************************************
						$(ul).html(div_html);
						jQuery('.proposals li').on('click', function(e){
							console.log('kliknuo na li');
							var li_text = $(this).text();
							// removes <i>stock</i> from li text
							var text_to_remove = $(this).find('i').text();
							var text = li_text.replace(text_to_remove, '').trim();
							$(self).val(text);
							// set that input is valid
							$(self).attr('data-validate', 'true');
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
	// 	jQuery('.proposal-input').focusout(function(e){
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
			var li_text = $(e.target).text();
			console.log(li_text);
		});
	}
}