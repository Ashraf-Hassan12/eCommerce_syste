

$('body').delegate('.get_link','click',function(e){
   e.preventDefault();
var url = $(this).attr('href');
var id = $(this).attr('alt');
   // if(url == "tools/invoice_page.php"){
   //       window.location = url;
   //       return true;
   // }

   var data = "form_id="+id;
  // alert(data);
   $.get(url,data,function(ress){
//alert(ress);
   	 $(".form_place").html(ress);
   })
});

$("body").delegate(".form_data","submit",function(e){
   e.preventDefault();
   var url = $(this).attr('action');
  var frm = $(this);
   $.ajax({
      url: url,
      data: new FormData(this),
      contentType: false,
      processData: false,
       type: 'POST',
      success: function(res){
      // alert(res);
         if(frm.hasClass('report')){
            $('.form_response').html(res);
         }else if(frm.hasClass('update')){
            $(".update_response").removeClass('hide');
             $('.update_response').html(res);
         }else{
           var msg = res.split('|');
        
         if(msg[0] == "success"){
              frm.trigger("reset");
         }
         //frm.next().html(msg[1]);
         $('.form_response').html("<button style='width:100%;margin-top:5px' class='btn btn-"+msg[0]+"'>"+msg[1]+"</button>");
         }
         
      

      }
   })
});


$("body").delegate(".autocomplete","keyup",function(){
   var text = $(this).val();
   var action = $(this).attr('action');
   var ul = $(this).next();

   if(text == ""){
      ul.addClass('hide');
      return false;
   }
   ul.removeClass('hide');

   var data = "text="+text+"&action="+action;
//alert(data);
   $.post("tools/autocomplete.php",data,function(res){
        ul.html(res);
   })

})
$("body").delegate('.list-data','click',function(){
    var text = $(this).text();
    var id = $(this).attr('id');
    $(this).parent().prev().val(text);
    $(this).parent().next().val(id);
    $(this).parent().addClass('hide');
})



function readURL(input,img) {

  if (input.files && input.files[0]) {
    var reader = new FileReader();
//alert(img.attr('src'));
    reader.onload = function(e) {
      img.attr('src', e.target.result);
    }

    reader.readAsDataURL(input.files[0]);
  }
}

$("body").delegate(".preview-image","change",function(){
    readURL(this,$(this).closest(".next-img").next().find("img"));
});



$("body").delegate(".load","change",function(){
var ele = $(this);
   var id = $(this).val();
   var action = $(this).attr('load_action');
   //alert(action);
  
   var data = "id="+id+"&action="+action;
   // alert(data);
   $.post("tools/load_data.php",data,function(res){
  alert(res);
          ele.parent().parent().next().find('select').html(res);
   })
})

$("body").delegate(".price","keyup",function(){
    var tr = $(this).closest('tr');
    var qty = tr.find('.qty').text();
    var price = $(this).text();
    tr.find('.amount').text(qty*price);

    var sum = 0;
    $('.amount').each(function(){
        if($(this).text() == ""){
            return false;
        }

        sum += parseFloat($(this).text());
    })
    $('.sub_total').text(sum);
     $('.balance').text(sum);
})

$("body").delegate(".qty","keyup",function(){
    var tr = $(this).closest('tr');
    var price = tr.find('.price').text();
    var qty = $(this).text();
    tr.find('.amount').text(qty*price);
})

$('body').delegate('.paid','keyup',function(){
    var total = parseFloat($('.sub_total').text());
    var dis = parseFloat($('.discount').text());
    var paid = parseFloat($(this).text());

    if(isNaN(paid)){
        paid = 0;
       
    }
    $('.balance').text(total - paid - dis);
})


$('body').delegate('.discount','keyup',function(){
    var total = $('.sub_total').text();
    var paid = parseFloat($('.paid').text());
    var dis = parseFloat($(this).text());

    if(isNaN(dis)){
        dis = 0;
       
    }
    $('.balance').text(total - paid - dis);
})

$("body").delegate(".make_entry","click",function(){
    var kan = $(this);
    var tr = $(this).closest('tr');
    var qty = tr.find('.qty').text();
    var price = tr.find('.price').text();
    var product_id = tr.find('.product_id').val();
    var supplier = $(".supplier").val();
     var ref_no = $(".ref_no").val();
      var desc = $(".desc").val();
       var date = $(".date").val();
       var user_id = $(".user_id").val();
    var data = "sp=purchase_sp"+"&product_id="+product_id+"&qty="+qty+"&price="+price+"&supplier="+supplier
    +"&ref_no="+ref_no+"&desc="+desc+"&date="+date+"&user_id="+user_id;
  
 $.post("tools/save.php",data,function(res){
      kan.removeClass('fa-remove');
      kan.addClass('fa-check');
 })
})
$("body").delegate(".save_print","click",function(){
     var supplier = $(".supplier").val();
     var ref_no = $(".ref_no").val();
      var desc = $(".desc").val();
       var date = $(".date").val();
       var user_id = $(".user_id").val();
       var paid = $.trim(parseFloat($('.paid').text()));
       var discount = $.trim(parseFloat($('.discount').text()));
       var action = "purchase";



  var items = 0;
   $('.make_entry').each(function(){
    var tr = $(this).closest('tr');
    if(tr.find('.product_id').val() == 0){
        return true;
    }
     $(this).trigger('click');
     items++;
   });


    var data = "sp=payment_sp&"+"supplier="+supplier+"&ref_no="+ref_no+"&desc="+desc+"&date="+date
    +"&user_id="+user_id+"&paid="+paid+"&discount="+discount+"&action="+action;



if(paid > 0){
   $.post("tools/save.php",data,function(res){
      alert(res);
   })
}
var wait_time = items * 1000;

function print(){
    window.open("tools/print_invoice.php?ref_no="+ref_no+"&print=true");
}

setTimeout(print,wait_time);

});

$("body").delegate(".add_row","click",function(){
    var tr = $(this).closest('tr');
    var no  = tr.find('.no').text();
    var row = 
    `<tr>
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
</tr>`;
     $(".table_row").append(row);
})

$("body").delegate(".del_data","click",function(){
    var row = $(this).closest('tr');
    if(confirm("ma hubtaa inaad tirayso")){
        var table = $(this).attr('table');
        var colum = $(this).attr('colum');
        var value = $(this).attr('value');
        var user_id =$(this).attr('user_id');
        var data = "sp=delete_sp&table="+table+"&colum="+colum+"&value="+value+
        "&user_id="+user_id;

        $.post("tools/save.php",data,function(res){
            alert(res);
            row.remove();
        })
    }
});

$('body').delegate('.edit_data','click',function(){
         var table = $(this).attr('table');
        var colum = $(this).attr('colum');
        var value = $(this).attr('value');
        var user_id =$(this).attr('user_id');
        var action =$(this).attr('action');

    var data = "table="+table+"&colum="+colum+"&value="+value+
        "&user_id="+user_id+"&action="+action;
//alert(data);
        $.get("tools/search_row.php",data,function(res){
            $(".update_body").html(res);
            $("#update-modal").modal("show");
           
        })
})

$('body').delegate('.update_field','change',function(){
    $(this).parent().parent().next().find('.update-btn').removeClass('hide');
})

$('body').delegate('.update_field','keyup',function(){
    $(this).parent().parent().next().find('.update-btn').removeClass('hide');
})

$("body").delegate(".confirm","keyup",function(){
    $(".msg-error").text('');
     $(".button").attr("disabled",false);
    var pass = $(".pass").val();
    var confirm = $(this).val();

    if(confirm != pass){
        $(".button").prop("disabled",true);
       
        $(this).parent().after(`<small class="msg-error text-danger">Password Not Matched</small>`);
    }
})
$("body").delegate(".permission_check","change",function(){
    var type = "del";
    if($(this).is(":checked")){
        type = "insert";
    }

var form_id = $(this).attr('f');
var user_id = $(this).attr('user');
var gra = $(this).attr('granted_user');
var action = $(this).attr('action');

var data = "sp=add_permission_sp&f="+form_id+"&user_id="+user_id+"&gra="+gra+"&action="+action+"&type="+type;
$.post("tools/save.php",data,function(ress){
   // alert(ress);
     $("#permission-msg").css("display","block");
    $("#permission-msg").html(ress);
})
});


$("body").delegate(".chart_detail","click",function(){
    var action = $(this).attr('action');
    var text = $(this).find(".chart-text").text();
  var data = "sp=rp_chart_detail_sp&action="+action+"&form_name="+text;
    $.post("tools/chart_report.php",data,function(ress){
   // alert(ress);
     $(".modal-content").html(ress);
     $("#chart-modal").modal("show");
})

})
$("body").delegate(".print","click",function(){

 var divToPrint=document.getElementById("printerea");
var newWin=window.open('','Print-Window');

  newWin.document.open();

newWin.document.write('<html><head> <style>.item{text-transform: capitalize;}.ignore{display:none;} td,th{ padding: 2px !important;border: 1px solid black;font-weight: bold;} table{width:100% !important; border-collapse: collapse;}.print{display:none}</style></head><body onload="window.print();">'+divToPrint.innerHTML+'</body></html>');

  newWin.document.close();


})