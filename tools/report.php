<?php 
require("conn.php");
require("function.php");
  $sql = gen_sql($_POST,'');
$ress = $conn->query($sql);

if(@$ress->num_rows == 0){
	?>

 <div class="alert alert-warning">Not Found</div>
	<?php
	return false;
}
?>

<div class="tab-pane show active" id="basic-datatable-preview">
 <table id="basic-datatable" class="table dt-responsive nowrap w-100">
 	<?php table_row($ress) ?>
                                           
</table>
</div>



 <script src="assets/js/vendor/jquery.dataTables.min.js"></script>
        <script src="assets/js/vendor/dataTables.bootstrap5.js"></script>
        <script src="assets/js/vendor/dataTables.responsive.min.js"></script>
        <script src="assets/js/vendor/responsive.bootstrap5.min.js"></script>
        <script src="assets/js/vendor/dataTables.buttons.min.js"></script>
        <script src="assets/js/vendor/buttons.bootstrap5.min.js"></script>
        <script src="assets/js/vendor/buttons.html5.min.js"></script>
        <script src="assets/js/vendor/buttons.flash.min.js"></script>
        <script src="assets/js/vendor/buttons.print.min.js"></script>
        <script src="assets/js/vendor/dataTables.keyTable.min.js"></script>
        <script src="assets/js/vendor/dataTables.select.min.js"></script>
        <!-- third party js ends -->

        <!-- demo app -->
        <script src="assets/js/pages/demo.datatable-init.js"></script>