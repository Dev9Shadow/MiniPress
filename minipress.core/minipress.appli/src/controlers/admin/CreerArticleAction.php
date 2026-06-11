<?php
declare(strict_types=1);

namespace minipress\appli\controlers\admin;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use minipress\appli\services\ArticleService;
use minipress\appli\services\ArticleServiceInterface;
use minipress\appli\services\exceptions\InternalErrorException;

final class CreerArticleAction
{
    private ArticleServiceInterface $service;

    public function __construct()
    {
        $this->service = new ArticleService();
    }

    public function __invoke(Request $rq, Response $rs, array $args): Response
    {
        $data        = (array) $rq->getParsedBody();
        $titre       = strip_tags(trim((string) ($data['titre'] ?? '')));
        $contenu     = (string) ($data['contenu'] ?? '');
        $resume      = (string) ($data['resume'] ?? '') ?: null;
        $categorieId = (int) ($data['categorie_id'] ?? 0);
        $image       = trim((string) ($data['image'] ?? '')) ?: null;

        if ($titre === '' || $contenu === '' || $categorieId <= 0) {
            return $rs->withHeader('Location', '/admin/articles/new')->withStatus(302);
        }
        if ($image !== null && filter_var($image, FILTER_VALIDATE_URL) === false) {
            return $rs->withHeader('Location', '/admin/articles/new')->withStatus(302);
        }
        try {
            $this->service->creerArticle([
                'titre'        => $titre,
                'resume'       => $resume,
                'contenu'      => $contenu,
                'image'        => $image,
                'categorie_id' => $categorieId,
            ], (int) $_SESSION['utilisateur_id']);
        } catch (InternalErrorException) {
            return $rs->withHeader('Location', '/admin/articles/new')->withStatus(302);
        }
        return $rs->withHeader('Location', '/admin/articles')->withStatus(302);
    }
}
