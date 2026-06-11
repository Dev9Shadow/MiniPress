<?php
declare(strict_types=1);

namespace minipress\appli\controlers\admin;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use minipress\appli\services\ArticleService;
use minipress\appli\services\ArticleServiceInterface;
use minipress\appli\services\exceptions\EntityNotFoundException;
use minipress\appli\services\exceptions\InternalErrorException;

final class PublierArticleAction
{
    private ArticleServiceInterface $service;

    public function __construct()
    {
        $this->service = new ArticleService();
    }

    public function __invoke(Request $rq, Response $rs, array $args): Response
    {
        try {
            $this->service->basculerPublication((int) $args['id']);
        } catch (EntityNotFoundException | InternalErrorException) {
            // silencieux, on redirige dans tous les cas
        }
        return $rs->withHeader('Location', '/admin/articles')->withStatus(302);
    }
}
