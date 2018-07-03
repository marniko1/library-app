		<div class="container">
			<div class="row">
				<form class="mt-2">
					<input type="text" name="filter" placeholder="Filter by client's name" id="filter">
				</form>
				<div  class="table-holder" style="min-height: 450px; width:100%">
					<table class="table table-hover mt-1">
						<caption>List of rentals</caption>
						<thead class="thead-dark">
						    <tr>
						      <th scope="col" style="width: 5%">#</th>
						      <th scope="col" style="width: 30%">Writer</th>
						    </tr>
						</thead>
						<div class="table-content">
							<tbody class="tbody col-12">
								<?php
								foreach ($this->data['writers'] as $key => $value) {
								?>
									<tr style="cursor: pointer;" onclick="document.location.href='<?php echo INCL_PATH.'Writers/'.$value->id.'/p1'; ?>'">
									    <th scope="row"><?php echo $key+1; ?></th>
									    <td><?php echo $value->writer; ?></td>
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