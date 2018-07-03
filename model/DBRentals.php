<?php

class DBRentals extends DB {
	public static function getAllRentals($skip) {
		$sql = "select r.id, concat(c.first_name, \" \", c.last_name) as client, r.created, r.due, r.opened from rentals as r 
				join clients as c
				on r.id_client = c.id
				order by created desc
				limit $skip,".PG_RESULTS;
		return self::queryAndFetchInObj($sql);
	}
	public static function getSingleRental($id) {
		$sql = "select b.id, b.title, b.writer_id, r.id as rental_id, r.created, r.due, r.opened, 
				concat(w.first_name, \" \", w.last_name) as writer,
				concat(c.first_name, \" \", c.last_name) as client, 
				c.id as client_id from rentals as r 
				join rentals_books as rb 
				on r.id = rb.id_rental 
				join books as b 
				on b.id = rb.id_book 
				join clients as c 
				on r.id_client = c.id 
				join writers as w 
				on w.id = b.writer_id
				where r.id=".$id;
		return self::queryAndFetchInObj($sql);
	}
	public static function getFilteredRentals ($cond_name, $cond, $skip) {
		$sql = "select r.id, concat(c.first_name, \" \", c.last_name) as client, r.created, r.due, r.opened from rentals as r 
				join clients as c
				on r.id_client = c.id
				having $cond_name like '%$cond%'
				order by created desc
				limit $skip,".PG_RESULTS;
		return self::queryAndFetchInObj($sql);
	}
	public static function totalRentalsNum () {
		$sql = "select count(*) as total_rents from rentals";
		return self::executeSQL($sql)->fetch_object();
	}
	public static function numberOfRowsInResult ($cond_name, $cond) {
		$sql = "select r.id, concat(c.first_name, \" \", c.last_name) as client, r.created, r.due, r.opened from rentals as r 
				join clients as c
				on r.id_client = c.id
				having $cond_name like '%$cond%'";
		return self::executeSQL($sql)->num_rows;
	}
	public static function insertRentalIntoDB ($client, $title1, $title2, $title3, $title4, $title5) {
		$sql = "call INSERT_RENTAL('$client', '$title1', '$title2', '$title3', '$title4', '$title5')";
		return self::executeSQL($sql);
	}
	public static function closeRental ($id_rental, $id_client) {
		$sql = "call CLOSE_RENTAL($id_rental, $id_client)";
		return self::executeSQL($sql);
	}
	public static function numOfBooksAtClient ($client) {
		$sql = "select stock from clients where concat(first_name, \" \", last_name) = '$client'";
		return self::executeSQL($sql)->fetch_object();
	}
}