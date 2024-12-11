$("body").delegate(".get_product","click",function(e){
	e.preventDefault();
	$('.catagory-card').removeClass('active');
	$(this).addClass('active');
var url = $(this).attr('href');

$.get(url,function(res){
	//alert(res);
	$('.product_place').html(res);
})
})
$("body").delegate('.addcart',"click",function(e){
   e.preventDefault();

   if($(this).hasClass('first')){
   	   $(this).removeClass('addcart');

   }

   var count = parseInt($('.cartcounnt').text());

   $('.cartcounnt').text(count+1);

   var id = localStorage.getItem('product');

var product_id = $(this).attr('product_id');



if(id == null){
	id = 0;
}

var item_id = id +','+ product_id;

$('.set_data').attr('href','salad.php?id='+item_id);
   localStorage.setItem('count',count+1);
   localStorage.setItem('product',item_id);
   swal("Success","Cart Aded","success");

// $(this).each(function(){
// 	var row = $(this).closest('.get_data');
// 	const data = {
//            image: row.find('img').attr('src'),
//            name: row.find('.product-title').text(),
//            price: row.find('.sale-price').text()
// 	}
// 	console.log(data.image);
// })
})

$(window).on('load', function() {
   var localdata = localStorage.getItem('count');
   var order_tell = localStorage.getItem('order_tell');
   var order_address = localStorage.getItem('order_address');

   if(localdata == null){
   	localdata = 0;
   }
  // alert(localdata);
    $('.cartcounnt').text(localdata);
    $('#tell').val(order_tell);
    $('#address').val(order_address);
});

$("body").delegate(".get_image","click",function(){
	var src = $(this).attr('src');



  var imageUrl = src;
              


	$(".set_image").attr("src",imageUrl);
})

$("body").delegate(".paynow",'click',function(){
   var price = $('#price').val();
   var item_id = $('#item_id').val();
var tell = $('#tell').val();
var address = $('#address').val();
 var itemname = $('.item').val();

   var data = "price="+price+"&item_id="+item_id+"&tell="+tell+"&address="+address+"&itemname="+itemname;
   $.post("save_order.php",data,function(res){
     alert(res);
       if($.trim(res) == "successfull"){
         //alert($.trim(res));
         localStorage.setItem('order_tell',tell);
         localStorage.setItem('order_address',address);
        // alert(1);
        window.location = "payment-success.php";
       }else{
        swal("error","Transaction Failed","error");
       }
   })
})