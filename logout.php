<?php
    session_start();
    session_destroy();
?>
<script>alert("您已登出成功！將自動回到首頁！");</script>
<meta http-equiv="refresh" content="0;URL='./index.php'" />

