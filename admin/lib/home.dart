import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List<String> categories = [];
  String selectedCategory = '';

  Uint8List? _selectedImage;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      final Uint8List imageData = await imageFile.readAsBytes();
      setState(() {
        _selectedImage = imageData;
      });
    }
  }

  Future<void> uploadImage(String productId, String category) async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select an image before uploading')),
      );
      return;
    }

    try {
      final fileName = '$productId-$category';
      ;
      final path = 'images/$fileName';
      await Supabase.instance.client.storage.from('images').uploadBinary(
          path, _selectedImage!,
          fileOptions: FileOptions(contentType: 'image/png'));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image uploaded successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('commcart')
          .doc('IIT MADRAS')
          .collection('products')
          .get();

      setState(() {
        categories = snapshot.docs.map((doc) => doc.id).toList();
        if (categories.isNotEmpty) {
          selectedCategory = categories.first;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching categories: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _showPopup(context);
              },
              child: const Text('Add Product'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                _showPopup(context);
              },
              child: const Text('Update Product'),
            ),
          ],
        ),
      ),
    );
  }

  void _showPopup(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String productName = '';
    String productId = '';
    double price = 0.0;
    String color = '';
    int stock = 0;
    bool isLoading = false;
    const String collegeName = 'IIT MADRAS';

    Future<void> fetchLastProductId() async {
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('commcart')
            .doc(collegeName)
            .collection('products')
            .doc(selectedCategory)
            .collection('items')
            .orderBy('createdAt', descending: true)
            .limit(1)
            .get();

        if (snapshot.docs.isNotEmpty) {
          String lastProductId = snapshot.docs.first.id;
          int lastNumericId = int.tryParse(lastProductId) ?? 0;
          productId = (lastNumericId + 1).toString().padLeft(5, '0');
        } else {
          productId = '00001';
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching last product ID: $e')),
        );
      }
    }

    Future<void> addProduct() async {
      if (!_formKey.currentState!.validate()) return;
      _formKey.currentState!.save();

      setState(() {
        isLoading = true;
      });

      try {
        await FirebaseFirestore.instance
            .collection('commcart')
            .doc(collegeName)
            .collection('products')
            .doc(selectedCategory)
            .collection('items')
            .doc(productId)
            .set({
          'color': color,
          'currentPrice': price,
          'college': collegeName,
          'name': productName,
          'category': selectedCategory,
          'price': price,
          'stock': stock,
          'discountPercentage': 0,
          'createdAt': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product added with ID: $productId')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Product'),
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Product Name'),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter a product name'
                            : null,
                        onSaved: (value) => productName = value!,
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: selectedCategory.isNotEmpty
                            ? selectedCategory
                            : null,
                        decoration:
                            const InputDecoration(labelText: 'Select Category'),
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCategory = newValue!;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {});
                          pickImage();
                          setState(() {});
                        },
                        child: const Text('Pick Image'),
                      ),
                      _selectedImage != null
                          ? Image.memory(_selectedImage!)
                          : const Text('No image selected'),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Price'),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter a price' : null,
                        onSaved: (value) => price = double.parse(value!),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Stock Quantity'),
                        keyboardType: TextInputType.number,
                        validator: (value) => value!.isEmpty
                            ? 'Please enter the stock quantity'
                            : null,
                        onSaved: (value) => stock = int.parse(value!),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Color'),
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter the color' : null,
                        onSaved: (value) => color = value!,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await fetchLastProductId();
                          addProduct();
                          uploadImage(productId, selectedCategory);
                        },
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
