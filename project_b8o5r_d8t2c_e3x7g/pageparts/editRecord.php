<div class="inserTeam" style="text-align: center;
        color: #6A4C9C;
        font-family: 'Press Start 2P';font-size: 20px;">
    Edit the Record
</div>
<br>
<form method="POST" action="index.php">
    Championship Season : <select name="championshipRecordSeason">
    <?php

    if(connectToDB()){
    
        $result=executePlainSQL("SELECT CHAMPIONSHIPSEASON FROM Championship group by CHAMPIONSHIPSEASON");
        while($row = oci_fetch_array($result,OCI_BOTH)){
            echo '<option value ="'.$row[0].'">'.$row[0].'</option>';
        }
    }
    disconnectFromDB();
    ?>
    </select></br></br>
    Championship Name : <select name="championshipRecordName">
    <?php
    if(connectToDB()){
    
        $result=executePlainSQL("SELECT CHAMPIONSHIPNAME FROM Championship group by CHAMPIONSHIPNAME");
        while($row = oci_fetch_array($result,OCI_BOTH)){
            echo '<option value ="'.$row[0].'">'.$row[0].'</option>';
        }
    }
    disconnectFromDB();
    ?>
    </select></br></br>
    Loser Team: <select name="championshipRecordTeam">
    <?php
    if(connectToDB()){
    
        $result=executePlainSQL("SELECT * FROM Team");
        while($row = oci_fetch_array($result,OCI_BOTH)){
            echo '<option value ="'.$row[0].'">'.$row[0].'</option>';
        }
    }
    disconnectFromDB();
    ?>
    </select></br></br>

    Winner: <select name="Winner">
    <?php
    if(connectToDB()){
    
        $result=executePlainSQL("SELECT * FROM Team");
        while($row = oci_fetch_array($result,OCI_BOTH)){
            echo '<option value ="'.$row[0].'">'.$row[0].'</option>';
        }
    }
    disconnectFromDB();
    ?>
    </select></br></br>
    RecordID: <input type="text" name="recordID" placeholder="recordID"/><br /><br />
    <input type="submit" value="insertRecord" name="insertRecord">
    <input type="submit" value="updateRecord" name="updateRecord">
    <!-- <input type="submit" value="deleteRecord" name="deleteRecord"></p> -->
</form>

<?php
global $selectedRecord;
global $db_conn;

if (isset($_POST['insertRecord'])) {
    addToDB("Record",$_POST['recordID'],
    $_POST['championshipRecordSeason'],
    $_POST['championshipRecordName'],
    $_POST['championshipRecordTeam'],
    $_POST['Winner']);

} elseif(isset($_POST['updateRecord'])){
    if(connectToDB()){
        executePlainSQL("UPDATE Record SET 
        TEAMNAME ='" .$_POST['championshipRecordTeam']."', WINNER ='".$_POST['Winner']."' 
        WHERE CHAMPIONSHIPNAME='".$_POST['championshipRecordName']."' 
        AND CHAMPIONSHIPSEASON='".$_POST['championshipRecordSeason']."' 
        AND RECORDID='".$_POST['recordID']."'");
        OCICommit($db_conn);
    }
    disconnectFromDB();

} 
?>