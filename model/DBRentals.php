<?php

class DBRentals extends DB {
	public static function getAllRentals($skip) {
		$data = [];
		$sql = "select r.id, concat(c.first_name, \" \", c.last_name) as client, r.totals, r.created, r.due, r.opened from rentals as r 
				join clients as c
				on r.id_client = c.id
				order by created desc
				limit $skip,2";
		$res = self::executeSQL($sql);
		while ($row = $res->fetch_object()) {
			array_push($data, $row);
		}
		return $data;
	}
	public static function getSingleRental($id) {
		$data = [];
		$sql = "select f.id, f.title, f.price, r.id as rental_id, r.totals, r.created, r.due, r.opened, concat(c.first_name, \" \", c.last_name) as client, c.id as client_id from rentals as r 
				join rentals_books as rf 
				on r.id = rf.id_rental 
				join books as f 
				on f.id = rf.id_book 
				join clients as c 
				on r.id_client = c.id 
				where r.id=".$id;
		$res = self::executeSQL($sql);
		while ($row = $res->fetch_object()) {
			array_push($data, $row);
		}
		return $data;
	}
	public static function getFilteredRentals ($cond_name, $cond, $skip) {
		$data = [];
		$sql = "select r.id, concat(c.first_name, \" \", c.last_name) as client, r.totals, r.created, r.due, r.opened from rentals as r 
				join clients as c
				on r.id_client = c.id
				having $cond_name like '%$cond%'
				order by created desc
				limit $skip,2";
		$res = self::executeSQL($sql);
		while ($row = $res->fetch_object()) {
			array_push($data, $row);
		}
		return $data;
	}
	public static function totalRentalsNum () {
		$sql = "select count(*) as total_rents from rentals";
		$res = self::executeSQL($sql);
		$total_rentals_num = $res->fetch_object();
		return $total_rentals_num;
	}
	public static function numberOfRowsInResult ($cond_name, $cond) {
		$sql = "select r.id, concat(c.first_name, \" \", c.last_name) as client, r.totals, r.created, r.due, r.opened from rentals as r 
				join clients as c
				on r.id_client = c.id
				having $cond_name like '%$cond%'";
		$num_of_rows = self::executeSQL($sql)->num_rows;
		return $num_of_rows;
	}
	public static function insertRentalIntoDB ($client, $title1, $title2, $title3, $title4, $title5) {
		$sql = "call INSERT_RENTAL('$client', '$title1', '$title2', '$title3', '$title4', '$title5')";
		$req = self::executeSQL($sql);
		return $req;
	}
	public static function closeRental ($id_rental, $id_client) {
		$sql = "call CLOSE_RENTAL($id_rental, $id_client)";
		$req = self::executeSQL($sql);
		return $req;
	}
	public static function numOfbooksAtClient ($client) {
		// $sql = "call NUM_OF_bookS_AT_CLIENT($client)";
		$sql = "select stock from clients where concat(first_name, \" \", last_name) = '$client'";
		$res = self::executeSQL($sql);
		return $res->fetch_object();
	}
}