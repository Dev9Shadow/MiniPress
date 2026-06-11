<?php
declare(strict_types=1);

namespace minipress\appli\services;

use minipress\appli\services\exceptions\AuthenticationException;

class AuthService implements AuthServiceInterface
{
    public function authentifier(string $email, string $password): array
    {
        throw new AuthenticationException('Non implemente');
    }
}
