<?php
declare(strict_types=1);

namespace minipress\appli\services;

interface ArticleServiceInterface
{
    public function listerArticlesPublies(?string $tri = null): array;
    public function listerArticlesParCategorie(int $categorieId, ?string $tri = null): array;
    public function listerArticlesParAuteur(int $auteurId, ?string $tri = null): array;
    public function afficherArticle(int $id): array;
    public function listerTousArticles(): array;
    public function creerArticle(array $data, int $auteurId): int;
    public function basculerPublication(int $id): void;
}
