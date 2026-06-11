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
    private function appliquerTri($query, ?string $tri)
    {
        return match ($tri) {
            'date-asc'  => $query->orderBy('date_creation', 'asc'),
            'date-desc' => $query->orderBy('date_creation', 'desc'),
            default     => $query->orderBy('date_creation', 'desc'),
        };
    }

    public function listerArticlesPublies(?string $tri = null): array
    {
        $q = Article::with('auteur')->where('publie', true);
        return $this->appliquerTri($q, $tri)->get()->map(fn($a) => [
            'id'            => $a->id,
            'titre'         => $a->titre,
            'date_creation' => $a->date_creation?->toDateTimeString(),
            'auteur'        => ['id' => $a->auteur->id, 'email' => $a->auteur->email],
            'href'          => '/api/articles/' . $a->id,
        ])->all();
    }

    public function listerArticlesParCategorie(int $categorieId, ?string $tri = null): array
    {
        $q = Article::with('auteur')
            ->where('publie', true)
            ->where('categorie_id', $categorieId);
        return $this->appliquerTri($q, $tri)->get()->map(fn($a) => [
            'id'            => $a->id,
            'titre'         => $a->titre,
            'date_creation' => $a->date_creation?->toDateTimeString(),
            'auteur'        => ['id' => $a->auteur->id, 'email' => $a->auteur->email],
            'href'          => '/api/articles/' . $a->id,
        ])->all();
    }

    public function listerArticlesParAuteur(int $auteurId, ?string $tri = null): array
    {
        $q = Article::with('auteur')
            ->where('publie', true)
            ->where('auteur_id', $auteurId);
        return $this->appliquerTri($q, $tri)->get()->map(fn($a) => [
            'id'            => $a->id,
            'titre'         => $a->titre,
            'date_creation' => $a->date_creation?->toDateTimeString(),
            'auteur'        => ['id' => $a->auteur->id, 'email' => $a->auteur->email],
            'href'          => '/api/articles/' . $a->id,
        ])->all();
    }

    public function afficherArticle(int $id): array
    {
        try {
            $a = Article::with(['auteur', 'categorie'])
                ->where('publie', true)
                ->findOrFail($id);
        } catch (ModelNotFoundException) {
            throw new EntityNotFoundException("Article $id introuvable ou non publie");
        }
        return [
            'id'            => $a->id,
            'titre'         => $a->titre,
            'resume'        => $a->resume,
            'contenu'       => $a->contenu,
            'image'         => $a->image,
            'date_creation' => $a->date_creation?->toDateTimeString(),
            'auteur'        => ['id' => $a->auteur->id, 'email' => $a->auteur->email],
            'categorie'     => ['id' => $a->categorie->id, 'libelle' => $a->categorie->libelle],
        ];
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