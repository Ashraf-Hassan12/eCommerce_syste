<?php 
require("function.php");
require("conn.php");
$company = get_company('name');
$address = get_company('address');
$tell = get_company('tell');
$logo = get_company('logo');

$sql = "SELECT s.name,sum(p.qty*p.cost) total2,s.tell,p.ref_no,date_format(p.date,'%b %D %Y')date FROM purchase p JOIN supplier s on s.id=p.supplier_id WHERE ref_no='$_GET[ref_no]'";
$res = $conn->query($sql);

$r = $res->fetch_array();
extract($r);
?>


<?php
require("conn.php");
 $s = "SELECT find_payment($_GET[ref_no],'p') paid,find_payment($_GET[ref_no],'s') dis ";
$re = $conn->query($s);
$rs = $re->fetch_array();
extract($rs);
?>
<div class="container">
<div class="row gutters">
		<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
			<div class="card">
				<div class="card-body p-0">
					<div class="invoice-container">
						<div class="invoice-header">
							<!-- Row start -->
							
							<!-- Row end -->
							<!-- Row start -->
							<div class="row gutters  aaran">
								<div class="col-md-8">
									<img src="../<?php echo $logo ?>">
								</div>
								<div class="col-md-4 address">
									<a href="index.html" class="invoice-logo">
										<?php echo $company ?>
									</a>
									<nav class="">
										<?php echo $tell ?>.<br>
										<?php echo $address ?><br>
										
									</nav>
								</div>
								
							</div>
							<!-- Row end -->
							<!-- Row start -->
							<div style="" class="row gutters aaran customer_info">
								
									<div class="invoice-details">
										<address>
											<?php echo $name ?><br>
											<?php echo $tell ?>
										</address>

									</div>
									<div class="invoice-details">
										<div class="invoice-num">
											<div>Invoice - #<?php echo $ref_no ?></div>
											<div><?php echo $date ?></div>
										</div>
									</div>
								
								
							</div>
							<!-- Row end -->
						</div>
						<div class="invoice-body">
							<!-- Row start -->
							<div class="row gutters">
								<div class="col-lg-12 col-md-12 col-sm-12">
									<div class="table-responsive">
										<table style="width: 100%" class="table custom-table m-0">
											<thead>
												<tr>
													<th>Items</th>
												
													<th>Quantity</th>
													<th>Unit price</th>
													<th>Total</th>
												</tr>
											</thead>
											<tbody>
												<?php 
require("conn.php");
$sq = "SELECT s.name,p.qty,p.cost,p.qty * p.cost total FROM purchase p JOIN product s on s.id=p.product_id WHERE `ref_no`='$_GET[ref_no]' ";
$ress = $conn->query($sq);
while($row = $ress->fetch_array()){
	extract($row);
												?>

												<tr>
													<td>
														
														<p class="">
															<?php echo $name ?>
														</p>
													</td>
													<td><?php echo $qty ?></td>
													<td><?php echo $cost ?></td>
													<td><?php echo $total ?></td>
												</tr>
						<?php 
					}
					?>
												
											</tbody>

											<tfoot>
												<tr>	
								   <td></td>
								   <td></td>
                                   <td>Sub total</td>
                                   <td><?php echo $total2 ?></td>
												</tr>
												<tr>	
								   <td></td>
								   <td></td>
                                   <td>Paid</td>
                                   <td><?php echo @$paid ?></td>
												</tr>

												<tr>	
								   <td></td>
								   <td></td>
                                   <td>Discount</td>
                                   <td><?php echo @$dis ?></td>
												</tr>

												<tr>	
								   <td></td>
								   <td></td>
                                   <td>Balance</td>
                                   <td><?php echo $total2 - $paid - $dis ?></td>
												</tr>
											</tfoot>
										</table>
									</div>
								</div>
							</div>
							<!-- Row end -->
						</div>
						<div class="invoice-footer">
							Thank you for your Business.
						</div>
<br><br>
						<center>
							Segnature <br>
							________________
						</center>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<style type="text/css">
	body{margin-top:20px;
    color: #2e323c;
    background: #f5f6fa;
    position: relative;
    height: 100%;
}
.invoice-container {
    padding: 1rem;
}
.invoice-container .invoice-header .invoice-logo {
    margin: 0.8rem 0 0 0;
    display: inline-block;
    font-size: 1.6rem;
    font-weight: 700;
    color: #2e323c;
}
.invoice-container .invoice-header .invoice-logo img {
    max-width: 130px;
}
.invoice-container .invoice-header address {
    font-size: 0.8rem;
    color: #9fa8b9;
    margin: 0;
}
.invoice-container .invoice-details {
    margin: 1rem 0 0 0;
    padding: 1rem;
    line-height: 180%;
    background: #f5f6fa;
    color: black;
    font-weight: bold !important;

}
.invoice-container .invoice-details .invoice-num {
    text-align: right;
    font-size: 0.8rem;
}
.invoice-container .invoice-body {
    padding: 1rem 0 0 0;
}
.invoice-container .invoice-footer {
    text-align: center;
    font-size: 0.7rem;
    margin: 5px 0 0 0;
}

.invoice-status {
    text-align: center;
    padding: 1rem;
    background: #ffffff;
    -webkit-border-radius: 4px;
    -moz-border-radius: 4px;
    border-radius: 4px;
    margin-bottom: 1rem;
}
.invoice-status h2.status {
    margin: 0 0 0.8rem 0;
}
.invoice-status h5.status-title {
    margin: 0 0 0.8rem 0;
    color: #9fa8b9;
}
.invoice-status p.status-type {
    margin: 0.5rem 0 0 0;
    padding: 0;
    line-height: 150%;
}
.invoice-status i {
    font-size: 1.5rem;
    margin: 0 0 1rem 0;
    display: inline-block;
    padding: 1rem;
    background: #f5f6fa;
    -webkit-border-radius: 50px;
    -moz-border-radius: 50px;
    border-radius: 50px;
}
.invoice-status .badge {
    text-transform: uppercase;
}

@media (max-width: 767px) {
    .invoice-container {
        padding: 1rem;
    }
}

@media print{
	.aaran{
		display: flex;
	}
	.custom-table{
		max-width: 2000px !important;
	}
	.address{
		margin-top:40px;
		margin-left: 90px;
		font-weight: bold !important;
	}
	.customer_info div{
		width: 100%;
		font-weight: bold !important;

	}
	
}


.custom-table {
    border: 1px solid #e0e3ec;
}
.custom-table thead {
    background: #007ae1;
}
.custom-table thead th {
    border: 0;
    color: #ffffff;
}
.custom-table > tbody tr:hover {
    background: #fafafa;
}
.custom-table > tbody tr:nth-of-type(even) {
    background-color: #ffffff;
}
.custom-table > tbody td {
    border: 1px solid #e6e9f0;
}


.card {
    background: #ffffff;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    border-radius: 5px;
    border: 0;
    margin-bottom: 1rem;
}

.text-success {
    color: #00bb42 !important;
}

.text-muted {
    color: #9fa8b9 !important;
}

.custom-actions-btns {
    margin: auto;
    display: flex;
    justify-content: flex-end;
}

.custom-actions-btns .btn {
    margin: .3rem 0 .3rem .3rem;
}
</style>

<script>
	window.print();
</script>