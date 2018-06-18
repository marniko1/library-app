		<?php 
		// var_dump($this->data['msg']['msg1']);
		 ?>
		<div class="container">
			<div class="row">
				<nav class="navbar col-12 row">
					<ul class="nav col-12 justify-content-center">
						<li class="nav-item border-right"><a class="nav-link" href="<?php echo INCL_PATH.'Admin/index';?>">Add/List/Edit Users</a></li>
						<li class="nav-item"><a class="nav-link" id="page_2_link" href="<?php echo INCL_PATH.'Admin/panel';?>">Add Writer/Genre</a></li>
					</ul>
				</nav>
				<div class="form-wrapper col-6">
					<form class="mt-5 col-12" method="post" action="<?php echo INCL_PATH.'Admin/addNewWriter';?>" id="new-writer">
						<h5>Add new writer</h5>
						<div class="form-group">
							<label for="first_name">First name: </label>
							<input type="text" name="first_name" id="first_name" class="form-control">
						</div>
						<div class="form-group">
							<label for="last_name">Last Name: </label>
							<input type="text" name="last_name" id="last_name" class="form-control">
						</div>
						<div class="form-group">
							<input type="submit" value="Submit" class="btn btn-primary">
						</div>
					</form>
					<span class="msg-span"><?php echo (isset($this->data['msg']['msg1'])) ? $this->data['msg']['msg1'] : false ?></span>
				</div>
				<div class="form-wrapper col-6">
					<form class="mt-5 col-12" method="post" action="<?php echo INCL_PATH.'Admin/addNewGenre';?>" id="new-genre">
						<h5>Add new genre</h5>
						<div class="form-group">
							<label for="genre_title">Genre title: </label>
							<input type="text" name="genre_title" id="genre_title" class="form-control">
						</div>
						<div class="form-group">
							<input type="submit" value="Submit" class="btn btn-primary">
						</div>
					</form>
					<span class="msg-span"><?php echo (isset($this->data['msg']['msg2'])) ? $this->data['msg']['msg2'] : false ?></span>
				</div>