import 'package:commcart/firestore/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInit = true; // To avoid multiple calls

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      productsProvider.fetchItems(); // Fetch data only once
      _isInit = false;
    }
  }

  Widget build(BuildContext context) {
    print('calling provider again');
    final productsProvider = Provider.of<ProductsProvider>(context);

    return SafeArea(child: Scaffold(
        body: Consumer<ProductsProvider>(builder: (context, provider, child) {
      {
        if (productsProvider.isLoading == true) {
          return Center(child: CircularProgressIndicator());
        } else {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 130.0, // Height when expanded
                pinned: true, // Keeps the app bar visible when collapsed
                backgroundColor: Colors.blue,

                // Add search bar inside title
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1,
                  title: _buildSearchBar(),
                  centerTitle: true,
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue,
                          const Color.fromARGB(0, 254, 254, 254)
                        ], // Define gradient colors
                        begin:
                            Alignment.topLeft, // Start position of the gradient
                        end: Alignment
                            .bottomCenter, // End position of the gradient
                      ),
                    ),
                  ),
                ),
              ),
              // Scrollable content
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  print(productsProvider.Items);
                  final item = productsProvider.Items['T-shirts']?[0];

                  return ListTile(
                    title: Text(item?['name']),
                  );
                }, childCount: 1 // Number of items in the list
                    ),
              ),
            ],
          );
        }
      }
    })));
  }

  // Search Bar Widget to be placed in the title
  Widget _buildSearchBar() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.fromLTRB(60, 0, 10, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: TextField(
            decoration: InputDecoration(
                fillColor: const Color.fromARGB(255, 226, 223, 223),
                filled: true,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                prefixIcon: Icon(Icons.search),
                hintText: 'search commcart'),
          ),
        ));
  }
}
