import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  Map<String, List<Map<String, dynamic>>> _items = {};
  bool _isLoading = false;

  Map<String, List<Map<String, dynamic>>> get Items => _items;
  bool get isLoading => _isLoading;

  void fetchItems() {
    _isLoading = true;
    notifyListeners();

    FirebaseFirestore.instance
        .collection('products')
        .snapshots() // Listen for real-time updates
        .listen((querySnapshot) {
      _items = {}; // Clear existing items

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        print('hi $data');
        if (data.containsKey('T-shirts')) {
          _items['T-shirts'] =
              List<Map<String, dynamic>>.from(data['T-shirts']);
        }
      }

      _isLoading = false;
      notifyListeners(); // Notify UI of changes
    }, onError: (error) {
      _isLoading = false;
      notifyListeners();
      print("Error fetching items: $error");
    });
  }
}
