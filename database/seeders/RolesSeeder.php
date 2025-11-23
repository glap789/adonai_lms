<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Role;
use App\Models\User;

class RolesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {

        $roles = [
            ['name' => 'Administrador', 'display_name' => 'Administrador', 'description' => 'Administrador del sistema'],
            ['name' => 'admin', 'display_name' => 'Admin', 'description' => 'Administrador del sistema (alias)'],
            ['name' => 'docente', 'display_name' => 'Docente', 'description' => 'Docente del colegio'],
            ['name' => 'estudiante', 'display_name' => 'Estudiante', 'description' => 'Estudiante del colegio'],
            ['name' => 'tutor', 'display_name' => 'Tutor', 'description' => 'Tutor de estudiante'],
        ];

        foreach ($roles as $roleData) {
            Role::firstOrCreate(
                ['name' => $roleData['name']],
                [
                    'display_name' => $roleData['display_name'],
                    'description' => $roleData['description']
                ]
            );
        }

        echo "Roles creados exitosamente.\n";

        $firstUser = User::first();
        if ($firstUser && !$firstUser->roles()->exists()) {
            $adminRole = Role::where('name', 'Administrador')->first();
            if ($adminRole) {
                $firstUser->roles()->attach($adminRole->id);
                echo "Rol Administrador asignado al usuario: {$firstUser->email}\n";
            }
        }
    }
}
