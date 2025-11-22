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
                <a href="{{ url('/admin/turnos/create') }}" class="btn btn-primary btn-sm">
                    <i class="fas fa-plus"></i> Crear nuevo turno
                </a>
            </div>

            <div class="card-body">
                <table id="turnosTable" class="table table-bordered table-striped table-hover table-sm">
                    <thead>
                        <tr>
                            <th style="width: 50px; text-align: center;">N°</th>
                            <th>Nombre</th>
                            <th style="width: 120px;">Hora inicio</th>
                            <th style="width: 120px;">Hora fin</th>
                            <th style="width: 100px; text-align: center;">Estado</th>
                            <th>Descripción</th>
                            <th style="width: 150px; text-align: center;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse ($turnos as $turno)
                            <tr>
                                <td style="text-align: center">{{ $loop->iteration }}</td>
                                <td>{{ $turno->nombre }}</td>
                                <td>{{ \Carbon\Carbon::parse($turno->hora_inicio)->format('h:i A') }}</td>
                                <td>{{ \Carbon\Carbon::parse($turno->hora_fin)->format('h:i A') }}</td>
                                <td style="text-align: center">
                                    @if($turno->estado === 'activo')
                                        <span class="badge bg-success">Activo</span>
                                    @else
                                        <span class="badge bg-secondary">Inactivo</span>
                                    @endif
                                </td>
                                <td>{{ Str::limit($turno->descripcion, 50) ?? '—' }}</td>
                                <td style="text-align: center">
                                    <a href="{{ url('/admin/turnos/'.$turno->id.'/edit') }}" 
                                       class="btn btn-success btn-sm" 
                                       title="Editar">
                                        <i class="fas fa-pencil-alt"></i> Editar
                                    </a>
                                    <button type="button" 
                                            class="btn btn-danger btn-sm" 
                                            onclick="confirmDelete({{ $turno->id }})" 
                                            title="Eliminar">
                                        <i class="fas fa-trash"></i> Eliminar
                                    </button>
                                    <form id="delete-form-{{ $turno->id }}" 
                                          action="{{ url('/admin/turnos/'.$turno->id) }}" 
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

@section('css')
    {{-- Estilos personalizados --}}
@stop

@section('js')
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    {{-- Mensaje de éxito --}}
    @if (session('mensaje'))
        <script>
            Swal.fire({
                icon: '{{ session('icono') ?? "success" }}',
                title: '¡Éxito!',
                text: '{{ session('mensaje') }}',
                confirmButtonText: 'Aceptar',
                confirmButtonColor: '#3085d6',
                timer: 3000
            });
        </script>
    @endif

    {{-- Confirmación para eliminar con SweetAlert2 --}}
    <script>
        function confirmDelete(id) {
            Swal.fire({
                title: '⚠️ ¿Está seguro?',
                text: "Esta acción eliminará el turno de forma permanente",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Sí, eliminar',
                cancelButtonText: 'Cancelar',
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById('delete-form-' + id).submit();
                }
            });
        }
    </script>
@stop