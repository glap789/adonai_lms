<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class HashPasswords extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'users:hash-passwords {--password=123456789 : Default password for all users}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Hash all user passwords that are not properly hashed with bcrypt';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $defaultPassword = $this->option('password');

        $this->info('Checking users with invalid password hashes...');

        $users = User::all();
        $updated = 0;
        $skipped = 0;

        foreach ($users as $user) {
            // Verificar si la contraseña ya está hasheada con bcrypt
            if (str_starts_with($user->password, '$2y$') || str_starts_with($user->password, '$2a$')) {
                $this->line("✓ User {$user->email} already has valid hash");
                $skipped++;
                continue;
            }

            // Hashear la contraseña por defecto
            $user->password = Hash::make($defaultPassword);
            $user->save();

            $this->info("✓ Updated password for user: {$user->email}");
            $updated++;
        }

        $this->newLine();
        $this->info("Summary:");
        $this->info("- Updated: {$updated} users");
        $this->info("- Skipped: {$skipped} users (already hashed)");
        $this->newLine();

        if ($updated > 0) {
            $this->warn("Default password set to: {$defaultPassword}");
            $this->warn("IMPORTANT: Ask users to change their passwords!");
        }

        return Command::SUCCESS;
    }
}
