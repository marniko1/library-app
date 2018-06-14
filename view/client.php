		<div class="container">
			<div class="row">
				<form method="post" action="<?php echo INCL_PATH.'Clients/removeClient';?>" class="edit_form">
					<table class="table mt-5 main  client_book">
						<thead class="thead-dark">
						    <tr>
						      	<th scope="col" style="width: 5%">#</th>
							    <th scope="col" style="width: 30%">Name</th>
						      	<th scope="col" style="width: 30%">Email</th>
						      	<th scope="col" style="width: 30%">Address</th>
						      	<th scope="col" style="width: 5%">Stock</th>
						    </tr>
						</thead>
						<tbody>
							<tr>
						      	<th scope="row"><?php echo 1; ?></th>
							    <td data-name="client"><?php echo $this->data['client'][0]->client; ?></td>
							    <td data-name="email"><?php echo $this->data['client'][0]->email; ?></td>
							    <td data-name="address"><?php echo $this->data['client'][0]->address; ?></td>
							    <td data-name="stock"><?php echo $this->data['client'][0]->stock; ?></td>
						    </tr>
						</tbody>
					</table>
					<input type="hidden" name="client_id" value="<?php echo $this->data['client'][0]->id; ?>">
					<div class="btn-holder">
						<input type="button" name="edit" value="Edit" class="btn edit btn-info">
						<input type="submit" name="remove" value="Remove" class="btn btn-danger remove">
					</div>
				</form>
				<div class="col-10 mt-5">
					<div class="table-wrapper" style="min-height: 200px">
						<table class="col-10 table table-sm clients">
							<caption>List of books that rented client <?php echo $this->data['client'][0]->client; ?></caption>
							<thead>
								<th scope="col" style="width: 5%">#</th>
							    <th scope="col" style="width: 30%">Title</th>
						      	<th scope="col" style="width: 30%">Rented</th>
						      	<th scope="col" style="width: 30%">Returned</th>
						      	<th scope="col" style="width: 5%">Active</th>
							</thead>
							<tbody class="tbody">
					<?php if ($this->data['client'][0]->title != null):
						foreach ($this->data['client'] as $key => $value) {
						?>
								<tr style="cursor: pointer;" onclick="document.location.href='<?php echo INCL_PATH.'Rentals/'.$value->id_rental; ?>'">
									<th scope="row"><?php echo $key + 1; ?></th>
									<td><?php echo $this->data['client'][$key]->title; ?></td>
									<td><?php echo $this->data['client'][$key]->created; ?></td>
									<td><?php echo $this->data['client'][$key]->due; ?></td>
									<td><?php echo $this->data['client'][$key]->opened; ?></td>
								</tr>
						<?php
						}
						else: ?>
						<tr><td colspan="6">Didn't made rentals yet.</td></tr>
					<?php endif ?>
							</tbody>
						</table>
					</div>
					<?php if ($this->data['client'][0]->title != null): ?>
					<nav class="col-12 mt-5" aria-label="...">
					    <ul class="pagination pagination-sm justify-content-center">
					    	<?php
						    foreach ($this->data['pagination_links'] as $link) {
						    	echo  '<li class="page-item"><a href="'.$link[0].'" class="page-link">'.$link[1].'</a></li>';
						    }
						    ?>
					    </ul>
					</nav>
					<?php endif ?>
				</div>