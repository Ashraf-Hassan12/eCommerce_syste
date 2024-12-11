<?php 
function get_company($col){
	require("conn.php");
	$sql = "select $col from company";
	$ress = $conn->query($sql);
	$r = $ress->fetch_array();
     return $r[0];
}

function get_val($sql){
	require("conn.php");
	$ress = $conn->query($sql);
	$r = $ress->fetch_array();
	return $r[0];
}

function get_checkbox($action,$id_p,$label,$name){
	require("conn.php");
	 $sql = "call get_dropdown_sp('$action','$id_p')";
	$ress = $conn->query($sql);

if($ress){
     
    if(@$ress->num_rows > 0){
    	?>

    	<?php
   while($row = $ress->fetch_array()){
    	 	$val = explode("|",$row[1]);
     	?>

 	    <div class="form-check form-check-inline">
 <input type="checkbox" class="form-check-input" value="<?php echo $row[0] ?>" name="<?php echo $name.'[]' ?>">
<label class="form-check-label" for="customCheckcolor1"><?php echo $val[0] ?></label>

 </div>
     	<?php 
     }
 }else{
 	echo "No Option to select ";
 }

}else{
	echo $conn->error;
}
}

function get_dropdown($action,$id_p){
	require("conn.php");
	 $sql = "call get_dropdown_sp('$action','$id_p')";
	$ress = $conn->query($sql);

if($ress){
     
    if(@$ress->num_rows > 0){
    	?>
<option >Choose One</option>
    	<?php
   while($row = $ress->fetch_array()){
    	 	$val = explode("|",$row[1]);
     	?>
  <option <?php echo $id_p == $row[0] ? 'selected' : '' ?> value="<?php echo $row[0] ?>" <?php echo @$val[1] ?>><?php echo @$val[0] ?></option>
     	<?php 
     }
 }else{
 	echo "<option>No Option to select go get_dropdown_sp and add action</option>";
 }

}else{
	echo $conn->error;
}

}


function gen_sql($post,$files){
    $sql = "CALL ";
unset($post['link_link_link']);

$c = count($post);
$i = 0;
foreach($post as $key => $val){
	$i++;
		if(is_array($val)){
	    $val = implode(",", $val);
	}
	
	$val = addslashes($val);

	if ($c ==1 && $i==$c){
		$sql .= $val."()";
	}
	else if($i == 1){
		$sql .= $val . " (";
	}else if((strpos($key, '_next_upload_') !== false) && $i == $c) {
	     $tmp = $files[$val]['tmp_name'];
		$file = addslashes($files[$val]['name']);
		 $path = upload($tmp, $file);
		$sql .= "'". $path . "')";
	}else if((strpos($key, '_next_multi_upload_') !== false) && $i == $c) {
	    $files = "";
	      $total_files = count($_FILES[$val]['name']);
  
  for($f = 0; $f < $total_files; $f++) {
    
    // Check if file is selected
    if(isset($_FILES[$val]['name'][$f]) 
                      && $_FILES[$val]['size'][$f] > 0) {
      
       $tmp = $_FILES[$val]['tmp_name'][$f];
		$file = addslashes($_FILES[$val]['name'][$f]);
		 $path = upload($tmp, $file);
	
      $files.=$path.";";
    }
    
  }
	    
		$sql .= "'". $files . "')";
	}
	else if ($i == $c){
		$sql .= "'". $val . "')";
	}else if(strpos($key, '_next_upload_') !== false) {
		 $tmp = $files[$val]['tmp_name'];
		$file = addslashes($files[$val]['name']);
		 $path = upload($tmp, $file);
		$sql .= "'". $path . "',";
		
	}else if(strpos($key, '_next_multi_upload_') !== false) {
	    $files = "";
	      $total_files = count($_FILES[$val]['name']);
  
  for($f = 0; $f < $total_files; $f++) {
    
    // Check if file is selected
    if(isset($_FILES[$val]['name'][$f]) 
                      && $_FILES[$val]['size'][$f] > 0) {
      
       $tmp = $_FILES[$val]['tmp_name'][$f];
		$file = addslashes($_FILES[$val]['name'][$f]);
		 $path = upload($tmp, $file);
	
      $files.=$path.";";
    }
    
  }
	    
		$sql .= "'". $files . "',";
	}
	else{
		$sql .= "'". $val . "',";
	}
}
return $sql;
}


function upload($tmp,$file){
    

    $ext = pathinfo($file, PATHINFO_EXTENSION);
    $ext = strtolower($ext);
    $p = "../uploads/";
        $path = $p.$file;
        $path2 = str_replace("../","",$path);
        
        move_uploaded_file($tmp,$path);
        return $path;
    
	

}

function  table_row($ress){
	$col = $ress->fetch_fields();
?>

<thead>
	<tr>
		<?php 
     foreach($col as $key){
  	$k = explode("~",$key->name);
     	  ?>

<th class="<?php echo @$k[1] ?>"><?php echo @$k[0] ?></th>


     	  <?php
     }

		?>
	</tr>
</thead>

<tbody>
	<?php 
while($row = $ress->fetch_assoc()){
	?>
	<tr>
	<?php 
  foreach($row as $key => $val){
$v = explode("~",$key);
if(@$v[1] == 'image'){
?>
 <td><img style="width:50px" src="<?php echo @$val ?>"></td>
<?php

}else if(@$v[1] == "dropdown"){

?>
<td>
	<select>
		<?php get_dropdown(@$v[2],'') ?>
	</select>
</td>
<?php

}else{
?>
<td><?php echo @$val ?></td>
    <?php
  }
}
	?>
	</tr>

	<?php
}
?>
</tbody>


<?php
}

?>