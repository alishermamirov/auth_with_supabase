
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<AuthResponse> signInWithEmail(String email, String password) async {
    return await _supabaseClient.auth.signInWithPassword(
      password: password,
      email: email,
    );
  }

  Future<AuthResponse> signUpWithEmail(String email, String password) async {
    return await _supabaseClient.auth.signUp(
      password: password,
      email: email,
    );
  }

  Future<void> logOut() async {
    await _supabaseClient.auth.signOut();
  }

  String? getCurrentUserEmail() {
    final session = _supabaseClient.auth.currentSession;
    final user = session!.user;
    return user.email;
  }
}
