<?php
require ROOT_DIR.'config/database_conn.php';

class DB {

	private static $data = [];
	private static $conn;
	private static $instance;

	private static function getInstance(){
		if(!isset(self::$conn)){
			self::$instance = new DB();
		}
		return self::$conn;
	}

	private function __construct(){
		self::$conn = new mysqli(DBSERVER,DBUSER,DBPASS,DBNAME);
	}

	protected static function executeSQL($sql) {
		$db = self::getInstance();
		$db->set_charset("utf8");
		$res = $db->query($sql);
		return $res;
	}
	protected static function queryAndFetchInObj($sql) {
		self::$data = [];
		$res = self::executeSQL($sql);
		while ($row = $res->fetch_object()) {
			array_push(self::$data, $row);
		}
		return self::$data;
	}
}