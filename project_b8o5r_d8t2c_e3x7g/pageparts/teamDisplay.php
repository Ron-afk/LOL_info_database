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
    global $team;
    echo $team;
    ?>
</div>
<div>
<?php
global $db_conn;

if(connectToDB()){
    echo 'LOYAL BOARD: </br>';
    $result = executePlainSQL("select playerID, COUNT(CONTRACTSEASON) from PlayerContract1 where TEAMNAME ='".$team.
    "' group by playerID having COUNT(CONTRACTSEASON)>0");
    while($row = oci_fetch_array($result,OCI_BOTH)){
        echo 'Player: '.$row[0].' has been played for this team for '.$row[1].' contract period</br>';
    }
    

    $result = executePlainSQL("select COACHNAME from CoachContract1 where TEAMNAME ='".$team.
    "' group by COACHNAME having COUNT(COACHINGSEASON)>0");
    while($row = oci_fetch_array($result,OCI_BOTH)){
        echo 'Coach: '.$row[0].' has coached team over 1 contract period</br>';
    }

    $result = executePlainSQL("select playerID from PlayerContract1 where TEAMNAME ='".$team.
    "' group by playerID having COUNT(CONTRACTSEASON)>0");
    while($row = oci_fetch_array($result,OCI_BOTH)){
        echo 'Player: '.$row[0].' has been played for this team over 1 contract period</br>';
    }

    echo '<br>Coach Team: ';

    $result = executePlainSQL("select CoachContract1.coachName, CoachContract1.coachRole, 
    CoachContract2.coachSalary, CoachContract1.coachingSeason 
    from CoachContract1 
    inner join CoachContract2 on CoachContract1.coachRole = CoachContract2.coachRole
    where CoachContract1.teamName ='".$team."'");
    while($row = oci_fetch_array($result,OCI_BOTH)){
        echo '<br>'.$row[1].': '.$row[0];
        echo '<br> Season: '.$row[3].' Salary: '.$row[2];
    }
    echo '<br>';
    echo 'This has has been participate in season: ';
    $result= executePlainSQL("select distinct championshipSeason from Championship where not exists 
                                (select distinct championshipSeason from Record
                                where not exists (select championshipSeason from Record where
                                    Record.winner = '".$team."' or Record.teamName = '".$team."'))");
    while($row=oci_fetch_array($result,OCI_BOTH)){
        echo $row[0].' ';
    }


    echo '<br><br> Team by season:';
    echo '<br>';
    $result = executePlainSQL("select CONTRACTSEASON from PlayerContract1 where TEAMNAME ='" .$team."' 
    group by CONTRACTSEASON" );
    while($row = oci_fetch_array($result, OCI_BOTH)){
        echo 'Seasson: '.$row[0];
        $inrowResult=executePlainSQL("select playerID, lane, tier from PlayerContract1 
        where teamName='".$team."' and contractSeason ='" .$row[0]."'");
        while($player = oci_fetch_array($inrowResult,OCI_BOTH)){
            echo '<br>'.$player[1].': '.$player[0];
            echo '<br> tier: '.$player[2];
        }
    }

}

?>




</div>