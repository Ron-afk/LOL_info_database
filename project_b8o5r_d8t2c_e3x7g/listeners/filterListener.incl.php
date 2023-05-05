<?php
    if (isset($_POST['teamTag']) || isset($_POST['teamFilter']) || isset($_POST['insertTeam'])) {
        include('pageparts/team.php');
    } elseif (
        isset($_POST['playerTag'])
        || isset($_POST['insertPlayer'])
        || isset($_POST['coachTag'])

    ) {
        echo '<div></div>';
    } elseif (
        isset($_POST['championTag'])
        || isset($_POST['deleteChampion'])
        || isset($_POST['championFilter'])
        || isset($_POST['insertChampion'])
        || isset($_POST['championButton'])
        || isset($_GET['champion2delete'])
    ) {
        include('pageparts/champion.php');
    } elseif (isset($_POST['championshipTag'])
     ||isset($_POST['championshipFilter'])
     ||isset($_POST['insertChampionship'])
     ||isset($_POST['championshipButton'])) {
        include('pageparts/championship.php');
    } else {
        include('pageparts/team.php');
    }
    