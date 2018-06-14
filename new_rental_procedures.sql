delimiter //
create procedure NUM_OF_BOOKS_AT_CLIENT (_client varchar(45))
	begin
	declare client_id int;

	select id from clients where concat(first_name, " ", last_name) = _client into client_id;

	select count(*) as num_of_books_at_client from rentals_books where id_rental in (select id from rentals where id_client = client_id and opened = 'yes');

	end//
delimiter ;
----------------------------------------------------------------------------------------------------------------------------------
delimiter //
create procedure CLOSE_RENTAL (_rental_id int(11), _client_id int(11))
	begin
	declare num_of_books_at_rental int;

	select count(*) from rentals_books where id_rental = _rental_id into num_of_books_at_rental;

	update rentals set opened = 'no', due = now() where id = _rental_id;
	update clients set stock = stock - num_of_books_at_rental where id = _client_id;
	update books set current_stock = current_stock + 1 where id in (select id_book from rentals_books where id_rental = _rental_id);

	end//
delimiter ;

----------------------------------------------------------------------------------------------------------------------------------
delimiter //
create procedure INSERT_RENTAL (_client varchar(45), _title_1 varchar(45), _title_2 varchar(45), _title_3 varchar(45), _title_4 varchar(45), _title_5 varchar(45))
	begin
	declare client_id int;
	declare rental_id int;
	declare curr_client_stock int;


	select id from clients where concat(first_name, " ", last_name) = _client into client_id;
	select stock from clients where concat(first_name, " ", last_name) = _client into curr_client_stock;
	
	set @client_stock = curr_client_stock;
	set @totals = 0;


	insert into rentals values (null, client_id, 0, now(), now() + interval 7 day, 'yes');

	set @max_rentals_id = (select max(id) from rentals);
	
	

	if _title_1 != '' then
		set @id_book = (select id from books where title = _title_1);
		set @book_price = (select price from books where title = _title_1);
		insert into rentals_books values (null, @max_rentals_id, @id_book);
		set @totals = @totals + @book_price;
		set @client_stock = @client_stock + 1;
		set @current_book_stock = (select current_stock from books where title = _title_1);
		set @current_book_stock = @current_book_stock - 1;
		update books set current_stock = @current_book_stock where title = _title_1;
	end if;
	if _title_2 != '' then
		set @id_book = (select id from books where title = _title_2);
		set @book_price = (select price from books where title = _title_2);
		insert into rentals_books values (null, @max_rentals_id, @id_book);
		set @totals = @totals + @book_price;
		set @client_stock = @client_stock + 1;
		set @current_book_stock = (select current_stock from books where title = _title_2);
		set @current_book_stock = @current_book_stock - 1;
		update books set current_stock = @current_book_stock where title = _title_2;
	end if;
	if _title_3 != '' then
		set @id_book = (select id from books where title = _title_3);
		set @book_price = (select price from books where title = _title_3);
		insert into rentals_books values (null, @max_rentals_id, @id_book);
		set @totals = @totals + @book_price;
		set @client_stock = @client_stock + 1;
		set @current_book_stock = (select current_stock from books where title = _title_3);
		set @current_book_stock = @current_book_stock - 1;
		update books set current_stock = @current_book_stock where title = _title_3;
	end if;
	if _title_4 != '' then
		set @id_book = (select id from books where title = _title_4);
		set @book_price = (select price from books where title = _title_4);
		insert into rentals_books values (null, @max_rentals_id, @id_book);
		set @totals = @totals + @book_price;
		set @client_stock = @client_stock + 1;
		set @current_book_stock = (select current_stock from books where title = _title_4);
		set @current_book_stock = @current_book_stock - 1;
		update books set current_stock = @current_book_stock where title = _title_4;
	end if;
	if _title_5 != '' then
		set @id_book = (select id from books where title = _title_5);
		set @book_price = (select price from books where title = _title_5);
		insert into rentals_books values (null, @max_rentals_id, @id_book);
		set @totals = @totals + @book_price;
		set @client_stock = @client_stock + 1;
		set @current_book_stock = (select current_stock from books where title = _title_5);
		set @current_book_stock = @current_book_stock - 1;
		update books set current_stock = @current_book_stock where title = _title_5;
	end if;
	
	update rentals set totals = @totals where id = @max_rentals_id;
	update clients set stock = @client_stock where concat(first_name, " ", last_name) = _client;

	end//
delimiter ;

call INSERT_RENTAL (null, null, null, 'Sekula se opet zeni', 'Umri muski 2', 'Marko', 'Nikolic');