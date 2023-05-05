<div class="inserTeam" style="text-align: center;
        color: #6A4C9C;
        font-family: 'Press Start 2P';font-size: 20px;">
    Insert Coach
</div>
<br>
<form method="POST" ,action="index.php">
    Coach Name: <input type="text" name="coachName" placeholder="input coach name"><br /><br />
    <input type="submit" value="insertCoach" name="insertCoach"></p>
</form>

<?php
if (isset($_POST['insertCoach'])) {
    $coachName = $_POST['coachName'];
    addToDB("Coach",$coachName,null,null,null,null);
}
?>