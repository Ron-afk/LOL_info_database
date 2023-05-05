<div class="inserTeam" style="text-align: center;
        color: #6A4C9C;
        font-family: 'Press Start 2P';font-size: 20px;">
    Insert Champion
</div>
<br>
<form method="POST" action="index.php">
    Champion Name: <input type="text" name="championName" placeholder="input champion name"/><br /><br />
    Main Lane: <input type="text" name="mainLane" placeholder="input champion's main lane"/><br /><br />
    <input type="submit" value="insertChampion" name="insertChampion"></p>
</form>

<?php
if (isset($_POST['insertChampion'])) {
    $championName = $_POST['championName'];
    $mainlane = $_POST['mainLane'];
    addToDB("Champion",$championName, $mainlane,null,null,null);
}
?>