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
        Schema::table('talleres', function (Blueprint $table) {

            if (!Schema::hasColumn('talleres', 'costo')) {
                $table->decimal('costo', 8, 2)->nullable()->after('duracion_fin');
            }

            if (!Schema::hasColumn('talleres', 'imagen')) {
                $table->string('imagen')->nullable()->after('cupo_maximo');
            }

            if (!Schema::hasColumn('talleres', 'activo')) {
                $table->boolean('activo')->default(true)->after('imagen');
            }

            if (Schema::hasColumn('talleres', 'cupo_maximo') && !Schema::hasColumn('talleres', 'cupos_maximos')) {
                $table->renameColumn('cupo_maximo', 'cupos_maximos');
            }

            if (Schema::hasColumn('talleres', 'estado') && Schema::hasColumn('talleres', 'activo')) {
                $table->dropColumn('estado');
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('talleres', function (Blueprint $table) {
            // Revertir cambios
            if (Schema::hasColumn('talleres', 'costo')) {
                $table->dropColumn('costo');
            }

            if (Schema::hasColumn('talleres', 'imagen')) {
                $table->dropColumn('imagen');
            }

            if (Schema::hasColumn('talleres', 'activo')) {
                $table->dropColumn('activo');
            }

            if (Schema::hasColumn('talleres', 'cupos_maximos')) {
                $table->renameColumn('cupos_maximos', 'cupo_maximo');
            }
        });
    }
};
