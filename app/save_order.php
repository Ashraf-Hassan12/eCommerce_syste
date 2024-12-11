<?php 

extract($_POST);
$paymentStatus="";
$mid = "M0912171";
$apiuser = "1004623";
$apkey = "API-1292309709AHX";






    $payment_description="";
   // print_r($_POST);
    $phoneNumber="252".$tell;
    $amount=$price;
	$desc= $itemname;
	$requestId=(rand(100000,999999));
	$ref=(rand(100000,999999));
	$invoiceId=(rand(100000,999999));
	$timestamp=date("Y-m-d H:i:s");
	$data=
	array
	(
		'schemaVersion' => '1.1',
		'requestId' => $requestId,
		'timestamp' => $timestamp,
		'channelName' => 'WEB',
		'serviceName' => 'API_PURCHASE',
		'serviceParams' => array
			(
				'merchantUid' => $mid,
				'apiUserId' => $apiuser,
				'apiKey' => $apkey,
				'paymentMethod' => 'MWALLET_ACCOUNT',
				'payerInfo' => array
					(
						'accountNo' => $phoneNumber,
					),
				'transactionInfo' => array
					(
						'referenceId' => $ref,
						'invoiceId' => $invoiceId,
						'amount' => $amount,
						'currency' => 'USD',
						'description' => $desc,
					)

			)
	);

	//curl starts here.
	$post_data=json_encode($data,JSON_UNESCAPED_SLASHES);

	$url="https://api.waafipay.net/asm";
	$ch=curl_init($url);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
	curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	$excuteCurl=curl_exec($ch);
//	print_r($excuteCurl);

	$returnData=json_decode($excuteCurl, true);
	$responseCode=$returnData['responseCode'];
	$apiResponseMessage=$returnData['responseMsg'];

	if ($responseCode==2001) {
		
		$paymentStatus="successfull";
		$payment_description= $paymentStatus.' '.$apiResponseMessage;
       // echo $paymentStatus;
	}else{

		$paymentStatus="Failed";
		$payment_description= $paymentStatus.' '.$apiResponseMessage;
		//echo $paymentStatus;
	}
	
require("../tools/conn.php");
extract($_POST);

$sql = "call order_sp('$tell','$address','$item_id','$price','$paymentStatus')";
$ress = $conn->query($sql);

$r = $ress->fetch_array();

echo $paymentStatus;
?>