<?php
declare(strict_types=1);

namespace minipress\appli\services;

interface AuthServiceInterface
{
    public function authentifier(string $email, string $password): array;
}
