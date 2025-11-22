@extends('adminlte::page')

@section('title', 'Gestión de Talleres')

@section('content_header')
    <div class="d-flex justify-content-between align-items-center">
        <h1>Lista de Talleres</h1>
        <button class="btn btn-primary" onclick="abrirModal()">
            <i class="fas fa-plus"></i> Agregar Taller
        </button>
    </div>
@stop

@section('content')

    <!-- Lista de Talleres -->
    <div class="card mt-3">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Imagen</th>
                            <th>Nombre</th>
                            <th>Instructor</th>
                            <th>Duración</th>
                            <th>Horario</th>
                            <th>Categoría</th>
                            <th>Costo</th>
                            <th>Cupos</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>

                    <tbody>
                        @foreach($talleres as $taller)
                        <tr>
                            <td>
                                @if($taller->imagen)
                                    <img src="{{ asset('storage/'.$taller->imagen) }}"
                                         style="width: 70px; height: 50px; object-fit: cover; border-radius: 6px;">
                                @else
                                    <span class="text-muted">Sin imagen</span>
                                @endif
                            </td>

                            <td>{{ $taller->nombre }}</td>
                            <td>{{ $taller->instructor }}</td>

                            <!-- DURACIÓN -->
<td>
    @if($taller->duracion_inicio && $taller->duracion_fin)
        @php
            $ini = \Carbon\Carbon::parse($taller->duracion_inicio);
            $fin = \Carbon\Carbon::parse($taller->duracion_fin);

            // Ejemplo: "19 Nov — 19 Dic 2025"
            $textoDuracion =
                $ini->format('d M') . ' — ' .
                $fin->format('d M Y');
        @endphp

        <span class="text-dark fw-semibold">
            <i class="bi bi-calendar-event" style="font-size: 1rem; color:#1a73e8;"></i>
            {{ $textoDuracion }}
        </span>
    @else
        <span class="text-muted">Sin fechas</span>
    @endif
</td>

                                                    <!-- HORARIO -->
                                                    <td>
                            @if($taller->horario_inicio && $taller->horario_fin)
                                {{ \Carbon\Carbon::parse($taller->horario_inicio)->format('H:i') }}
                                -
                                {{ \Carbon\Carbon::parse($taller->horario_fin)->format('H:i') }}
                            @else
                                <span class="text-muted">No definido</span>
                            @endif
                        </td>



                            <td>{{ $taller->categoria ?? '—' }}</td>

                            <td>{{ $taller->costo ? 'S/ '.$taller->costo : 'Gratuito' }}</td>

                            <td>{{ $taller->cupos_maximos }}</td>

                            <td>
                                <span class="badge {{ $taller->activo ? 'bg-success' : 'bg-danger' }}">
                                    {{ $taller->activo ? 'Activo' : 'Inactivo' }}
                                </span>
                            </td>

                            <td>
                                <button class="btn btn-sm btn-warning"
                                        onclick="editarTaller({{ $taller }})">
                                    <i class="fas fa-edit"></i>
                                </button>

                                <button class="btn btn-sm btn-danger"
                                        onclick="eliminarTaller({{ $taller->id }})">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                        @endforeach
                    </tbody>

                </table>
            </div>
        </div>
    </div>


    <!-- Modal Agregar/Editar -->
    <div class="modal fade" id="tallerModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle">Agregar Taller</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <form id="tallerForm" method="POST" enctype="multipart/form-data">
                    @csrf
                    <div id="formMethod"></div>

                    <div class="modal-body">

                        <!-- Nombre -->
                        <div class="mb-3">
                            <label class="form-label">Nombre del Taller *</label>
                            <input type="text" name="nombre" class="form-control" required>
                        </div>

                        <!-- Descripción -->
                        <div class="mb-3">
                            <label class="form-label">Descripción</label>
                            <textarea name="descripcion" rows="3" class="form-control"></textarea>
                        </div>

                        <!-- Instructor / Categoría -->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Instructor *</label>
                                    <input type="text" name="instructor" class="form-control" required>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Categoría</label>
                                    <input type="text" name="categoria" class="form-control"
                                           placeholder="Ej: Arte, Deporte, Música...">
                                </div>
                            </div>
                        </div>

                        <!-- Duración (FECHAS) -->
                        <div class="row">
                            <div class="col-md-6">
                                <label class="form-label">Fecha de Inicio *</label>
                                <input type="date" name="duracion_inicio" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Fecha de Fin *</label>
                                <input type="date" name="duracion_fin" class="form-control" required>
                            </div>
                        </div>

                        <!-- Horario (HORAS) -->
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <label class="form-label">Hora Inicio *</label>
                                <input type="time" name="horario_inicio" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Hora Fin *</label>
                                <input type="time" name="horario_fin" class="form-control" required>
                            </div>
                        </div>

                        <!-- Costos / Cupos -->
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <label class="form-label">Costo (S/)</label>
                                <input type="number" name="costo" class="form-control" step="0.01" min="0">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Cupos Máximos *</label>
                                <input type="number" name="cupos_maximos" min="1" class="form-control" required>
                            </div>
                        </div>

                        <!-- Imagen -->
                        <div class="mt-3">
                            <label class="form-label">Imagen</label>
                            <input type="file" name="imagen" accept="image/*" class="form-control">
                        </div>

                        <!-- Estado -->
                        <div class="mt-3">
                            <div class="form-check">
                                <input type="checkbox" name="activo" id="activoCheck"
                                       class="form-check-input" checked>
                                <label for="activoCheck" class="form-check-label">Taller Activo</label>
                            </div>
                        </div>

                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button class="btn btn-primary">Guardar Taller</button>
                    </div>

                </form>

            </div>
        </div>
    </div>

@stop

@section('js')
<script>
    function abrirModal(taller = null) {
        const modal = new bootstrap.Modal(document.getElementById('tallerModal'));
        const form = document.getElementById('tallerForm');
        const title = document.getElementById('modalTitle');

        if (taller) {
            // Editar
            title.textContent = 'Editar Taller';
            form.action = "{{ url('admin/talleres') }}/" + taller.id;
            document.getElementById('formMethod').innerHTML = '@method("PUT")';

            form.nombre.value = taller.nombre;
            form.descripcion.value = taller.descripcion ?? '';
            form.instructor.value = taller.instructor;
            form.categoria.value = taller.categoria ?? '';

            form.duracion_inicio.value = taller.duracion_inicio ?? '';
            form.duracion_fin.value = taller.duracion_fin ?? '';

            form.horario_inicio.value = taller.horario_inicio ?? '';
            form.horario_fin.value = taller.horario_fin ?? '';

            form.costo.value = taller.costo ?? '';
            form.cupos_maximos.value = taller.cupos_maximos;
            form.activo.checked = taller.activo;

        } else {
            // Nuevo
            title.textContent = 'Agregar Taller';
            form.action = "{{ route('admin.talleres.store') }}";
            document.getElementById('formMethod').innerHTML = '';
            form.reset();
            form.activo.checked = true;
        }

        modal.show();
    }

    function editarTaller(t) { abrirModal(t); }

    function eliminarTaller(id) {
        if (!confirm('¿Eliminar este taller? Esta acción no se puede deshacer.')) return;

        fetch("{{ url('admin/talleres') }}/" + id, {
            method: 'DELETE',
            headers: {
                "X-CSRF-TOKEN": "{{ csrf_token() }}",
                "Content-Type": "application/json"
            }
        }).then(res => {
            if (res.ok) location.reload();
        });
    }
</script>
@stop
