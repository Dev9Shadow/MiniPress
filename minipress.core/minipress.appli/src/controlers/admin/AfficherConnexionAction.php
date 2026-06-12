<?php
declare(strict_types=1);

namespace minipress\appli\controlers\admin;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use Slim\Views\Twig;

final class AfficherConnexionAction
{
    public function __invoke(Request $rq, Response $rs, array $args): Response
    {
        if (!empty($_SESSION['utilisateur_id'])) {
            return $rs->withHeader('Location', '/admin/articles')->withStatus(302);
        }
        $_SESSION['csrf_token'] = $_SESSION['csrf_token'] ?? bin2hex(random_bytes(32));
        return Twig::fromRequest($rq)->render($rs, 'auth/login.twig', [
            'csrf_token' => $_SESSION['csrf_token'],
        ]);
    }
}
