<?php
declare(strict_types=1);

namespace minipress\appli\models;

use Illuminate\Database\Eloquent\Model;

class Utilisateur extends Model
{
    protected $table = 'utilisateur';
    public $timestamps = false;
    protected $fillable = ['email', 'password', 'role'];
    protected $hidden = ['password'];

    public function articles()
    {
        return $this->hasMany(Article::class, 'auteur_id');
    }
}
