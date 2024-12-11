<?php 
session_start();
require("conn.php");
require("function.php");
$logo = get_company("logo");
$fname = $_POST['form_name'];
unset($_POST['form_name']);
  $sql = gen_sql($_POST,'');
$ress = $conn->query($sql);

if(@$ress->num_rows == 0){
	?>

 <div class="alert alert-warning">Not Found</div>
	<?php
	return false;
}
?>



<div class="container " id="printerea">
  <br>
  <button class="btn btn-primary hidden print">print ></button>
  <center><img style="width:100px" src="<?php echo $logo ?>"></center>
  <center><?php echo $fname ?></center>
 <table  id="bytable" class="border border-dark " width="100%" >
  <?php table_row($ress) ?>
                                           
</table>
<center>Printed By: <?php echo $_SESSION['full_name'] ?></center>
<br><br>
</div>


<style type="text/css">

  #bytable{
    border-collapse: collapse;
    padding: 10px;
  }
  th,td{
    padding: 5px;
    border: 1px solid black;
  }

  @media{
    #bytable{
    border-collapse: collapse;
    padding: 10px;
  }
  th,td{
    padding: 5px;
    border: 1px solid black;
  }
  }
</style>


