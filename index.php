<?php
    if(!isset($_SESSION)) {
        session_start();
    }
    
    // Enable us to use Headers
    ob_start();
    // import essential system parameters
    require("./connected/php_connected.php");   

    // Set sessions


    if(!isset($_SESSION['account'])){
        header("location: sign-in.html");
        exit(); 
    }
    else{        
        switch($_SESSION['power']){
            case 'boss':
                $pageTemplate = "check.html";
                break;
            case 'manager':
                $pageTemplate = "punch_in.html";
                break;
            case 'accountant':
                $pageTemplate = "edit_construction_site.html";
                break;
            default:
                $pageTemplate = "error.html";
                break;
        }
        include($pageTemplate);
    }
    
?>