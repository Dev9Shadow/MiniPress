<?php
declare(strict_types=1);

require_once __DIR__ . '/../src/vendor/autoload.php';

use Slim\Factory\AppFactory;
use minipress\appli\utils\Eloquent;
use minipress\appli\controlers\api\ListerCategoriesAction;
use minipress\appli\controlers\api\ListerArticlesAction;
use minipress\appli\controlers\api\ListerArticlesCategorieAction;
use minipress\appli\controlers\api\AfficherArticleAction;

Eloquent::init(__DIR__ . '/../src/conf/minipress.db.conf.ini');

$app = AppFactory::create();
$app->addRoutingMiddleware();
$app->addErrorMiddleware(true, true, true);

$app->get('/api/categories', ListerCategoriesAction::class);
$app->get('/api/articles', ListerArticlesAction::class);
$app->get('/api/categories/{id_categ}/articles', ListerArticlesCategorieAction::class);
$app->get('/api/articles/{id_a}', AfficherArticleAction::class);

$app->run();