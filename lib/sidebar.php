    <div class="leftside-menu">
    
                <!-- LOGO -->
                <a href="index.html" class="logo text-center logo-light">
                    <span class="logo-lg">
                        <img src="assets/images/logo.png" alt="" height="16">
                    </span>
                    <span class="logo-sm">
                        <img src="assets/images/logo_sm.png" alt="" height="16">
                    </span>
                </a>

                <!-- LOGO -->
                <a href="index.html" class="logo text-center logo-dark">
                    <span class="logo-lg">
                        <img src="assets/images/logo-dark.png" alt="" height="16">
                    </span>
                    <span class="logo-sm">
                        <img src="assets/images/logo_sm_dark.png" alt="" height="16">
                    </span>
                </a>
    
                <div class="h-100" id="leftside-menu-container" data-simplebar>

                    <!--- Sidemenu -->
                    <ul class="side-nav">

                        <li class="side-nav-title side-nav-item">Navigation</li>

                        <li class="side-nav-item">
                            <a class="side-nav-link">
                                <i class="uil-home-alt"></i>
                                <span class="badge bg-success float-end">4</span>
                                <span> Dashboards </span>
                            </a>
                        </li>
                          

                <ul class="side-nav-second-level">
                    <?php 
require("tools/conn.php");
$sql = "SELECT m.name,replace(m.name,' ','')idname,m.id,m.icon FROM forms f JOIN menu m on f.menu_id=m.id
JOIN user_links u on u.form_id=f.id  WHERE u.user_id=$_SESSION[user_id] group by m.name";
$ress = $conn->query($sql);
while($rc = $ress->fetch_array()){
                    ?>
     <li class="side-nav-item">
                            <a data-bs-toggle="collapse" href="#<?php echo $rc['idname'] ?>" aria-expanded="false" aria-controls="<?php echo $rc['idname'] ?>" class="side-nav-link">
                                <i class="<?php echo $rc['icon'] ?>"></i>
                                <span> <?php echo $rc['name'] ?> </span>
                                <span class="menu-arrow"></span>
                            </a>
                            <div class="collapse" id="<?php echo $rc['idname'] ?>">
                                <ul class="side-nav-second-level">
                                    
                <?php 
         require("tools/conn.php");
      $sql1 = "SELECT f.name,f.id,f.href FROM forms f JOIN menu m on f.menu_id=m.id
JOIN user_links u on u.form_id=f.id  WHERE u.user_id=$_SESSION[user_id] and m.id=$rc[id]";
$res = $conn->query($sql1);
while($f = $res->fetch_array()){
                ?>

                <li>
                  <a alt="<?php echo $f['id'] ?>" class="get_link" href="<?php echo $f['href']?>"><?php echo $f['name']?></a>
                </li>
                <?php 
            }
            ?>
                               
                                </ul>
                            </div>
                       
       <?php 
   }
   ?>
</li>
                    </ul>

                  
                   
                <!-- Sidebar -left -->

            </div>
</div>