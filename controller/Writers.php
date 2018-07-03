<?php

class Writers extends BaseController {
	public function index ($pg=0) {
		$skip = 0;
		if ($pg !== 0) {
			$pg = substr($pg, 1);
			$skip = $pg*PG_RESULTS-PG_RESULTS;
		}
		$this->data['title'] = 'Writers';
		$this->data['writers'] = DBWriters::getAllWriters($skip);
		$this->data['pagination_links'] = $this->preparePaginationLinks($this->data['writers'][0]->total, $pg);
		$this->show_view('writers');
	}
	public function singleWriter($id, $pg=0) {
		$skip = 0;
		if ($pg !== 0) {
			$pg = substr($pg, 1);
			$skip = $pg*PG_RESULTS-PG_RESULTS;
		}
		$this->data['writer'] = DBWriters::getSingleWriter($id, $skip);
		$this->data['title'] = $this->data['writer'][0]->writer;
		$ids = $this->prepareIDSGroup($this->data['writer']);
		if (isset($this->data['writer'][0]->id)) {
			$this->data['genres'] = DBBooks::getGenres($ids);
			$this->data['genres'] = $this->prepareBooksGenres($this->data['genres']);
			$this->prepareShortenedBookData($this->data['writer']);
		}
		$total_books_num = $this->data['writer'][0]->total_books_written;
		$this->data['pagination_links'] = $this->preparePaginationLinks($total_books_num, $pg);
		$this->data['pagination_links'] = $this->changePrevNext($this->data['pagination_links']);
		$this->show_view('writer');
	}
	public function prepareIDSGroup($data) {
		$ids = '';
		foreach ($data as $book) {
			$ids .= $book->id . ', ';
		}
		return rtrim($ids, ', ');
	}
	public function prepareBooksGenres($data) {
		$books_genres = [];
		foreach ($data as $value) {
			if (isset($books_genres[$value->book_id])) {
				$books_genres[$value->book_id] = $books_genres[$value->book_id] . ', ' . $value->title;
			} else {
				$books_genres[$value->book_id] = $value->title;
			}
		}
		foreach ($books_genres as $key => $book_genres) {
			foreach ($this->data['writer'] as $k => $writer_data) {
				if ($writer_data->id == $key) {
					$this->data['writer'][$k]->genre = $book_genres;
				}
			}
		}
	}
	public function editWriterData($name, $id) {
		$first_name = substr($name, 0, strpos($name, ' '));
		$last_name =trim(substr($name, strpos($name, ' ')));
		// var_dump($first_name, $last_name, $id);die;
		DBWriters::editWriter($first_name, $last_name, $id);
		header("Location: ".INCL_PATH.'Writers/'.$id.'/p1');
	}
	public function removeWriter($id) {
		DBWriters::removeWriter($id);
		header("Location: ".INCL_PATH.'Writers/index');
	}
}