import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_model.dart';
import '../models/user_model.dart';

class AuthService {
  static const String baseUrl = 'https://api.haloclinic.com'; // Ganti dengan URL API Anda
  static const bool _mockForgotPassword = true; // Disable when real API ready
  
  // Login
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      );

      final data = json.decode(response.body);
      final authResponse = AuthResponse.fromJson(data);

      if (response.statusCode == 200 && authResponse.success) {
        // Save token
        if (authResponse.token != null) {
          await _saveToken(authResponse.token!);
        }
        
        // Save user data
        if (authResponse.user != null) {
          await _saveUserData(authResponse.user!);
        }
      }

      return authResponse;
    } catch (e) {
      return AuthResponse(
        success: false,
        message: 'Terjadi kesalahan: ${e.toString()}',
      );
    }
  }

  // Register
  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      );

      final data = json.decode(response.body);
      final authResponse = AuthResponse.fromJson(data);

      if (response.statusCode == 201 && authResponse.success) {
        // Save token
        if (authResponse.token != null) {
          await _saveToken(authResponse.token!);
        }
        
        // Save user data
        if (authResponse.user != null) {
          await _saveUserData(authResponse.user!);
        }
      }

      return authResponse;
    } catch (e) {
      return AuthResponse(
        success: false,
        message: 'Terjadi kesalahan: ${e.toString()}',
      );
    }
  }

  // Forgot Password
  Future<AuthResponse> forgotPassword(String email) async {
    if (_mockForgotPassword) {
      await Future.delayed(const Duration(milliseconds: 600));
      return AuthResponse(
        success: true,
        message: 'Kode OTP terkirim ke $email (Dev: gunakan 1234)',
      );
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      final data = json.decode(response.body);
      return AuthResponse.fromJson(data);
    } catch (e) {
      return AuthResponse(
        success: false,
        message: 'Terjadi kesalahan: ${e.toString()}',
      );
    }
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Get current user
  Future<UserModel?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');
      
      if (userJson != null) {
        return UserModel.fromJson(json.decode(userJson));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
  }

  // Get token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Development: Save dummy token and user data for testing
  Future<void> saveDummyToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', 'dummy_token_for_development');
    
    // Save dummy user data
    final dummyUser = {
      'id': '1',
      'name': 'tupex',
      'email': 'tupexx@mail.com',
      'phone': '081234567890',
    };
    await prefs.setString('user', json.encode(dummyUser));
  }

  // Private methods
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(userData));
  }
}
