<?php

class Home extends BaseController {
	public function index () {
		$this->data['title'] = 'Home';
		$this->show_view('home');
	}
}