<?php
declare(strict_types=1);

namespace minipress\appli\services;

use minipress\appli\models\Article;
use minipress\appli\services\exceptions\EntityNotFoundException;
use minipress\appli\services\exceptions\InternalErrorException;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Database\QueryException;

class ArticleService implements ArticleServiceInterface
{
    public function listerArticlesPublies(?string $tri = null): array
    {
        return Article::with('auteur')->where('publie', true)->get()->map(fn($a) => [
            'id'            => $a->id,
            'titre'         => $a->titre,
            'date_creation' => $a->date_creation?->toDateTimeString(),
            'auteur'        => ['id' => $a->auteur->id, 'email' => $a->auteur->email],
        ])->all();
    }

    public function listerArticlesParCategorie(int $categorieId, ?string $tri = null): array
    {
        return [];
    }

    public function listerArticlesParAuteur(int $auteurId, ?string $tri = null): array
    {
        return [];
    }

    public function afficherArticle(int $id): array
    {
        return [];
    }

    public function listerTousArticles(): array
    {
        return [];
    }

    public function creerArticle(array $data, int $auteurId): int
    {
        return 0;
    }

    public function basculerPublication(int $id): void {}
}