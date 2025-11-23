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
            // ADMINISTRADOR
            $admin = User::firstOrCreate(
                ['email' => 'admin@adonai.com'],
                [
                    'name'              => 'Administrador',
                    'password'          => Hash::make('admin123'),
                    'email_verified_at' => now(),
                ]
            );

            $rolAdmin = Role::where('name', 'admin')->first()
                ?? Role::where('name', 'Administrador')->first();

            if ($rolAdmin) {
                $admin->roles()->syncWithoutDetaching([$rolAdmin->id]);
                $this->command->info('✅ Usuario administrador creado/asignado con rol admin');
            }

            // DOCENTE
            $docente = User::firstOrCreate(
                ['email' => 'docente@adonai.com'],
                [
                    'name'              => 'Docente Ejemplo',
                    'password'          => Hash::make('docente123'),
                    'email_verified_at' => now(),
                ]
            );

            $rolDocente = Role::where('name', 'docente')->first();
            if ($rolDocente) {
                $docente->roles()->syncWithoutDetaching([$rolDocente->id]);
                $this->command->info('✅ Usuario docente creado con rol docente');
            }

            // TUTOR
            $tutor = User::firstOrCreate(
                ['email' => 'tutor@adonai.com'],
                [
                    'name'              => 'Tutor Ejemplo',
                    'password'          => Hash::make('tutor123'),
                    'email_verified_at' => now(),
                ]
            );

            $rolTutor = Role::where('name', 'tutor')->first();
            if ($rolTutor) {
                $tutor->roles()->syncWithoutDetaching([$rolTutor->id]);
                $this->command->info('✅ Usuario tutor creado con rol tutor');
            }

            DB::commit();

            $this->command->info('');
            $this->command->info('========================================');
            $this->command->info('      USUARIOS CREADOS EXITOSAMENTE     ');
            $this->command->info('========================================');
            $this->command->info('Administrador:');
            $this->command->info('   Email: admin@adonai.com');
            $this->command->info('   Password: admin123');
            $this->command->info('');
            $this->command->info('Docente:');
            $this->command->info('   Email: docente@adonai.com');
            $this->command->info('   Password: docente123');
            $this->command->info('');
            $this->command->info('Tutor:');
            $this->command->info('   Email: tutor@adonai.com');
            $this->command->info('   Password: tutor123');
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
