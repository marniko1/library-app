<?php
require ROOT_DIR.'config/database_conn.php';

class DB {

	public static $conn;
	public static $instance;

	public static function getInstance(){
		if(!isset(self::$conn)){
			self::$instance = new DB();
		}
		return self::$conn;
	}

	public function __construct(){
		self::$conn = new mysqli(DBSERVER,DBUSER,DBPASS,DBNAME);
	}

	public static function executeSQL($sql) {
		$db = self::getInstance();
		$req = $db->query($sql);
		return $req;
	}
}