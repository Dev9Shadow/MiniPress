<?php
declare(strict_types=1);

namespace minipress\appli\models;

use Illuminate\Database\Eloquent\Model;

class Categorie extends Model
{
    protected $table = 'categorie';
    public $timestamps = false;
    protected $fillable = ['libelle'];

    public function articles()
    {
        return $this->hasMany(Article::class, 'categorie_id');
    }
}
