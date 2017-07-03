
<?php
 
class DbOperation
{
    private $conn;
 
    //Constructor
    function __construct()
    {
        //require_once dirname(__FILE__) . '/configrobin.php';
        require_once dirname(__FILE__) . '/dbconnect.php';
        // opening db connection
        $db = new DbConnect();
        $this->conn = $db->connect();
    }
 
    //Function to create a new user
    public function createTeam($moduleno, $names)
    {
        echo 'here :: ' . $names;
        $stmt = $this->conn->prepare("INSERT INTO info(module, name) values(?, ?)");
        $stmt->bind_param("is", $moduleno, $names);
        $result = $stmt->execute();
        $stmt->close();
        if ($result) {
            return true;
        } else {
            return false;
        }
    }
 
}

?>
