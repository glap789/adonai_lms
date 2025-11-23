<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Role;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::beginTransaction();

        try {
            
            $admin = User::create([
                'name' => 'Administrador',
                'email' => 'admin@adonai.com',
                'password' => Hash::make('admin123'),
                'email_verified_at' => now(),
            ]);

            $rolAdmin = Role::where('name', 'admin')->first();
            if ($rolAdmin) {
                $admin->roles()->attach($rolAdmin->id);
                $this->command->info('Usuario administrador creado con rol admin');
            }

            $docente = User::create([
                'name' => 'Docente Ejemplo',
                'email' => 'docente@adonai.com',
                'password' => Hash::make('docente123'),
                'email_verified_at' => now(),
            ]);

            $rolDocente = Role::where('name', 'docente')->first();
            if ($rolDocente) {
                $docente->roles()->attach($rolDocente->id);
                $this->command->info('Usuario docente creado con rol docente');
            }

            $estudiante = User::create([
                'name' => 'Estudiante Ejemplo',
                'email' => 'estudiante@adonai.com',
                'password' => Hash::make('estudiante123'),
                'email_verified_at' => now(),
            ]);

            // Asignar rol de estudiante
            $rolEstudiante = Role::where('name', 'estudiante')->first();
            if ($rolEstudiante) {
                $estudiante->roles()->attach($rolEstudiante->id);
                $this->command->info('Usuario estudiante creado con rol estudiante');
            }

            DB::commit();

            $this->command->info('');
            $this->command->info('========================================');
            $this->command->info('      USUARIOS CREADOS EXITOSAMENTE     ');
            $this->command->info('========================================');
            $this->command->info('');
            $this->command->info('Administrador:');
            $this->command->info('   Email: admin@adonai.com');
            $this->command->info('   Password: admin123');
            $this->command->info('');
            $this->command->info('Docente:');
            $this->command->info('   Email: docente@adonai.com');
            $this->command->info('   Password: docente123');
            $this->command->info('');
            $this->command->info('Estudiante:');
            $this->command->info('   Email: estudiante@adonai.com');
            $this->command->info('   Password: estudiante123');
            $this->command->info('');
            $this->command->info('IMPORTANTE: Cambiar estas contraseñas en producción');
            $this->command->info('========================================');

        } catch (\Exception $e) {
            DB::rollBack();
            $this->command->error('Error al crear usuarios: ' . $e->getMessage());
            throw $e;
        }
    }
}