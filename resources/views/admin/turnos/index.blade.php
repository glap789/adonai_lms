@extends('adminlte::page')

@section('title', 'Gestión de Turnos')

@section('content_header')
    <h1><b>Listado de Turnos</b></h1>
@stop

@section('content')

<div class="row">
    <div class="col-md-12">
        <div class="card card-outline card-primary">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h3 class="card-title">Turnos registrados</h3>

                {{-- BOTÓN CREAR --}}
                <a href="{{ route('admin.turnos.create') }}" class="btn btn-primary btn-sm">
                    <i class="fas fa-plus"></i> Crear nuevo turno
                </a>
            </div>

            <div class="card-body">
                <table class="table table-bordered table-striped table-hover table-sm">
                    <thead>
                        <tr>
                            <th style="width: 40px; text-align:center;">N°</th>
                            <th>Nombre</th>
                            <th style="width: 120px;">Hora inicio</th>
                            <th style="width: 120px;">Hora fin</th>
                            <th style="width: 100px; text-align:center;">Estado</th>
                            <th>Descripción</th>
                            <th style="width: 90px; text-align:center;">Acciones</th>
                        </tr>
                    </thead>

                    <tbody>
                        @forelse ($turnos as $turno)
                            <tr>
                                <td style="text-align:center;">{{ $loop->iteration }}</td>
                                <td>{{ $turno->nombre }}</td>

                                <td>{{ \Carbon\Carbon::parse($turno->hora_inicio)->format('h:i A') }}</td>
                                <td>{{ \Carbon\Carbon::parse($turno->hora_fin)->format('h:i A') }}</td>

                                <td style="text-align:center;">
                                    @if ($turno->estado === 'activo')
                                        <span class="badge bg-success">Activo</span>
                                    @else
                                        <span class="badge bg-secondary">Inactivo</span>
                                    @endif
                                </td>

                                <td>{{ $turno->descripcion ? Str::limit($turno->descripcion, 50) : '—' }}</td>

                                {{-- ACCIONES SOLO ÍCONOS Y A LADO --}}
                                <td style="text-align:center;">
                                    <div class="btn-group" role="group">

                                        {{-- Editar --}}
                                        <a href="{{ route('admin.turnos.edit', $turno->id) }}"
                                           class="btn btn-success btn-sm"
                                           title="Editar">
                                            <i class="fas fa-pencil-alt"></i>
                                        </a>

                                        {{-- Eliminar --}}
                                        <button type="button"
                                            class="btn btn-danger btn-sm"
                                            onclick="confirmDelete({{ $turno->id }})"
                                            title="Eliminar">
                                            <i class="fas fa-trash"></i>
                                        </button>

                                    </div>

                                    {{-- FORM ELIMINAR --}}
                                    <form id="delete-form-{{ $turno->id }}"
                                          action="{{ route('admin.turnos.destroy', $turno->id) }}"
                                          method="POST"
                                          style="display:none;">
                                        @csrf
                                        @method('DELETE')
                                    </form>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="7" class="text-center text-muted">No hay turnos registrados.</td>
                            </tr>
                        @endforelse
                    </tbody>

                </table>
            </div>
        </div>
    </div>
</div>

@stop

@section('js')
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    {{-- Confirmación SweetAlert --}}
    <script>
        function confirmDelete(id) {
            Swal.fire({
                title: '¿Eliminar turno?',
                text: "Esta acción no se puede deshacer",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Sí, eliminar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById('delete-form-' + id).submit();
                }
            });
        }
    </script>

    {{-- Notificación éxito --}}
    @if (session('mensaje'))
        <script>
            Swal.fire({
                icon: '{{ session("icono") }}',
                title: 'Éxito',
                text: '{{ session("mensaje") }}',
                timer: 2500,
                showConfirmButton: false
            });
        </script>
    @endif
@stop
