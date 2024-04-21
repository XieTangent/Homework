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
if(!empty($_GET['val2'])) {
    $val2 = $_GET['val2'];
}
if(!empty($_GET['val3'])) {
    $val3 = $_GET['val3'];
}
if(!empty($_GET['val4'])) {
    $val4 = $_GET['val4'];
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

    case 'insertcity':
        $sql = "INSERT INTO city VALUES ('$val','$val2')";
        mysqli_query($link,$sql);
        break;
    case 'insertsite':
        $sql = "INSERT INTO site VALUES ('$val','$val2','$val3')";
        mysqli_query($link,$sql);
        break;

    case 'insertroad':
        $sql = "INSERT INTO road VALUES ('$val','$val2')";
        mysqli_query($link,$sql);
        break;  

    case 'updatecity':
        $sql = "UPDATE city SET city_id = '$val2',city = '$val3' WHERE city_id = '$val'";
        mysqli_query($link,$sql);
        break;
    
    case 'updatesite':
        $sql = "UPDATE site SET site_id = '$val2',site = '$val3' WHERE site_id = '$val'";
        mysqli_query($link,$sql);
        break;
    
    case 'updateroad':
        $list = array();
        $sql = "UPDATE road SET site_id = '$val3',road = '$val4' WHERE site_id = '$val' AND road = '$val2'";
        mysqli_query($link,$sql);
        break;
}

echo json_encode($list);
return;

mysqli_free_result($result);

mysqli_close($link);
?>
