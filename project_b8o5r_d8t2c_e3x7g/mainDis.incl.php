<?php
global $champion;
global $team;
global $player;
global $coach;

if (
    isset($_POST['teamTag'])
    || isset($_POST['insertTeam'])
) {
    displayFromDB("Team", "ALL", null);
} elseif (isset($_POST['teamFilter'])) {
    $value = $_POST['teamFilter'];
    if ($value == "ALL") {
        displayFromDB("Team", "ALL", null);
    } else {
        displayFromDB("Team", "REGION", $value);
    }
} elseif (
    isset($_POST['championTag'])
    || isset($_POST['insertChampion'])
    || isset($_GET['champion2delete'])
) {
    displayFromDB("Champion", "ALL", null);
} elseif (isset($_POST['championFilter'])) {
    $value = $_POST['championFilter'];
    if ($value == "ALL") {
        displayFromDB("Champion", "ALL", null);
    } else {
        displayFromDB("Champion", "MAINLANE", $value);
    }
} elseif (isset($_POST['playerTag']) || isset($_POST['insertPlayer'])) {
    displayFromDB("Player", "ALL", null);
} elseif (isset($_POST['coachTag']) || isset($_POST['insertCoach'])) {
    displayFromDB("Coach", "ALL", null);
} elseif (isset($_POST['championButton'])) {
    $champion = $_POST['championButton'];
    include('pageparts/championDisplay.php');
} elseif (isset($_POST['playerButton'])) {
    $player = $_POST['playerButton'];
    include('pageparts/playerDisplay.php');
} elseif (isset($_POST['coachButton'])) {
    $coach = $_POST['coachButton'];
    include('pageparts/coachDisplay.php');
} elseif (isset($_POST['teamButton'])) {
    $team = $_POST['teamButton'];
    include('pageparts/teamDisplay.php');
} elseif (isset($_POST["deleteChampion"])) {
    displayFromDB("Champion", "ALL", null);
} elseif (
    isset($_POST["championshipTag"])
    || isset($_POST['insertChampionship'])
) {
    displayFromDB("Championship", "ALL", null);
} elseif (isset($_POST['championshipFilter'])) {
    $value = $_POST["championshipFilter"];
    if ($value == "ALL") {
        displayFromDB("Championship", "ALL", null);
    } else {
        echo $value;
        displayFromDB("Championship", "CHAMPIONSHIPSEASON", $value);
    }
} elseif (isset($_POST['updateRecord']) || isset($_POST['insertRecord'])) {
    displayFromDB("Championship", "ALL", null);
} elseif (isset($_POST["championshipTag"])) {
    displayFromDB("Championship", "CHAMPIONSHIPSEASON", null);
} elseif (isset($_POST['championshipButton'])) {
    $championshipName = $_POST['championshipButton'];
    echo $championshipName;
    dispRecords($championshipName);
} else {
    displayFromDB("Team", "ALL", null);
}
