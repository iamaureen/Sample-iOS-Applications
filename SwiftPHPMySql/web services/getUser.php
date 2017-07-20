<?php

//including the db operation file
require dirname(__FILE__).'/dboperation.php';


//creating a response array to store data
$response = array();

//creating a key in the response array to insert values
//this key will store an array iteself
$response['user'] = array();

//creating object of class DbOperation
$db = new DbOperation();

//getting the teams using the function we created
$teams = $db->getUsers();

//looping through all the teams.
while($team = $teams->fetch_assoc()){
    //creating a temporary array
    $temp = array();
    
    //inserting the team in the temporary array
    $temp['module'] = $team['module'];
    $temp['name']=$team['name'];
    
    //inserting the temporary array inside response
    array_push($response['user'],$temp);
}

//displaying the array in json format
echo json_encode($response);

?>
