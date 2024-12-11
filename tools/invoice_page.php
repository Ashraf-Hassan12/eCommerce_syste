<?php 
session_start();
require("function.php");
$ref_no = get_val("select ref_no()");

?>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
  
  </head>
  <body>
   
<div class="container">
  <center>  Purchase Form</center>
  <div class="row">
    <input class="user_id" type="hidden" value="<?php echo $_SESSION['user_id'] ?>">
      <div class="col-3">
          <div class="form-group">
            <label> Supplier Name</label>
            <input  action="supplier" type="text" name="" class="form-control  autocomplete">
            <ul style="list-style: none;" class="hide list-group">
   
</ul>

<input type="hidden" class="supplier" >
          </div>
<style type="text/css">
    .hide{
        display: none;
    }
</style>
      </div>

         <div class="col-3">
          <div class="form-group">
            <label> Invoice Number</label>
            <input type="number" name="" class="form-control  ref_no" value="<?php echo $ref_no ?>">
          </div>

      </div>

        <div class="col-3">
          <div class="form-group">
            <label> description</label>
            <input type="text" name="" class="form-control  desc">
          </div>

      </div>

        <div class="col-2">
          <div class="form-group">
            <label>Date</label>
            <input type="date" name="" class="form-control  date">
          </div>

      </div>


  </div>
  <br>
  <div class="card">
    
<div style="background: blue;color: white;" class="card-header">
<h2 style="text-align: center;">Order Summary</h2>

</div>

 <div class="card-body">
     <table class="table table-striped table-bordered  table_row">
         <thead>
             <tr>
                 <th>No</th>
                 <th>Item Name</th>
                 <th>Quantity</th>
                 <th>Price</th>
                 <th>Amount</th>
                 <th style="display: none;">Save</th>
                 <th>Action</th>
             </tr>
         </thead>

         <tbody>    
<tr>
    <td class="no">1</td>
     <td contenteditable class="item">
       <input type="text" class="autocomplete form-control" action="item" name="">
        <ul style="list-style: none;" class="hide list-group">
   
</ul>
<input class="product_id" type="hidden" name="">
     </td>
      <td contenteditable class="qty"></td>
       <td contenteditable class="price"></td>
      <td class="amount"></td>
      <td><i class="fa fa-remove make_entry"></i></td>
      <td><button class="btn btn-success add_row">Add</button></td>
</tr>


         </tbody>

         <tfoot>
    <tr>
      <td></td>
     <td></td>
      <td></td>
       <td>Sub Total</td>
        <td class="sub_total">0</td>
      </tr>

       <tr>
      <td></td>
      <td></td>
      <td></td>
       <td>Paid</td>
        <td class="paid" contenteditable>0</td>
      </tr>

       <tr>
      <td></td>
     <td></td>
      <td></td>
       <td>Discount</td>
        <td class="discount" contenteditable>0</td>
      </tr>

       <tr>
      <td></td>
     <td></td>
      <td></td>
       <td>Balance</td>
        <td class="balance">$0</td>
      </tr>

       <tr>
      <td></td>
     <td></td>
      <td></td>
       <td>Choose Account</td>
        <td class="account">
          
          <select>
            <?php get_dropdown('account','') ?>
          </select>
        </td>
      </tr>
         </tfoot>
     </table>
     <div class="row">
    <div style="margin-left: 1000px;" class="6">
      
         <button class="btn btn-success">Save & New</button>
     
     
          <button class="btn btn-primary  save_print">Save & Print</button>
    </div>
     
 </div>
 
</div>

</div>


<style>
  .btn{
    margin: 5px;
  }
  tfoot td:empty{
    border: none !important;
  }
  .make_entry{
    cursor: pointer;
    display: none;
  }
</style>
 
  </body>
</html>