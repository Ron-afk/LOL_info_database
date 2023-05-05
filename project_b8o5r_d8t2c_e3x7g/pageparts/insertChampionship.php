<div class="inserTeam" style="text-align: center;
        color: #6A4C9C;
        font-family: 'Press Start 2P';font-size: 20px;">
    Insert Championship
</div>
<br>
<form method="POST" action="index.php">
    Championship Season: <input type="text" name="championshipSeason" placeholder="Championship season"/><br /><br />
    Championship Name: <input type="text" name="championshipName" placeholder="Championship Name"/><br /><br />
    Winner Team: <input type="text" name="championshipTeam" placeholder="Winner here"/><br /><br />
    Bonus: <input type="text" name="bonus" placeholder="Bonus number"/><br /><br />
    <input type="submit" value="insertChampionship" name="insertChampionship"></p>
</form>

<?php
if (isset($_POST['insertChampionship'])) {
    // $championshipName = $_POST['championName'];
    // $mainlane = $_POST['mainLane'];
    addToDB("Championship",$_POST['championshipSeason'], $_POST['championshipName'], $_POST['championshipTeam'], $_POST['bonus'],null);
}
?>