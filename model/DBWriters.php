<?php

class DBWriters extends DB {
	public static function getAllWriters($skip) {
		// var_dump(PG_RESULTS);
		$sql = "select id, concat(first_name, \" \", last_name) as writer, 
				(select count(*) from writers) as total 
				from writers 
				order by first_name
				limit $skip,".PG_RESULTS;
		return self::queryAndFetchInObj($sql);
	}
	public static function getSingleWriter($id, $skip) {
		$sql = "select w.id as id_writer, concat(w.first_name, \" \", w.last_name) as writer, 
				b.* , 
				(select count(*) from books where writer_id = $id) as total_books_written
				from writers as w 
				left join books as b 
				on b.writer_id = w.id 
				where w.id=$id 
				limit $skip,".PG_RESULTS;
		return self::queryAndFetchInObj($sql);
	}
	public static function getSingleWriterBooks ($id, $skip) {
		$sql = "select b.*, 
				(select count(*) from books where writer_id = $id) as total 
				from books as b 
				where writer_id=$id  
				order by title 
				limit $skip,".PG_RESULTS;
		return self::queryAndFetchInObj($sql);
	}
	public static function getFilteredWriters($cond_name, $cond, $skip) {
		$sql = "select id, concat(first_name, \" \", last_name) as writer,  
				(select count(*) from writers where concat(first_name, \" \", last_name) like '%$cond%') as total 
				from writers 
				having $cond_name like '%$cond%'  
				order by $cond_name
				limit $skip,".PG_RESULTS;
		return self::queryAndFetchInObj($sql);
	}
	public static function getFilteredWritersForNewBook ($cond) {
		$sql = "select concat(first_name, \" \", last_name) as writer from writers having writer like '%$cond%' order by writer limit 6";
		return self::queryAndFetchInObj($sql);
	}
	public static function insertWriterIntoDB($first_name, $last_name) {
		$sql = "insert into writers values (null, '$first_name', '$last_name')";
		return self::executeSQL($sql);
	}
	public static function editWriter($first_name, $last_name, $id) {
		$sql = "update writers set first_name = '$first_name', last_name = '$last_name' where id = $id";
		self::executeSQL($sql);
	}
	public static function removeWriter($id) {
		$sql = "delete from writers where id = $id";
		return self::executeSQL($sql);
	}
}