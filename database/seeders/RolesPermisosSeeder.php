<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Role;
use App\Models\Permission;
use Illuminate\Support\Facades\DB;

class RolesPermisosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::beginTransaction();

        try {
            // ======================================
            // CREAR ROLES (con firstOrCreate)
            // ======================================

            $adminPrincipal = Role::firstOrCreate(
                ['name' => 'Administrador'],
                [
                    'display_name' => 'Administrador',
                    'description'  => 'Administrador del sistema'
                ]
            );

            $adminAlias = Role::firstOrCreate(
                ['name' => 'admin'],
                [
                    'display_name' => 'Admin',
                    'description'  => 'Administrador del sistema (alias)'
                ]
            );

            $docente = Role::firstOrCreate(
                ['name' => 'docente'],
                [
                    'display_name' => 'Docente',
                    'description'  => 'Docente del colegio'
                ]
            );

            $tutor = Role::firstOrCreate(
                ['name' => 'tutor'],
                [
                    'display_name' => 'Tutor',
                    'description'  => 'Tutor de estudiante'
                ]
            );

            $estudiante = Role::firstOrCreate(
                ['name' => 'estudiante'],
                [
                    'display_name' => 'Estudiante',
                    'description'  => 'Estudiante del colegio'
                ]
            );

            // ======================================
            // CREAR PERMISOS POR MÓDULOS
            // (misma lógica que ya tenías, pero con firstOrCreate)
            // ======================================

            $permisos = [];

            // Helper para no repetir código
            $crearPermiso = function (string $name, string $display, string $description, string $module) use (&$permisos) {
                $permisos[] = Permission::firstOrCreate(
                    ['name' => $name],
                    [
                        'display_name' => $display,
                        'description'  => $description,
                        'module'       => $module,
                    ]
                );
            };

            // === DASHBOARD ===
            $crearPermiso('dashboard.view', 'Ver Dashboard', 'Acceso al panel principal', 'dashboard');

            // === CONFIGURACIÓN ===
            $crearPermiso('configuracion.view', 'Ver Configuración', 'Acceso a configuración del sistema', 'configuracion');

            // === GESTIONES ===
            $crearPermiso('gestiones.view', 'Ver Gestiones', 'Ver listado de gestiones', 'academico');
            $crearPermiso('gestiones.create', 'Crear Gestiones', 'Crear nuevas gestiones', 'academico');
            $crearPermiso('gestiones.edit', 'Editar Gestiones', 'Editar gestiones existentes', 'academico');
            $crearPermiso('gestiones.delete', 'Eliminar Gestiones', 'Eliminar gestiones', 'academico');

            // === PERÍODOS ===
            $crearPermiso('periodos.view', 'Ver Períodos', 'Ver listado de períodos', 'academico');
            $crearPermiso('periodos.create', 'Crear Períodos', 'Crear nuevos períodos', 'academico');
            $crearPermiso('periodos.edit', 'Editar Períodos', 'Editar períodos existentes', 'academico');
            $crearPermiso('periodos.delete', 'Eliminar Períodos', 'Eliminar períodos', 'academico');

            // === NIVELES ===
            $crearPermiso('niveles.view', 'Ver Niveles', 'Ver listado de niveles', 'academico');
            $crearPermiso('niveles.create', 'Crear Niveles', 'Crear nuevos niveles', 'academico');

            // === TURNOS ===
            $crearPermiso('turnos.view', 'Ver Turnos', 'Ver listado de turnos', 'academico');

            // === HORARIOS ===
            $crearPermiso('horarios.view', 'Ver Horarios', 'Ver listado de horarios', 'academico');

            // === DOCENTES ===
            $crearPermiso('docentes.view', 'Ver Docentes', 'Ver listado de docentes', 'personal');
            $crearPermiso('docentes.create', 'Crear Docentes', 'Registrar nuevos docentes', 'personal');
            $crearPermiso('docentes.edit', 'Editar Docentes', 'Editar datos de docentes', 'personal');
            $crearPermiso('docentes.delete', 'Eliminar Docentes', 'Eliminar docentes', 'personal');

            // === TUTORES ===
            $crearPermiso('tutores.view', 'Ver Tutores', 'Ver listado de tutores', 'personal');

            // === ESTUDIANTES ===
            $crearPermiso('estudiantes.view', 'Ver Estudiantes', 'Ver listado de estudiantes', 'estudiantes');
            $crearPermiso('estudiantes.create', 'Crear Estudiantes', 'Registrar nuevos estudiantes', 'estudiantes');
            $crearPermiso('estudiantes.edit', 'Editar Estudiantes', 'Editar datos de estudiantes', 'estudiantes');
            $crearPermiso('estudiantes.delete', 'Eliminar Estudiantes', 'Eliminar estudiantes', 'estudiantes');

            // === CURSOS ===
            $crearPermiso('cursos.view', 'Ver Cursos', 'Ver listado de cursos', 'academico');
            $crearPermiso('cursos.create', 'Crear Cursos', 'Crear nuevos cursos', 'academico');
            $crearPermiso('cursos.edit', 'Editar Cursos', 'Editar cursos existentes', 'academico');
            $crearPermiso('cursos.delete', 'Eliminar Cursos', 'Eliminar cursos', 'academico');

            // === GRADOS ===
            $crearPermiso('grados.view', 'Ver Grados', 'Ver listado de grados', 'academico');
            $crearPermiso('grados.create', 'Crear Grados', 'Crear nuevos grados', 'academico');
            $crearPermiso('grados.edit', 'Editar Grados', 'Editar grados existentes', 'academico');
            $crearPermiso('grados.delete', 'Eliminar Grados', 'Eliminar grados', 'academico');

            // === ASIGNACIÓN DOCENTES ===
            $crearPermiso('asignacion-docentes.view', 'Ver Asignación Docentes', 'Ver asignaciones de docentes a cursos', 'academico');
            $crearPermiso('asignacion-docentes.create', 'Crear Asignación Docentes', 'Asignar docentes a cursos', 'academico');
            $crearPermiso('asignacion-docentes.delete', 'Eliminar Asignación Docentes', 'Eliminar asignaciones de docentes', 'academico');

            // === MATRÍCULAS ===
            $crearPermiso('matriculas.view', 'Ver Matrículas', 'Ver listado de matrículas', 'estudiantes');
            $crearPermiso('matriculas.create', 'Crear Matrículas', 'Matricular estudiantes', 'estudiantes');
            $crearPermiso('matriculas.edit', 'Editar Matrículas', 'Editar matrículas existentes', 'estudiantes');
            $crearPermiso('matriculas.delete', 'Eliminar Matrículas', 'Eliminar matrículas', 'estudiantes');

            // === TUTOR-ESTUDIANTE ===
            $crearPermiso('tutor-estudiante.view', 'Ver Tutor-Estudiante', 'Ver relaciones tutor-estudiante', 'estudiantes');
            $crearPermiso('tutor-estudiante.create', 'Asignar Tutor-Estudiante', 'Asignar tutores a estudiantes', 'estudiantes');

            // === ASISTENCIAS ===
            $crearPermiso('asistencias.view', 'Ver Asistencias', 'Ver registro de asistencias', 'docentes');
            $crearPermiso('asistencias.create', 'Registrar Asistencias', 'Registrar asistencias de estudiantes', 'docentes');
            $crearPermiso('asistencias.edit', 'Editar Asistencias', 'Editar registros de asistencias', 'docentes');

            // === NOTAS ===
            $crearPermiso('notas.view', 'Ver Notas', 'Ver calificaciones de estudiantes', 'docentes');
            $crearPermiso('notas.create', 'Registrar Notas', 'Registrar calificaciones', 'docentes');
            $crearPermiso('notas.edit', 'Editar Notas', 'Editar calificaciones', 'docentes');

            // === COMPORTAMIENTOS ===
            $crearPermiso('comportamientos.view', 'Ver Comportamientos', 'Ver evaluaciones de comportamiento', 'docentes');
            $crearPermiso('comportamientos.create', 'Registrar Comportamientos', 'Registrar evaluaciones de comportamiento', 'docentes');
            $crearPermiso('comportamientos.edit', 'Editar Comportamientos', 'Editar evaluaciones de comportamiento', 'docentes');

            // === REPORTES ===
            $crearPermiso('reportes.view', 'Ver Reportes', 'Acceso a módulo de reportes', 'reportes');
            $crearPermiso('reportes.generate', 'Generar Reportes', 'Generar reportes del sistema', 'reportes');

            // === ADMINISTRADORES ===
            $crearPermiso('administradores.view', 'Ver Administradores', 'Ver listado de administradores', 'administracion');
            $crearPermiso('administradores.create', 'Crear Administradores', 'Registrar nuevos administradores', 'administracion');

            // === PERMISOS ===
            $crearPermiso('permisos.view', 'Ver Permisos', 'Ver listado de permisos', 'administracion');
            $crearPermiso('permisos.create', 'Crear Permisos', 'Crear nuevos permisos', 'administracion');
            $crearPermiso('permisos.edit', 'Editar Permisos', 'Editar permisos existentes', 'administracion');
            $crearPermiso('permisos.delete', 'Eliminar Permisos', 'Eliminar permisos', 'administracion');

            // === ROLES ===
            $crearPermiso('roles.view', 'Ver Roles', 'Ver listado de roles', 'administracion');
            $crearPermiso('roles.create', 'Crear Roles', 'Crear nuevos roles', 'administracion');
            $crearPermiso('roles.edit', 'Editar Roles', 'Editar roles existentes', 'administracion');
            $crearPermiso('roles.delete', 'Eliminar Roles', 'Eliminar roles', 'administracion');

            // === USUARIOS ===
            $crearPermiso('usuarios.view', 'Ver Usuarios', 'Ver listado de usuarios', 'administracion');
            $crearPermiso('usuarios.create', 'Crear Usuarios', 'Crear nuevos usuarios', 'administracion');
            $crearPermiso('usuarios.edit', 'Editar Usuarios', 'Editar usuarios existentes', 'administracion');
            $crearPermiso('usuarios.delete', 'Eliminar Usuarios', 'Eliminar usuarios', 'administracion');

            // ======================================
            // ASIGNAR PERMISOS A ROLES
            // ======================================

            // ADMINISTRADORES: TODOS
            $todosPermisos = Permission::all()->pluck('id');
            $adminPrincipal->permissions()->sync($todosPermisos);
            $adminAlias->permissions()->sync($todosPermisos);

            // DOCENTE
            $permisosDocente = Permission::whereIn('name', [
                'dashboard.view',
                'asistencias.view',
                'asistencias.create',
                'asistencias.edit',
                'notas.view',
                'notas.create',
                'notas.edit',
                'comportamientos.view',
                'comportamientos.create',
                'comportamientos.edit',
                'reportes.view',
                'estudiantes.view',
            ])->pluck('id');
            $docente->permissions()->sync($permisosDocente);

            // TUTOR
            $permisosTutor = Permission::whereIn('name', [
                'dashboard.view',
                'tutor-estudiante.view',
                'asistencias.view',
                'notas.view',
                'reportes.view',
                'estudiantes.view',
            ])->pluck('id');
            $tutor->permissions()->sync($permisosTutor);

            // ESTUDIANTE
            $permisosEstudiante = Permission::whereIn('name', [
                'dashboard.view',
                'notas.view',
                'asistencias.view',
            ])->pluck('id');
            $estudiante->permissions()->sync($permisosEstudiante);

            DB::commit();

            $this->command->info('✅ Roles y permisos creados/actualizados correctamente.');
            $this->command->info('📊 Total de permisos: ' . count($permisos));
        } catch (\Exception $e) {
            DB::rollBack();
            $this->command->error('❌ Error al crear roles y permisos: ' . $e->getMessage());
            throw $e;
        }
    }
}
