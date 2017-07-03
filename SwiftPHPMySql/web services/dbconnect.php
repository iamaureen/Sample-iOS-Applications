
<?php
 
class DbConnect
{
    private $conn;
 
    function __construct()
    {
    }
 
    /**
     * Establishing database connection
     * @return database connection handler
     */
    function connect()
    {
        //require dirname(__FILE__).‘/configrobin.php';
 
        // Connecting to mysql database
        $this->conn = new mysqli('localhost', 'root', 'password', 'robinlocal');
 
        // Check for database connection error
        if (mysqli_connect_errno()) {
            echo "Failed to connect to MySQL: " . mysqli_connect_error();
        }
 
        // returing connection resource
        return $this->conn;
    }
}

?>
