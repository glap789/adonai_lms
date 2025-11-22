@extends('adminlte::page')

@section('title', 'Editar Publicación')

@section('content')

<div class="pagetitle">
    <h1>Editar Publicación</h1>
    <nav>
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="{{ route('admin.dashboard') }}">Inicio</a>
            </li>
            <li class="breadcrumb-item">
                <a href="{{ route('admin.blog.index') }}">Blog</a>
            </li>
            <li class="breadcrumb-item active">Editar</li>
        </ol>
    </nav>
</div>

<section class="section">

    <div class="card">
        <div class="card-header">
            <h5 class="card-title m-0">Actualizar Publicación</h5>
        </div>

        <div class="card-body">

            {{-- MUY IMPORTANTE: POST a admin.blog.update (que ahora es POST /{id}/actualizar) --}}
            <form action="{{ route('admin.blog.update', $post->id) }}"
                  method="POST"
                  enctype="multipart/form-data">

                @csrf
                {{-- OJO: YA NO USAMOS @method('PUT') --}}

                <div class="row mb-3">
                    <div class="col-md-8">
                        <label class="form-label">Título</label>
                        <input type="text" name="titulo" class="form-control"
                               value="{{ $post->titulo }}" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Categoría</label>
                        <select name="categoria" class="form-select" required>
                            <option value="Premios" {{ $post->categoria == 'Premios' ? 'selected' : '' }}>Premios</option>
                            <option value="Concursos" {{ $post->categoria == 'Concursos' ? 'selected' : '' }}>Concursos</option>
                            <option value="Académico" {{ $post->categoria == 'Académico' ? 'selected' : '' }}>Académico</option>
                            <option value="Eventos" {{ $post->categoria == 'Eventos' ? 'selected' : '' }}>Eventos</option>
                            <option value="Comunidad" {{ $post->categoria == 'Comunidad' ? 'selected' : '' }}>Comunidad</option>
                        </select>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-4">
                        <label class="form-label">Fecha</label>
                        <input type="date" name="fecha" class="form-control"
                               value="{{ $post->fecha->format('Y-m-d') }}" required>
                    </div>

                    <div class="col-md-8">
                        <label class="form-label">Autor</label>
                        <input type="text" name="autor" class="form-control"
                               value="{{ $post->autor }}">
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Descripción Corta</label>
                    <textarea name="descripcion_corta" rows="3" class="form-control" required>{{ $post->descripcion_corta }}</textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Contenido Completo</label>
                    <textarea name="contenido" rows="7" class="form-control" required>{{ $post->contenido }}</textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Imagen Actual</label><br>
                    @if ($post->portada)
                        <img src="{{ asset('storage/' . $post->portada) }}"
                             width="120"
                             class="rounded mb-2">
                    @else
                        <span class="text-muted">Sin imagen</span>
                    @endif
                </div>

                <div class="mb-3">
                    <label class="form-label">Cambiar Imagen</label>
                    <input type="file" name="portada" class="form-control">
                </div>

                <div class="text-end">
                    <a href="{{ route('admin.blog.index') }}" class="btn btn-secondary">Cancelar</a>
                    <button type="submit" class="btn btn-primary">Actualizar</button>
                </div>

            </form>

        </div>
    </div>

</section>

@endsection
