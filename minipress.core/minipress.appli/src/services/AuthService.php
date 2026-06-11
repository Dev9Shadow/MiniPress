<?php
declare(strict_types=1);

namespace minipress\appli\services;

use minipress\appli\models\Utilisateur;
use minipress\appli\services\exceptions\AuthenticationException;

class AuthService implements AuthServiceInterface
{
    public function authentifier(string $email, string $password): array
    {
        $utilisateur = Utilisateur::where('email', $email)->first();
        if ($utilisateur === null || !password_verify($password, $utilisateur->password)) {
            throw new AuthenticationException('Identifiants invalides');
        }
        return [
            'id'    => $utilisateur->id,
            'email' => $utilisateur->email,
            'role'  => $utilisateur->role,
        ];
    }
}
