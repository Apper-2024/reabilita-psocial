import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() {
    return _instance;
  }

  SupabaseService._internal();

  Future<void> initSupabase() async {
    await Supabase.initialize(
      url: 'https://fylieakxxdwkwsuomlln.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ5bGllYWt4eGR3a3dzdW9tbGxuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI1NjU2NjYsImV4cCI6MjA0ODE0MTY2Nn0.Z7nPqzM6nF25_1sMJcxqDRMZ8GHIHlme2bBSMdJidwk',
    );
  }

  SupabaseClient get client => Supabase.instance.client;
}
