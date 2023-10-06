import 'dart:math';

import 'package:flutter/material.dart';

class Add_screen extends StatefulWidget {
  const Add_screen({super.key});

  @override
  State<Add_screen> createState() => _Add_screenState();
}

class _Add_screenState extends State<Add_screen> {
  String? selectedItem;
  FocusNode ex = FocusNode();
  FocusNode amount = FocusNode();
  final List<String> _item = [
    "food",
    "transfer",
    "transportation",
    "Education"
  ];
  final TextEditingController explain_C = TextEditingController();
  final TextEditingController amount_C = TextEditingController();
  @override
  void initState() {
    super.initState();
    ex.addListener(() {
      setState(() {});
    });
    amount.addListener(() {
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
          child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          background(context),
          Positioned(top: 120, child: main_container())
        ],
      )),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

  Column background(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: BoxDecoration(
              color: Colors.teal[700],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Column(children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                  Text(
                    'Adding',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Icon(
                    Icons.attach_file_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            )
          ]),
        )
      ],
    );
  }

  Container main_container() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          height: 550,
          width: 340,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              name(),
              SizedBox(
                height: 30,
              ),
              explain(),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                    controller: explain_C,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        labelText: 'explain',
                        labelStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.grey.shade500,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 209, 218, 223))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 209, 218, 223))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                width: 2,
                                color:
                                    const Color.fromARGB(255, 46, 186, 172))))),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding explain() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
          controller: explain_C,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              labelText: 'explain',
              labelStyle: TextStyle(
                fontSize: 17,
                color: Colors.grey.shade500,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      width: 2, color: Color.fromARGB(255, 209, 218, 223))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      width: 2, color: Color.fromARGB(255, 209, 218, 223))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      width: 2,
                      color: const Color.fromARGB(255, 46, 186, 172))))),
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: Color.fromARGB(255, 209, 218, 223),
            )),
        width: 300,
        child: DropdownButton<String>(
          value: selectedItem,
          items: _item
              .map((e) => DropdownMenuItem(
                    child: Container(
                        width: 40,
                        child: Row(children: [
                          Image.asset('assets/images/${e}.jpeg'),
                          SizedBox(width: 10),
                          Text(
                            e,
                            style: TextStyle(fontSize: 18),
                          ),
                        ])),
                    value: e,
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => _item
              .map((e) => Row(
                    children: [
                      Container(
                        width: 42,
                        child: Image.asset('assets/images/${e}.jpeg'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(e),
                    ],
                  ))
              .toList(),
          onChanged: ((value) {
            setState(() {
              selectedItem = value!;
            });
          }),
          hint: Text(
            'Name',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          dropdownColor: Colors.white,
          underline: Container(),
          isExpanded: true,
        ),
      ),
    );
  }
}