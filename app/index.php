<?php 
require("../tools/function.php");
$tell = get_company('tell');
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
    <!-- Header Area -->
    <div style="background: #2d3693" class="header-area" id="headerArea">
      <div class="container h-100 d-flex align-items-center justify-content-between d-flex rtl-flex-d-row-r">
        <!-- Logo Wrapper -->
        <div class="logo-wrapper"><a href="index.php">
          <img style="width:50px;border-radius: 50px;" src="img/logo.png" alt=""></a></div>
        <div class="navbar-logo-container d-flex align-items-center">
          <!-- Cart Icon -->
          <div class="cart-icon-wrap">
            <a data="" href="salad.php" class="set_data">
              <i style="color: white" class="fa-solid fa-cart-shopping "></i>
          <span style="background: #6abe45" class="cartcounnt">0</span></a></div>
          <!-- User Profile Icon -->
         
          <!-- Navbar Toggler -->
          <div style="background: white"  class="suha-navbar-toggler ms-2" data-bs-toggle="offcanvas" data-bs-target="#suhaOffcanvas" aria-controls="suhaOffcanvas">
            <div><span></span><span></span><span></span></div>
          </div>
        </div>
      </div>
    </div>
    <div style="background: #6abe45;" class="offcanvas offcanvas-start suha-offcanvas-wrap" tabindex="-1" id="suhaOffcanvas" aria-labelledby="suhaOffcanvasLabel">
      <!-- Close button-->
      <button class="btn-close btn-close-white" type="button" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      <!-- Offcanvas body-->
      <div class="offcanvas-body">
        <!-- Sidenav Profile-->
        <div class="sidenav-profile">
          <div class="user-profile"><img src="img/logo.png" alt=""></div>
          <div class="user-info">
            <h5 class="user-name mb-1 text-white">Aaran market</h5>
           
          </div>
        </div>
        <!-- Sidenav Nav-->
        <ul class="sidenav-nav ps-0">
        
          <li><a href="settings.html"><i class="fa-solid fa-sliders"></i>My Order</a></li>
            <li><a href="lastorder.php"><i class="fa-solid fa-sliders"></i>Last Order</a></li>
              <li><a href="settings.html"><i class="fa-solid fa-sliders"></i>WhatsApp</a></li>
        </ul>
      </div>
    </div>

    <div class="page-content-wrapper">
      <!-- Search Form-->
      <!-- Search Form-->
      <div class="container">
        <div class="search-form pt-3 rtl-flex-d-row-r">
          <form action="#" method="">
            <input class="form-control" type="search" placeholder="Search in Suha">
            <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
          </form>
          <!-- Alternative Search Options -->
          <div class="alternative-search-options">
            <div class="dropdown"><a class="btn btn-danger dropdown-toggle" id="altSearchOption" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fa-solid fa-sliders"></i></a>
              <!-- Dropdown Menu -->
              <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="altSearchOption">
                <li><a class="dropdown-item" href="#"><i class="fa-solid fa-microphone"> </i>Voice Search</a></li>
                <li><a class="dropdown-item" href="#"><i class="fa-solid fa-image"> </i>Image Search</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <!-- Hero Wrapper -->
      <div class="hero-wrapper">
        <div class="container">
          <div class="pt-3">
            <!-- Hero Slides-->
            <div class="hero-slides owl-carousel">
              <!-- Single Hero Slide-->
              <div class="single-hero-slide" style="background-image: url('img/bg-img/1.jpg')">
                <div class="slide-content h-100 d-flex align-items-center">
                  <div class="slide-text">
                    <h4 class="text-white mb-0" data-animation="fadeInUp" data-delay="100ms" data-duration="1000ms">Amazon Echo</h4>
                    <p class="text-white" data-animation="fadeInUp" data-delay="400ms" data-duration="1000ms">3rd Generation, Charcoal</p><a class="btn btn-primary" href="#" data-animation="fadeInUp" data-delay="800ms" data-duration="1000ms">Buy Now</a>
                  </div>
                </div>
              </div>
         
           
            </div>
          </div>
        </div>
      </div>
      <!-- Product Catagories -->
      <div class="product-catagories-wrapper py-3">
        <div class="container">
          <div class="row g-2 rtl-flex-d-row-r">
            <!-- Catagory Card -->
<?php 
require("../tools/conn.php");
$sql = "call app_category_sp()";
$ress = $conn->query($sql);
$i = 0;
while($row = $ress->fetch_array()){
  $i++;
?>
            <div class="col-3">
              <div class=" card catagory-card <?php echo $i == 1 ? 'active' : ''  ?>">
                <div class="card-body px-2">
  <a class="get_product" href="php/productlist.php?id=<?php echo $row['id'] ?>&category=<?php echo $row['name'] ?>">
                  <img src="<?php echo $row['image'] ?>" alt=""><span><?php echo $row['name'] ?></span></a></div>
              </div>
            </div>
         
<?php 
}
?>      
        
           
       
          </div>
        </div>
      </div>
   
    
      <!-- Top Products -->
   
  <div class="product_place">
     <?php require("php/all_products.php") ?>
  </div>
     
    <!-- end product-->
    </div>
    <!-- Internet Connection Status-->
    <div class="internet-connection-status" id="internetStatus"></div>
    <!-- Footer Nav-->
    <div style="background: #2d3693" class="footer-nav-area" id="footerNav">
      <div class="suha-footer-nav">
        <ul class="h-200 d-flex align-items-center justify-content-between ps-0 d-flex rtl-flex-d-row-r">


          <li><a href="https://wa.me/252<?php echo $tell?>"><i class="fa-brands fa-whatsapp"></i>Whatsapp</a></li>
          <li><a href="tel:<?php echo $tell?>"><i class="fa-solid fa-phone"></i>Call</a></li>
           <li>
            <a data="" href="salad.php" class="set_data">
              <span data="" class="cart-count">1</span>
              <i class="fa-solid fa-cart-shopping"></i>
         
         </a></li>
         
        </ul>
      </div>
    </div>
  
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <!-- All JavaScript Files-->
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