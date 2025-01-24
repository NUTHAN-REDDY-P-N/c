import 'dart:async';

import 'package:commcart/components/bottombar.dart';
import 'package:commcart/firestore/provider.dart';
import 'package:commcart/offers/coupons.dart';
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
    final List<Color> cardColors = [
      const Color.fromARGB(50, 244, 67, 54),
      const Color.fromARGB(50, 33, 149, 243),
      const Color.fromARGB(50, 76, 175, 79),
      const Color.fromARGB(50, 255, 153, 0),
      const Color.fromARGB(50, 155, 39, 176),
      const Color.fromARGB(50, 0, 187, 212),
    ];
    print('calling provider again');
    final productsProvider = Provider.of<ProductsProvider>(context);

    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: CustomNavBarCurved(),
            body:
                Consumer<ProductsProvider>(builder: (context, provider, child) {
              {
                if (productsProvider.isLoading == true) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 150.0, // Height when expanded
                        pinned:
                            true, // Keeps the app bar visible when collapsed
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        collapsedHeight: 80,

                        // Add search bar inside title
                        flexibleSpace: FlexibleSpaceBar(
                          expandedTitleScale: 1,
                          title: _buildSearchBar(),
                          centerTitle: true,
                          background: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color.fromARGB(255, 67, 111, 242),
                                  const Color.fromARGB(92, 255, 255, 255)
                                ], // Define gradient colors
                                begin: Alignment
                                    .topLeft, // Start position of the gradient
                                end: Alignment
                                    .bottomLeft, // End position of the gradient
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Scrollable content
                      SliverToBoxAdapter(
                          child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: PageView.builder(
                                controller:
                                    PageController(initialPage: pageview()),
                                physics: ScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return banners();
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 0, 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Shop by category',
                                style: TextStyle(
                                    color: const Color.fromARGB(206, 0, 0, 0),
                                    fontSize: 25),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.14,
                            width: MediaQuery.of(context).size.width * 0.99,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Card(
                                    child: Column(
                                  children: [
                                    Center(
                                      child: Container(
                                        color: const Color.fromARGB(
                                            255, 199, 201, 202),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.13,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                      ),
                                    ),
                                  ],
                                ));
                              },
                              itemCount: 5,
                            ),
                          )
                        ],
                      ))
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
        padding: EdgeInsets.fromLTRB(15, 0, 25, 0),
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

int pageview() {
  int pageView = 0;
  if (pageView != 4) {
    Timer.periodic(Duration(seconds: 3), (timer) {
      pageView = pageView + 1;
    });
  } else {
    pageView = 4;
  }
  return pageView;
}
