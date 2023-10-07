import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List cat = ['income', 'expense'];
  int? index_color = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Category',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(4, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          index_color = index;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index_color == index
                                ? Colors.teal[600]
                                : Colors.white),
                        alignment: Alignment.center,
                        child: Text(
                          cat[index],
                          style: TextStyle(
                              color: index_color == index
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.teal),
                width: 120,
                height: 50,
                child: Text(
                  'Save',
                  style: TextStyle(
                      fontFamily: 'f',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 17),
                ),
              ),
            )
          ],
        ),
      ),
    ); // TODO: implement build
    throw UnimplementedError();
  }
}
