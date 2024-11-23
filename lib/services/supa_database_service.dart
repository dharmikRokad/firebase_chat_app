import 'package:supabase_flutter/supabase_flutter.dart';

class SupaDataBaseService {
  SupaDataBaseService._();

  static final SupaDataBaseService _instance = SupaDataBaseService._();

  factory SupaDataBaseService() => _instance;

  final _usersTable = Supabase.instance.client.from('users');

  Future<void> updateProfile({
    required String uid,
    required String email,
    Map<String, dynamic> data = const {},
  }) async {
    return await _usersTable.insert({
      'id': uid,
      'email': email,
      ...data,
    });
  }

  Future<bool> isUserOnBoarded({required String uid}) async {
    final doc = await _usersTable.select().eq('id', uid).single();
    return doc.isNotEmpty;
  }

  Stream<List<Map<String, dynamic>>> getUsers() {
    return _usersTable.asStream().map((snapshot) {
      return snapshot.docs.map((e) => e.data()).toList();
    });
  }
}
