<?php
declare(strict_types=1);

namespace minipress\appli\controlers\admin;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use Slim\Views\Twig;
use minipress\appli\controlers\AbstractAction;
use minipress\appli\services\CategorieService;
use minipress\appli\services\CategorieServiceInterface;

final class AfficherCreerArticleAction
{
    private CategorieServiceInterface $categories;

    public function __construct()
    {
        $this->categories = new CategorieService();
    }

    public function __invoke(Request $rq, Response $rs, array $args): Response
    {
        $_SESSION['csrf_token'] = $_SESSION['csrf_token'] ?? bin2hex(random_bytes(32));
        $categories = $this->categories->listerCategories();
        return Twig::fromRequest($rq)->render($rs, 'article/create.twig', [
            'categories' => $categories,
            'csrf_token' => $_SESSION['csrf_token'],
        ]);
    }
}
