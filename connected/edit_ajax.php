<?php

session_start();
$name = $_SESSION['name'];
$power = $_SESSION['power'];

// 定義資料庫資訊
$DB_CONN = "construction_site"; // 欲選取的資料表
include "./php_connected.php";

// 設定一頁資料數
$data_num_per_page = 4;
$data_start = 0;
$feedback = array("data" => "");


// 新增工程
if ($_POST['propose'] == 'add') {
    $sql = "INSERT INTO `construction_site` (`工程名稱`, `開始日期`, `預計結束日期`)
        VALUES ('" . $_POST['c_site_name'] . "', '" .
        $_POST['c_site_date_start'] . "', '" . $_POST['c_site_date_end'] . "')";
    $result = mysqli_query($con, $sql);

    // 檢查是否成功新增
    if ($con->affected_rows == 1) {
        $feedback["status"] = "成功";
    } else {
        $feedback["status"] = "失敗";
    }
}

// 更新工程
else if ($_POST['propose'] == 'update') {
    $sql = "UPDATE `construction_site` SET `工程名稱`='" . $_POST['c_site_name'] .
        "',`開始日期`='" . $_POST['c_site_date_start'] .
        "',`預計結束日期`='" . $_POST['c_site_date_end'] .
        "' WHERE `construction_site`.`工程名稱`= '" . $_POST['c_site_name_before'] . "'";
    $result = mysqli_query($con, $sql);

    // 檢查是否成功更新
    if ($con->affected_rows == 1) {
        $feedback["status"] = "成功";
    } else {
        $feedback["status"] = "失敗";
    }
}

// 刪除工程
else if ($_POST['propose'] == 'delete') {
    $sql = "DELETE FROM `construction_site` WHERE `construction_site`.`工程名稱` = '" . $_POST['c_site_name'] . "'";
    $result = mysqli_query($con, $sql) or die(mysqli_error($con));

    // 檢查是否成功刪除
    if ($con->affected_rows == 1) {
        $feedback["status"] = "成功";
    } else {
        $feedback["status"] = "失敗";
    }
}

$sql = "SELECT * FROM $DB_CONN";
if ($result = mysqli_query($con, $sql)) {
    // 取得資料總筆數
    $data_num = mysqli_num_rows($result);
    // 取得資料總頁數
    $page_num = CEIL($data_num / $data_num_per_page);
}

if ($_POST['propose'] == 'initialization' || $_POST['propose'] == 'change_page' || $_POST['propose'] == 'update') {
    // 取得現在頁面
    $now_page = $_POST['now_page'];

    // 從資料庫抓資料的起始位置
    $data_start = ($now_page - 1) * $data_num_per_page;
    $feedback["now_page"] = $now_page;

    if ($_POST['propose'] == 'initialization') {
        if ($power == 'boss') {
            $power = '老闆';
        } else if ($power == 'manager') {
            $power = '主任';
        } else {
            $power = '會計';
        }
        $feedback["name"] = $name;
        $feedback["power"] = $power;
    }
}
$feedback["page_num"] = $page_num;


// 從起始位置開始往下抓 $data_num_per_page 筆資料
$sql = "SELECT * FROM `construction_site` ORDER BY `工程名稱` DESC Limit $data_start, $data_num_per_page";

$data = [];
if ($result = mysqli_query($con, $sql)) {
    while ($obj = mysqli_fetch_assoc($result)) {
        array_push($data, $obj);
    }
}

$feedback["data"] = $data;
$feedback["sql"] = $sql;
echo json_encode($feedback);
