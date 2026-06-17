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
            'auteur'    => $query->join('utilisateur', 'article.auteur_id', '=', 'utilisateur.id')
                                 ->orderBy('utilisateur.email', 'asc')
                                 ->select('article.*'),
            default     => $query->orderBy('date_creation', 'desc'),
        };
    }

    public function listerArticlesPublies(?string $tri = null): array
    {
        $q = Article::with('auteur')->where('publie', true);
        return $this->appliquerTri($q, $tri)->get()->map(fn($a) => [
            'id'            => $a->id,
            'titre'         => $a->titre,
            'resume'        => $a->resume,
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
            'resume'        => $a->resume,
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
            'resume'        => $a->resume,
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
        return Article::with('auteur')->get()->map(fn($a) => [
            'id'            => $a->id,
            'titre'         => $a->titre,
            'resume'        => $a->resume,
            'date_creation' => $a->date_creation?->toDateTimeString(),
            'auteur'        => ['id' => $a->auteur->id, 'email' => $a->auteur->email],
            'publie'        => $a->publie,
        ])->all();
    }

    public function creerArticle(array $data, int $auteurId): int
    {
        try {
            $article = Article::create([
                'titre'        => $data['titre'],
                'resume'       => $data['resume'] ?? null,
                'contenu'      => $data['contenu'],
                'image'        => $data['image'] ?? null,
                'categorie_id' => $data['categorie_id'],
                'auteur_id'    => $auteurId,
                'publie'       => false,
                'date_creation'=> date('Y-m-d H:i:s'),
            ]);
            return $article->id;
        } catch (\Exception $e) {
            throw new InternalErrorException('Erreur creation article', 0, $e);
        }
    }

    public function basculerPublication(int $id): void
    {
        try {
            $article = Article::findOrFail($id);
            $article->publie = !$article->publie;
            $article->save();
        } catch (ModelNotFoundException) {
            throw new EntityNotFoundException("Article $id introuvable");
        } catch (\Exception $e) {
            throw new InternalErrorException('Erreur bascule publication', 0, $e);
        }
    }
}