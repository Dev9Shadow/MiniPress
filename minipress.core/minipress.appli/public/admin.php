<?php
declare(strict_types=1);

session_start();

require_once __DIR__ . '/../src/vendor/autoload.php';

use Slim\Factory\AppFactory;
use Slim\Views\Twig;
use Slim\Views\TwigMiddleware;
use Slim\Routing\RouteCollectorProxy as Group;
use minipress\appli\utils\Eloquent;
use minipress\appli\middlewares\AuthMiddleware;
use minipress\appli\middlewares\CsrfMiddleware;
use minipress\appli\controlers\admin\AfficherConnexionAction;
use minipress\appli\controlers\admin\ConnexionAction;
use minipress\appli\controlers\admin\DeconnexionAction;
use minipress\appli\controlers\admin\ListerArticlesAdminAction;
use minipress\appli\controlers\admin\AfficherCreerArticleAction;
use minipress\appli\controlers\admin\CreerArticleAction;
use minipress\appli\controlers\admin\PublierArticleAction;
use minipress\appli\controlers\admin\AfficherCreerCategorieAction;
use minipress\appli\controlers\admin\CreerCategorieAction;
use minipress\appli\controlers\admin\AfficherCreerUtilisateurAction;
use minipress\appli\controlers\admin\CreerUtilisateurAction;

Eloquent::init(__DIR__ . '/../src/conf/minipress.db.conf.ini');

$app = AppFactory::create();

// Twig (vues admin)
$twig = Twig::create(__DIR__ . '/../src/views', ['cache' => false]);
$app->add(TwigMiddleware::create($app, $twig));

$app->addRoutingMiddleware();
$app->addBodyParsingMiddleware();
$app->addErrorMiddleware(true, true, true);

// Authentification
$app->get('/login', AfficherConnexionAction::class);
$app->post('/login', ConnexionAction::class)->add(CsrfMiddleware::class);
$app->post('/logout', DeconnexionAction::class)->add(AuthMiddleware::class);

// Espace admin protege
$app->group('/admin', function (Group $g): void {
    $g->get('/articles', ListerArticlesAdminAction::class);
    $g->get('/articles/new', AfficherCreerArticleAction::class);
    $g->post('/articles/new', CreerArticleAction::class)->add(CsrfMiddleware::class);
    $g->post('/articles/{id}/publish', PublierArticleAction::class)->add(CsrfMiddleware::class);
    $g->get('/categories/new', AfficherCreerCategorieAction::class);
    $g->post('/categories/new', CreerCategorieAction::class)->add(CsrfMiddleware::class);
    $g->get('/users/new', AfficherCreerUtilisateurAction::class);
    $g->post('/users/new', CreerUtilisateurAction::class)->add(CsrfMiddleware::class);
})->add(AuthMiddleware::class);

$app->run();
