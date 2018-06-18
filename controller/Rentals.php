<?php

class Rentals extends BaseController {
	public function index($pg=0) {
		$skip = 0;
		if ($pg !== 0) {
			$pg = substr($pg, 1);
			$skip = $pg*2-2;
		}
		$this->data['title'] = 'Rentals';
		$this->data['rentals'] = DBRentals::getAllRentals($skip);
		$total_rents_num = DBRentals::totalRentalsNum();
		$this->data['pagination_links'] = $this->preparePaginationLinks($total_rents_num->total_rents, $pg);
		$this->show_view('rentals');
	}
	public function singleRental($id) {
		$this->data['title'] = 'Single Rental';
		$this->data['rental'] = DBRentals::getSingleRental($id);
		$this->show_view('rental');
	}
	public function addNewRental($client, $title1, $title2, $title3, $title4, $title5, $is_ajax = false) {
		$num_of_books_at_client = DBRentals::numOfBooksAtClient($client);
		$num_of_books_in_curr_rent = 0;
		$method_args = func_get_args();
		unset($method_args[0]);
		unset($method_args[6]);
		$books_av = true;
		$more_then_one_unav = false;
		$unav_books = [];
		// check for each title if there is enough in stock
		foreach ($method_args as $key => $value) {
			if ($value != '') {
				$num_of_books_in_curr_rent++;
				if (!DBBooks::currBookStock($value)->current_stock > 0) {
					$books_av = false;
					$unav_books[$key] = $value;
				}
			}
		}
		// check if in rental is same title more then once and if there is enough in stock
		$count_more_then_one = array_count_values($method_args);
		foreach ($count_more_then_one as $key => $value) {
			if ($value > 1 && $key != '') {
				$book_curr_stock = DBBooks::currBookStock($key)->current_stock;
				if (!($book_curr_stock >= $value)) {
					$books_av = false;
					$more_then_one_unav = $book_curr_stock;
					foreach ($method_args as $k => $v) {
						if ($v == $key) {
							$unav_books[$k] = $more_then_one_unav;
						}
						
					}
				}
			}
		}
		try {
			if ($num_of_books_at_client->stock >= 5) {
				throw new Exception("The client already rented max num of books");
			}
			try {
				if ($num_of_books_at_client->stock + $num_of_books_in_curr_rent > 5) {
					$av = 5 - $num_of_books_at_client->stock;
					throw new Exception("The client can rent " . $av . " more book/s.");
				}
				try {
					if ($books_av == false) {
						throw new bookUnaviableException($unav_books);
					}
					$req = DBRentals::insertRentalIntoDB($client, $title1, $title2, $title3, $title4, $title5);
					if ($req) {
					// if (false) {
						Msg::createMessage("msg3", "Success.");
					} else {
						Msg::createMessage("msg3", "Unsuccess.");
					}
					if(!$is_ajax) {
						header("Location: ".INCL_PATH);
					} else {
						return Msg::getMessage();
					}
					
				} catch (bookUnaviableException $e) {
					foreach ($e->getData() as $key => $value) {
						if (preg_match('/^\d+$/', $value)) {
							$msg = "It is possible to have " . $value . " of this title in rental.";
						} else {
							$msg = "This book is not aviable for rent.";
						}
						Msg::createMessage("unav_book_msg" . $key, $msg);
					}
					return Msg::getMessage();
				}
			} catch (Exception $e) {
				Msg::createMessage("msg3", $e->getMessage());
				return Msg::getMessage();
			}
			
		} catch (Exception $e) {
			Msg::createMessage("msg3", $e->getMessage());
			return Msg::getMessage();
		}		
	}
	public function closeRental($id_rental, $id_client) {
		$req = DBRentals::closeRental(intval($id_rental), intval($id_client));
		header("Location: ".INCL_PATH."Rentals/{$id_rental}");
	}
}