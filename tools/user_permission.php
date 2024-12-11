<div class="row">

	<?php
	session_start(); 
require("conn.php");
$sql = "call show_permission_sp($_POST[_user_id],'menu','')";
$ress = $conn->query($sql);
while($row  = $ress->fetch_array()){
	//echo $row[0];
	?>
	<div class="col-4">
		<ul style="list-style: none">
         <h3 style="color: blue">	<?php echo $row['name'] ?></h3>
         	<?php 
require("conn.php");
$sq = "call show_permission_sp($_POST[_user_id],'forms',$row[id])";
$res = $conn->query($sq);
while($r  = $res->fetch_array()){
          ?>

<li>
	<input class="permission_check" f="<?php echo $r['id'] ?>"  user="<?php echo $_POST['_user_id'] ?>" granted_user="<?php echo $_SESSION['user_id'] ?>" action="<?php echo $r['action'] ?>"  <?php echo $r['ch'] == 'checked' ? $r['ch'] : '' ?> type="checkbox" name="">&nbsp;&nbsp;<?php echo $r['name'] ?>

</li>
  
	<?php 
}
?>
</ul>
	</div>

	<?php 
}
?>
</div>

<style type="text/css">
	li{
		margin: 5px;
		font-size: 18px;
	}
</style>