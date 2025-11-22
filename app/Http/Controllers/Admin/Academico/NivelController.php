<?php

namespace App\Http\Controllers\Admin\Academico;

use App\Http\Controllers\Controller;
use App\Models\Nivel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class NivelController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $niveles = Nivel::orderBy('orden', 'asc')->get();
        return view('admin.niveles.index', compact('niveles'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        // Vista manejada en el modal del index
        return redirect()->route('admin.niveles.index');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'nombre_create' => 'required|max:50|unique:nivels,nombre',
            'descripcion_create' => 'nullable',
            'orden_create' => 'nullable|integer|min:0',
            'estado_create' => 'required|in:Activo,Inactivo',
        ]);
        
        $nivel = new Nivel();
        $nivel->nombre = $request->nombre_create;
        $nivel->descripcion = $request->descripcion_create;
        $nivel->orden = $request->orden_create ?? 0;
        $nivel->estado = $request->estado_create;
        $nivel->save();
        
        return redirect()->route('admin.niveles.index')
            ->with('mensaje', 'Nivel creado correctamente')
            ->with('icono', 'success');
    }

    /**
     * Display the specified resource.
     */
    public function show(Nivel $nivel)
    {
        return view('admin.niveles.show', compact('nivel'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Nivel $nivel)
    {
        // Vista manejada en el modal del index
        return redirect()->route('admin.niveles.index');
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Nivel $nivel)
    {
        $validate = Validator::make($request->all(), [
            'nombre' => 'required|max:50|unique:nivels,nombre,' . $nivel->id,
            'descripcion' => 'nullable',
            'orden' => 'nullable|integer|min:0',
            'estado' => 'required|in:Activo,Inactivo',
        ]);

        if ($validate->fails()) {
            return redirect()->back()
                ->withErrors($validate)
                ->withInput()
                ->with('modal_id', $nivel->id);
        }

        $nivel->nombre = $request->nombre;
        $nivel->descripcion = $request->descripcion;
        $nivel->orden = $request->orden ?? 0;
        $nivel->estado = $request->estado;
        $nivel->save();

        return redirect()->route('admin.niveles.index')
            ->with('mensaje', 'Nivel actualizado correctamente')
            ->with('icono', 'success');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Nivel $nivel)
    {
        $nivel->delete();

        return redirect()->route('admin.niveles.index')
            ->with('mensaje', 'Nivel eliminado correctamente')
            ->with('icono', 'success');
    }
}