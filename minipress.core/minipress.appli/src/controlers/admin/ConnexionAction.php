<?php
declare(strict_types=1);

namespace minipress\appli\controlers\admin;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use Slim\Views\Twig;
use minipress\appli\services\AuthService;
use minipress\appli\services\AuthServiceInterface;
use minipress\appli\services\exceptions\AuthenticationException;

final class ConnexionAction
{
    private AuthServiceInterface $auth;

    public function __construct()
    {
        $this->auth = new AuthService();
    }

    public function __invoke(Request $rq, Response $rs, array $args): Response
    {
        $data     = (array) $rq->getParsedBody();
        $email    = trim((string) ($data['email'] ?? ''));
        $password = (string) ($data['password'] ?? '');
        try {
            $utilisateur = $this->auth->authentifier($email, $password);
        } catch (AuthenticationException) {
            $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
            return Twig::fromRequest($rq)->render($rs, 'auth/login.twig', [
                'erreur'     => 'Identifiants invalides',
                'csrf_token' => $_SESSION['csrf_token'],
            ]);
        }
        session_regenerate_id(true);
        $_SESSION['utilisateur_id'] = $utilisateur['id'];
        $_SESSION['csrf_token']     = bin2hex(random_bytes(32));
        return $rs->withHeader('Location', '/admin/articles')->withStatus(302);
    }
}
