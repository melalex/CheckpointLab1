<?php
/**
 * Created by PhpStorm.
 * User: Александр Сергеевич
 * Date: 06.08.2016
 * Time: 16:15
 */

if (!file_exists(__DIR__ . '.htrouter.php/' . $_SERVER['REQUEST_URI'])) {
    $_GET['_url'] = $_SERVER['REQUEST_URI'];
}
return false;