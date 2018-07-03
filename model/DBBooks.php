<?php

class DBBooks extends DB {
	public static function getAllBooks($skip) {
		$sql = "select b.*, 
				(select count(*) from books) as total,
				concat(w.first_name, \" \", w.last_name) as writer
				from books as b
				join writers as w  
				on w.id = b.writer_id
				order by title
				limit $skip,".PG_RESULTS;
		return self::queryAndFetchInObj($sql);
	}
	public static function getSingleBook($id, $skip) {
		$sql = "select b.*, 
				(select count(*) from rentals_books where id_book=$id) as rented, 
				concat(w.first_name, \" \", w.last_name) as writer,
				concat(c.first_name, \" \", c.last_name) as client, r.id as rental_id, r.created, r.due, r.opened from books as b 
				left join rentals_books as rb 
				on rb.id_book = b.id 
				left join rentals as r 
				on r.id = rb.id_rental 
				left join clients as c 
				on c.id = r.id_client 
				left join writers as w 
				on w.id = b.writer_id 
				where b.id=$id 
				limit $skip,".PG_RESULTS;
		return self::queryAndFetchInObj($sql);
	}
	// needed for AjaxCalls.php
	public static function getSingleBookRentals ($id, $skip) {
		$sql = "select (select count(*) from rentals_books where id_book=$id) as rented, 
				concat(c.first_name, \" \", c.last_name) as client, r.id, r.created, r.due, r.opened from books as b 
				left join rentals_books as rb 
				on rb.id_book = b.id 
				left join rentals as r 
				on r.id = rb.id_rental 
				left join clients as c 
				on c.id = r.id_client  
				where b.id=$id 
				limit $skip,".PG_RESULTS;
		return self::queryAndFetchInObj($sql);
	}
	public static function getFilteredBooks ($cond_name, $cond, $skip) {
		$sql = "select b.id, b.title, b.description, concat(w.first_name, \" \", w.last_name) as writer, b.current_stock, b.stock, 
				(select count(*) from books where $cond_name like '%$cond%') as total 
				from books as b 
				left join writers as w 
				on w.id = b.writer_id 
				where $cond_name like '%$cond%'
				order by $cond_name
				limit $skip,".PG_RESULTS;
		return self::queryAndFetchInObj($sql);
	}
	public static function getFilteredBooksForNewRent ($cond) {
		$sql = "select title, current_stock from books having title like '%$cond%' order by title limit 6";
		return self::queryAndFetchInObj($sql);
	}
	public static function currBookStock($title) {
		$sql = "select current_stock from books where title = '$title'";
		return self::executeSQL($sql)->fetch_object();
	}
	public static function insertBookIntoDB ($title, $description, $writer, $stock, $genre1, $genre2, $genre3) {
		$sql = "call INSERT_NEW_BOOK('$title', '$description', '$writer', $stock, $genre1, $genre2, $genre3)";
		$req = self::executeSQL($sql);
		return $req;
	}
	public static function editBook($title, $description, $genre1, $genre2, $genre3, $writer, $cur_stock, $stock, $id) {
		$sql = "call EDIT_BOOK('$title', '$description', '$writer', $stock, $cur_stock, $genre1, $genre2, $genre3, $id)";
		self::executeSQL($sql);
	}
	public static function removeBook($id) {
		$sql = "delete from books where id = $id";
		return self::executeSQL($sql);
	}
	public static function getGenres($ids) {
		$sql = "select bg.book_id, 
				g.title
				from books_genres as bg 
				join genres as g 
				on g.id = bg.genre_id 
				where book_id in ($ids)";
		return self::queryAndFetchInObj($sql);
	}
}