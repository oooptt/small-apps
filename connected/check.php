<?php

$DB_CONN = "working_record2";   // 欲選取的資料表
// 定義資料庫資訊
include "php_connected.php";

date_default_timezone_set('Asia/Taipei');
$getDate = date("Y-m-d");

// 初始化頁面，選擇工地名稱
if ($_POST['propose'] == 'initialize') {

    // 將工程名稱存在c_name中
    $sql = "SELECT DISTINCT `工程名稱`  FROM `$DB_CONN` ORDER BY `日期` DESC";
    $c_name = [];
    $c_charge = [];

    if ($result = mysqli_query($con, $sql)) {
        while ($obj = mysqli_fetch_assoc($result)) {
            array_push($c_name, $obj['工程名稱']);
        }
    }

    // 將負責人存在c_charge中
    $sql = "SELECT DISTINCT `負責人`  FROM `$DB_CONN` ORDER BY `日期` DESC";
    if ($result = mysqli_query($con, $sql)) {
        while ($obj = mysqli_fetch_assoc($result)) {
            array_push($c_charge, $obj['負責人']);
        }
    }

    // 回傳ajax
    $feedback = array("status" => "success", "c_name" => $c_name, "c_charge" => $c_charge);
    echo json_encode($feedback);
}
// 當功能為: 更新工程名稱，更新負責人，更新日期時
else if ($_POST['propose'] == 'change_c_site' || $_POST['propose'] == 'change_charge' || 
$_POST['propose'] == 'date-func' || $_POST['propose'] == 'make_files') {

    @$date_select = $_POST['date_select'];
    $date_end = $getDate;
    $date_start = $getDate;

    // 設定日期
    if ($date_select == '1' || $_POST['propose'] == 'change_c_site') {
        $date_end = $getDate;
        $date_start = $getDate;
    } else if ($date_select == '7') {
        $date_end = $getDate;
        $date_start = date("Y-m-d", strtotime("$date_end -7 day"));
        $date_start = date("Y-m-d", strtotime("$date_start +1 day"));
    } else if ($date_select == '30') {
        $date_end = $getDate;
        $date_start = date("Y-m-d", strtotime("$date_end -1 month"));
        $date_start = date("Y-m-d", strtotime("$date_start +1 day"));
    } else if ($date_select == '100') {
        $date_end = $getDate;
        $date_start = date("Y-m-d", strtotime("$date_end -3 year"));
        $date_start = date("Y-m-d", strtotime("$date_start +1 day"));
    } else if ($date_select == '0') {
        $date_start = $_POST['date_start'];
        $date_end = $_POST['date_end'];
    }

    
    // 若選擇所有工程，則sql不加條件
    $all_site = ($_POST['c_site_name'] != '所有工程') ? "' AND `工程名稱` = '" . $_POST['c_site_name'] : "";
    // 若選擇所有主任，則sql不加條件
    $all_charge = ($_POST['c_site_charge'] != '所有主任') ? "' AND `負責人` = '" . $_POST['c_site_charge'] : "";

    // 設定sql
    $sql = "SELECT * FROM `$DB_CONN` WHERE `日期` BETWEEN '" . $date_start . "' AND '" . $date_end .
            $all_site . $all_charge . "' ORDER BY `日期` ASC , `補請款` DESC, `工程名稱` ASC, `負責人` ASC";

    // 將sql結果存在data中
    $data = [];
    if ($result = mysqli_query($con, $sql)) {
        while ($obj = mysqli_fetch_assoc($result)) {
            array_push($data, $obj);
        }
    }

    // 回傳ajax
    $feedback = array("status" => "success", "data" => $data, "sql" => $sql);
    echo json_encode($feedback);
} else {
    // 當方法名稱錯誤
    $feedback = array("status" => "failed", "data" => "propose incorrect");
    echo json_encode($feedback);
}
