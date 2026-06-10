<?php
declare(strict_types=1);

require_once __DIR__ . '/../src/vendor/autoload.php';

use Slim\Factory\AppFactory;
use minipress\appli\utils\Eloquent;
use minipress\appli\controlers\api\ListerCategoriesAction;

Eloquent::init(__DIR__ . '/../src/conf/minipress.db.conf.ini');

$app = AppFactory::create();
$app->addRoutingMiddleware();
$app->addErrorMiddleware(true, true, true);

$app->get('/api/categories', ListerCategoriesAction::class);

$app->run();