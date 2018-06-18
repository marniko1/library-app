<?php

class AjaxCalls extends BaseController {

	public $method;
	public $pg;
	public $id;
	public $skip;
	public $search_value;
	public $params = [];

	public function __construct () {
		$this->method = $_POST['ajax_fn'];
		if (isset($_POST['pg'])) {
			$this->pg = $_POST['pg'];
			$this->skip = $_POST['pg']*2-2;
		}
		if (isset($_POST['search_value'])) {
			$this->search_value = $_POST['search_value'];
		}
		if (isset($_POST['id'])) {
			$this->id = $_POST['id'];
		}
	}

	public function index () {
		$method = $this->method;
		$this->$method();
	}

	public function rentalsFilter () {
		$filtered_data = DBRentals::getFilteredRentals('client', $this->search_value, $this->skip);
		$total_rents_num = DBRentals::numberOfRowsInResult('client', $this->search_value);
		$pagination_data = $this->preparePaginationLinks($total_rents_num, $this->pg);
		$response = [$filtered_data, $pagination_data];
		echo json_encode($response);
	}

	public function booksFilter () {
		$filtered_data = DBBooks::getFilteredBooks('title', $this->search_value, $this->skip);
		$this->prepareShortenedbooksData($filtered_data);
		$total_rents_num = 0;
		if (isset($filtered_data[0]->total)) {
			$total_rents_num = $filtered_data[0]->total;
		}
		$pagination_data = $this->preparePaginationLinks($total_rents_num, $this->pg);
		$response = [$filtered_data, $pagination_data];
		echo json_encode($response);
	}

	public function bookFilter () {
		$filtered_data = DBBooks::getSingleBookRentals($this->id, $this->skip);
		$total_rents_num = $filtered_data[0]->rented;
		$pagination_data = $this->preparePaginationLinks($total_rents_num, $this->pg);
		$pagination_data[0][1] = "<";
		$pagination_data[count($pagination_data)-1][1] = ">";
		$response = [$filtered_data, $pagination_data];
		echo json_encode($response);
	}

	public function clientsFilter () {
		$filtered_data = DBClients::getFilteredClients('client', $this->search_value, $this->skip);
		$total_clients_num = 0;
		if (isset($filtered_data[0]->total)) {
			$total_clients_num = $filtered_data[0]->total;
		}
		$pagination_data = $this->preparePaginationLinks($total_clients_num, $this->pg);
		$response = [$filtered_data, $pagination_data, $total_clients_num];
		echo json_encode($response);
	}

	public function clientFilter () {
		$filtered_data = DBClients::getSingleClientRentals($this->id, $this->skip);
		$total_rents_num = $filtered_data[0]->rented;
		$pagination_data = $this->preparePaginationLinks($total_rents_num, $this->pg);
		$pagination_data[0][1] = "<";
		$pagination_data[count($pagination_data)-1][1] = ">";
		$response = [$filtered_data, $pagination_data];
		echo json_encode($response);
	}

	public function submitForm(){
		$controller = $_POST['controller'];
		$method = $_POST['method'];
		$this->params = json_decode($_POST['params']);
		// this is ajax == true
		$this->params[] = true;
		include_once "controller/" . $controller . ".php";
		$controller = new $controller;
		$response = call_user_func_array([$controller, $method], $this->params);
		echo json_encode($response);
	}

	public function makeNewRentalClientFilter() {
		$response = DBClients::getFilteredClientsForNewRent($this->search_value);
		echo json_encode($response);
	}

	public function makeNewRentalbookFilter() {
		$response = DBBooks::getFilteredBooksForNewRent($this->search_value);
		echo json_encode($response);
	}

	public function prepareShortenedbooksData ($data_array) {
		include_once 'controller/Books.php';
		$c = new Books();
		$c->prepareShortenedData($data_array);
	}
}