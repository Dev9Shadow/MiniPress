<?php
/**
 * File: Eloquent.php
 * Service de connexion a la base de donnees (ORM Eloquent).
 */

namespace minipress\appli\utils;

use Illuminate\Database\Capsule\Manager as DB;

class Eloquent
{
    public static function init($filename): void
    {
        $db = new DB();
        $db->addConnection(parse_ini_file($filename));
        $db->setAsGlobal();
        $db->bootEloquent();
    }
}
