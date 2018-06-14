<?php

class DBBooks extends DB {
	public static function getAllBooks($skip) {
		$data = [];
		$sql = "select *,
				(select count(*) from books) as total 
				from books 
				order by title
				limit $skip,2";
		$res = self::executeSQL($sql);
		while ($row = $res->fetch_object()) {
			array_push($data, $row);
		}
		return $data;
	}
	public static function getSingleBook($id, $skip) {
		$data = [];
		$sql = "select f.*, 
				(select count(*) from rentals_books where id_book=$id) as rented, 
				concat(c.first_name, \" \", c.last_name) as client, r.id as rental_id, r.created, r.due, r.opened from books as f 
				left join rentals_books as rf 
				on rf.id_book = f.id 
				left join rentals as r 
				on r.id = rf.id_rental 
				left join clients as c 
				on c.id = r.id_client  
				where f.id=$id 
				limit $skip,2";
		$res = self::executeSQL($sql);
		while ($row = $res->fetch_object()) {
			array_push($data, $row);
		}
		return $data;
	}
	public static function getSingleBookRentals ($id, $skip) {
		$data = [];
		$sql = "select (select count(*) from rentals_books where id_book=$id) as rented, 
				concat(c.first_name, \" \", c.last_name) as client, r.id, r.created, r.due, r.opened from books as f 
				left join rentals_books as rf 
				on rf.id_book = f.id 
				left join rentals as r 
				on r.id = rf.id_rental 
				left join clients as c 
				on c.id = r.id_client  
				where f.id=$id 
				limit $skip,2";
		$res = self::executeSQL($sql);
		while ($row = $res->fetch_object()) {
			array_push($data, $row);
		}
		return $data;
	}
	public static function getFilteredBooks ($cond_name, $cond, $skip) {
		$data = [];
		$sql = "select id, title, description, genre, price, current_stock, stock,
				(select count(*) from books where $cond_name like '%$cond%') as total 
				from books 
				where $cond_name like '%$cond%'
				order by $cond_name
				limit $skip,2";
		$res = self::executeSQL($sql);
		while ($row = $res->fetch_object()) {
			array_push($data, $row);
		}
		return $data;
	}
	public static function getFilteredBooksForNewRent ($cond) {
		$data = [];
		$sql = "select title, current_stock from books having title like '%$cond%' order by title limit 6";
		$res = self::executeSQL($sql);
		while ($row = $res->fetch_object()) {
			array_push($data, $row);
		}
		return $data;
	}
	// public static function totalBooksNum () {
	// 	$sql = "select count(*) as total_books from books";
	// 	$res = self::executeSQL($sql);
	// 	$total_books_num = $res->fetch_object();
	// 	return $total_books_num;
	// }
	public static function currBookStock($title) {
		$sql = "select current_stock from books where title = '$title'";
		return $res = self::executeSQL($sql)->fetch_object();
	}
	public static function insertBookIntoDB ($title, $description, $genre, $price, $stock) {
		$sql = "insert into books values (null, '$title', '$description', '$genre', $price, $stock, $stock)";
		$req = self::executeSQL($sql);
		return $req;
	}
	public static function editBook($title, $description, $genre, $price, $cur_stock, $stock, $id) {
		$sql = "update books set title = '$title', description = '$description', genre = '$genre', price = $price, current_stock = $cur_stock, stock = $stock where id = $id";
		self::executeSQL($sql);
	}
	public static function removeBook($id) {
		$sql = "delete from books where id = $id";
		return self::executeSQL($sql);
	}
}