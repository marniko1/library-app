		<div class="container">
			<div class="row">
				<table class="table mt-5">
					<thead class="thead-dark">
					    <tr>
					      <th scope="col">#</th>
					      <th scope="col">Title</th>
					      <th scope="col">Writer</th>
					    </tr>
					</thead>
					<tbody>
						<?php
						foreach ($this->data['rental'] as $key => $value) {
						?>
							<tr>
						      	<th scope="row"><?php echo $key+1; ?></th>
						     	<td><?php echo '<a class="nav-link p-0" href="'.INCL_PATH.'Books/'.$value->id.'/p1">'.$value->title.'</a>'; ?></td>
						      	<td><?php echo $value->writer; ?></td>
						    </tr>
						<?php
						}
						?>
					</tbody>
				</table>
				<ul>
					<li>Client: <?php echo '<a class="nav-link p-0 d-inline" href="'.INCL_PATH.'Clients/'.$this->data['rental'][0]->client_id.'/p1">'.$this->data['rental'][0]->client.'</a>'; ?></li>
					<li>Active: <?php echo $this->data['rental'][0]->opened; ?></li>
					<li>Date created: <?php echo $this->data['rental'][0]->created; ?></li>
					<li>Due: <?php echo $this->data['rental'][0]->due; ?></li>
				</ul>
				<?php if ($this->data['rental'][0]->opened == 'yes'): ?>
					<div class="col-12">
						<form method="post" action="<?php echo INCL_PATH.'Rentals/closeRental';?>">
							<input type="hidden" name="rental_id" value="<?php echo $this->data['rental'][0]->rental_id; ?>">
							<input type="hidden" name="client_id" value="<?php echo $this->data['rental'][0]->client_id; ?>">
							<input type="submit" value="Close Rental" class="btn">
						</form>
					</div>
				<?php endif ?>