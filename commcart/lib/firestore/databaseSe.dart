import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch the entire document as a Map with null safety
  Stream<Map<String, dynamic>> readDatabase() {
    return _firestore
        .collection('products')
        .doc('products')
        .snapshots()
        .map((snapshot) {
      // Ensure snapshot.data() is not null and return an empty map as a fallback
      return snapshot.data() ?? {};
    });
  }
}
