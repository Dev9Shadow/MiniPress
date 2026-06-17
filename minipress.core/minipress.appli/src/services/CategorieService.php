<?php
declare(strict_types=1);

namespace minipress\appli\services;

use minipress\appli\models\Categorie;
use minipress\appli\services\exceptions\InternalErrorException;
use Illuminate\Database\QueryException;

class CategorieService implements CategorieServiceInterface
{
    public function listerCategories(): array
    {
        return Categorie::orderBy('libelle')->get()->map(fn($c) => [
            'id'      => $c->id,
            'libelle' => $c->libelle,
            'href'    => '/api/categories/' . $c->id,
        ])->all();
    }

    public function creerCategorie(array $data): int
    {
        try {
            $categorie = Categorie::create(['libelle' => $data['libelle']]);
            return $categorie->id;
        } catch (QueryException $e) {
            throw new InternalErrorException('Erreur creation categorie', 0, $e);
        }
    }
}