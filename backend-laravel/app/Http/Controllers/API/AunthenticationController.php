<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Http\Requests\UserRequest;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\JsonResponse;

class AunthenticationController extends Controller
{
    public function register(UserRequest $userRequest){
        $validatedData = $userRequest->validated();

        $validator = Validator::make($validatedData,[
            'password' => ['required', 'string', 'min:8'],
        ], [
            'password.min' => 'Password must be at least 8 chracters long',
        ]);
        
        if($validator->fails()){
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors()->first(),
            ], 422);
        }

        $newUser = new User([
            'name' => $validatedData['name'],
            'email' => $validatedData['email'],
            'password' => Hash::make($validatedData['password']),
        ]);

        $newUser->save();

        $newUserToken = $newUser->createToken('authToken')->plainTextToken;

        return response()->json([
            'message' => 'User created successfully',
            'user' => $newUser,
            'token' => $newUserToken,
        ], 201);
    }

    public function login(Request $request){
        
        $loginData = $request->validate([
            'email' =>'required|email',
            'password' => 'required',
        ],[
            'email.required'=> 'Email address is required',
            'email.email' => 'Email address is invalid',
            'password.required' => 'Password is required',
        ]);

        $user = User::where('email', $loginData['email'])->first();

        if (!$user || !Hash::check($loginData['password'], $user->password)) {
            return response()->json([
                'message' => 'Invalid credentials',
            ], 401);
        }

        // if(!auth()->attempt($loginData)){
        //     return response()->json([
        //         'message' => 'Invalid credentials',
        //     ], 401);
        // }

        $user = User::where('email', $loginData['email'])->firstOrFail();

        $userToken = $user->createToken('authToken')->plainTextToken;

        return response()->json([
            'message' => 'Login successful',
            'user' => $user,
            'token' => $userToken,
        ], 200);
    }

    // public function logout(){

    //     auth()->user()->tokens()->delete();

    //     return response()->json([
    //         'message'=> 'User logged out succesfully',
    //     ], 200);
    // }

    public function user(): JsonResponse
    {
        $users = User::all();
        return response()->json($users);
    }
}
