<?php

namespace App\Http\Controllers\Admin\Blog;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Blog;
use Illuminate\Support\Facades\Storage;

class BlogController extends Controller
{
    public function index()
    {
        $posts = Blog::orderBy('fecha', 'desc')->get();
        return view('admin.blog.index', compact('posts'));
    }

    public function create()
    {
        return view('admin.blog.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'titulo' => 'required',
            'categoria' => 'required',
            'descripcion_corta' => 'required',
            'contenido' => 'required',
            'fecha' => 'required|date',
            'portada' => 'image'
        ]);

        $data = $request->all();

        if ($request->hasFile('portada')) {
            $data['portada'] = $request->file('portada')->store('blog', 'public');
        }

        Blog::create($data);

        return redirect()->route('admin.blog.index')
            ->with('success', 'Publicación creada correctamente');
    }

    public function edit($id)
    {
        $post = Blog::findOrFail($id);
        return view('admin.blog.edit', compact('post'));
    }

    public function update(Request $request, $id)
    {
        $post = Blog::findOrFail($id);

        $request->validate([
            'titulo' => 'required',
            'categoria' => 'required',
            'descripcion_corta' => 'required',
            'contenido' => 'required',
            'fecha' => 'required|date',
            'portada' => 'image'
        ]);

        $data = $request->all();

        if ($request->hasFile('portada')) {
            // eliminar anterior
            if ($post->portada && Storage::disk('public')->exists($post->portada)) {
                Storage::disk('public')->delete($post->portada);
            }

            $data['portada'] = $request->file('portada')->store('blog', 'public');
        }

        $post->update($data);

        return redirect()->route('admin.blog.index')
            ->with('success', 'Publicación actualizada');
    }

    public function destroy($id)
    {
        $post = Blog::findOrFail($id);

        if ($post->portada && Storage::disk('public')->exists($post->portada)) {
            Storage::disk('public')->delete($post->portada);
        }

        $post->delete();

        return back()->with('success', 'Publicación eliminada');
    }
}
