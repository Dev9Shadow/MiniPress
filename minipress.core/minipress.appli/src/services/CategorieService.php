<?php
declare(strict_types=1);

namespace minipress\appli\services;

class CategorieService implements CategorieServiceInterface
{
    public function listerCategories(): array
    {
        return [];
    }

    public function creerCategorie(array $data): int
    {
        return 0;
    }
}