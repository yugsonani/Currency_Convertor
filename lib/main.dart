import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'helper/api_helper.dart';
import 'models/castam.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => myapp(),
    },
  ));
}

class myapp extends StatefulWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  String dropdownvalue = 'INR';
  dynamic dropdownvalue1 = 'INR';
  dynamic amount = 0;
  double converteramount = 0;
  dynamic total = 0;
  var items = [
    'INR',
  ];
  var items1 = [
    'INR',
    'CDF',
    'USD',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency converter app",),
        centerTitle: true,
        backgroundColor: Colors.black,

      ),
      body: FutureBuilder(
        future: API.api.fetchCurrency(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            Currency? data = snapshot.data;

            return (data != null)
                ? Center(
                    child: Container(
                      width: 350,
                      height: 600,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Converter currency",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                            ),
                          ),
                          Container(
                            height: 2,
                            color: Colors.black,
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              onChanged: (e) {
                                amount = int.parse(e);
                              },
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter INR Amount ',
                              ),
                            ),
                          ),
                          DropdownButton(
                            value: dropdownvalue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                          const Icon(
                            Icons.arrow_downward_outlined,
                            size: 30,
                          ),
                          DropdownButton(
                            value: dropdownvalue1,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: items1.map((items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                dropdownvalue1 = newValue;
                                if (dropdownvalue1 == "USD") {
                                  converteramount = data.USD;
                                } else if (dropdownvalue1 == 'CDF') {
                                  converteramount = data.CDF;
                                } else if (dropdownvalue1 == 'INR') {
                                  converteramount = data.INR;
                                }
                              });
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              total = converteramount * amount;
                            },
                            child: Container(
                              width: 199,
                              height: 59,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Converter",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                color:Colors.black ),
                              ),
                            ),
                          ),
                          Text(
                            "Your amount :$amount\ncurrency$dropdownvalue1:$converteramount\n\nTotal :$total",
                            style: const TextStyle(color: Colors.black, fontSize: 30),
                          )
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: Text("No Data"),
                  );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      backgroundColor:Colors.black26 ,
    );
  }
}
