<?php 
require("conn.php");
require("function.php");
extract($_POST);


	 $sql = "call get_dropdown_sp('$action',$id)";
	$ress = $conn->query($sql);

if($ress){
     
    if(@$ress->num_rows > 0){
    	?>
<option  value="%" >Choose One</option>
    	<?php
   while($row = $ress->fetch_array()){
    	 	$val = explode("|",$row[1]);
     	?>
  <option value="<?php echo $row[0] ?>" <?php echo @$val[1] ?>><?php echo @$val[0] ?></option>
     	<?php 
     }
 }else{
 	echo "<option>No Option to select go get_dropdown_sp and add action</option>";
 }

}else{
	echo $conn->error;
}
?>

