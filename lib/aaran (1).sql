-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 01, 2023 at 02:30 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aaran`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_permission_sp` (IN `_form_id` INT, IN `_user_id` INT, IN `_grant` INT, IN `_action` TEXT, IN `_type` TEXT)   BEGIN
if(_grant != 1)THEN
SELECT 'Kaliya shaqadaan waxaa qaban kara adminka oo kaliya';
ELSE
if(_action='form')THEN

SELECT f.name INTO @name FROM forms f
LEFT JOIN user_links u on u.form_id=f.id AND u.action='form'  WHERE f.id=_form_id AND u.user_id=_user_id;
ELSE
SELECT f.text INTO @name FROM other_table f
LEFT JOIN user_links u on u.form_id=f.id AND u.action in('edit','delete')  WHERE f.id=_form_id;
END IF;
if(_type='insert')THEN
INSERT INTO `user_links`(`form_id`, `user_id`, `granted_user`, `action`)
VALUES(_form_id,_user_id,_grant,_action);
SELECT concat(@name,' Has been Granted');
ELSE
DELETE FROM user_links WHERE form_id=_form_id AND user_id=_user_id AND action=_action;
SELECT concat(@name,' Has been Refoked');
END IF;

END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `app_category_sp` ()   BEGIN

SELECT * FROM category ORDER by id ASC;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `autocomplete_sp` (IN `_text` TEXT, IN `_action` TEXT)   BEGIN
if(_action='menu')THEN
SELECT id,name FROM menu WHERE name LIKE concat('%',_text,'%');

ELSEIF(_action='sp')THEN
SELECT `ROUTINE_NAME`,`ROUTINE_NAME` FROM information_schema.`ROUTINES` WHERE `ROUTINE_TYPE`='PROCEDURE' AND `ROUTINE_SCHEMA`=DATABASE() AND `ROUTINE_NAME` LIKE concat('%',_text,'%') ;

ELSEIF(_action='supplier')THEN
SELECT id,name FROM supplier WHERE name LIKE concat('%',_text,'%');

ELSEIF(_action='item')THEN
SELECT id,name FROM product WHERE name LIKE concat('%',_text,'%');

END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cartlist_sp` (IN `_product_id` TEXT)   BEGIN


SELECT name,image,p.sales FROM product p
WHERE find_in_set(id,_product_id);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `category_sp` (IN `_name` VARCHAR(100), IN `_image` TEXT)   BEGIN
if EXISTS(SELECT id FROM category WHERE name=_name)THEN
SELECT concat('danger|',_name,' Horaya yaa lo diiwan galiyay fadlan hubi');

ELSE
  INSERT INTO category(name,image)
  VALUES(_name,_image);
  SELECT concat('success|',_name,' waala diiwan galiyay');


END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `change_pass_sp` (`_user_id` INT, `_old_p` TEXT, `_new_p` TEXT, `_confirm` TEXT)   BEGIN

if NOT EXISTS(SELECT * FROM users WHERE id=_user_id AND password=md5(_old_p))THEN
SELECT concat('danger| Old password is incorrect');
ELSEIF EXISTS(SELECT * FROM users WHERE id=_user_id AND password=md5(_new_p))THEN
SELECT concat('warning| Old password is not match new password');
ELSE
  UPDATE users SET password = md5(_new_p) WHERE id=_user_id;
  
  SELECT concat('success| Password changed');
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `charts_show_sp` (IN `_user_id` INT)   BEGIN

SELECT *,chart_count(action) c  FROM charts;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_sp` (`_table` TEXT, `_colum` TEXT, `_value` TEXT, `_user_id` INT)   BEGIN
SET sql_mode='';
START TRANSACTION;
SET @sql1 = concat(' SELECT group_concat(`COLUMN_NAME` SEPARATOR '','''','''','') into @columns
FROM information_schema.`COLUMNS` WHERE `TABLE_NAME` = ',quote(_table),' and `TABLE_SCHEMA` = DATABASE()'); 
PREPARE stm1 FROM @sql1;
EXECUTE stm1;


SET @sql2 = concat('SELECT group_concat(concat(',@columns,') separator '';'') into @backup from ',_table, ' where concat(',_colum,') = ',quote(_value));

PREPARE s2 from @sql2;
EXECUTE s2;

INSERT INTO `deleted_records`(`tran_id`, `backup`, `table`, `user_id`)
VALUES(_value,@backup,_table,_user_id);

SET @sql = concat('delete from ',_table,' where ',_colum,' =',QUOTE(_value));

PREPARE stm FROM @sql;
EXECUTE stm;

SELECT  'deleted Success';
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `employee_sp` (`_name` VARCHAR(100), `_tell` VARCHAR(100), `_salary` DOUBLE, `_user_id` INT, `_date` DATE)   BEGIN
IF EXISTS(SELECT id FROM employee WHERE name=_name AND tell=_tell)THEN

SELECT concat('danger|',_name,' Horaya yaa lo diiwan galiyay fadlan hubi');

ELSE
  INSERT INTO employee(name,tell,salary,user_id,date)
  VALUES(_name,_tell,_salary,_user_id,_date);
  
  SELECT concat('success|',_name,' waala diwan galiyay');


END if;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `expense_account_sp` (`_name` VARCHAR(100))   BEGIN
if EXISTS(SELECT id FROM expense_account WHERE name=_name)THEN
SELECT concat('danger|',_name,' Horaya yaa lo diiwan galiyay fadlan hubi');

ELSE
  INSERT INTO expense_account(name)
  VALUES(_name);
  SELECT concat('success|',_name,' waala diiwan galiyay');


END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `expense_sp` (`_expense_id` INT, `_amount` DOUBLE, `_desc` TEXT, `_user_id` INT, `_date` DATE)   BEGIN
SELECT name INTO @expense_name FROM expense_account WHERE id=_expense_id;

  INSERT INTO expense(`expense_id`,`amount`,`description`,user_id,date)
  VALUES(_expense_id,_amount,_desc,_user_id,_date);
  
  SELECT concat('success|',ifnull(@expense_name,' Other'),' ayaa la bixiyay lacag dhan ',_amount);


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `form_info` (IN `_form_id` INT, IN `_user_id` INT)   BEGIN
SELECT name INTO @name FROM forms WHERE id=_form_id;
if EXISTS(SELECT id FROM user_links u WHERE u.form_id=_form_id AND u.user_id=_user_id)THEN

 SELECT concat(m.name,'->' ,f.title)title,f.form_action,f.button,f.sp FROM forms f JOIN menu m on m.id=f.menu_id WHERE f.id=_form_id;

ELSE
 SELECT concat(@name,' Laguma ogola in aad so boqoto') as error;

END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `form_sp` (IN `_name` VARCHAR(100), IN `_title` VARCHAR(100), IN `_href` VARCHAR(100), IN `_menu_id` INT, IN `_icon` VARCHAR(100), IN `_sp` VARCHAR(100), IN `_action` VARCHAR(100), IN `_button` VARCHAR(100), IN `_user_id` INT)   BEGIN
START TRANSACTION;
if EXISTS(SELECT id FROM forms WHERE name=_name)THEN
SELECT concat('danger|',_name,' Horay ayaa lo diwan galiyay');

ELSE
INSERT INTO `forms`(`name`, `title`, `href`, `menu_id`, `icon`, `sp`, `button`, `form_action`)
VALUES(_name,_title,_href,_menu_id,_icon,_sp,_button,_action);

SET @form_id = last_insert_id();

INSERT INTO form_input(form_id,type,label,placeholder,name)
SELECT @form_id,'text',concat(upper(LEFT(REPLACE(PARAMETER_NAME,'_',''),1)),substring(REPLACE(PARAMETER_NAME,'_',''),2,20)),concat('Enter ',concat(upper(LEFT(REPLACE(PARAMETER_NAME,'_',''),1)),substring(REPLACE(PARAMETER_NAME,'_',''),2,20))),PARAMETER_NAME  FROM information_schema.`PARAMETERS` WHERE `SPECIFIC_SCHEMA` LIKE DATABASE() AND `SPECIFIC_NAME` LIKE _sp;

INSERT INTO `user_links`(`form_id`, `user_id`, `granted_user`, `action`)
VALUES(@form_id,_user_id,_user_id,'form');


SELECT concat('success|',_name,' waala diwan galiyay');
END IF;
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_dropdown_sp` (IN `_action` TEXT, IN `id_p` INT)   BEGIN
if(_action='menu')THEN
SELECT id,if(id=1,concat(name,'|selected'),name) FROM menu;
ELSEIF(_action='href')THEN
SELECT o.value,o.text FROM other_table o WHERE o.action='href';

ELSEIF(_action='form')THEN
SELECT o.id,o.name FROM forms o;

ELSEIF(_action='form_action')THEN
SELECT o.value,o.text FROM other_table o WHERE o.action='form_action';

ELSEIF(_action='expense')THEN
SELECT id,name FROM expense_account;

ELSEIF(_action='category')THEN

SELECT id,name FROM category;

ELSEIF(_action='status')THEN

SELECT o.status,o.status FROM orders o GROUP by o.status;

ELSEIF(_action='products')THEN
SELECT 0,'No releted'
UNION
SELECT id,name FROM product;

ELSEIF(_action='account')THEN
SELECT 0,if('Account paybal'='Account paybal',concat('Account paybal','|selected'),'Account paybal')
UNION
SELECT id,name FROM account;

ELSEIF(_action='load_form')THEN
SELECT id,name FROM forms f WHERE f.menu_id=id_p;

ELSEIF(_action='product')THEN
SELECT id,name FROM product f;


ELSEIF(_action='user')THEN
SELECT id,username FROM users f;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login_sp` (IN `_username` VARCHAR(100), IN `_password` TEXT)   BEGIN

if EXISTS(SELECT * FROM users WHERE username=_username AND password=md5(_password) AND status=1)THEN

SELECT id user_id,name full_name,username,REPLACE(image,'../','')image,email FROM users WHERE username=_username AND password=md5(_password);

ELSEIF EXISTS(SELECT * FROM users WHERE username=_username AND password=md5(_password) AND status !=1)THEN

SELECT concat(_username,' Waa la block gareeyay fadlan adminkaga la xirir') AS error;
ELSE

 SELECT 'username or password incorrect' AS error;
END IF;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_sp` (`_name` VARCHAR(100), `_icon` TEXT)   BEGIN

if EXISTS(SELECT id FROM	 menu WHERE name=_name)THEN

SELECT concat('danger|',_name, ' Hoara ayaa lo aburay');
ELSE

INSERT INTO menu(name,icon)
VALUES(_name,_icon);
SELECT concat('success|',_name, 'waala diwan galiyay');
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `order_sp` (IN `_tell` TEXT, IN `_address` TEXT, IN `_item_id` INT, IN `_price` DOUBLE, IN `_paymentStatus` TEXT)   BEGIN
START TRANSACTION;
if not EXISTS(SELECT * FROM customer WHERE tell=_tell)THEN
INSERT INTO customer(tell,address)
VALUES(_tell,_address);

SELECT id INTO @cust_id FROM customer WHERE tell=_tell;
END IF;

SELECT id INTO @cust_id FROM customer WHERE tell=_tell;

SELECT p.cost INTO @cost FROM product p WHERE id=_item_id;
INSERT INTO orders(customer_id,product,qty,cost,sales,date,status)
VALUES(@cust_id,_item_id,1,@cost,_price,now(),_paymentStatus);

SELECT 'success';
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `payment_sp` (`_suplier_id` INT, `_ref_no` INT, `_desc` TEXT, `_date` DATE, `_user_id` INT, `_paid` DOUBLE, `_discount` DOUBLE, `_action` TEXT)   BEGIN

INSERT INTO payment(supplier_id,amount,discount,date,ref_no,action,description)
VALUES(_suplier_id,_paid,_discount,_date,_ref_no,_action,_desc);
SELECT 'ok';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `paymeny_show` (`_ref` INT)   BEGIN

SELECT find_payment(127,'p')paid,find_payment(127,'r')dis FROM payment p WHERE p.ref_no=_ref;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `product_sp` (IN `_category_id` INT, IN `_name` TEXT, IN `_cost` DOUBLE, IN `_sales` DOUBLE, IN `_description` TEXT, IN `_image` TEXT, IN `_image2` TEXT, IN `_image3` TEXT, IN `_vedio` TEXT, IN `_color` TEXT, IN `_rate` TEXT, IN `_alert` INT, IN `_releted` TEXT)   BEGIN
if EXISTS(SELECT id FROM product WHERE name=_name)THEN
SELECT concat('danger|',_name,' horay ayaa loo diwan galiyay');
ELSE
INSERT INTO `product`(`name`, `category_id`, `cost`, `sales`, `description`, `image`, `image2`, `image3`, `vedio`, `color`, `rate`, `alert`,releated_products)
VALUES(_name,_category_id,_cost,_sales,_description,_image,_image2,_image3,_vedio,_color,_rate,_alert,_releted);
SELECT concat('success|',_name,'waala diwan galiyay');

END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `purchase_sp` (`_product_id` INT, `_qty` INT, `_price` DOUBLE, `_supplier` INT, `_ref_no` INT, `_desc` TEXT, `_date` DATE, `_user_id` INT)   BEGIN
   INSERT INTO purchase(supplier_id,product_id,qty,cost,user_id,description,date,ref_no)
   VALUES(_supplier,_product_id,_qty,_price,_user_id,_desc,_date,_ref_no);
   
   SELECT 'Registred';
   
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rp_category_sp` (IN `_category_id` VARCHAR(100), IN `_user_id` INT)   BEGIN
SET @n = 0;
SELECT @n:=@n+1 `No`, name,del_data('category','id',id,_user_id)`Delete` FROM category WHERE id LIKE _category_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rp_chart_detail_sp` (`_action` TEXT)   BEGIN

if(_action='customer')THEN
SELECT * FROM form_input;
ELSEIF(_action='order')THEN
SELECT c.tell,c.address,p.name 	`Product Name`,o.qty `Quantity`,o.sales,o.date FROM orders o LEFT JOIN customer c on c.id=o.customer_id LEFT JOIN product p on p.id=o.product;
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rp_deleted_sp` (`_table` TEXT, `_user_id` TEXT)   BEGIN
if(_table='orders')THEN
SELECT find_name(SPLIT_STR(d.backup,',',3))`name`,u.username,d.date FROM deleted_records d JOIN users u on u.id=d.user_id WHERE d.table='orders' AND d.table=_table AND d.user_id LIKE _user_id;
ELSEIF(_table='product')THEN
SELECT SPLIT_STR(d.backup,',',2)name,u.username,d.date  FROM deleted_records d JOIN users u on u.id=d.user_id WHERE d.table=_table AND d.user_id LIKE _user_id;

END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rp_form_sp` (`_menu_id` VARCHAR(100), `_form_id` VARCHAR(100))   BEGIN

SELECT m.name `Menu`,f.name `Form Name`,f.title,f.href,f.icon,f.sp,f.button FROM forms f JOIN menu m on f.menu_id=m.id
WHERE m.id LIKE _menu_id AND f.id LIKE _form_id ;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rp_order_sp` (IN `_status` VARCHAR(100), IN `_from` DATE, IN `_to` DATE, IN `_user_id` INT)   BEGIN

if(_to='0000-00-00')THEN

SET _to =  now();
END IF;
SELECT c.tell,c.address,p.name,o.qty `Quantity`,o.sales,o.date,o.status,
edit_data('orders','id','orders',_user_id,o.id)`Edit`,
del_data('orders','id',o.id,_user_id)`Delete`
FROM customer c JOIN orders o on c.id=o.customer_id
JOIN product p on p.id=o.product
WHERE o.status LIKE _status AND o.date BETWEEN _from AND _to;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rp_product_sp` (IN `_category_id` VARCHAR(100), IN `_product_id` VARCHAR(100), IN `_user_id` INT)   BEGIN
if(_product_id='')THEN
SET _product_id = '%';

END IF;
SELECT c.name `Category~dropdown~category`,p.name `Item Name`,p.cost,p.sales,p.description,REPLACE(p.image,'../','') `Image~image`,del_data('product','id',p.id,_user_id)`Delete`,edit_data('product','id','product',_user_id,p.id)`Update` FROM product p LEFT JOIN category c on c.id=p.category_id
WHERE c.id LIKE _category_id AND p.id LIKE _product_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `search_row_sp` (IN `_action` TEXT, IN `_val` INT)   BEGIN
if(_action='orders')THEN
SELECT o.status,o.qty,o.date `date~date`,o.product `Prdoduct~dropdown~product` FROM orders o WHERE id=_val;

elseif(_action='product')then 
select name,cost from product where id = _val;
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_alll_products_sp` (IN `_category_id` TEXT)   BEGIN


IF(_category_id=1)THEN

SET _category_id='%';
END IF;
SELECT id,name,if(p.discount > 0,p.discount,p.sales)sales,
if(p.discount = 0,'',concat('$',p.sales))discount,p.image,p.image2,p.description,p.releated_products FROM product p WHERE p.category_id LIKE _category_id ORDER BY rand();

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_permission_sp` (IN `_user_id` INT, IN `_action` TEXT, IN `_id` TEXT)   BEGIN
if(_action='menu')THEN
SELECT m.id,m.name FROM menu m JOIN forms f on f.menu_id=m.id GROUP by m.name
UNION
SELECT 0 id,'Delete Info'  FROM other_table o WHERE o.action in('delete')
UNION
SELECT '-01' id,'Edit Info'  FROM other_table o WHERE o.action in('edit');

ELSEIF(_action='forms')THEN
SELECT f.id,f.name,if(u.form_id is not null,'checked','')ch,'form' action FROM 
menu m LEFT JOIN forms f on f.menu_id=m.id LEFT JOIN user_links u on u.form_id=f.id where m.id=_id
UNION

SELECT ff.id,ff.text,if(u.form_id is not null,'checked','')ch,'delete' `action` FROM 
other_table ff 
LEFT JOIN user_links u on u.form_id=ff.id AND ff.action='delete' AND u.action='delete' WHERE ff.action='delete' AND _id=0

UNION

SELECT ff.id,ff.text,if(u.form_id is not null,'checked','')ch,'edit' `action` FROM 
other_table ff 
LEFT JOIN user_links u on u.form_id=ff.id AND ff.action='edit' AND u.action='edit' WHERE ff.action='edit' AND _id=-01;

END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_products_sp` (IN `_product_id` TEXT)   BEGIN


SELECT id,name,if(p.discount > 0,p.discount,p.sales)sales,
if(p.discount = 0,'',concat('$',p.sales))discount,p.image,p.image2,p.image3,p.description,p.releated_products,
concat('waxaan ubahnaa alaabtaan ',p.name,' Qimahana waa $',if(p.discount > 0,p.discount,p.sales))sms
FROM product p WHERE p.id = _product_id ORDER BY rand();

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_releted_products_sp` (IN `_product_id` TEXT)   BEGIN




SELECT p.releated_products INTO @r FROM product p WHERE id=_product_id;
SELECT id,name,if(p.discount > 0,p.discount,p.sales)sales,
if(p.discount = 0,'',concat('$',p.sales))discount,p.image,p.image2,p.description,p.releated_products FROM product p 
WHERE find_in_set(id,@r)   ORDER BY rand();

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `supplier_sp` (`_name` VARCHAR(100), `_tell` VARCHAR(100), `_address` VARCHAR(100), `_user_id` INT, `_date` DATE)   BEGIN

if EXISTS(SELECT id FROM supplier WHERE name=_name AND tell =_tell)THEN
SELECT concat('danger|',_name,' Horaya yaa lo diiwan galiyay fadlan hubi');


ELSE 
INSERT INTO supplier(name,tell,address,user_id,date)
VALUES(_name,_tell,_address,_user_id,_date);
SELECT concat('success|',_name,' waala diiwan galiyay');


END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_sp` (`_table` TEXT, `_set_col` TEXT, `_id` INT, `_col` TEXT, `_user_id` INT, `_val` TEXT)   BEGIN

SET @col = concat('select ' ,_set_col, ' into @cols from ',_table,' where ',_col,' = ',_id);
PREPARE s FROM @col;
EXECUTE s;

INSERT updated_records(tran_id,`table`,colum,old_val,val,user_id)
VALUES(_id,_table,_set_col,@cols,_val,_user_id);


SET @sql = concat('update ',_table,' set ',_set_col,' = ',quote(_val),' where ',_col,' = ',_id);
PREPARE stm FROM @sql;
EXECUTE stm;

SELECT 'Updated Success';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `users_sp` (`_username` TEXT, `_password` TEXT, `_confirm` TEXT, `_image` TEXT, `_email` TEXT)   BEGIN
if EXISTS(SELECT id FROM users WHERE username=_username)THEN
SELECT concat('danger| ',_username,' All Ready Exists');

ELSE
INSERT INTO users(username,password,image,email)
VALUES(_username,md5(_password),_image,_email);
SELECT concat('success| ',_username,' registred');
END if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_permission_sp` (`_user_id` INT)   BEGIN


END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `chart_count` (`_action` TEXT) RETURNS TEXT CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
SET @cc = 0;
if(_action = 'customer')THEN
SELECT COUNT(id) INTO @cc FROM customer;
ELSEIF(_action='order')THEN
SELECT COUNT(id) INTO @cc FROM orders;

ELSEIF(_action='f_order')THEN
SELECT COUNT(id) INTO @cc FROM orders a WHERE a.status='Failed';

ELSEIF(_action='s_order')THEN
SELECT COUNT(id) INTO @cc FROM orders a WHERE a.status='Success';

ELSEIF(_action='t_orders')THEN
SELECT COUNT(id) INTO @cc FROM orders a WHERE a.date= date(now());

ELSEIF(_action='income')THEN
SELECT concat('$',format(sum(a.qty*a.sales),2)) INTO @cc FROM orders a WHERE a.date= date(now());
END IF;

RETURN @cc;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `del_data` (`_table` TEXT, `_colum` TEXT, `_value` TEXT, `_user_id` INT) RETURNS TEXT CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN

if not EXISTS(SELECT id FROM other_table WHERE action='delete' AND value=_table)THEN
INSERT INTO other_table(value,text,action)
value(_table,concat('Delete ',_table),'delete');
END IF;


if EXISTS(SELECT u.id FROM user_links u JOIN other_table o on o.id=u.form_id AND o.action='delete' WHERE u.user_id=_user_id AND u.action='delete' AND o.value=_table)THEN

RETURN concat('<button table="',_table,'" colum="',_colum,'"  value="',_value,'" user_id="',_user_id,'" class="del_data btn btn-info">','<i class="fa fa-trash"> Delete</i>','</button>'); 

ELSE
  RETURN 'xx';

END IF;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `edit_data` (`_table` TEXT, `_col` TEXT, `_action` TEXT, `_user_id` INT, `_val` TEXT) RETURNS TEXT CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
if NOT EXISTS(SELECT id FROM other_table a WHERE a.value=_table AND a.action='edit')THEN
INSERT INTO other_table(value,text,action)
VALUES(_table,concat('edit ',_table),'edit');

END IF;

if EXISTS(SELECT a.id FROM other_table a JOIN user_links u on u.form_id=a.id AND a.action='edit' WHERE a.value=_table AND u.user_id=_user_id AND u.action='edit')THEN

RETURN concat('<button table="',_table,'" colum="',_col,'"  value="',_val,'" user_id="',_user_id,'" action="',_action,'"  class="edit_data btn btn-info">','<i class="fa fa-edit"> Edit</i>','</button>'); 
ELSE

RETURN 'xxx';

END IF;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `find_name` (`_id` INT) RETURNS TEXT CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
SELECT name INTO @name FROM product p WHERE id=_id;

RETURN @name;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `find_payment` (`_ref` INT, `_action` TEXT) RETURNS DOUBLE  BEGIN
if(_action='p')THEN
SELECT ifnull(p.amount,0) INTO @p FROM payment p WHERE  p.ref_no=_ref;
ELSE
SELECT ifnull(p.discount,0) INTO @p FROM payment p WHERE  p.ref_no=_ref;
END IF;

RETURN ifnull(@p,0);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `ref_no` () RETURNS INT(11)  BEGIN

SET @start = 1;

SELECT ref_no+1 into @start FROM purchase ORDER by ref_no DESC LIMIT 1;

RETURN @start;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `SPLIT_STR` (`x` VARCHAR(255), `delim` VARCHAR(12), `pos` INT) RETURNS VARCHAR(255) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
       LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
       delim, '');
       
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`id`, `name`) VALUES
(1, 'Salaam bank'),
(2, 'Evc');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `image`) VALUES
(1, 'All Products', '../uploads/all_products.png'),
(2, 'Shoping', '../uploads/shopping.jpeg'),
(3, 'Electronics', '../uploads/electronics.png'),
(4, 'Sports', '../uploads/sports.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `charts`
--

CREATE TABLE `charts` (
  `id` int(11) NOT NULL,
  `text` text DEFAULT NULL,
  `action` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `charts`
--

INSERT INTO `charts` (`id`, `text`, `action`) VALUES
(1, 'Total Customers', 'customer'),
(2, 'Total Orders', 'order'),
(3, 'Success Orders', 's_order'),
(4, 'Today Orders', 't_orders'),
(5, 'Failed Orders', 'f_order'),
(6, 'Total Income', 'income');

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `tell` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`id`, `name`, `tell`, `address`, `logo`, `date`) VALUES
(1, 'Aaran Hypermarket', '614474706', 'Mugadisho,somalia,Calikamin', 'uploads/logo.png', '2023-02-10');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `tell` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `mac_address` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `tell`, `address`, `date`, `mac_address`) VALUES
(9, '614474706', 'Madina', NULL, NULL),
(10, '614324554', 'Madina', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `deleted_records`
--

CREATE TABLE `deleted_records` (
  `id` int(11) NOT NULL,
  `tran_id` int(11) NOT NULL,
  `backup` text NOT NULL,
  `table` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deleted_records`
--

INSERT INTO `deleted_records` (`id`, `tran_id`, `backup`, `table`, `user_id`, `date`) VALUES
(5, 10, '1000,9,23,1,100,150,waiting,2023-04-13', 'orders', 1, '2023-05-05 12:17:15'),
(6, 33, '33,9,24,1,300,400,Failed,2023-04-27', 'orders', 1, '2023-05-05 12:17:27'),
(7, 25, '25,Watch,3,12,40,0,Watch,../uploads/download (4).jpeg,../uploads/download (5).jpeg,../uploads/,,,,0,22', 'product', 1, '2023-05-05 12:20:40');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `tell` varchar(100) DEFAULT NULL,
  `salary` double DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `name`, `tell`, `salary`, `user_id`, `date`) VALUES
(1, 'Ayman', '765765', 300, 1, '2023-02-24'),
(2, 'Hassan Ali', '66252266', 200, 1, '2023-02-24');

-- --------------------------------------------------------

--
-- Table structure for table `expense`
--

CREATE TABLE `expense` (
  `id` int(11) NOT NULL,
  `expense_id` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `description` text DEFAULT NULL,
  `date` date DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expense`
--

INSERT INTO `expense` (`id`, `expense_id`, `amount`, `description`, `date`, `user_id`) VALUES
(1, 1, 30, 'interka xarunta', '2023-02-24', 1),
(2, 2, 250, 'kirada xarunta bisha February', '2023-02-24', 1);

-- --------------------------------------------------------

--
-- Table structure for table `expense_account`
--

CREATE TABLE `expense_account` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expense_account`
--

INSERT INTO `expense_account` (`id`, `name`) VALUES
(1, 'Internet'),
(2, 'Kiro');

-- --------------------------------------------------------

--
-- Table structure for table `forms`
--

CREATE TABLE `forms` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `href` varchar(100) DEFAULT NULL,
  `menu_id` int(11) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `sp` varchar(100) DEFAULT NULL,
  `button` varchar(100) DEFAULT NULL,
  `form_action` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `forms`
--

INSERT INTO `forms` (`id`, `name`, `title`, `href`, `menu_id`, `icon`, `sp`, `button`, `form_action`) VALUES
(2, 'Create Form', 'Create Form', 'tools/gen_form.php', 1, 'fa fa-list', 'form_sp', 'Add', 'tools/save.php'),
(3, 'Create Menu', 'Create Menu', 'tools/gen_form.php', 2, 'fa fa-list', 'menu_sp', 'Save', 'tools/save.php'),
(5, 'Add Category', 'Add Product Category', 'tools/gen_form.php', 2, 'fa fa-plus', 'category_sp', 'Save', 'tools/save.php'),
(6, 'Add Employee', 'Add Employee', 'tools/gen_form.php', 19, 'fa fa-users', 'employee_sp', 'Add', 'tools/save.php'),
(8, 'Expense Account', 'Expense Account', 'tools/gen_form.php', 2, 'fa fa-plus', 'expense_account_sp', 'Save', 'tools/save.php'),
(9, 'Pay Expense Form', 'Pay Expense Form', 'tools/gen_form.php', 2, 'fa fa-users', 'expense_sp', 'Pay', 'tools/save.php'),
(10, 'Add Supplier', 'Add Supplier', 'tools/gen_form.php', 2, 'fa fa-users', 'supplier_sp', 'Save', 'tools/save.php'),
(11, 'Add Product', 'Add Product', 'tools/gen_form.php', 2, ' ', 'product_sp', 'Save', 'tools/save.php'),
(12, 'Category List', 'Category List', 'tools/gen_report.php', 3, 'fa fa-users', 'rp_category_sp', 'Search', 'tools/report.php'),
(13, 'Product list', 'Product list', 'tools/gen_report.php', 3, 'fa fa-list', 'rp_product_sp', 'Search', 'tools/report.php'),
(14, 'Form List', 'Forms List', 'tools/gen_report.php', 1, ' ', 'rp_form_sp', 'Search', 'tools/report.php'),
(15, 'Add Purchase', 'Forms List', 'tools/invoice_page.php', 20, ' ', '', 'Search', 'tools/report.php'),
(16, 'Ayman form', 'Ayman form', 'tools/gen_form.php', 1, 'fa fa-users', '', 'Save', 'Choose One'),
(17, 'Order List', 'Order List', 'tools/gen_report.php', 3, 'fa fa-list', 'rp_order_sp', 'Search', 'tools/report.php'),
(18, 'Add User', 'Add User', 'tools/gen_form.php', 21, 'fa fa-users', 'users_sp', 'Add', 'tools/save.php'),
(19, 'user Permission', 'user Permission', 'tools/gen_report.php', 21, 'fa fa-list', 'user_permission_sp', 'Show', 'tools/user_permission.php'),
(20, 'deleted records', 'Deleted Records', 'tools/gen_report.php', 3, 'fa fa-list', 'rp_deleted_sp', 'Show', 'tools/report.php'),
(21, 'change Password', 'Change Password', 'tools/gen_form.php', 21, 'fa fa-users', 'change_pass_sp', 'Chnage', 'tools/save.php');

-- --------------------------------------------------------

--
-- Table structure for table `form_input`
--

CREATE TABLE `form_input` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `label` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `class` varchar(100) DEFAULT NULL,
  `placeholder` varchar(100) DEFAULT NULL,
  `required` varchar(100) DEFAULT NULL,
  `action` varchar(100) DEFAULT ' ',
  `help` varchar(100) DEFAULT NULL,
  `size` varchar(100) DEFAULT NULL,
  `form_id` int(11) DEFAULT NULL,
  `load_action` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `form_input`
--

INSERT INTO `form_input` (`id`, `name`, `label`, `type`, `class`, `placeholder`, `required`, `action`, `help`, `size`, `form_id`, `load_action`) VALUES
(1, 'name', 'Form Name', 'text', NULL, 'Enter Name', 'required', ' ', NULL, NULL, 2, ''),
(2, 'title', 'Form title', 'text', NULL, 'Enter Title', NULL, ' ', NULL, NULL, 2, ''),
(3, 'href', 'Href', 'dropdown', NULL, 'Enter Href', NULL, 'href', NULL, NULL, 2, ''),
(4, 'menu', 'Choose Menu', 'dropdown', NULL, 'Enter Menuid', NULL, 'menu', NULL, NULL, 2, ''),
(5, 'icon', 'Icon', 'text', NULL, 'Enter Icon', NULL, '', NULL, NULL, 2, ''),
(6, 'sp', 'Sp', 'autocomplete', NULL, 'Enter Sp', NULL, 'sp', NULL, NULL, 2, ''),
(7, 'action', 'Form Action', 'dropdown', NULL, 'Enter Action', NULL, 'form_action', NULL, NULL, 2, ''),
(16, 'name', 'Name', 'text', NULL, 'Enter Name', NULL, ' ', NULL, NULL, 3, ''),
(17, 'icon', 'Icon', 'text', NULL, 'Enter Icon', NULL, ' ', NULL, NULL, 3, ''),
(18, 'button', 'Button Text', 'text', NULL, 'Enter Name', NULL, ' ', NULL, NULL, 2, ''),
(19, '_name', 'Name', 'text', NULL, 'Enter Name', NULL, ' ', NULL, NULL, 5, ''),
(20, '_name', 'Employee Name', 'text', NULL, 'Enter Name', NULL, ' ', NULL, NULL, 6, ''),
(21, '_tell', 'Employee Tell', 'text', NULL, 'Enter Tell', NULL, ' ', NULL, NULL, 6, ''),
(22, '_salary', 'Salary', '', NULL, 'Enter Salary', NULL, ' ', NULL, NULL, 6, ''),
(23, '_user_id', 'Userid', 'user_id', NULL, 'Enter Userid', NULL, ' ', NULL, NULL, 6, ''),
(24, '_date', 'Date', 'date', NULL, 'Enter Date', NULL, ' ', NULL, NULL, 6, ''),
(28, 'user_id', 'Button Text', 'user_id', NULL, 'Enter Name', NULL, ' ', NULL, NULL, 2, ''),
(29, '_name', 'Name', 'text', NULL, 'Enter Name', NULL, ' ', NULL, NULL, 8, ''),
(30, '_expense_id', 'Choose expense Account', 'autocomplete', NULL, 'Enter Expenseid', NULL, 'expense', NULL, NULL, 9, ''),
(31, '_amount', 'Amount', '', NULL, 'Enter Amount', NULL, ' ', NULL, NULL, 9, ''),
(32, '_desc', 'Description', 'text', NULL, 'Enter Description', NULL, ' ', NULL, NULL, 9, ''),
(33, '_user_id', 'Userid', 'user_id', NULL, 'Enter Userid', NULL, ' ', NULL, NULL, 9, ''),
(34, '_date', 'Date', 'date', NULL, 'Enter Date', NULL, ' ', NULL, NULL, 9, ''),
(37, '_name', 'Name', 'text', NULL, 'Enter Name', NULL, ' ', NULL, NULL, 10, ''),
(38, '_tell', 'Tell', 'text', NULL, 'Enter Tell', NULL, ' ', NULL, NULL, 10, ''),
(39, '_address', 'Address', 'text', NULL, 'Enter Address', NULL, ' ', NULL, NULL, 10, ''),
(40, '_user_id', 'Userid', 'text', NULL, 'Enter Userid', NULL, ' ', NULL, NULL, 10, ''),
(41, '_date', 'Date', 'text', NULL, 'Enter Date', NULL, ' ', NULL, NULL, 10, ''),
(42, '_category_id', 'Choose Category', 'dropdown', NULL, 'Enter Categoryid', NULL, 'category', NULL, NULL, 11, ''),
(43, '_name', 'Name', 'text', NULL, 'Enter Name', NULL, ' ', NULL, NULL, 11, ''),
(44, '_cost', 'Cost', 'text', NULL, 'Enter Cost', NULL, ' ', NULL, NULL, 11, ''),
(45, '_sales', 'Sales', 'text', NULL, 'Enter Sales', NULL, ' ', NULL, NULL, 11, ''),
(46, '_description', 'Description', 'text', NULL, 'Enter Description', NULL, ' ', NULL, NULL, 11, ''),
(47, '_image', 'Image', 'file', NULL, 'Enter Image', NULL, ' ', NULL, NULL, 11, ''),
(48, '_image2', 'Image2', 'file', NULL, 'Enter Image2', NULL, ' ', NULL, NULL, 11, ''),
(49, 'image3', 'Image3', 'file', NULL, 'Enter Image3', NULL, ' ', NULL, NULL, 11, ''),
(50, '_vedio', 'Vedio', 'text', NULL, 'Enter Url Vedio', NULL, ' ', NULL, NULL, 11, ''),
(51, '_color', 'Color', 'text', NULL, 'Enter Color', NULL, ' ', NULL, NULL, 11, ''),
(52, '_rate', 'Rate', 'text', NULL, 'Enter Rate', NULL, ' ', NULL, NULL, 11, ''),
(53, '_alert', 'Alert', 'text', NULL, 'Enter Alert', NULL, ' ', NULL, NULL, 11, ''),
(54, '_category_id', 'Categoryid', 'dropdown', NULL, 'Enter Categoryid', NULL, 'category', NULL, NULL, 12, ''),
(55, '_category_id', 'Categoryid', 'dropdown', NULL, 'Enter Categoryid', NULL, 'category', NULL, NULL, 13, ''),
(56, '_product_id', 'Productid', 'autocomplete', NULL, 'Enter Productid', NULL, 'product', NULL, NULL, 13, ''),
(58, '_menu_id', 'Menuid', 'dropdown', 'load', 'Enter Menuid', NULL, 'menu', NULL, NULL, 14, 'load_form'),
(59, '_form_id', 'Choose form', 'dropdown', NULL, 'Enter Formid', NULL, 'form', NULL, NULL, 14, ''),
(61, 'user', 'Categoryid', 'user_id', NULL, 'Enter Categoryid', NULL, 'category', NULL, NULL, 12, ''),
(62, 'user', 'Productid', 'user_id', NULL, 'Enter Productid', NULL, 'product', NULL, NULL, 13, ''),
(63, 'image', 'Image', 'file', NULL, 'Enter Name', NULL, ' ', NULL, NULL, 5, ''),
(64, 'rel', 'related products', 'checkbox', NULL, 'Enter Alert', NULL, 'products', NULL, NULL, 11, ''),
(65, '_status', 'Status', 'dropdown', NULL, 'Enter Status', NULL, 'status', NULL, NULL, 17, ''),
(66, '_from', 'From', 'date', NULL, 'Enter From', NULL, ' ', NULL, NULL, 17, ''),
(67, '_to', 'To', 'date', NULL, 'Enter To', NULL, ' ', NULL, NULL, 17, ''),
(68, '_user_id', 'To', 'user_id', NULL, 'Enter To', NULL, ' ', NULL, NULL, 17, ''),
(69, '_username', 'Username', 'text', NULL, 'Enter Username', NULL, ' ', NULL, NULL, 18, ''),
(70, '_password', 'Password', 'text', 'pass', 'Enter Password', NULL, ' ', NULL, NULL, 18, ''),
(71, '_confirm', 'Confirm', 'text', 'confirm', 'Enter Confirm', NULL, ' ', NULL, NULL, 18, ''),
(72, '_image', 'Image', 'file', NULL, 'Enter Image', NULL, ' ', NULL, NULL, 18, ''),
(73, '_email', 'Email', 'text', NULL, 'Enter Email', NULL, ' ', NULL, NULL, 18, ''),
(76, '_user_id', 'Choose User', 'dropdown', NULL, 'Enter Userid', NULL, 'user', NULL, NULL, 19, ''),
(77, '_table', 'Table', 'text', NULL, 'Enter Table', NULL, ' ', NULL, NULL, 20, ''),
(78, '_user_id', 'Userid', 'text', NULL, 'Enter Userid', NULL, ' ', NULL, NULL, 20, ''),
(79, '_user_id', 'Userid', 'user_id', NULL, 'Enter Userid', NULL, ' ', NULL, NULL, 21, ''),
(80, '_old_p', 'Oldp', 'text', NULL, 'Enter Oldp', NULL, ' ', NULL, NULL, 21, ''),
(81, '_new_p', 'Newp', 'text', NULL, 'Enter Newp', NULL, ' ', NULL, NULL, 21, ''),
(82, '_confirm', 'Confirm', 'text', NULL, 'Enter Confirm', NULL, ' ', NULL, NULL, 21, '');

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id`, `name`, `icon`) VALUES
(1, 'Developer  Page', 'fa fa-users'),
(2, 'Registration', 'fa fa-plus'),
(3, 'Reports', 'fa fa-list'),
(19, 'Hrm', 'fa fa-users'),
(20, 'Purchase', 'fa fa-cart'),
(21, 'Users', 'fa fa-users');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `product` int(11) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `cost` double DEFAULT NULL,
  `sales` double DEFAULT NULL,
  `status` varchar(100) DEFAULT 'waiting',
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_id`, `product`, `qty`, `cost`, `sales`, `status`, `date`) VALUES
(13, 9, 22, 1, 12, 18, 'Failed', '2023-04-14'),
(34, 9, 22, 1, 12, 34.45656, 'Success', '2023-05-12');

-- --------------------------------------------------------

--
-- Table structure for table `order_delivery`
--

CREATE TABLE `order_delivery` (
  `id` int(11) NOT NULL,
  `empoyee_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `other_table`
--

CREATE TABLE `other_table` (
  `id` int(11) NOT NULL,
  `value` varchar(100) NOT NULL,
  `text` text NOT NULL,
  `action` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `other_table`
--

INSERT INTO `other_table` (`id`, `value`, `text`, `action`) VALUES
(1, 'tools/gen_form.php', 'Form Vertical', 'href'),
(2, 'male', 'Male', 'gender'),
(3, 'tools/gen_report.php', 'Form Horizontal', 'href'),
(4, 'tools/save.php', 'Save Page', 'form_action'),
(5, 'tools/report.php', 'Report Page', 'form_action'),
(6, 'category', 'Delete category', 'delete'),
(7, 'product', 'Delete product', 'delete'),
(8, 'orders', 'edit orders', 'edit'),
(9, 'product', 'edit product', 'edit'),
(10, 'orders', 'Delete orders', 'delete');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `date` date DEFAULT NULL,
  `ref_no` int(11) DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`id`, `supplier_id`, `amount`, `discount`, `date`, `ref_no`, `action`, `description`) VALUES
(2, 1, 100, 0, '2023-03-16', 123, 'purchase', 'test purchase'),
(4, 1, 40, 2, '0000-00-00', 125, 'purchase', 'test'),
(5, 1, 50, 0, '0000-00-00', 128, 'purchase', '1223'),
(6, 1, 220, 4, '0000-00-00', 130, 'purchase', '');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `cost` double DEFAULT NULL,
  `sales` double DEFAULT NULL,
  `discount` double NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `image2` varchar(100) DEFAULT NULL,
  `image3` varchar(100) DEFAULT NULL,
  `vedio` varchar(100) DEFAULT NULL,
  `color` varchar(100) DEFAULT NULL,
  `rate` varchar(100) DEFAULT NULL,
  `alert` int(11) DEFAULT NULL,
  `releated_products` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `category_id`, `cost`, `sales`, `discount`, `description`, `image`, `image2`, `image3`, `vedio`, `color`, `rate`, `alert`, `releated_products`) VALUES
(22, '9 Pm6666', 2, 12, 0.01, 0, '9pm by Afnan is a Amber Vanilla fragrance for men. This is a new fragrance. 9pm was launched in 2020. Top notes are Apple, Cinnamon, Wild Lavender and', '../uploads/download.jpeg', '../uploads/download (1).jpeg', '../uploads/', '', '', '', 5, '23,24'),
(23, 'A12s', 3, 100, 150, 0, 'A12s waa mobile wacan waana 128gb ram6', '../uploads/download (2).jpeg', '../uploads/download (3).jpeg', '../uploads/', '', '', '', 10, '22'),
(24, 'Computer core i5', 3, 300, 450, 400, 'Hp Core i5', '../uploads/download (10).jpeg', '../uploads/download (7).jpeg', '../uploads/', '', '', '', 0, '0'),
(26, 'All Products', 3, 120, 450, 0, 'A12s waa mobile wacan waana 128gb ram6', '../uploads/download (3).jpeg', '../uploads/download (4).jpeg', '../uploads/', 'vv', 'anycolor', '0', 10, '22'),
(27, 'SAW SAWE', 0, 300, 890, 0, '9pm by Afnan is a Amber Vanilla fragrance for men. This is a new fragrance. 9pm was launched in 2020. Top notes are Apple, Cinnamon, Wild Lavender and', '../uploads/download (7).jpeg', '../uploads/download (6).jpeg', '../uploads/', 'vv', 'anycolor', '0', 10, '22');

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE `purchase` (
  `id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `cost` double DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `date` date DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `ref_no` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchase`
--

INSERT INTO `purchase` (`id`, `supplier_id`, `product_id`, `qty`, `cost`, `user_id`, `description`, `date`, `status`, `ref_no`) VALUES
(3, 1, 17, 10, 100, 1, 'test purchase', '2023-03-16', 1, 123),
(4, 1, 18, 1, 5, 1, 'test purchase', '2023-03-16', 1, 123),
(5, 1, 19, 4, 5, 1, '', '0000-00-00', 1, 0),
(6, 1, 17, 5, 12, 1, '', '0000-00-00', 1, 7),
(7, 1, 17, 5, 6, 1, '', '0000-00-00', 1, 124),
(8, 1, 17, 3, 4, 1, 'test', '0000-00-00', 1, 125),
(9, 1, 18, 6, 5, 1, 'test', '0000-00-00', 1, 125),
(10, 1, 17, 5, 6, 1, '', '0000-00-00', 1, 126),
(11, 1, 18, 6, 2, 1, '', '0000-00-00', 1, 126),
(12, 1, 23, 5, 5, 1, '123', '2023-05-11', 1, 127),
(13, 1, 26, 4, 2, 1, '123', '2023-05-11', 1, 127),
(14, 1, 27, 3, 3, 1, '123', '2023-05-11', 1, 127),
(15, 1, 23, 3, 4, 1, '1223', '0000-00-00', 1, 128),
(16, 1, 26, 5, 8, 1, '1223', '0000-00-00', 1, 128),
(17, 1, 23, 6, 90, 1, '', '0000-00-00', 1, 129),
(18, 1, 23, 4, 56, 1, '', '2023-05-11', 1, 130);

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `tell` int(11) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`id`, `name`, `tell`, `address`, `user_id`, `date`) VALUES
(1, 'Baal Goray', 34567, 'bakara', 1, '2023-02-24');

-- --------------------------------------------------------

--
-- Table structure for table `updated_records`
--

CREATE TABLE `updated_records` (
  `id` int(11) NOT NULL,
  `tran_id` int(11) NOT NULL,
  `table` varchar(100) NOT NULL,
  `colum` text NOT NULL,
  `old_val` text NOT NULL,
  `val` text NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `updated_records`
--

INSERT INTO `updated_records` (`id`, `tran_id`, `table`, `colum`, `old_val`, `val`, `user_id`) VALUES
(5, 22, 'orders', 'product', '24', '23', 1),
(6, 22, 'orders', 'product', '23', '24', 1),
(7, 22, 'orders', 'status', 'Failed', 'Success', 1),
(8, 22, 'orders', 'qty', '4', '7', 1),
(9, 22, 'product', 'name', '9 Pm', '9 Pm6666', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` text DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT '1',
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password`, `image`, `status`, `email`) VALUES
(1, 'Hassan Ali', 'admin', '827ccb0eea8a706c4c34a16891f84e7b', 'uploads/avatar-1.jpg', '1', NULL),
(2, 'Jaamac', 'jamac', '827ccb0eea8a706c4c34a16891f84e7b', 'uploads/avatar-1.jpg', '1', NULL),
(3, NULL, 'Nageye', '81dc9bdb52d04dc20036dbd8313ed055', '1', '1', 's'),
(4, NULL, 'Nageye2', '202cb962ac59075b964b07152d234b70', '../uploads/download.jpeg', '1', 'test@gmail.com'),
(5, NULL, 'abdalla', '202cb962ac59075b964b07152d234b70', '../uploads/download (1).jpg', '1', 'test@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `user_links`
--

CREATE TABLE `user_links` (
  `id` int(11) NOT NULL,
  `form_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `granted_user` int(11) DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_links`
--

INSERT INTO `user_links` (`id`, `form_id`, `user_id`, `granted_user`, `action`) VALUES
(3, 3, 1, 1, 'form'),
(4, 5, 1, 1, 'form'),
(6, 6, 2, 1, 'form'),
(7, 8, 1, 1, 'form'),
(8, 9, 1, 1, 'form'),
(9, 10, 1, 1, 'form'),
(11, 11, 1, 1, 'form'),
(17, 7, 1, 1, 'delete'),
(21, 9, 1, 1, 'edit'),
(27, 16, 4, 1, 'form'),
(29, 19, 1, 1, 'form'),
(33, 17, 1, 1, 'form'),
(34, 10, 1, 1, 'delete'),
(35, 8, 1, 1, 'edit'),
(36, 12, 1, 1, 'form'),
(37, 13, 1, 1, 'form'),
(38, 2, 1, 1, 'form'),
(39, 15, 1, 1, 'form'),
(40, 18, 1, 1, 'form'),
(41, 14, 1, 1, 'form'),
(42, 20, 1, 1, 'form'),
(43, 21, 1, 1, 'form');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `charts`
--
ALTER TABLE `charts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deleted_records`
--
ALTER TABLE `deleted_records`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense`
--
ALTER TABLE `expense`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_account`
--
ALTER TABLE `expense_account`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `forms`
--
ALTER TABLE `forms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `form_input`
--
ALTER TABLE `form_input`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_delivery`
--
ALTER TABLE `order_delivery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `other_table`
--
ALTER TABLE `other_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `updated_records`
--
ALTER TABLE `updated_records`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_links`
--
ALTER TABLE `user_links`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `charts`
--
ALTER TABLE `charts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `deleted_records`
--
ALTER TABLE `deleted_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `expense`
--
ALTER TABLE `expense`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `expense_account`
--
ALTER TABLE `expense_account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `forms`
--
ALTER TABLE `forms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `form_input`
--
ALTER TABLE `form_input`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `order_delivery`
--
ALTER TABLE `order_delivery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `other_table`
--
ALTER TABLE `other_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `purchase`
--
ALTER TABLE `purchase`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `updated_records`
--
ALTER TABLE `updated_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_links`
--
ALTER TABLE `user_links`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
