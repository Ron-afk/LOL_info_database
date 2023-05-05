<?PHP
require 'pageparts/header.php';
?>


<div class="mainDisplay">
    <!-- <div style="height: 30px;" class="miniBar"></div> -->
    <?php include('listeners/filterListener.incl.php'); ?>

    <div style="overflow-y: scroll; color: #482522;
    font-family: 'Gruppo', cursive;
    font-size: 20px;
    border-style: hidden;
    background: none;" class="displayResult">

        <?PHP
        $palyer = null;
        $champion = null;
        $coach = null;
        $team = null;
        $championshipName = null;
        $season = null;

        include('listeners/mainDis.incl.php');
        ?>
        <!-- <script>
            $('input[type=radio]').click(function(e) {

                var selectedRecord = $(this).val();
                $('.selectedRecord').html(selectedRecord);

            });
        </script> -->
        

    </div>
    <!-- <br> break </br> -->
    <div class="insertPanel" style="height:200px;">
        <?php
        echo $selectedRecord;
        include('listeners/insertListener.incl.php');
        ?>
    </div>
</div>



<!-- database related request function here -->
<?php
$success = True;
$db_conn = NULL;
$show_debug_alert_messages = False;
$selectedRecord = null;


function debugAlertMessage($message)
{
    global $show_debug_alert_messages;

    if ($show_debug_alert_messages) {
        echo "<script type='text/javascript'>alert('" . $message . "');</script>";
    }
}

function executePlainSQL($cmdstr)
{ //takes a plain (no bound variables) SQL command and executes it
    //echo "<br>running ".$cmdstr."<br>";
    global $db_conn, $success;

    $statement = OCIParse($db_conn, $cmdstr);
    //There are a set of comments at the end of the file that describe some of the OCI specific functions and how they work

    if (!$statement) {
        echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
        $e = OCI_Error($db_conn); // For OCIParse errors pass the connection handle
        echo htmlentities($e['message']);
        $success = False;
    }

    $r = OCIExecute($statement, OCI_DEFAULT);
    if (!$r) {
        echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
        $e = oci_error($statement); // For OCIExecute errors pass the statementhandle
        echo htmlentities($e['message']);
        $success = False;
    }

    return $statement;
}

function executeBoundSQL($cmdstr, $list)
{
    /* Sometimes the same statement will be executed several times with different values for the variables involved in the query.
In this case you don't need to create the statement several times. Bound variables cause a statement to only be
parsed once and you can reuse the statement. This is also very useful in protecting against SQL injection.
See the sample code below for how this function is used */

    global $db_conn, $success;
    $statement = OCIParse($db_conn, $cmdstr);

    if (!$statement) {
        echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
        $e = OCI_Error($db_conn);
        echo htmlentities($e['message']);
        $success = False;
    }

    foreach ($list as $tuple) {
        foreach ($tuple as $bind => $val) {
            //echo $val;
            //echo "<br>".$bind."<br>";
            OCIBindByName($statement, $bind, $val);
            unset($val); //make sure you do not remove this. Otherwise $val will remain in an array object wrapper which will not be recognized by Oracle as a proper datatype
        }

        $r = OCIExecute($statement, OCI_DEFAULT);
        if (!$r) {
            echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
            $e = OCI_Error($statement); // For OCIExecute errors, pass the statementhandle
            echo htmlentities($e['message']);
            echo "<br>";
            $success = False;
        }
    }
}

function connectToDB()
{
    global $db_conn;

    $db_conn = OCILogon("ora_xiaorang", "a25621657", "dbhost.students.cs.ubc.ca:1522/stu");
    if ($db_conn) {
        debugAlertMessage("Database is Connected");
        return true;
    } else {
        debugAlertMessage("Cannot connect to Database");
        $e = OCI_Error(); // For OCILogon errors pass no handle
        echo htmlentities($e['message']);
        return false;
    }
}

function disconnectFromDB()
{
    global $db_conn;

    debugAlertMessage("Disconnect from Database");
    OCILogoff($db_conn);
}

function displayFromDB($table, $mode, $value)
{
    global $db_conn;

    if (connectToDB()) {
        echo '<table class="dispTable" style="
        width: 100%;
        text-align:center;
        padding: 15px;">';
        switch ($table) {
            case "Player":
                echo '<tr><th>Player ID</th></tr>';
                break;
            case "Coach":
                echo '<tr><th>Coach ID</th></tr>';
                break;
            case "Champion":
                echo '<tr><th >Champion</th><th>Mainlane</th></tr>';
                break;
            case "Championship":
                echo '<tr><th>Championship Name</th>
                <th>Championship Season</th>
                <th>Championship Winner Team</th>
                <th>Championship Bonus</th></tr>';
                break;
            default:
                echo '<tr><th >Team</th><th>Region</th></tr>';
                break;
        }
        if ($mode == "ALL") {
            // echo 'mode all';
            $result = executePlainSQL("SELECT * FROM " . $table);
        } else {
            $result = executePlainSQL("SELECT * FROM " . $table . " WHERE " . $mode . "='" . $value . "'");
        }
        switch ($table) {
            case "Player":
                while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
                    // echo '<tr><td> ' . $row["PLAYERID"].'</td></tr>';
                    echo '<tr><td> ' . buttonConv("playerButton", $row["PLAYERID"], null) . '</td></tr>';
                }
                break;
            case "Coach":
                while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
                    echo '<tr><td> ' . buttonConv("coachButton", $row["COACHNAME"], null) . '</td></tr>';
                }
                break;
            case "Champion":
                while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
                    // echo $row["CHAMPIONNAME"]."</br>";
                    echo '<tr><td> ' . buttonConv("championButton", $row["CHAMPIONNAME"], null) . ' </td><td > ' . $row["MAINLANE"] . '</td></tr>';
                }
                break;
            case "Championship":
                while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
                    // echo $row["CHAMPIONNAME"]."</br>";
                    echo '<tr><td> ' . buttonConv("championshipButton", $row["CHAMPIONSHIPNAME"], $row["CHAMPIONSHIPSEASON"]) . ' </td><td > '
                        . $row["CHAMPIONSHIPSEASON"] . '</td><td>' . $row["TEAMNAME"] . '</td><td>' . $row["BONUS"] . '</td></tr>';
                }

                break;
                // case "Record":
                //     while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
                //         echo '<tr><td> ' . buttonConv("RecordButton", $row["CHAMPIONSHIPNAME"],$row["CHAMPIONSHIPSEASON"]) . ' </td><td > ' 
                //         . $row["CHAMPIONSHIPSEASON"] . '</td><td>'.$row["TEAMNAME"].'</td><td>'.$row["BONUS"].'</td></tr>';
                //     }

                break;
            default:
                while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
                    echo '<tr><td>' . buttonConv("teamButton", $row["TEAMNAME"], null) . '</td><td > ' . $row["REGION"] . '</td></tr>';
                }
                break;
        }

        echo '</table>';
    }
    disconnectFromDB();
}


function buttonConv($name, $value1, $value2)
{
    // global $season;
    // global $championshipName;
    $result = '<form method="POST" action="index.php">
    <input type ="submit" name=' . $name . ' value=' . $value1 . ' />  
    </form>';
    // if($name = "championshipButton") {
    //     $season = $value2;
    //     $championshipName = $value1;    
    // }

    // $test = "'<form method='POST' action='index.php'>
    // <input type ='submit' name=' . $name . ' value=' . $value . ' />  
    // </form>'";
    // echo $test.'</br>';
    return $result;
}

function addToDB($table, $val1, $val2, $val3, $val4, $val5)
{
    global $db_conn;
    $plainSQL = "";
    if (connectToDB()) {
        switch ($table) {
            case "Team":
                $plainSQL = "INSERT into " . $table . " values('" . $val1 . "','" . $val2 . "')";
                break;
            case "Player":
                $plainSQL = "INSERT into " . $table . " values('" . $val1 . "')";
                break;
            case "Coach":
                $plainSQL = "INSERT into " . $table . " values('" . $val1 . "')";
                break;
            case "Champion":
                $plainSQL = "INSERT into " . $table . " values('" . $val1 . "','" . $val2 . "')";
                break;
            case "Championship":
                $plainSQL = "INSERT into " . $table . " values('" . $val1 . "','" . $val2 . "','" . $val3 . "','" . $val4 . "')";
                break;
            case "Record":
                $plainSQL = "INSERT into " . $table . " values('" . $val1 . "','" . $val2 . "','" . $val3 . "','" . $val4 . "','" . $val5 . "')";
                break;
            default:
                break;
        }
        if (executePlainSQL($plainSQL)) {
            OCICommit($db_conn);
            echo $val1 . ' has ben added to data base';
        } else {
            echo "Fail to add";
        }
    }
    disconnectFromDB();
}

function deleteFromDB($table, $val1, $val2, $val3)
{
    global $db_conn;
    global $champion;
    $plainSQL = "";
    // echo 'b1';
    if (connectToDB()) {
        switch ($table) {
            case "Team":
                // echo 'b2';
                $plainSQL = "DELETE from " . $table . " WHERE TEAMNAME='" . $val1 . "'";
                break;
            case "Player":
                $plainSQL = "DELETE from " . $table . " WHERE PLAYERID='" . $val1 . "'";
                break;
            case "Coach":
                $plainSQL = "DELETE from " . $table . " WHERE COACHNAME='" . $val1 . "'";
                break;
            case "Champion":
                // echo 'b6 </br>';
                // echo $champion;
                // DELETE from " . $table . " WHERE CHAMPIONNAME='" . $val1 . "'
                $plainSQL = "DELETE from " . $table . " WHERE CHAMPIONNAME='" . $val1 . "'";
                // echo $plainSQL;
                break;
            case "Championship":
                break;
            default:
                break;
        }
        if (executePlainSQL($plainSQL)) {
            // echo ' b3';
            if (OCICommit($db_conn)) {
                // echo ' b4';
            };
            // echo $val1 . ' has ben deleted data base';
            // echo 'b5';
        }
    }
    disconnectFromDB();
}

function dispRecords($val)
{
    global $db_conn;
    if (connectToDB()) {
        echo '<form method="POST" action="index.php"><table class="dispTable" style="
        width: 100%;
        text-align:center;
        padding: 15px;">';
        echo '<tr>
        <th>Championship</th>
        <th>Season</th>
        <th>Record ID</th>
        <th>Loser Team</th>
        <th>Winner Team</th>
        </tr>';
        // echo "<br>".$val;
        $result1 = executePlainSQL("SELECT * FROM Record  WHERE CHAMPIONSHIPNAME='" . $val . "'");
        // echo 'br';
        while ($row = OCI_Fetch_Array($result1, OCI_BOTH)) {
            // $list = $row;
            

            echo '<tr><td>'
                . $row["CHAMPIONSHIPNAME"] . '</td><td>'
                . $row["CHAMPIONSHIPSEASON"] . '</td><td>'
                . $row["RECORDID"] . '</td><td>'
                . $row["TEAMNAME"] . '</td><td>'
                . $row["WINNER"] . '</td></tr>
            ';
        }
        echo '</table>';
        // echo "        <script>
        // $('input[type=radio]').click(function(e) {

        //     var selectedRecord = $(this).val();
        //     $('.selectedRecord').html(selectedRecord);

        // });
        // </script>";
        echo '</form>';
    }
    disconnectFromDB();
}
?>

</body>

</html>