<?php
declare(strict_types=1);

namespace minipress\appli\controlers\api;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use minipress\appli\services\CategorieService;
use minipress\appli\services\CategorieServiceInterface;

final class ListerCategoriesAction
{
    private CategorieServiceInterface $service;

    public function __construct()
    {
        $this->service = new CategorieService();
    }

    public function __invoke(Request $rq, Response $rs, array $args): Response
    {
        $categories = $this->service->listerCategories();
        $rs->getBody()->write(json_encode($categories));
        return $rs->withHeader('Content-Type', 'application/json');
    }
}