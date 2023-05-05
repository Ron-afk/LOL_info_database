
<div style="height: 30 px;" class="miniBar">
    <div class="filter">
        <form method="POST" action="index.php">
            <label> FILTER </label>
            <input class="teamFilter" type="submit" name="championshipFilter" value="ALL" />
            <?php
            if (connectToDB()) {
                global $db_conn;
                $result = executePlainSQL("SELECT DISTINCT CHAMPIONSHIPSEASON FROM Championship");
            }
            while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
                echo '<input class="teamFilter" type="submit" name="championshipFilter" 
                        value=' . $row["CHAMPIONSHIPSEASON"] . ' /> ';
            }
            disconnectFromDB();
            ?>

        </form>
    </div>
</div>
