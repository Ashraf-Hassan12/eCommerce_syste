<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
  </head>
  <body>
   
<div class="container">
  <center>  Purchase Form</center>
  <div class="row">
      <div class="col-3">
          <div class="form-group">
            <label> Supplier Name</label>
            <input type="text" name="" class="form-control supplier">
          </div>

      </div>

         <div class="col-3">
          <div class="form-group">
            <label> Invoice Number</label>
            <input type="number" name="" class="form-control  ref_no">
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
     <table class="table table-striped table-bordered">
         <thead>
             <tr>
                 <th>No</th>
                 <th>Item Name</th>
                 <th>Quantity</th>
                 <th>Price</th>
                 <th>Amount</th>
             </tr>
         </thead>

         <tbody>    
<tr>
    <td></td>
     <td></td>
      <td></td>
       <td></td>
        <td></td>
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
        <td class="balance">0</td>
      </tr>

       <tr>
      <td></td>
     <td></td>
      <td></td>
       <td>Choose Account</td>
        <td class="sub_total">
          
          <select></select>
        </td>
      </tr>
         </tfoot>
     </table>
     <div class="row">
    <div style="margin-left: 1000px;" class="6">
      
         <button class="btn btn-success">Save & New</button>
     
     
          <button class="btn btn-primary">Save & Print</button>
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
</style>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
  </body>
</html>