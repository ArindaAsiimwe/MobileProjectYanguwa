<?php

use App\Http\Controllers\API\AunthenticationController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');

Route::post('/register', [AunthenticationController::class, 'register']);
Route::post('/login', [AunthenticationController::class, 'login']);

