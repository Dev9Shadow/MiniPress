<?php
declare(strict_types=1);

namespace minipress\appli\services;

interface UtilisateurServiceInterface
{
    public function creerUtilisateur(array $data): int;
}
