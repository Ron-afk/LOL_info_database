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
    global $player;
    echo $player;
    ?>
</div>
<div>
<?php
global $db_conn;

if(connectToDB()){
    echo 'Player is good at: </br>';
    $result = executePlainSQL("select championName from IsGoodAt where playerID='".$player."'");
    while($row = oci_fetch_array($result,OCI_BOTH)){
        echo $row[0].'</br>';
    }

    echo 'Highlighted Time: <br>';
    $result = executePlainSQL("select championshipSeason, avg(kda) from Pick where playerID ='".$player."'
                                group by championshipSeason 
                                having avg(kda) >= (select avg(kda) from Pick
                                                    where playerID ='".$player."')");
    while($row = oci_fetch_array($result,OCI_BOTH)){
        echo 'At season '.$row[0].', '.$player.' plays great with an average kda: '.$row[1].'</br>';
    }

    echo '<br> Team history:</br>';

    $result=executePlainSQL("select contractSeason, teamName, lane from PlayerContract1 
                                where playerID ='".$player."'");
    while($row=oci_fetch_array($result,OCI_BOTH)){
        echo 'At '.$row[0].', '.$player.' played for '.$row[1].' as '.$row[2].'<br>';
    }

    echo '<br>Pick Hhistory: </br>';
    $result =executePlainSQL("select recordID, championshipSeason, championshipName, championName
                                from Pick where playerID = '".$player."'");
    while($row=oci_fetch_array($result,OCI_BOTH)){
        echo 'At '.$row[1].' '.$row[2].', '.$player.' plays '.$row[3].'</br>';
    
    }

    


}

?>




</div>