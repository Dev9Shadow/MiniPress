<?php
declare(strict_types=1);

namespace minipress\appli\controlers\admin;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use Slim\Views\Twig;
use minipress\appli\controlers\AbstractAction;

final class AfficherCreerUtilisateurAction
{
    public function __invoke(Request $rq, Response $rs, array $args): Response
    {
        $_SESSION['csrf_token'] = $_SESSION['csrf_token'] ?? bin2hex(random_bytes(32));
        return Twig::fromRequest($rq)->render($rs, 'utilisateur/create.twig', [
            'csrf_token' => $_SESSION['csrf_token'],
        ]);
    }
}
