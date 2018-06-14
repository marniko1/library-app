<?php

class Books extends BaseController {
	public function index ($pg=0) {
		$skip = 0;
		if ($pg !== 0) {
			$pg = substr($pg, 1);
			$skip = $pg*2-2;
		}
		$this->data['title'] = 'Books';
		$this->data['books'] = DBBooks::getAllBooks($skip);
		$this->prepareShortenedData($this->data['books']);
		$total_books_num = $this->data['books'][0]->total;
		$this->data['pagination_links'] = $this->preparePaginationLinks($total_books_num, $pg);
		$this->show_view('books');
	}
	public function singleBook($id, $pg=0) {
		$skip = 0;
		if ($pg !== 0) {
			$pg = substr($pg, 1);
			$skip = $pg*2-2;
		}
		$this->data['book'] = DBBooks::getSingleBook($id, $skip);
		$this->data['title'] = $this->data['book'][0]->title;
		$total_books_num = $this->data['book'][0]->rented;
		$this->data['pagination_links'] = $this->preparePaginationLinks($total_books_num, $pg);
		$this->data['pagination_links'] = $this->changePrevNext($this->data['pagination_links']);
		$this->show_view('book');
	}
	public function prepareShortenedData($data_array) {
		foreach ($data_array as $key => $value) {
			$desc = substr($value->description, 0, 45).'... ';
			$data_array[$key]->description = $desc;
			if (strpos($value->genre, ',') !== false) {
				$long_genre = $value->genre;
				$desc = substr($value->genre, 0, strpos($value->genre, ',')+1).'... ';
				$data_array[$key]->genre = $desc;
				$data_array[$key]->long_genre = $long_genre;
			} else {
				$data_array[$key]->long_genre = $data_array[$key]->genre;
			}
		}
	}
	public function addNewBook($title, $price, $stock, $description, $genre, $is_ajax = false) {
		$req = DBBooks::insertBookIntoDB($title, $description, $genre, $price, $stock);
		if ($req) {
		// if (true) {
			Msg::createMessage("msg2", "Success.");
		} else {
			Msg::createMessage("msg2", "Unsuccess.");
		}
		if(!$is_ajax) {
			header("Location: ".INCL_PATH);
		} else {
			// var_dump($genre);
			return Msg::getMessage();
			// return $genre;
		}
	}
	public function editBookData($title, $description, $genre, $price, $cur_stock, $stock, $id) {
		DBBooks::editBook($title, $description, $genre, $price, $cur_stock, $stock, $id);
		header("Location: ".INCL_PATH.'books/'.$id.'/p1');
	}
	public function removeBook($id) {
		DBBooks::removeBook($id);
		header("Location: ".INCL_PATH.'books/index');
	}
}