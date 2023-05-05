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
    // global $champion;
    echo $champion;
    global $db_conn;
    $mainLane;
    if (connectToDB()) {
        $mainLane = executePlainSQL("SELECT MAINLANE FROM Champion WHERE CHAMPIONNAME = '" . $champion . "'");
        if (($mainLane = oci_fetch_row($mainLane)) != false) {
            echo ' <br>' . $mainLane[0] . '';
        }
    }
    disconnectFromDB();
    ?>
</div>

<div>
    <!-- <div style ="text-align: center; font-size: 20px;">SKILLS</div> -->
    <?php
    global $db_conn;
    $skills;
    // echo "<br>".$champion;
    if (connectToDB()) {
        $skills = executePlainSQL("SELECT * FROM ChampionSkill WHERE CHAMPIONNAME = '" . $champion . "'");
        while ($skill = oci_fetch_array($skills, OCI_BOTH)) {
            echo '<div> <div style="font-size:25px;"> ' . $skill["SKILLNAME"] . '</div>';
            skillInfoDisplay($skill["SKILLNAME"]);
        }
    }
    
    disconnectFromDB();

    function skillInfoDisplay($skillName)
    {
        echo '<br> skill';
        $sup = executePlainSQL("SELECT * FROM SupportSkill WHERE SKILLNAME ='" . $skillName . "'");
        while ($row = oci_fetch_array($sup, OCI_BOTH)) {
            echo "<br>Heal Amount: " . $row["HEAL"];
            echo "<br>Shield Amount: " . $row["SHIELD"];
        }
        $ctl = executePlainSQL("SELECT * FROM ControlSkill WHERE SKILLNAME ='" . $skillName . "'");
        while ($row = oci_fetch_array($ctl, OCI_BOTH)) {
            echo "<br>Control Effect: " . $row["CONTROLEFFECT"];
            echo "<br>Control Time: " . $row["CONTROLTIME"];
        }
        $dmg = executePlainSQL("SELECT * FROM DamageSkill WHERE SKILLNAME ='" . $skillName . "'");
        while ($row = oci_fetch_array($dmg, OCI_BOTH)) {
            echo "<br>Damage Amout: " . $row["DAMAGEAMOUT"];
        }
        echo '</div>';
    }
    ?>
</div>
<div>

    <form method="GET" action="index.php">
        <input type="submit" name="delete" value="Delete this champion">
        <input type="hidden" name="champion2delete" id="champion2delete" value= <?php echo $champion; ?>>
    </form>

</div>

