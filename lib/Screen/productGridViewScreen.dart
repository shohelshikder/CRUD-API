import 'dart:io';

import 'package:crud_api/RestAPI/rest_client.dart';
import 'package:crud_api/Screen/product_create_screen.dart';
import 'package:crud_api/Screen/product_update_screen.dart';
import 'package:crud_api/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ProductGridViewScreen extends StatefulWidget {
  const ProductGridViewScreen({Key? key}) : super(key: key);

  @override
  State<ProductGridViewScreen> createState() => _ProductGridViewScreenState();
}

class _ProductGridViewScreenState extends State<ProductGridViewScreen> {
  List ProductList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      InternetCheck();
    });
  }

  InternetCheck() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      CallData();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Internet !"),
              content: Text("Please check internet Connection"),
              actions: [
                OutlinedButton(
                    onPressed: () async {
                      exit(0);
                    },
                    child: Text("Yes")),
              ],
            );
          });
    }
  }

  CallData() async {
    isLoading = true;
    var data = await ProductGridViewListRequest();
    setState(() {
      ProductList = data;
      isLoading = false;
    });
  }

  DeleteItem(id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete !"),
            actions: [
              OutlinedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() {
                      isLoading = true;
                    });
                    await ProductDeleteRequest(id);
                    CallData();
                  },
                  child: Text("Yes")),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No"))
            ],
          );
        });
  }

  GoToUpdate(context, productItem) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductUpdateScreen(productItem)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      body: Stack(
        children: [
          ScreenBackground(),
          Container(
            child: Visibility(
              replacement: Center(
                child: CircularProgressIndicator(),
              ),
              visible: isLoading == false,
              child: RefreshIndicator(
                onRefresh: () async {
                  await CallData();
                },
                child: GridView.builder(
                    gridDelegate: ProductGridViewStyle(),
                    itemCount: ProductList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                                child: Image.network(
                              ProductList[index]['Img'].toString(),
                              fit: BoxFit.fill,
                            )),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(ProductList[index]['ProductName']
                                      .toString()),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text("Price: " +
                                      ProductList[index]['UnitPrice']
                                          .toString() +
                                      " BDT"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OutlinedButton(
                                          onPressed: () {
                                            GoToUpdate(
                                                context, ProductList[index]);
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            size: 18,
                                            color: colorGreen,
                                          )),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      OutlinedButton(
                                          onPressed: () {
                                            DeleteItem(ProductList[index]['_id']
                                                .toString());
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            size: 18,
                                            color: colorRed,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProductCreateScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
