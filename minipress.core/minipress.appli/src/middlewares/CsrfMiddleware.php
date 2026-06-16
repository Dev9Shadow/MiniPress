<?php
declare(strict_types=1);

namespace minipress\appli\middlewares;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Psr\Http\Message\ResponseInterface as Response;
use Slim\Psr7\Response as SlimResponse;

class CsrfMiddleware
{
    public function __invoke(Request $rq, RequestHandler $handler): Response
    {
        $data     = (array) $rq->getParsedBody();
        $token    = (string) ($data['csrf_token'] ?? '');
        $expected = (string) ($_SESSION['csrf_token'] ?? '');
        if ($expected === '' || !hash_equals($expected, $token)) {
            return (new SlimResponse())->withStatus(403);
        }
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
        return $handler->handle($rq);
    }
}
