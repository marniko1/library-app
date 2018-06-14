		<div class="container">
			<div class="row">
				<form class="mt-2">
					<input type="text" name="filter" placeholder="Filter by book's title" id="filter">
				</form>
				<div  class="table-holder" style="min-height: 450px">
					<table class="table table-hover mt-1">
						<caption>List of books</caption>
						<thead class="thead-dark">
						    <tr>
						      	<th scope="col" style="width: 5%">#</th>
						      	<th scope="col" style="width: 30%">Title</th>
						      	<th scope="col" style="width: 35%">Description</th>
						      	<th scope="col" style="width: 10%">Genre</th>
						      	<th scope="col" style="width: 10%">Price</th>
						      	<th scope="col" style="width: 5%">CurSt</th>
						      	<th scope="col" style="width: 5%">Stock</th>
						    </tr>
						</thead>
						<div class="table-content">
							<tbody class="tbody col-12">
								<?php
								foreach ($this->data['books'] as $key => $value) {
								?>
									<tr style="cursor: pointer;" onclick="document.location.href='<?php echo INCL_PATH.'Books/'.$value->id.'/p1'; ?>'">
									    <th scope="row"><?php echo $key+1; ?></th>
									    <td><?php echo $value->title; ?></td>
									    <td><?php echo $value->description; ?></td>
									    <td title="<?php echo $value->long_genre; ?>"><?php echo $value->genre; ?></td>
									    <td><?php echo $value->price; ?></td>
									    <td><?php echo $value->current_stock; ?></td>
									    <td><?php echo $value->stock; ?></td>
								    </tr>
								<?php
								}
								?>
							 </tbody>
						</div>
					</table>
				</div>
				<nav class="col-12">
				    <ul class="pagination justify-content-center">
				    	<?php
					    foreach ($this->data['pagination_links'] as $link) {
					    	echo  '<li class="page-item"><a href="'.$link[0].'" class="page-link">'.$link[1].'</a></li>';
					    }
					    ?>
				    </ul>
				</nav>