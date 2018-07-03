<?php

class DBUsers extends DB {
	public static function getCredentials($username) {
		$sql = "select * from users where username = '$username'";
		return self::executeSQL($sql)->fetch_object();
	}
	public static function getAllUsers() {
		$sql = "select * from users";
		$res = self::executeSQL($sql);
		return self::queryAndFetchInObj($sql);
	}
	public static function addNewUser($username, $full_name, $password, $priviledge){
		$sql = "insert into users values (null, '$username', '$full_name', '$password', '$priviledge')";
		$req = self::executeSQL($sql);
		return $req;
	}
	public static function editUser($username, $full_name, $password, $priviledge, $user_id){
		$sql = "update users set username = '$username', full_name = '$full_name', password = '$password', priviledge = '$priviledge' where id = $user_id";
		self::executeSQL($sql);
	}
	public static function removeUser($user_id){
		$sql = "delete from users where id = $user_id";
		return self::executeSQL($sql);
	}
}