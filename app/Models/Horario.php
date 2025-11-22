<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Horario extends Model
{
    protected $table = 'horarios';
    
    protected $fillable = [
        'gestion_id',
        'curso_id',
        'grado_id',
        'docente_id',
        'dia_semana',
        'hora_inicio',
        'hora_fin',
        'aula'
    ];

    // Relaciones
    public function gestion()
    {
        return $this->belongsTo(Gestion::class);
    }

    public function curso()
    {
        return $this->belongsTo(Curso::class);
    }

    public function grado()
    {
        return $this->belongsTo(Grado::class);
    }

    public function docente()
    {
        return $this->belongsTo(Docente::class);
    }

    // Scope para ordenar por día y hora
    public function scopeOrdenado($query)
    {
        return $query->orderByRaw("FIELD(dia_semana, 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado')")
                     ->orderBy('hora_inicio', 'asc');
    }
}