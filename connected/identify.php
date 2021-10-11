<?php

// 上一個表單傳過來的資訊
$account = isset($_POST['account'])? $_POST['account']:"";
$name = isset($_POST['name'])? $_POST['name']:"";
$passwd = isset($_POST['passwd'])? $_POST['passwd']:"";

$DB_CONN = "staff_list";          // 欲選取的資料表
include "php_connected.php";


// 取得資料
$sql = "SELECT * FROM $DB_CONN WHERE 帳號='$account'";
$result = mysqli_query($con, $sql);

if ($result) {
    $num = mysqli_num_rows($result);

    // 若帳號只有一組資料
    if ($num == 1) {
        $row = mysqli_fetch_assoc($result);

        if (password_verify($passwd, $row['密碼'])) {  // 帳號密碼正確
            echo '成功登入，即將跳轉！';
        } else {    // 帳號密碼錯誤
            echo '密碼錯誤，請重新輸入';
            header("refresh:3;url=../index.php");
            exit; 
        }

        switch($row['職位']) {
            case 'boss':
            case 'manager':
            case 'accountant':
                //header("refresh:3;url=../index.php");
                header("refresh:0;url=../index.php");
                break;
            default:
                echo 'ERROR!!發生未知錯誤';
                header("refresh:3;url=../index.php");
        }
    } else {
        echo "登入失敗，將自動回到登入頁面！";
        echo $num;
        //header("refresh:3; url=./sign-in.html");
        exit();
    }

    // 以session紀錄帳號、權限傳給下一個網頁
    session_start();
    $_SESSION['account'] = $account;
    $_SESSION['name'] = $row['姓名'];
    $_SESSION['power'] = $row['職位'];
}

// 回收mysql資源
include "php_return.php";
exit;
