<?php

$DB_CONN = "construction_site";   // 欲選取的資料表
// 定義資料庫資訊
include "php_connected.php";

date_default_timezone_set('Asia/Taipei');
$getDate = date("Y-m-d");
// $getDate = '2021-09-17';


if ($_POST['propose'] == 'initialize') {  // 初始化頁面

    $sql = "SELECT *  FROM `$DB_CONN` WHERE `開始日期` < '$getDate' AND `預計結束日期` > '$getDate'";
    $name = [];

    if ($result = mysqli_query($con, $sql)) {
        while ($obj = mysqli_fetch_assoc($result)) {
            array_push($name, $obj['工程名稱']);
        }
    }

    $feedback = array("status" => "success", "name" => $name, "sql" => $sql);
    echo json_encode($feedback);
} else {
    $feedback = array("status" => "failed", "data" => "propose錯誤");
    echo json_encode($feedback);
}
