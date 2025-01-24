import 'package:commcart/components/bottombar.dart';
import 'package:flutter/material.dart';

class items extends StatefulWidget {
  const items({super.key});

  @override
  State<items> createState() => _itemsState();
}

class _itemsState extends State<items> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavBarCurved(selectedIndex: 1),
      appBar: AppBar(
        title: Text(
          'All categories',
          style: TextStyle(
              color: const Color.fromARGB(255, 73, 73, 73),
              fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.local_grocery_store_outlined))
        ],
      ),
      body: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    color: const Color.fromARGB(255, 181, 189, 194),
                    height: MediaQuery.of(context).size.width * 0.25,
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                );
              },
              itemCount: 10,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two columns
                  mainAxisSpacing: 2.0, // Vertical spacing
                  crossAxisSpacing: 2.0, // Horizontal spacing
                  childAspectRatio: 3 / 4, // Width to height ratio
                ),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      color: const Color.fromARGB(255, 181, 189, 194),
                      height: MediaQuery.of(context).size.width * 0.33,
                      width: MediaQuery.of(context).size.width * 0.33,
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
