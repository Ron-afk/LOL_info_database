<div style="height: 30 px;" class="miniBar">
    <div class="filter">
        <form method="POST" action="index.php">
            <label> FILTER </label>
            <input class="teamFilter" type="submit" name="teamFilter" value="ALL" />
            <?php
            if (connectToDB()) {
                global $db_conn;
                $result = executePlainSQL("SELECT DISTINCT REGION FROM Team");
            }
            while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
                echo '<input class="teamFilter" type="submit" name="teamFilter" 
                        value=' . $row["REGION"] . ' /> ';
            }
            disconnectFromDB();
            ?>

        </form>
    </div>
</div>

