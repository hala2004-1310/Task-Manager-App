<?php

use Illuminate\Support\Facades\Route;
use App\Livewire\TaskManager;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/tasks', TaskManager::class);