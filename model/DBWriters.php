<?php

class DBWriters extends DB {
	public static function insertWriterIntoDB($first_name, $last_name) {
		$sql = "insert into writers values (null, '$first_name', '$last_name')";
		$req = self::executeSQL($sql);
		return $req;
	}
}