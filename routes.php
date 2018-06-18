<?php


if (Auth::logged()) {
	
	Route::get('/', 'Home@index');

	Route::get('/Rentals/index', 'Rentals@index');
	Route::get('/Rentals/{id}', 'Rentals@singleRental', $req = ['/^\d+$/']);
	Route::get('/Rentals/{page}', 'Rentals@index', $req = ['/^p\d+$/']);
	Route::post('/Rentals/addNewRental', 'Rentals@addNewRental');
	Route::post('/Rentals/closeRental', 'Rentals@closeRental');

	Route::get('/Books/index', 'Books@index');
	Route::get('/Books/{id}/{page}', 'Books@singleBook', $req = ['/^\d+$/', '/^p\d+$/']);
	Route::get('/Books/{page}', 'Books@index', $req = ['/^p\d+$/']);
	Route::post('/Books/addNewBook', 'Books@addNewBook');
	Route::post('/Books/editBookData', 'Books@editBookData');
	Route::post('/Books/removeBook', 'Books@removeBook');

	Route::get('/Clients/index', 'Clients@index');
	Route::get('/Clients/{id}/{page}', 'Clients@singleClient', $req = ['/^\d+$/', '/^p\d+$/']);
	Route::get('/Clients/{page}', 'Clients@index', $req = ['/^p\d+$/']);
	Route::post('/Clients/addNewClient', 'Clients@addNewClient');
	Route::post('/Clients/editClientData', 'Clients@editClientData');
	Route::post('/Clients/removeClient', 'Clients@removeClient');

	Route::get('/Admin/index', 'Admin@index');
	Route::get('/Admin/panel', 'Admin@showPageNumTwo');
	Route::post('/Admin/addNewUser', 'Admin@addNewUser');
	Route::post('/Admin/editUserData', 'Admin@editUserData');
	Route::post('/Admin/removeUser', 'Admin@removeUser');
	Route::post('/Admin/addNewWriter', 'Admin@addNewWriter');
	// Route::post('/Admin/addNewUser', 'Admin@addNewUser');

	Route::get('/AjaxCalls/index', 'AjaxCalls@index');

	Route::post('/Login/logoutUser', 'Login@logoutUser');

	Route::redirect('Error404@index');
} else {
	Route::post('/Login/loginUser', 'Login@loginUser');
	Route::redirect('Login@index');
}