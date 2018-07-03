<?php

class Home extends BaseController {
	public function index () {
		$this->data['title'] = 'Home';
		$this->data['genres'] = DBGenres::getAllGenres();
		$this->show_view('home');
	}
}