<?php 

require("conn.php");
extract($_POST);
$sql = "call autocomplete_sp('$text','$action')";
$ress = $conn->query($sql);
if($ress){

	if(@$ress->num_rows > 0){
            while($row = $ress->fetch_array()){
            	?>
   <li id="<?php echo $row[0] ?>" class="list-data"><?php echo $row[1] ?></li>
            	<?php
            }
	}else{
		echo "<div style='color:red'>Not Found</div>";
	}

}else{
	echo $conn->error.$sql;
}
?>




<style type="text/css">
	.list-data{
		border: 1px solid gray;
       cursor: pointer;
        padding-left: 5px;
	}
	.list-data:hover{
		background: #f2f2f2;
	}
</style>