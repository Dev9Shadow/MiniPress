<?php
declare(strict_types=1);

namespace minipress\appli\controlers\admin;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use minipress\appli\services\UtilisateurService;
use minipress\appli\services\UtilisateurServiceInterface;
use minipress\appli\services\exceptions\InternalErrorException;

final class CreerUtilisateurAction
{
    private UtilisateurServiceInterface $service;

    public function __construct()
    {
        $this->service = new UtilisateurService();
    }

    public function __invoke(Request $rq, Response $rs, array $args): Response
    {
        $data = (array) $rq->getParsedBody();
        $email    = filter_var(trim((string) ($data['email'] ?? '')), FILTER_VALIDATE_EMAIL);
        $password = (string) ($data['password'] ?? '');
        if ($email === false || $password === '') {
            return $rs->withHeader('Location', '/admin/users/new')->withStatus(302);
        }
        try {
            $this->service->creerUtilisateur(['email' => $email, 'password' => $password]);
        } catch (InternalErrorException) {
            return $rs->withHeader('Location', '/admin/users/new')->withStatus(302);
        }
        return $rs->withHeader('Location', '/admin/articles')->withStatus(302);
    }
}
