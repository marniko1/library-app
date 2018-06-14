		<div class="container">
			<div class="row">
				<form class="mt-2">
					<input type="text" name="filter" placeholder="Filter by client's name" id="filter">
				</form>
				<div  class="table-holder" style="min-height: 450px">
					<table class="table table-hover mt-1">
						<caption>List of rentals</caption>
						<thead class="thead-dark">
						    <tr>
						      <th scope="col" style="width: 5%">#</th>
						      <th scope="col" style="width: 30%">Client</th>
						      <th scope="col" style="width: 10%">Total</th>
						      <th scope="col" style="width: 25%">Created</th>
						      <th scope="col" style="width: 25%">Due</th>
						      <th scope="col" style="width: 5%">Opened</th>
						    </tr>
						</thead>
						<div class="table-content">
							<tbody class="tbody col-12">
								<?php
								foreach ($this->data['rentals'] as $key => $value) {
								?>
									<tr style="cursor: pointer;" onclick="document.location.href='<?php echo INCL_PATH.'Rentals/'.$value->id; ?>'">
									    <th scope="row"><?php echo $key+1; ?></th>
									    <td><?php echo $value->client; ?></td>
									    <td><?php echo $value->totals; ?></td>
									    <td><?php echo $value->created; ?></td>
									    <td><?php echo $value->due; ?></td>
									    <td><?php echo $value->opened; ?></td>
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