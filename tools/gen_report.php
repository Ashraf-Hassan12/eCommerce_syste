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
    .header-title{
        color: red;
    }
</style>
<div class="row">
 <div class="col-12" style="margin-top: 20px;">

 <div class="card">

<div class="card-body">
   <div style="width:100%;margin:3px;display: none;" class="btn btn-success" id="permission-msg">    </div>
 <h4 class="header-title"><?php echo $r['title'] ?></h4>
                                       
 <div class="tab-content">
  <div class="tab-pane show active" id="input-types-preview">
   <div class="row">
      <div class="col-lg-12">
<form action="<?php echo $r['form_action'] ?>" method="post" enctype="multipart/form-data" class="form_data report" >
    <div class="row">   
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
         <div class="col-2 ">
              <div class="mb-3">
               <label for="simpleinput" class="form-label"><?php echo $label ?></label>
<select load_action="<?php echo $load_action ?>" class="form-control <?php echo $class ?>" name="<?php echo $name ?>">
                    <option value="%">Choose One</option>
                    <?php get_dropdown($action,'') ?>
                </select>
           </div>
         </div>
<?php 
}elseif($type == "autocomplete"){
?>
<div class="col-3">
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
</div>
<?php

}elseif($type == "file"){
?>

<div class="mb-3 next-img">
<label for="simpleinput" class="form-label"><?php echo $label ?></label>
    <input type="hidden" value="<?php echo $name;?>" name="_next_upload_<?php echo $name;?> " class="form-control hide"/>
        
            <input class="form-control  preview-image" type="file" name="<?php echo $name;?>"     />

 
</div>

<?php
}else{
	?>
<div class="col-2">
    <div class="mb-3">
               <label for="simpleinput" class="form-label"><?php echo $label ?></label>
                <input name="<?php echo $name ?>" type="<?php echo $type ?>" id="simpleinput" class="form-control">
</div>
</div>
	<?php 
}
?>



   <?php 
   }
   ?>     

     <div class="col-2">  
   <button style="width:100%;margin-top: 30px;" class="btn btn-primary "><?php echo $r['button'] ?></button>
     </div>

                                                      
        
                                                         
                                                         
        
              </div>                                         
                
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

 <?php require("update_modal.php") ?>