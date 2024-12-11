<?php 
require("function.php");
require("conn.php");
//print_r($_FILES);


 $sql = gen_sql($_POST,@$_FILES);
 $ress = $conn->query($sql);
 if($ress){

// $path = "uploads/".basename($_FILES['image_name_']['name']);
// move_uploaded_file($_FILES['image_name']['tmp_name'],$path);
 	$r = $ress->fetch_array();
 	

 	echo $r[0];

 }else{
 	echo $conn->error.$sql;
 }

?>