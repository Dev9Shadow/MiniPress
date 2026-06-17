<?php
declare(strict_types=1);

namespace minipress\appli\services;

use minipress\appli\models\Utilisateur;
use minipress\appli\services\exceptions\InternalErrorException;

class UtilisateurService implements UtilisateurServiceInterface
{
    public function creerUtilisateur(array $data): int
    {
        try {
            $utilisateur = Utilisateur::create([
                'email'    => $data['email'],
                'password' => password_hash($data['password'], PASSWORD_BCRYPT),
                'role'     => $data['role'] ?? 'auteur',
            ]);
            return $utilisateur->id;
        } catch (\Exception $e) {
            throw new InternalErrorException('Erreur creation utilisateur', 0, $e);
        }
    }
}
