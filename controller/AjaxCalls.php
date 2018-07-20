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
			$this->skip = $_POST['pg']*PG_RESULTS-PG_RESULTS;
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
		$response = [$filtered_data, $pagination_data, $this->skip];
		echo json_encode($response);
	}

	public function booksFilter () {
		$filtered_data = DBBooks::getFilteredBooks('title', $this->search_value, $this->skip);
		// var_dump($filtered_data);
		if (!empty($filtered_data)) {
			$filtered_data = $this->prepareBooksGenres($filtered_data);
			$filtered_data = $this->changePropPlaces($filtered_data);
		}
		$this->prepareShortenedBookData($filtered_data);
		$total_rents_num = 0;
		if (isset($filtered_data[0]->total)) {
			$total_rents_num = $filtered_data[0]->total;
		}
		$pagination_data = $this->preparePaginationLinks($total_rents_num, $this->pg);
		$response = [$filtered_data, $pagination_data, $this->skip];
		echo json_encode($response);
	}

	public function bookFilter () {
		$filtered_data = DBBooks::getSingleBookRentals($this->id, $this->skip);
		$total_rents_num = $filtered_data[0]->rented;
		$pagination_data = $this->preparePaginationLinks($total_rents_num, $this->pg);
		$pagination_data[1][1] = "<";
		$pagination_data[count($pagination_data)-2][1] = ">";
		$response = [$filtered_data, $pagination_data, $this->skip];
		echo json_encode($response);
	}

	public function writersFilter () {
		$filtered_data = DBWriters::getFilteredWriters('writer', $this->search_value, $this->skip);
		$total_writers_num = 0;
		if (isset($filtered_data[0]->total)) {
			$total_writers_num = $filtered_data[0]->total;
		}
		$pagination_data = $this->preparePaginationLinks($total_writers_num, $this->pg);
		$response = [$filtered_data, $pagination_data, $this->skip];
		echo json_encode($response);
	}

	public function writerFilter () {
		$filtered_data = DBWriters::getSingleWriterBooks($this->id, $this->skip);
		$filtered_data = $this->prepareBooksGenres($filtered_data);
		$this->prepareShortenedBookData($filtered_data);
		$filtered_data = $this->changePropPlaces($filtered_data);
		$total_books_num = $filtered_data[0]->total;
		$pagination_data = $this->preparePaginationLinks($total_books_num, $this->pg);
		$pagination_data[1][1] = "<";
		$pagination_data[count($pagination_data)-2][1] = ">";
		$response = [$filtered_data, $pagination_data, $this->skip];
		echo json_encode($response);
	}

	public function clientsFilter () {
		$filtered_data = DBClients::getFilteredClients('client', $this->search_value, $this->skip);
		$total_clients_num = 0;
		if (isset($filtered_data[0]->total)) {
			$total_clients_num = $filtered_data[0]->total;
		}
		$pagination_data = $this->preparePaginationLinks($total_clients_num, $this->pg);
		$response = [$filtered_data, $pagination_data, $this->skip, $total_clients_num];
		echo json_encode($response);
	}

	public function clientFilter () {
		$filtered_data = DBClients::getSingleClientRentals($this->id, $this->skip);
		$total_rents_num = $filtered_data[0]->rented;
		$pagination_data = $this->preparePaginationLinks($total_rents_num, $this->pg);
		$pagination_data[1][1] = "<";
		$pagination_data[count($pagination_data)-2][1] = ">";
		$response = [$filtered_data, $pagination_data, $this->skip];
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

	public function makeNewRentalBookFilter() {
		$response = DBBooks::getFilteredBooksForNewRent($this->search_value);
		echo json_encode($response);
	}

	public function makeNewBookWriterFilter() {
		$response = DBWriters::getFilteredWritersForNewBook($this->search_value);
		echo json_encode($response);
	}

	public function prepareBooksGenres($filtered_data) {
		$ids = '';
		foreach ($filtered_data as $book) {
			$ids .= $book->id . ', ';
		}
		$ids = rtrim($ids, ', ');
		$data = DBBooks::getGenres($ids);
		$books_genres = [];
		foreach ($data as $value) {
			if (isset($books_genres[$value->book_id])) {
				$books_genres[$value->book_id] = $books_genres[$value->book_id] . ', ' . $value->title;
			} else {
				$books_genres[$value->book_id] = $value->title;
			}
		}
		foreach ($books_genres as $key => $book_genres) {
			foreach ($filtered_data as $k => $book_data) {
				if ($book_data->id == $key) {
					$filtered_data[$k]->genre = $book_genres;
				}
			}
		}
		return $filtered_data;
	}
	// move property genre just after prop description, need order like that in ajax response
	public function changePropPlaces($filtered_data){
		foreach ($filtered_data as $key => $value) {
			$tmp_obj = new stdClass();
			$tmp_obj->id = $value->id;
			$tmp_obj->title = $value->title;
			$tmp_obj->description = $value->description;
			$tmp_obj->genre = $value->genre;
			if (isset($value->writer)) {
				$tmp_obj->writer = $value->writer;
			}
			$tmp_obj->current_stock = $value->current_stock;
			$tmp_obj->stock = $value->stock;
			$tmp_obj->total = $value->total;
			$filtered_data[$key] = $tmp_obj;
		}
		return $filtered_data;
	}
	public function getAllGenres() {
		echo json_encode(DBGenres::getAllGenres());
	}
}