<?php
declare(strict_types=1);

require_once __DIR__ . '/../vendor/autoload.php';

use minipress\appli\utils\Eloquent;
use minipress\appli\models\Utilisateur;
use minipress\appli\models\Categorie;
use minipress\appli\models\Article;

Eloquent::init(__DIR__ . '/../conf/minipress.db.conf.ini');

$faker = \Faker\Factory::create('fr_FR');

// Nettoyage dans l'ordre FK
Article::query()->delete();
Categorie::query()->delete();
Utilisateur::query()->delete();

// Utilisateurs (2 auteurs + 1 admin)
$admin = Utilisateur::create([
    'email'    => 'admin@minipress.local',
    'password' => password_hash('admin1234', PASSWORD_DEFAULT),
    'role'     => 'admin',
]);

$auteurs = [];
for ($i = 0; $i < 2; $i++) {
    $auteurs[] = Utilisateur::create([
        'email'    => $faker->unique()->safeEmail(),
        'password' => password_hash('motdepasse', PASSWORD_DEFAULT),
        'role'     => 'auteur',
    ]);
}

echo "Utilisateurs créés : " . (count($auteurs) + 1) . "\n";

// Catégories (4)
$libellesCats = ['Technologie', 'Culture', 'Science', 'Société'];
$categories = [];
foreach ($libellesCats as $libelle) {
    $categories[] = Categorie::create(['libelle' => $libelle]);
}

echo "Catégories créées : " . count($categories) . "\n";

// Articles (10, répartis sur les 2 auteurs)
for ($i = 0; $i < 10; $i++) {
    $auteur   = $auteurs[$i % 2];
    $categorie = $categories[array_rand($categories)];

    // resume >= 30 mots
    $resume = implode(' ', $faker->words(35));

    // contenu >= 3 paragraphes
    $contenu = implode("\n\n", [
        $faker->paragraph(6),
        $faker->paragraph(6),
        $faker->paragraph(6),
    ]);

    Article::create([
        'titre'        => $faker->sentence(5),
        'resume'       => $resume,
        'contenu'      => $contenu,
        'image'        => $faker->boolean(50) ? $faker->imageUrl(640, 480) : null,
        'date_creation' => $faker->dateTimeBetween('-6 months')->format('Y-m-d H:i:s'),
        'publie'       => $faker->boolean(70),
        'auteur_id'    => $auteur->id,
        'categorie_id' => $categorie->id,
    ]);
}

echo "Articles créés : 10\n";
echo "Seed terminé.\n";
