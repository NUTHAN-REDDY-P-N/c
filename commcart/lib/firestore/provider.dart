import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  Map<String, List<Map<String, dynamic>>> _allItems =
      {}; // Holds all categories and their items
  bool _isLoading = false;

  Map<String, List<Map<String, dynamic>>> get allItems => _allItems;
  bool get isLoading => _isLoading;

  /// Fetch all categories and their items.
  void fetchAllCategories() {
    _isLoading = true;
    notifyListeners();

    _allItems = {}; // Clear existing items

    // Fetch category names dynamically
    FirebaseFirestore.instance
        .collection('commcart') // Main collection
        .doc('IIT MADRAS') // Document for IIT MADRAS
        .collection('products') // Sub-collection "products"
        .get()
        .then((categorySnapshot) {
      // Iterate through each category document to get the category names
      List<String> categoryNames = categorySnapshot.docs
          .map((doc) => doc.id) // Extract category names (doc IDs)
          .toList();

      // Now fetch items for each category
      Future.wait(categoryNames.map((categoryName) {
        return FirebaseFirestore.instance
            .collection('commcart') // Main collection
            .doc('IIT MADRAS') // Document for IIT MADRAS
            .collection('products') // Sub-collection "products"
            .doc(categoryName) // Dynamic category name
            .collection('items') // Final sub-collection "items"
            .get()
            .then((querySnapshot) {
          // Add items for this category
          _allItems[categoryName] = querySnapshot.docs.map((doc) {
            final data = doc.data();
            print(' $data'); // Debug log
            return data as Map<String, dynamic>;
          }).toList();

          notifyListeners(); // Notify UI after updating each category
        }).catchError((error) {
          print("Error fetching items for category $categoryName: $error");
        });
      })).then((_) {
        // Once all category data is fetched, set loading to false
        _isLoading = false;
        notifyListeners();
      }).catchError((error) {
        // Handle any errors in fetching categories or items
        print("Error fetching categories: $error");
        _isLoading = false;
        notifyListeners();
      });
    }).catchError((error) {
      print("Error fetching category names: $error");
      _isLoading = false;
      notifyListeners();
    });
  }
}
