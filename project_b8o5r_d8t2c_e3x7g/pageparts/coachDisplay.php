<div style="font-size: 25px;
width: auto;
padding: 10px;
text-align: center;
font-family: 'Press Start 2P';
color: #5c2223;
border-style: groove;
border-radius: 10px;
border: 5px;
background-color: #fcc307">
    <?php
    global $coach;
    echo $coach;
    ?>
</div>
<div>
<?php
global $db_conn;

if(connectToDB()){

    echo '<br> Team history:</br>';

    $result=executePlainSQL("select coachingSeason, teamName, coachRole from CoachContract1 
                                where coachName ='".$coach."'");
    while($row=oci_fetch_array($result,OCI_BOTH)){
        echo 'At '.$row[0].', '.$coach.' coached '.$row[1].' as '.$row[2].'<br>';
    }

    echo '<br>Ban Hhistory: </br>';
    $result =executePlainSQL("select recordID, championshipSeason, championshipName, championName
                                from Ban where coachName = '".$coach."'");
    while($row=oci_fetch_array($result,OCI_BOTH)){
        echo 'At '.$row[1].' '.$row[2].', '.$coach.' bans '.$row[3].'</br>';
    
    }
}

?>








</div>