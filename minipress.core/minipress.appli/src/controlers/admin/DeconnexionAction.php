<?php
declare(strict_types=1);

namespace minipress\appli\controlers\admin;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;

final class DeconnexionAction
{
    public function __invoke(Request $rq, Response $rs, array $args): Response
    {
        $_SESSION = [];
        session_destroy();
        return $rs->withHeader('Location', '/login')->withStatus(302);
    }
}
