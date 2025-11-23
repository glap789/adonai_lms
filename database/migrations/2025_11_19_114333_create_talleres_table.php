<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('talleres', function (Blueprint $table) {
            $table->id();
            $table->string('nombre');
            $table->text('descripcion')->nullable();
            $table->string('instructor');
            $table->date('duracion_inicio')->nullable();
            $table->date('duracion_fin')->nullable();
            $table->decimal('costo', 8, 2)->nullable();
            $table->integer('cupos_maximos')->default(20);
            $table->string('imagen')->nullable();
            $table->boolean('activo')->default(true);
            $table->timestamps();
            $table->time('horario_inicio')->nullable();
            $table->time('horario_fin')->nullable();
            $table->string('categoria')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('talleres');
    }
};
