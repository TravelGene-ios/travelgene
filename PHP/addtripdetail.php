<?php
$host="localhost"; //replace with your hostname 
$username="root"; //replace with your username 
$password="travelgene"; //replace with your password 
$db_name="travelgene"; //replace with your database 
$conn=mysql_connect("$host", "$username", "$password");
mysql_select_db("$db_name")or die("cannot select DB");

$email = $_GET['email'];
$date_start = $_GET['date_start'];
$date_end = $_GET['date_end'];
$destination = $_GET['destination'];
$activity = $_GET['activity'];

$sql = "INSERT INTO tripdetail (email, date_start, date_end, destination, activity) VALUES('$email','$date_start','$date_end','$destination','$activity');

$retval = mysql_query( $sql, $conn );
if(!$retval) {
die('Could not enter data: ' . mysql_error());
}

mysql_close($db_name);
?>
