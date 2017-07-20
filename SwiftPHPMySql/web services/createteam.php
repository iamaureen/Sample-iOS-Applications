
<?php
 
//creating response array
$response = array();
 
if($_SERVER['REQUEST_METHOD']=='POST'){
 
    //getting values
    $module = $_POST['module'];
    $name = $_POST['name'];
 
    //including the db operation file
    require dirname(__FILE__).'/dboperation.php';
 
    $db = new DbOperation();
 
    //inserting values 
    if($db->createTeam($module,$name)){
        
        $response['error']=false;
        $response['message']='Team added successfully';
    }else{
 
        $response['error']=true;
        $response['message']='Could not add team';
    }
 
}else{
    $response['error']=true;
    $response['message']='You are not authorized';
}

    
    //prints in postman
echo json_encode($response);

?>
