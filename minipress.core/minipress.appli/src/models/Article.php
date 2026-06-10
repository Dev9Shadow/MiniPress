<?php
declare(strict_types=1);

namespace minipress\appli\models;

use Illuminate\Database\Eloquent\Model;

class Article extends Model
{
    protected $table = 'article';
    public $timestamps = false;
    protected $casts = ['date_creation' => 'datetime', 'publie' => 'boolean'];
    protected $fillable = ['titre', 'resume', 'contenu', 'image', 'date_creation', 'publie', 'auteur_id', 'categorie_id'];

    public function auteur()
    {
        return $this->belongsTo(Utilisateur::class, 'auteur_id');
    }

    public function categorie()
    {
        return $this->belongsTo(Categorie::class, 'categorie_id');
    }
}
