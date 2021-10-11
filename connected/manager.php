<?php

$DB_CONN = "construction_site";   // 欲選取的資料表
// 定義資料庫資訊
include "./connected/php_connected.php";

// 取得資料
$sql = "SELECT * FROM $DB_CONN";

// 將資料改為json格式
// $json = "[";
// if ($result = mysqli_query($con, $sql)) {
//     $num = mysqli_num_rows($result);
//     $tmp = 1;

//     while ($row = mysqli_fetch_assoc($result)) {
//         $json .= "{\"name\": \"" . $row['工程名稱'] . "\", \"site\": \"" . $row['工程位置'] . "\"}";
//         if ($tmp < $num) {
//             $json .= ",\n";
//         }
//         $tmp++;
//     }
// }
// $json .= "]";


$return = array();
if ($result = mysqli_query($con, $sql)) {
    $num = mysqli_num_rows($result);
    $tmp = 1;

    while ($row = mysqli_fetch_assoc($result)) {
        $data = array();
        $data["name"] = $row['工程名稱'];
        $data["site"] = $row['工程位置'];
        if ($tmp < $num) {
            array_push($return, $data);
        }
        $tmp++;
    }
}

echo json_encode(array("result"=>$return));
// 回收sql資源
include "connected/php_return.php"
?>
