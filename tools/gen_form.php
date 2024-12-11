<?php 
session_start();
require("conn.php");
require("function.php");
$sql = "call form_info($_GET[form_id],$_SESSION[user_id])";
$ress = $conn->query($sql);
$r = $ress->fetch_assoc();
if(@$r['error']){
	echo @$r['error'];
	return false;
}
?>
<style type="text/css">
    .header-title{fas
        color: red;
    }
</style>
<div class="row">
 <div class="col-8" style="margin:auto;margin-top: 20px;">
 <div class="card">
<div class="card-body">
 <h4 class="header-title"><?php echo $r['title'] ?></h4>
                                       
 <div class="tab-content">
  <div class="tab-pane show active" id="input-types-preview">
   <div class="row">
      <div class="col-lg-12">
<form action="<?php echo $r['form_action'] ?>" method="post" enctype="multipart/form-data" class="form_data" >
         	<input type="hidden" name="sp_name" value="<?php echo $r['sp'] ?>">
        <?php 
        require("conn.php");
  $sql1 = "SELECT * FROM `form_input` WHERE form_id=$_GET[form_id]";
  $res = $conn->query($sql1);
  while($row = $res->fetch_array()){
  	extract($row);

if($type == "user_id"){
   ?>
<input type="hidden" name="<?php echo $name ?>" value="<?php echo $_SESSION['user_id'] ?>">
   <?php
}elseif($type == "dropdown"){
        ?>                                                  
          <div class="mb-3">
               <label for="simpleinput" class="form-label"><?php echo $label ?></label>
                <select class="form-control" name="<?php echo $name ?>">
                	<option>Choose One</option>
                	<?php get_dropdown($action,'') ?>
                </select>
           </div>
<?php 
}elseif($type == "autocomplete"){
?>

<div class="mb-3">
<label for="simpleinput" class="form-label"><?php echo $label ?></label>
 <input action="<?php echo $action ?>"  type="<?php echo $type ?>" id="simpleinput" class="form-control autocomplete">

<ul style="list-style: none;" class="hide list-group">
   
</ul>

<input type="hidden" name="<?php echo $name ?>">

<style type="text/css">
    .hide{
        display: none;
    }
</style>
</div>

<?php

}elseif($type == "file"){
?>

<div class="mb-3 next-img">
<label for="simpleinput" class="form-label"><?php echo $label ?></label>
    <input type="hidden" value="<?php echo $name;?>" name="_next_upload_<?php echo $name;?> " class="form-control "/>
        
            <input class="form-control  preview-image" type="file" name="<?php echo $name;?>"     />

 
</div>

<?php
}elseif($type == "checkbox"){
   ?>
  <div class="mb-3">
     
          <?php  get_checkbox($action,'',$label,$name);?>
    
  </div>

   <?php 
}else{
	?>
<div class="mb-3">
               <label for="simpleinput" class="form-label"><?php echo $label ?></label>
    <input name="<?php echo $name ?>" type="<?php echo $type ?>" id="simpleinput" class="form-control <?php echo $class ?>">
</div>
	<?php 
}
?>



   <?php 
   }
   ?>     

        <button style="width:100%" class="btn btn-primary  btn-block button"><?php echo $r['button'] ?></button>

                                                      
        
                                                         
                                                         
        
                                                       
                
 </form>

 <div class="form_response">
     
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