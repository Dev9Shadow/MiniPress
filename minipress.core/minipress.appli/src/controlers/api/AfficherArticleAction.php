<?php
declare(strict_types=1);

namespace minipress\appli\controlers\api;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use minipress\appli\services\ArticleService;
use minipress\appli\services\ArticleServiceInterface;
use minipress\appli\services\exceptions\EntityNotFoundException;
use Slim\Exception\HttpNotFoundException;

final class AfficherArticleAction
{
    private ArticleServiceInterface $service;

    public function __construct()
    {
        $this->service = new ArticleService();
    }

    public function __invoke(Request $rq, Response $rs, array $args): Response
    {
        try {
            $article = $this->service->afficherArticle((int) $args['id_a']);
        } catch (EntityNotFoundException $e) {
            throw new HttpNotFoundException($rq, $e->getMessage());
        }
        $rs->getBody()->write(json_encode($article));
        return $rs->withHeader('Content-Type', 'application/json');
    }
}