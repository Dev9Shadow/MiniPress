<?php
declare(strict_types=1);

namespace minipress\appli\controlers\admin;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use minipress\appli\services\CategorieService;
use minipress\appli\services\CategorieServiceInterface;
use minipress\appli\services\exceptions\InternalErrorException;

final class CreerCategorieAction
{
    private CategorieServiceInterface $service;

    public function __construct()
    {
        $this->service = new CategorieService();
    }

    public function __invoke(Request $rq, Response $rs, array $args): Response
    {
        $data    = (array) $rq->getParsedBody();
        $libelle = strip_tags(trim((string) ($data['libelle'] ?? '')));
        if ($libelle === '') {
            return $rs->withHeader('Location', '/admin/categories/new')->withStatus(302);
        }
        try {
            $this->service->creerCategorie(['libelle' => $libelle]);
        } catch (InternalErrorException) {
            return $rs->withHeader('Location', '/admin/categories/new')->withStatus(302);
        }
        return $rs->withHeader('Location', '/admin/articles')->withStatus(302);
    }
}
