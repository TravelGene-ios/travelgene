<?php
$host="localhost"; //replace with your hostname 
$username="root"; //replace with your username 
$password="travelgene"; //replace with your password 
$db_name="travelgene"; //replace with your database 
$conn=mysql_connect("$host", "$username", "$password");
mysql_select_db("$db_name")or die("cannot select DB");

$email = $_GET['email'];
$password = $_GET['password'];
$sql = "INSERT INTO users2 (email, password) VALUES ('$email', SHA2('$password',256))";

$retval = mysql_query( $sql, $conn );
if(!$retval) {
die('Could not enter data: ' . mysql_error());
}

mysql_close($db_name);
?>
