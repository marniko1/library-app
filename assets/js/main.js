window.onload = function() {

	// makes ajax for pagination and filter
	var controller = window.location.href.split('/').reverse()[1];
	if (controller.match(/(\d+)/)) {
		controller = window.location.href.split('/').reverse()[2].slice(0, -1);
	}
	var filter = document.getElementById('filter');
	var pagination_links = document.querySelectorAll(".pagination li a");
	var ajax = new FilterAndPagination(filter, pagination_links, controller);
    // *************************************************************************************************
	// stylize forms on home page
    if (window.location.origin + window.location.pathname == root_url) {
    	// form validation
    	var frmvalidator = new Validator($('div.col-6.form-wrapper form'));

    	// add validation rules on fields
    	// add new_client fields validation rules
    	frmvalidator.addValidation('first_name', ['req', 'minLength=3', 'maxLength=20']);
    	frmvalidator.addValidation('last_name', ['req', 'minLength=3', 'maxLength=20']);
    	frmvalidator.addValidation('email', ['req', 'email']);
    	frmvalidator.addValidation('address', ['req', 'minLength=3', 'maxLength=20']);
    	// add new_book fields validation rules
    	frmvalidator.addValidation('title', ['req']);
    	frmvalidator.addValidation('price', ['req', 'positiveNum']);
    	frmvalidator.addValidation('stock', ['req', 'moreThenNull']);
    	frmvalidator.addValidation("genre[]", ['checkedOne']);
    	frmvalidator.addValidation('description', ['req']);
    	// add new_rental fields validation rules
    	frmvalidator.addValidation('client', ['req']);
    	frmvalidator.addValidation('title1', ['req']);

		new FormSubmit(frmvalidator);
		
		var first_input = document.querySelector('input');
		first_input.focus();
		jQuery('input, textarea').on('click', function(){
			// $('input, textarea').not($(this).parents('div.form-wrapper').find('input, textarea')).css('box-shadow', 'initial').css('border', '1px solid #ced4da');
			$('input, textarea, .checkbox-wrapper').not($(this).parents('div.form-wrapper').find('input, textarea, .checkbox-wrapper')).removeClass('err-border');
			// $('.checkbox-wrapper').not($(this).parents('form').find('.checkbox-wrapper')).css('box-shadow', 'none').css('border', 'none');
			$('span.val').not($(this).parents('div.form-wrapper').find('span.val')).remove();
			$('.checkbox-holder').addClass('d-none');
			$('div.form-wrapper').removeClass('col-6').addClass('col-3 opacity-5');
			$('div.form-wrapper .msg-span').contents().remove();
			$('div.form-wrapper .msg-span').removeClass('text-danger text-success');
			$('div.form-wrapper input').not(':input[type=submit], :input[type=checkbox]').not($(this).parents('div.form-wrapper').find('input')).val('');
			$('div.form-wrapper input.btn').prop('disabled', true);
			$('div.border').removeClass('border-primary').addClass('border-secondary');
			$(this).parents('div.form-wrapper').removeClass('col-3 opacity-5').addClass('col-6');
			$(this).parents('div.border').removeClass('border-secondary').addClass('border-primary');
			$(this).parents('div.form-wrapper').find('input.btn').removeAttr('disabled');
			$(this).parents('div.form-wrapper.col-6').find('.checkbox-holder').removeClass('d-none');
		});
    	// add new rental proposals filters
    	new ShowNewRentalProposals;
		// style for msg span
		var msg_span = $('div.form-wrapper span');
		if (msg_span) {
			if (msg_span.text() == "Success.") {
				msg_span.addClass('text-success');
			} else if (msg_span.text() == "Unsuccess.") {
				msg_span.addClass('text-danger');
			}
		}
	}
	// ***********************************************************************************************
	// if page url is single book view or single client view, only then prepare for edit button
	var url = window.location.origin + window.location.pathname;
	var url_part = url.replace(root_url, '').split('/');
	if ((url_part[0] == 'Clients' || url_part[0] == 'Books') && url_part[1].match(/^\d+$/)) {
		new Edit(url_part[0]);
	}
	// ***********************************************************************************************
	// if page is Admin
	if (url_part[0] == 'Admin') {
		console.log('admin page');
		new Edit(url_part[0]);
		var frmvalidator = new Validator($('form#new-user'));

		frmvalidator.addValidation('username', ['req', 'minLength=3', 'maxLength=20']);
    	frmvalidator.addValidation('full_name', ['req', 'minLength=6', 'maxLength=40']);
    	frmvalidator.addValidation('password', ['req', 'passConfirm=#co_password']);
    	frmvalidator.addValidation('co_password', ['req', 'passConfirm=#password']);

    	jQuery('.submit').on('click', function(e){
    		e.preventDefault();
    		if (frmvalidator.validation($('form#new-user'))) {
    			$('form#new-user').submit();
    		}
    	});
    	var msg_span = $('div.form-wrapper span');
    	if (msg_span.text() == "Success.") {
			msg_span.addClass('text-success');
		} else if (msg_span.text() == "Unsuccess.") {
			msg_span.addClass('text-danger');
		}
	}
}