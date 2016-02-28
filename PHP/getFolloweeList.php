<?php
$host="localhost"; //replace with your hostname 
$username="root"; //replace with your username 
$password="travelgene"; //replace with your password 
$db_name="travelgene"; //replace with your database 
$connection=mysql_connect("$host", "$username", "$password");
mysql_select_db("$db_name")or die("cannot select DB");

$userid = $_GET['userid'];

$sql = "select * from users2 where userid in (select followee from friendlist where userid = $uesrid);";
$result = mysql_query($sql);
$json = array();
if(mysql_num_rows($result)){
while($row=mysql_fetch_assoc($result)){
$json[]=$row;
}
}
mysql_close($db_name);
echo json_encode($json);
?>
