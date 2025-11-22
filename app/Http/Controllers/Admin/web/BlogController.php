<?php

namespace App\Http\Controllers\Admin\web;

use App\Http\Controllers\Controller;
use App\Models\Blog;

class BlogController extends Controller
{
    // Página principal del blog (lista de publicaciones)
    public function index()
    {
        $posts = Blog::orderBy('fecha', 'desc')->get();

        return view('blog', compact('posts'));
    }

    // Página de detalle de cada publicación
    public function show($id)
    {
        $post = Blog::findOrFail($id);

        return view('blog-show', compact('post'));
    }
}
