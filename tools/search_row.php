<?php 
session_start();
require("conn.php");
require("function.php");
$sql = "call search_row_sp('$_GET[action]','$_GET[value]')";
$ress = $conn->query($sql);
if(!$ress){
    echo $conn->error;
}
if(@$ress->num_rows ==0){
   echo "Go To search_row_sp add action<br>  elseif(_action='$_GET[action]')then select * from $_GET[table] where $_GET[colum] = _val;";
   return false;
}
?>
<style type="text/css">
    .header-title{fas
        color: red;
    }
</style>
<div class="row">
 <div class="col-12" style="margin:auto;margin-top: 20px;">
 <div class="card">
<div class="card-body">
 <?php 
 $cols = $ress->fetch_fields();
while($row = $ress->fetch_assoc()){
    //print_r($row);
    foreach($cols as $key){
        $name = explode("~",@$key->name);
        $type = @$name[1];
        $action = @$name[2];

if($type == "dropdown"){
    ?>
<form action="tools/save.php" method="post" class="form_data update">
    <input type="hidden" name="sp" value="update_sp">
    <input type="hidden" name="table" value="<?php echo $key->orgtable?>">
    <input type="hidden" name="set_col" value="<?php echo $key->orgname?>">
    <input type="hidden" name="id" value="<?php echo $_GET['value'] ?>">
     <input type="hidden" name="col" value="<?php echo $_GET['colum'] ?>">
    <input type="hidden" name="user_id" value="<?php echo $_SESSION['user_id'] ?>">
<div class="row">
<div class="col-10">
<div class="mb-3">

    <label for="simpleinput" class="form-label"><?php echo $name[0] ?></label>
                <select  name="name"  class="form-control update_field">
                  <?php get_dropdown($action,$row[$key->name]) ?>
                </select>
</div>

</div>
<div class="col-2">
    <button style="margin-top: 30px" class="btn btn-primary update-btn hide">Update</button>
</div>
</div>

                                                      
        
                                                         
                                                         
        
                                                       
                
 </form>

    <?php
}else{
 ?>
 <form action="tools/save.php" method="post" class="form_data update">
    <input type="hidden" name="sp" value="update_sp">
    <input type="hidden" name="table" value="<?php echo $key->orgtable?>">
    <input type="hidden" name="set_col" value="<?php echo $key->orgname?>">
    <input type="hidden" name="id" value="<?php echo $_GET['value'] ?>">
     <input type="hidden" name="col" value="<?php echo $_GET['colum'] ?>">
    <input type="hidden" name="user_id" value="<?php echo $_SESSION['user_id'] ?>">
<div class="row">
<div class="col-10">
<div class="mb-3">

    <label for="simpleinput" class="form-label"><?php echo $name[0] ?></label>
                <input value="<?php echo $row[$key->name] ?>" name="name" type="<?php echo $name[1] ?>" id="simpleinput" class="form-control update_field">
</div>

</div>
<div class="col-2">
    <button style="margin-top: 30px" class="btn btn-primary update-btn hide">Update</button>
</div>
</div>

                                                      
        
                                                         
                                                         
        
                                                       
                
 </form>
<?php 
}
}
}
?>
<button style="width:100%" class="update_response hide btn btn-success"></button>
 </div>
<style type="text/css">
    .hide{
        display: none;
    }
</style>
 
</div>
</div>
     
 </div>
</div> <!-- end col -->
 </div>
</div> <!-- end preview-->
 </div> <!-- end preview code-->
</div> <!-- end tab-content-->
</div> <!-- end card-body -->
 </div> <!-- end card -->
 </div><!-- end col -->


 </div>

 <style type="text/css">
     .hide{
        display: none;
     }
 </style>