<div class="insertTab" style="text-align: center;
        color: #6A4C9C;
        font-family: 'Press Start 2P';font-size: 20px;">
    Insert Player
</div>
<br>
<form method="POST" ,action="index.php">
    Player ID: <input type="text" name="playerName" placeholder="input player id here"><br /><br />
    <input type="submit" value="insertPlayer" name="insertPlayer"></p>
</form>

<?php
if (isset($_POST['insertPlayer'])) {
    // addPlayer($_POST['playerName']);
    addToDB("Player",$_POST['playerName'],null,null,null,null);
}
?>