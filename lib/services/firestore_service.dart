import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();

  static final FirestoreService _instance = FirestoreService._();

  factory FirestoreService() => _instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUSer({
    required String uid,
    required String email,
    Map<String, dynamic> data = const {},
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'email': email,
      ...data,
    });
  }

  Future<bool> isUserOnBoarded({required String uid}) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.exists;
  }

  Stream<List<Map<String, dynamic>>> getUsers() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((e) => e.data()).toList();
    });
  }
}
