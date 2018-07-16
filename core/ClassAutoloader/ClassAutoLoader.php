<?php

class ClassAutoLoader {
	private $path;

	public function __construct($path) {
		$this->path = $path;
		// array specifying the class and the method to run
		spl_autoload_register(array($this, 'load'));
	}

	public function load($file) {
		var_dump($file);
		if (is_file($this->path . '/' . $file . '.php')) {
            require_once( $this->path . '/' . $file . '.php' );
        }
	}
}