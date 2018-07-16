<?php

class Books extends BaseController {
	public function index ($pg=0) {
		$skip = 0;
		if ($pg !== 0) {
			$pg = substr($pg, 1);
			$skip = $pg*PG_RESULTS-PG_RESULTS;
		}
		$this->data['title'] = 'Books';
		$this->data['books'] = DBBooks::getAllBooks($skip);
		$this->prepareGenres();
		$this->prepareShortenedBookData($this->data['books']);
		$total_books_num = $this->data['books'][0]->total;
		$this->data['pagination_links'] = $this->preparePaginationLinks($total_books_num, $pg);
		$this->show_view('books');
	}
	public function singleBook($id, $pg=0) {
		$skip = 0;
		if ($pg !== 0) {
			$pg = substr($pg, 1);
			$skip = $pg*PG_RESULTS-PG_RESULTS;
		}
		$this->data['book'] = DBBooks::getSingleBook($id, $skip);
		$this->prepareSingleBookGenres($id);
		$this->data['title'] = $this->data['book'][0]->title;
		$total_books_num = $this->data['book'][0]->rented;
		$this->data['pagination_links'] = $this->preparePaginationLinks($total_books_num, $pg);
		$this->data['pagination_links'] = $this->changePrevNext($this->data['pagination_links']);
		$this->show_view('book');
	}
	public function addNewBook($title, $writer, $stock, $description, $genres, $is_ajax = false) {
 		$genres_arr = explode(',', $genres);
 		$genre1 = $genres_arr[0];
 		$genre2 = 0;
 		$genre3 = 0;
 		if (isset($genres_arr[1])) {
 			$genre2 = $genres_arr[1];
 		}
 		if (isset($genres_arr[2])) {
 			$genre3 = $genres_arr[2];
 		}
		$req = DBBooks::insertBookIntoDB($title, $description, $writer, $stock, $genre1, $genre2, $genre3);
		if ($req) {
		// if (true) {
			Msg::createMessage("msg2", "Success.");
		} else {
			Msg::createMessage("msg2", "Unsuccess.");
		}
		if(!$is_ajax) {
			header("Location: ".INCL_PATH);
		} else {
			return Msg::getMessage();
		}
	}
	public function editBookData($title, $description, $genre, $writer, $cur_stock, $stock, $id) {
		$genre1 = $genre[0];
 		$genre2 = 0;
 		$genre3 = 0;
 		if (isset($genre[1])) {
 			$genre2 = $genre[1];
 		}
 		if (isset($genre[2])) {
 			$genre3 = $genre[2];
 		}
		DBBooks::editBook(addslashes($title), addslashes($description), $genre1, $genre2, $genre3, addslashes($writer), $cur_stock, $stock, $id);
		header("Location: ".INCL_PATH.'Books/'.$id.'/p1');
	}
	public function removeBook($id) {
		$book_had_been_rented = DBBooks::checkIfBookHadBeenRented($id);
		try {
			if ($book_had_been_rented) {
				throw new Exception();
			}
			DBBooks::removeBook($id);
		} catch (Exception $e) {
			DBBooks::makeBookInactive($id);
		}
		header("Location: ".INCL_PATH.'Books/index');
	}
	public function prepareGenres() {
		$ids = '';
		foreach ($this->data['books'] as $book) {
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
			foreach ($this->data['books'] as $k => $book_data) {
				if ($book_data->id == $key) {
					$this->data['books'][$k]->genre = $book_genres;
				}
			}
		}
	}
	public function prepareSingleBookGenres($id) {
		$data = DBBooks::getGenres($id);
		$this->data['book'][0]->genre = '';
		foreach ($data as $value) {
			$this->data['book'][0]->genre .= $value->title . ', ';
		}
		$this->data['book'][0]->genre = rtrim($this->data['book'][0]->genre, ', ');
	}
}