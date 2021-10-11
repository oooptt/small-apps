<?php
session_start();

$account = $_SESSION['account'];
$power = $_SESSION['power'];

// 計算總額
$sum = $_POST['wages'] * $_POST['c_site_worker'];
// 是否為補請款
date_default_timezone_set('Asia/Taipei');
$alter = ($_POST['date'] == date("Y-m-d")) ? 0 : 1;

$dedu = ($_POST['deduction_method'] == '營造請') ? $_POST['deduction_remark'] : '';

// 定義資料庫資訊
include "./php_connected.php";
$DB_CONN = "staff_list"; // 欲選取的資料表

// 將資料新增進資料庫中
$sql = "INSERT INTO `working_record2` (`id`, `工程名稱`, `負責人`, `日期`, `請款人`, `工數`, `扣工方式`, `備註`, `工作內容`,
        `扣工明細`, `工錢`, `總額`, `補請款`) VALUES (NULL, '$_POST[c_site_name]', '$account',  
        '$_POST[date]', '$_POST[requester]', '$_POST[c_site_worker]', '$_POST[deduction_method]', '$dedu', 
        '$_POST[remark]', '$_POST[deduction]', '$_POST[wages]', '$sum', '$alter')";

$result = mysqli_query($con, $sql);

$feedback = array("status" => "success", "sql" => $sql);
echo json_encode($feedback);

// 回收mysql資源
mysqli_close($con);
exit;
