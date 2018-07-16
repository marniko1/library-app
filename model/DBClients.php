<?php

class DBClients extends DB {
		public static function getAllClients($skip) {
		$sql = "select id, concat(first_name, \" \", last_name) as client, email, address, stock, 
				(select count(*) from clients) as total 
				from clients 
				order by first_name
				limit $skip,".PG_RESULTS;
		return self::queryAndFetchInObj($sql);
	}
	public static function getSingleClient($id, $skip) {
		$sql = "select c.id, concat(c.first_name, \" \", c.last_name) as client, c.email, c.address, c.stock, f.title, r.id as id_rental, r.created, r.due, r.opened, 
				(select count(*) from rentals_books where id_rental in (select id from rentals where id_client = $id)) as rented from clients as c  
				left join rentals as r 
				on c.id = r.id_client 
				left join rentals_books as rf 
				on r.id = rf.id_rental 
				left join books as f 
				on rf.id_book = f.id 
				where c.id = $id 
				order by f.title 
				limit $skip,".PG_RESULTS;
		return self::queryAndFetchInObj($sql);
	}
	public static function getSingleClientRentals ($id, $skip) {
		$sql = "select c.id, f.title, r.id, r.created, r.due, r.opened,   
				(select count(*) from rentals_books where id_rental in (select id from rentals where id_client = $id)) as rented from clients as c 
				left join rentals as r 
				on r.id_client = c.id 
				left join rentals_books as rf 
				on r.id = rf.id_rental 
				left join books as f 
				on f.id = rf.id_book  
				where c.id=$id  
				order by f.title 
				limit $skip,".PG_RESULTS;
		return self::queryAndFetchInObj($sql);
	}
	public static function getFilteredClients ($cond_name, $cond, $skip) {
		$sql = "select id, concat(first_name, \" \", last_name) as client, email, address, stock, 
				(select count(*) from clients where concat(first_name, \" \", last_name) like '%$cond%') as total 
				from clients 
				having $cond_name like '%$cond%'  
				order by $cond_name
				limit $skip,".PG_RESULTS;
		return self::queryAndFetchInObj($sql);
	}
	public static function getFilteredClientsForNewRent ($cond) {
		$sql = "select concat(first_name, \" \", last_name) as client, stock from clients where active = 'yes' having client like '%$cond%' order by client limit 6";
		return self::queryAndFetchInObj($sql);
	}
	public static function insertClientIntoDB ($first_name, $last_name, $email, $address) {
		$sql = "insert into clients values (null, '$first_name', '$last_name', '$email', '$address', default, default)";
		$req = self::executeSQL($sql);
		return $req;
	}
	public static function editClient($first_name, $last_name, $email, $address, $stock, $id) {
		$sql = "update clients set first_name = '$first_name', last_name = '$last_name', email = '$email', address = '$address', stock = $stock where id = $id";
		self::executeSQL($sql);
	}
	public static function removeClient($id) {
		$sql = "delete from clients where id = $id";
		return self::executeSQL($sql);
	}
	public static function makeClientInactive($id) {
		$sql = "update clients set active = 'no' where id = $id";
		return self::executeSQL($sql);
	}
	public static function checkIfClientHadRentals($id) {
		$sql = "select * from rentals where id_client = $id";
		return self::executeSQL($sql)->fetch_object();
	}
}