		<div class="container">
			<div class="row">
				<form method="post" action="<?php echo INCL_PATH.'Writers/removeWriter';?>" class="edit_form  col-12">
					<table class="table mt-5 main  writer_book">
						<thead class="thead-dark">
						    <tr>
						      	<th scope="col" style="width: 5%">#</th>
							    <th scope="col" style="width: 95%">Writer</th>
						    </tr>
						</thead>
						<tbody>
							<tr>
						      	<th scope="row"><?php echo 1; ?></th>
							    <td data-name="writer"><?php echo $this->data['writer'][0]->writer; ?></td>
						    </tr>
						</tbody>
					</table>
					<input type="hidden" name="writer_id" value="<?php echo $this->data['writer'][0]->id_writer; ?>">
					<div class="btn-holder">
						<input type="button" name="edit" value="Edit" class="btn edit btn-info">
						<input type="submit" name="remove" value="Remove" class="btn btn-danger remove">
					</div>
				</form>
				<div class="col-10 mt-5">
					<div class="table-wrapper" style="min-height: 200px">
						<table class="col-10 table table-sm writers">
							<caption>List of books in stock published by writer <?php echo $this->data['writer'][0]->writer; ?></caption>
							<thead>
								<th scope="col" style="width: 5%">#</th>
							    <th scope="col" style="width: 30%">Title</th>
						      	<th scope="col" style="width: 30%">Description</th>
						      	<th scope="col" style="width: 25%">Genre</th>
						      	<th scope="col" style="width: 5%">CurSt</th>
						      	<th scope="col" style="width: 5%">Stock</th>
							</thead>
							<tbody class="tbody">
					<?php if ($this->data['writer'][0]->title != null):
						foreach ($this->data['writer'] as $key => $value) {
						?>
								<tr style="cursor: pointer;" onclick="document.location.href='<?php echo INCL_PATH.'Books/'.$value->id.'/p1'; ?>'">
									<th scope="row"><?php echo $key + 1; ?></th>
									<td><?php echo $this->data['writer'][$key]->title; ?></td>
									<td><?php echo $this->data['writer'][$key]->description; ?></td>
									<td><?php echo $this->data['writer'][$key]->genre; ?></td>
									<td><?php echo $this->data['writer'][$key]->current_stock; ?></td>
									<td><?php echo $this->data['writer'][$key]->stock; ?></td>
								</tr>
						<?php
						}
						else: ?>
						<tr><td colspan="6">There is no books of writer <?php echo $this->data['writer'][0]->writer; ?> in stock.</td></tr>
					<?php endif ?>
							</tbody>
						</table>
					</div>
					<?php if ($this->data['writer'][0]->title != null): ?>
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