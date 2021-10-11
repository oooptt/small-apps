<?php

// 定義資料庫資訊
$DB_NAME = "TingWeiEngineering";  // 資料庫名稱
$DB_USER = "root";                // 資料庫管理帳號
$DB_PASS = "phpwwndbk";           // 資料庫管理密碼
$DB_HOST = "localhost";           // 資料庫位址


// 連接 MySQL 資料庫伺服器
$con = mysqli_connect($DB_HOST, $DB_USER, $DB_PASS, $DB_NAME);
if ($con -> connect_error) {
    die("連線失敗：" . $con -> connect_error);
  }

// 設定連線編碼
mysqli_query($con, "SET NAMES 'utf8mb4'");
