<?php
        if (
            isset($_POST['teamTag'])
            || isset($_POST['teamFilter'])
            || isset($_POST['insertTeam'])
        ) {
            include('pageparts/insertTeam.php');
        } elseif (
            isset($_POST['playerTag'])
            || isset($_POST['insertPlayer'])
        ) {
            include('pageparts/insertPlayer.php');
        } elseif (
            isset($_POST['championTag'])
            || isset($_GET['champion2delete'])
            || isset($_POST['championFilter'])
            || isset($_POST['insertChampion'])
            || isset($_POST['championButton'])
            
        ) {
            include('pageparts/insertChampion.php');
        } elseif (isset($_POST['championshipTag'])
            || isset($_POST['championshipFilter'])
            || isset($_POST['insertChampionship'])) {
            include('pageparts/insertChampionship.php');
        } elseif (
            isset($_POST['coachTag'])
            || isset($_POST['insertCoach'])
        ) {
            include('pageparts/insertCoach.php');
        } elseif(isset($_POST['insertRecord'])
        || isset($_POST['updateRecord'])
        || isset($_POST['deleteRecord'])
        || isset($_POST['selectedRecord'])
        || isset($_POST['championshipButton'])){
            if(isset($_POST['selectedRecord'])) {
                echo $_POST['selectedRecord'];
            }
            include('pageparts/editRecord.php');
        }else {
            include('pageparts/insertTeam.php');
        }

        if (isset($_GET['champion2delete'])) {
            $delCham = $_GET['champion2delete'];
            deleteFromDB("Champion", $delCham, null, null);
        }