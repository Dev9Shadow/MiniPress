<?php
declare(strict_types=1);

namespace minipress\appli\services;

interface CategorieServiceInterface
{
    public function listerCategories(): array;
    public function creerCategorie(array $data): int;
}
