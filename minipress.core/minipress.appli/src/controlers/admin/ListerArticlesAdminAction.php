<?php
declare(strict_types=1);

namespace minipress\appli\controlers\admin;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use Slim\Views\Twig;
use minipress\appli\controlers\AbstractAction;
use minipress\appli\services\ArticleService;
use minipress\appli\services\ArticleServiceInterface;

final class ListerArticlesAdminAction
{
    private ArticleServiceInterface $service;

    public function __construct()
    {
        $this->service = new ArticleService();
    }

    public function __invoke(Request $rq, Response $rs, array $args): Response
    {
        $_SESSION['csrf_token'] = $_SESSION['csrf_token'] ?? bin2hex(random_bytes(32));
        $articles = $this->service->listerTousArticles();
        return Twig::fromRequest($rq)->render($rs, 'article/list.twig', [
            'articles'   => $articles,
            'csrf_token' => $_SESSION['csrf_token'],
        ]);
    }
}
