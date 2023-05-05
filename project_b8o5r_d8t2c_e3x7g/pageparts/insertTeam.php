<div class="inserTeam" style="text-align: center;
        color: #6A4C9C;
        font-family: 'Press Start 2P';font-size: 20px;">
    Insert Team
</div>
<br>
<form method="POST" ,action="index.php">
    Team Name: <input type="text" name="teamName" placeholder="input team name Ex. G2"><br /><br />
    Team Region: <input type="text" name="region" placeholder="input team region Ex. LCS"><br /><br />
    <input type="submit" value="insertTeam" name="insertTeam"></p>
</form>

<?php
if (isset($_POST['insertTeam'])) {
    // addTeam($_POST['teamName'], $_POST['region']);
    addToDB("Team",$_POST['teamName'], $_POST['region'],null,null,null);
}
?>