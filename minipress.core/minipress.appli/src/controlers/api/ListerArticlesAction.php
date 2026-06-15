<?php
declare(strict_types=1);

namespace minipress\appli\controlers\api;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use minipress\appli\services\ArticleService;
use minipress\appli\services\ArticleServiceInterface;

final class ListerArticlesAction
{
    private ArticleServiceInterface $service;

    public function __construct()
    {
        $this->service = new ArticleService();
    }

    public function __invoke(Request $rq, Response $rs, array $args): Response
    {
        $tri = $rq->getQueryParams()['sort'] ?? null;
        $articles = $this->service->listerArticlesPublies($tri);
        $rs->getBody()->write(json_encode($articles));
        return $rs->withHeader('Content-Type', 'application/json');
    }
}