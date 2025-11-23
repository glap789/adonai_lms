<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Ejecutamos primero roles y permisos, luego usuarios
        $this->call([
            RolesPermisosSeeder::class,
            UserSeeder::class,
        ]);
    }
}
