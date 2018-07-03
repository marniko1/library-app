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


	insert into rentals values (null, client_id, now(), now() + interval 7 day, 'yes');

	set @max_rentals_id = (select max(id) from rentals);
	
	

	if _title_1 != '' then
		set @id_book = (select id from books where title = _title_1);
		insert into rentals_books values (null, @max_rentals_id, @id_book);
		set @client_stock = @client_stock + 1;
		set @current_book_stock = (select current_stock from books where title = _title_1);
		set @current_book_stock = @current_book_stock - 1;
		update books set current_stock = @current_book_stock where title = _title_1;
	end if;
	if _title_2 != '' then
		set @id_book = (select id from books where title = _title_2);
		insert into rentals_books values (null, @max_rentals_id, @id_book);
		set @client_stock = @client_stock + 1;
		set @current_book_stock = (select current_stock from books where title = _title_2);
		set @current_book_stock = @current_book_stock - 1;
		update books set current_stock = @current_book_stock where title = _title_2;
	end if;
	if _title_3 != '' then
		set @id_book = (select id from books where title = _title_3);
		insert into rentals_books values (null, @max_rentals_id, @id_book);
		set @client_stock = @client_stock + 1;
		set @current_book_stock = (select current_stock from books where title = _title_3);
		set @current_book_stock = @current_book_stock - 1;
		update books set current_stock = @current_book_stock where title = _title_3;
	end if;
	if _title_4 != '' then
		set @id_book = (select id from books where title = _title_4);
		insert into rentals_books values (null, @max_rentals_id, @id_book);
		set @client_stock = @client_stock + 1;
		set @current_book_stock = (select current_stock from books where title = _title_4);
		set @current_book_stock = @current_book_stock - 1;
		update books set current_stock = @current_book_stock where title = _title_4;
	end if;
	if _title_5 != '' then
		set @id_book = (select id from books where title = _title_5);
		insert into rentals_books values (null, @max_rentals_id, @id_book);
		set @client_stock = @client_stock + 1;
		set @current_book_stock = (select current_stock from books where title = _title_5);
		set @current_book_stock = @current_book_stock - 1;
		update books set current_stock = @current_book_stock where title = _title_5;
	end if;
	
	update clients set stock = @client_stock where concat(first_name, " ", last_name) = _client;

	end//
delimiter ;

-------------------------------------------------------------------------------------------------------------------

delimiter //
create procedure EDIT_BOOK (_title varchar(45), _description longtext, _writer varchar(45), _stock int(11), _current_stock int(11), _genre_id_1 int(11), _genre_id_2 int(11), _genre_id_3 int(11), _id_book int(11))
	begin
	declare id_writer int;

	select id from writers where concat(first_name, ' ', last_name) = _writer into id_writer;

	update books set title = _title, description = _description, writer_id = id_writer, current_stock = _current_stock, stock = _stock where id = _id_book;

	delete from books_genres where book_id = _id_book;

	insert into books_genres values (null, _id_book, _genre_id_1);

	if _genre_id_2 != 0 then
		insert into books_genres values (null, _id_book, _genre_id_2);
	end if;
	if _genre_id_3 != 0 then
		insert into books_genres values (null, _id_book, _genre_id_3);
	end if;

	end//
delimiter ;

-------------------------------------------------------------------------------------------------------------------
delimiter //
create procedure INSERT_NEW_BOOK (_title varchar(45), _description longtext, _writer varchar(45), _stock int(11), _genre_id_1 int(11), _genre_id_2 int(11), _genre_id_3 int(11))
	begin
	declare writer_id int;
	declare book_id int;

	select id from writers where concat(first_name, ' ', last_name) = _writer into writer_id;

	insert into books values (null, _title, _description, writer_id, _stock, _stock, default);

	select max(id) from books into book_id;

	
	insert into books_genres values (null, book_id, _genre_id_1);

	if _genre_id_2 != 0 then
		insert into books_genres values (null, book_id, _genre_id_2);
	end if;
	if _genre_id_3 != 0 then
		insert into books_genres values (null, book_id, _genre_id_3);
	end if;

	end//
delimiter ;


call INSERT_RENTAL (null, null, null, 'Sekula se opet zeni', 'Umri muski 2', 'Marko', 'Nikolic');