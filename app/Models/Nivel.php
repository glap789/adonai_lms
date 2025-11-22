<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Nivel extends Model
{
    protected $table = 'nivels';
    
    protected $fillable = [
        'nombre',
        'descripcion',
        'orden',
        'estado'
    ];

    // Scope para obtener solo niveles activos
    public function scopeActivo($query)
    {
        return $query->where('estado', 'Activo');
    }

    // Scope para ordenar por campo orden
    public function scopeOrdenado($query)
    {
        return $query->orderBy('orden', 'asc');
    }
}