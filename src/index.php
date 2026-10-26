<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Entorno PHP</title>
</head>
<body>
    <p>Entorno PHP</p>
    <?php
        echo date('Y-m-d H:i:s');
        echo "<br>";
        echo date_default_timezone_get();
        echo "<br>";
        //var_dump(gd_info());
        echo "<a href='http://localhost:5001/' target='_blank' rel='noopener noreferrer'>MailDev</a>";
        echo "<a href='http://localhost:8081/' target='_blank' rel='noopener noreferrer'>PHPMyAdmin</a>";
        echo "<a href='http://localhost:8080/sgt/public' target='_blank' rel='noopener noreferrer'>SGT</a>";
        echo "<a href='http://localhost:8080/sgt/public/api/doc/' target='_blank' rel='noopener noreferrer'>SGT API</a>";
        echo "<a href='http://localhost:8080/backend/public/api/doc/' target='_blank' rel='noopener noreferrer'>API Backend</a>";
        echo "<br>";
        phpinfo();
    ?>
</body>
</html>