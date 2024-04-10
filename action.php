<?php
header('Content-Type: application/json;charset=utf-8');

$host = "localhost";
$user = "root";
$password = "";
$database = "city";
$link = mysqli_connect($host, $user, $password) or die("無法選擇資料庫");
mysqli_select_db($link,$database);
mysqli_query($link,"SET NAMES utf8");


if(!empty($_GET['act'])) {
    $action = $_GET['act'];
}

if(!empty($_GET['val'])) {
    $val = $_GET['val'];
}



$list = array();
switch ($action) {

    case 'city':
        $sql = "SELECT * FROM city WHERE 1";
        $result = mysqli_query($link,$sql);
        while($row = mysqli_fetch_assoc($result)) {
            $list[] = $row;
        }
        break;
    case 'site_id':
        $sql = "SELECT * FROM site WHERE city_id = '$val'";
        $result = mysqli_query($link,$sql);
        while($row = mysqli_fetch_assoc($result)) {
            $list[] = $row;
        }
        break;
    case 'road':
        $sql = "SELECT * FROM road WHERE site_id = '$val'";
        $result = mysqli_query($link,$sql);
        while($row = mysqli_fetch_assoc($result)) {
            $list[] = $row;
        }
        break;
}

echo json_encode($list);
return;

mysqli_free_result($result);

mysqli_close($link);
?>
