import 'package:flutter/material.dart';

class banners extends StatefulWidget {
  const banners({super.key});

  @override
  State<banners> createState() => _bannersState();
}

class _bannersState extends State<banners> {
  List x = [1, 2, 3, 4];
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 3,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          height: MediaQuery.of(context).size.height * 0.23,
          width: MediaQuery.of(context).size.width,
          child: Image.network(
            'https://static.vecteezy.com/system/resources/previews/024/843/427/non_2x/pretty-good-at-drinking-beer-typography-t-shirt-design-perfect-for-print-items-and-bags-poster-sticker-mug-template-banner-handwritten-illustration-isolated-on-black-background-vector.jpg',
            fit: BoxFit.contain,
          )),
    );
  }
}
