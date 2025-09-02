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
        var_dump(gd_info());
        echo "<br>";
        phpinfo();
    ?>
</body>
</html>