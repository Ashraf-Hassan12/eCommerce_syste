<?php 
session_start();
 require("conn.php");
 // $username = $_POST['username'];
 extract($_POST);
 $sql = "call login_sp('$username','$password')";
 $res = $conn->query($sql);

 $msg = $res->fetch_array();

 if($msg['error']){
 	header("location: ../index.php?error=$msg[0]");

 }else{


 	foreach($msg as $key => $val){
 		$_SESSION[$key] = $val;
 	}


 	header("location: ../home.php");
 }

?>