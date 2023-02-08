import 'package:crud_api/RestAPI/rest_client.dart';
import 'package:crud_api/Screen/productGridViewScreen.dart';
import 'package:crud_api/Style/style.dart';
import 'package:flutter/material.dart';

class ProductUpdateScreen extends StatefulWidget {
  final Map productItem;

  const ProductUpdateScreen(this.productItem);

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  Map<String, String> FormValues = {
    "Img": "",
    "ProductCode": "",
    "ProductName": "",
    "Qty": "",
    "TotalPrice": "",
    "UnitPrice": ""
  };

  bool isLoading = false;

  @override
  void initState() {
    setState(() {
      FormValues.update("Img", (value) => widget.productItem['Img'] ?? '');
      FormValues.update(
          "ProductCode", (value) => widget.productItem['ProductCode'] ?? '');
      FormValues.update(
          "ProductName", (value) => widget.productItem['ProductName'] ?? '');
      FormValues.update("Qty", (value) => widget.productItem['Qty'] ?? '');
      FormValues.update(
          "TotalPrice", (value) => widget.productItem['TotalPrice'] ?? '');
      FormValues.update(
          "UnitPrice", (value) => widget.productItem['UnitPrice'] ?? '');
    });
  }

  InputOnChange(key, textValue) {
    setState(() {
      FormValues.update(key, (value) => textValue);
    });
  }

  FormOnSubmit() async {
    if (FormValues['Img']!.length == 0) {
      ErrorToast('Image Link Required!');
    } else if (FormValues['ProductCode']!.length == 0) {
      ErrorToast('ProductCode Required!');
    } else if (FormValues['ProductName']!.length == 0) {
      ErrorToast('ProductName Required!');
    } else if (FormValues['Qty']!.length == 0) {
      ErrorToast('Qty Required!');
    } else if (FormValues['TotalPrice']!.length == 0) {
      ErrorToast('TotalPrice Required!');
    } else if (FormValues['UnitPrice']!.length == 0) {
      ErrorToast('UnitPrice Required!');
    } else {
      setState(() {
        isLoading = true;
      });
      await ProductUpdateRequest(FormValues, widget.productItem['_id']);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ProductGridViewScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product"),
      ),
      body: Stack(
        children: [
          ScreenBackground(),
          Container(
            child: (SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    decoration: AppInputDecoration('Product Name'),
                    initialValue: FormValues['ProductName'],
                    onChanged: (value) {
                      InputOnChange("ProductName", value);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: FormValues['ProductCode'],
                    decoration: AppInputDecoration('Product Code'),
                    onChanged: (value) {
                      InputOnChange("ProductCode", value);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: FormValues['Img'],
                    decoration: AppInputDecoration('Product Image'),
                    onChanged: (value) {
                      InputOnChange("Img", value);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: FormValues['UnitPrice'],
                    decoration: AppInputDecoration('Product Unit Price'),
                    onChanged: (value) {
                      InputOnChange("UnitPrice", value);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: FormValues['TotalPrice'],
                    decoration: AppInputDecoration('Product Total Price'),
                    onChanged: (value) {
                      InputOnChange("TotalPrice", value);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AppDecoratedBox(DropdownButton(
                    value: FormValues['Qty'],
                    items: [
                      DropdownMenuItem(
                        child: Text('Select Qt'),
                        value: '',
                      ),
                      DropdownMenuItem(
                        child: Text('1 Pcs'),
                        value: '1',
                      ),
                      DropdownMenuItem(
                        child: Text('2 Pcs'),
                        value: '2',
                      ),
                      DropdownMenuItem(
                        child: Text('3 Pcs'),
                        value: '3',
                      ),
                      DropdownMenuItem(
                        child: Text('4 Pcs'),
                        value: '4',
                      ),
                    ],
                    onChanged: (value) {
                      InputOnChange("Qty", value);
                    },
                    underline: Container(),
                    isExpanded: true,
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Visibility(
                      replacement: Center(
                        child: CircularProgressIndicator(),
                      ),
                      visible: isLoading == false,
                      child: ElevatedButton(
                          style: AppButtonStyle(),
                          onPressed: () {
                            FormOnSubmit();
                          },
                          child: SuccessButtonChild('Submit')),
                    ),
                  )
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}
