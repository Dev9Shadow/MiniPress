<?php
declare(strict_types=1);

namespace minipress\appli\middlewares;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Psr\Http\Message\ResponseInterface as Response;
use Slim\Psr7\Response as SlimResponse;

class AuthMiddleware
{
    public function __invoke(Request $rq, RequestHandler $handler): Response
    {
        if (empty($_SESSION['utilisateur_id'])) {
            return (new SlimResponse())->withHeader('Location', '/login')->withStatus(302);
        }
        return $handler->handle($rq);
    }
}
