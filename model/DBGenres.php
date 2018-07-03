<?php

class DBGenres extends DB {
	public static function insertGenreIntoDB($title) {
		$sql = "insert into genres values (null, '$title')";
		return self::executeSQL($sql);
	}
	public static function getAllGenres() {
		$sql = "select * from genres order by title";
		return self::queryAndFetchInObj($sql);
	}
}