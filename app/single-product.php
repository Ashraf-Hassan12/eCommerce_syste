
<?php 
require("../tools/function.php");
$tell = get_company('tell');
require("../tools/conn.php");
extract($_GET);
$sql = "call show_products_sp($id)";
$ress = $conn->query($sql);
$r = $ress->fetch_array();
extract($r);
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, viewport-fit=cover, shrink-to-fit=no">
    <meta name="description" content="Suha - Multipurpose Ecommerce Mobile HTML Template">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="theme-color" content="#100DD1">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <!-- The above tags *must* come first in the head, any other head content must come *after* these tags -->
    <!-- Title -->
    <title>Suha - Multipurpose Ecommerce Mobile HTML Template</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hind+Siliguri:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet">
    <!-- Favicon -->
    <link rel="icon" href="img/icons/icon-72x72.png">
    <!-- Apple Touch Icon -->
    <link rel="apple-touch-icon" href="img/icons/icon-96x96.png">
    <link rel="apple-touch-icon" sizes="152x152" href="img/icons/icon-152x152.png">
    <link rel="apple-touch-icon" sizes="167x167" href="img/icons/icon-167x167.png">
    <link rel="apple-touch-icon" sizes="180x180" href="img/icons/icon-180x180.png">
    <!-- CSS Libraries -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/all.min.css">
    <link rel="stylesheet" href="css/brands.min.css">
    <link rel="stylesheet" href="css/solid.min.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
    <link rel="stylesheet" href="css/nice-select.css">
    <!-- Stylesheet -->
    <link rel="stylesheet" href="style.css">
    <!-- Web App Manifest -->
    <link rel="manifest" href="manifest.json">
  </head>
  <body>
    <!-- Preloader-->
    <div class="preloader" id="preloader">
      <div class="spinner-grow text-secondary" role="status">
        <div class="sr-only"></div>
      </div>
    </div>
    <!-- Header Area-->
    <div class="header-area" id="headerArea">
      <div class="container h-100 d-flex align-items-center justify-content-between rtl-flex-d-row-r">
        <!-- Back Button-->
        <div class="back-button me-2"><a href="shop-grid.html"><i class="fa-solid fa-arrow-left-long"></i></a></div>
        <!-- Page Title-->
        <div class="page-heading">
          <h6 class="mb-0">Product Details</h6>
        </div>
        <!-- Navbar Toggler-->
        <div class="suha-navbar-toggler ms-2" data-bs-toggle="offcanvas" data-bs-target="#suhaOffcanvas" aria-controls="suhaOffcanvas">
          <div><span></span><span></span><span></span></div>
        </div>
      </div>
    </div>
    <div class="offcanvas offcanvas-start suha-offcanvas-wrap" tabindex="-1" id="suhaOffcanvas" aria-labelledby="suhaOffcanvasLabel">
      <!-- Close button-->
      <button class="btn-close btn-close-white" type="button" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      <!-- Offcanvas body-->
      <div class="offcanvas-body">
        <!-- Sidenav Profile-->
        <div class="sidenav-profile">
          <div class="user-profile"><img src="img/bg-img/9.jpg" alt=""></div>
          <div class="user-info">
            <h5 class="user-name mb-1 text-white">Suha Sarah</h5>
            <p class="available-balance text-white">Available points <span class="counter">499</span></p>
          </div>
        </div>
        <!-- Sidenav Nav-->
        <ul class="sidenav-nav ps-0">
          <li><a href="profile.html"><i class="fa-solid fa-user"></i>My Profile</a></li>
          <li><a href="notifications.html"><i class="fa-solid fa-bell lni-tada-effect"></i>Notifications<span class="ms-1 badge badge-warning">3</span></a></li>
          <li class="suha-dropdown-menu"><a href="#"><i class="fa-solid fa-store"></i>Shop Pages</a>
            <ul>
              <li><a href="shop-grid.html">Shop Grid</a></li>
              <li><a href="shop-list.html">Shop List</a></li>
              <li><a href="single-product.html">Product Details</a></li>
              <li><a href="featured-products.html">Featured Products</a></li>
              <li><a href="flash-sale.html">Flash Sale</a></li>
            </ul>
          </li>
          <li><a href="pages.html"><i class="fa-solid fa-file-code"></i>All Pages</a></li>
          <li class="suha-dropdown-menu"><a href="wishlist-grid.html"><i class="fa-solid fa-heart"></i>My Wishlist</a>
            <ul>
              <li><a href="wishlist-grid.html">Wishlist Grid</a></li>
              <li><a href="wishlist-list.html">Wishlist List</a></li>
            </ul>
          </li>
          <li><a href="settings.html"><i class="fa-solid fa-sliders"></i>Settings</a></li>
          <li><a href="intro.html"><i class="fa-solid fa-toggle-off"></i>Sign Out</a></li>
        </ul>
      </div>
    </div>
    <div class="page-content-wrapper">
      <div class="product-slide-wrapper">
        <!-- Product Slides-->
        <div class="product-slides owl-carousel">
          <!-- Single Hero Slide-->
          <div class="single-product-slide ">
            <img class="set_image" src="<?php echo $image ?>">
          </div>
        
        
        </div>
        <!-- Video Button--><a class="video-btn shadow-sm" id="singleProductVideoBtn" href="https://www.youtube.com/watch?v=lFGvqvPh5jI"><i class="fa-solid fa-play"></i></a>
      </div>
      <div class="product-description pb-3">
        <!-- Product Title & Meta Data-->
        <div class="product-title-meta-data bg-white mb-3 py-3">
          <div class="container d-flex justify-content-between rtl-flex-d-row-r">
            <div class="p-title-price">
              <h5 id="<?php echo $id ?>" class="mb-1 item_name">$<?php echo $name ?></h5>
              <p price="<?php echo $sales ?>" class="sale-price mb-0 lh-1"><?php echo $sales ?>
              <span><?php echo $discount ?></span></p>
            </div>
            <div class="p-wishlist-share"><a href="wishlist-grid.html"><i class="fa-solid fa-heart"></i></a></div>
          </div>

            <div class="selection-panel bg-white mb-3 py-3">
          <div class="container d-flex align-items-center justify-content-between">
            <!-- Choose Color-->
            <div class="choose-color-wrapper">
            
              <div style="margin-left: -30px;" class="choose-color-radio d-flex align-items-center">
                <!-- Single Radio Input-->
                <div class="form-check mb-0 image-color">
                  <img class="get_image" style="width:60px;border:1px solid" src="<?php echo $image ?>">
                </div>
                <!-- Single Radio Input-->
                <div class="form-check mb-0 image-color">
                  <img class="get_image" style="width:60px;border:1px solid" src="<?php echo $image2 ?>">
                </div>
                <!-- Single Radio Input-->
                <div class="form-check mb-0 image-color">
                 <img class="get_image" style="width:60px;border:1px solid" src="<?php echo $image3 ?>">
                </div>
              
              <style>

              </style>
              </div>
            </div>
           
          </div>
        </div>
          <!-- Ratings-->
          <div class="product-ratings">
            <div class="container d-flex align-items-center justify-content-between rtl-flex-d-row-r">
              <div class="ratings"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><span class="ps-1">3 ratings</span></div>
              <div class="total-result-of-ratings"><span>5.0</span><span>Very Good                                </span></div>
            </div>
          </div>
          <div style="padding: 10px;">
            <p><?php echo $description ?></p>
          </div>
        </div>
      
        <!-- Selection Panel-->
      
        <!-- Add To Cart-->
       <!--  <div class="cart-form-wrapper bg-white mb-3 py-3">
          <div class="container">
            <form class="cart-form" action="#" method="">
              <div class="order-plus-minus d-flex align-items-center">
                <div class="quantity-button-handler">-</div>
                <input class="form-control cart-quantity-input" type="text" step="1" name="quantity" value="3">
                <div class="quantity-button-handler">+</div>
              </div>
              <button class="btn btn-danger ms-3" type="submit">Add To Cart</button>
            </form>
          </div>
        </div> -->
    
      
        <div class="pb-3"></div>
        <!-- Related Products Slides-->
        <div class="related-product-wrapper bg-white py-3 mb-3">
          <div class="container">
            <div class="section-heading d-flex align-items-center justify-content-between rtl-flex-d-row-r">
              <h6>Related Products</h6><a class="btn p-0" href="shop-grid.html">View All</a>
            </div>
              <div class="top-products-area py-3">
        <div class="container">
       
          <div class="row g-2">
            <!-- Product Card -->
<?php 
require("../tools/conn.php");
$sql = "call show_releted_products_sp($id)";
$ress = $conn->query($sql);
while($row = $ress->fetch_array()){
?>
           <div class="col-6 col-md-4 get_data">
              <div class="card product-card">
                <div class="card-body">
                  <!-- Badge--><span class="badge rounded-pill badge-warning">Sale</span>
                  <!-- Wishlist Button--><a class="wishlist-btn" href="#"><i class="fa-solid fa-heart">                       </i></a>
                  <!-- Thumbnail --><a class="product-thumbnail d-block" href="single-product.php?id=<?php echo $row['id'] ?>">
                    <img class="mb-2" src="<?php echo $row['image'] ?>" alt="">
                    <!-- Offer Countdown Timer: Please use event time this format: YYYY/MM/DD hh:mm:ss -->
                    <ul  class="offer-countdown-timer d-flex align-items-center shadow-sm" data-countdown="2023/12/31 23:59:59">
                      <li><span class="days">0</span>d</li>
                      <li><span class="hours">0</span>h</li>
                      <li><span class="minutes">0</span>m</li>
                      <li><span class="seconds">0</span>s</li>
                    </ul></a>
                  <!-- Product Title -->
                  <a class="product-title" href="single-product.php?id=<?php echo $row['id'] ?>"><?php echo $row['name'] ?></a>
                  <!-- Product Price -->
                  <p class="sale-price">$<?php echo $row['sales'] ?><span><?php echo  $row['discount']?></span></p>
                  <!-- Rating -->
                  <div class="product-rating"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></div>
                  <!-- Add to Cart -->
                  <a class="btn btn-success btn-sm " href="#">
                    <i product_id="<?php echo $row['id'] ?>" class="fa-solid fa-cart-shopping  addcart  first"></i></a>
                </div>
              </div>
            </div>
  <?php 
}
?>
            <!--end-->
          </div>
        </div>
      </div>
          </div>
        </div>
      
      </div>
    </div>
    <!-- Internet Connection Status-->
    <div class="internet-connection-status" id="internetStatus"></div>
    <!-- Footer Nav-->
 <div style="background: #2d3693" class="footer-nav-area" id="footerNav">
      <div class="suha-footer-nav">
        <ul class="h-200 d-flex align-items-center justify-content-between ps-0 d-flex rtl-flex-d-row-r">


          <li><a href="https://wa.me/252<?php echo $tell.'?text='.$sms?>"><i class="fa-brands fa-whatsapp"></i>Whatsapp</a></li>
          <li><a href="tel:<?php echo $tell?>"><i class="fa-solid fa-phone"></i>Call</a></li>
           <li>
            <a data="" href="checkout.php?item_id=<?php echo $id ?>&price=<?php echo $sales ?>&name=<?php echo $name ?>" class="set_data btn btn-success">
              <span class="">Hada Iibso</span>
             
         </a></li>
         
        </ul>
      </div>
    </div>
    <!-- All JavaScript Files-->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/jquery.min.js"></script>
    <script src="js/waypoints.min.js"></script>
    <script src="js/jquery.easing.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/jquery.counterup.min.js"></script>
    <script src="js/jquery.countdown.min.js"></script>
    <script src="js/jquery.passwordstrength.js"></script>
    <script src="js/jquery.nice-select.min.js"></script>
    <script src="js/theme-switching.js"></script>
    <script src="js/no-internet.js"></script>
    <script src="js/active.js"></script>
    <script src="js/pwa.js"></script>
     <script src="js/app.js"></script>
  </body>
</html>