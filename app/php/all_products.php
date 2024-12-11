   <div class="top-products-area py-3">
        <div class="container">
          <div class="section-heading d-flex align-items-center justify-content-between dir-rtl">
            <h6>All Products</h6><a class="btn p-0" href="shop-grid.html">View All<i class="ms-1 fa-solid fa-arrow-right-long"></i></a>
          </div>
          <div class="row g-2">
            <!-- Product Card -->
<?php 
require("../tools/conn.php");
$sql = "call show_alll_products_sp('%')";
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