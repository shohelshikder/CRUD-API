import 'package:crud_api/RestAPI/rest_client.dart';
import 'package:crud_api/Style/style.dart';
import 'package:flutter/material.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({Key? key}) : super(key: key);

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  Map<String, String> FormValues = {
    "Img": "",
    "ProductCode": "",
    "ProductName": "",
    "Qty": "",
    "TotalPrice": "",
    "UnitPrice": ""
  };

  bool isLoading = false;

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
      await ProductCreateRequest(FormValues);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Product"),
      ),
      body: Stack(
        children: [
          ScreenBackground(),
          Container(
            child: (SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    decoration: AppInputDecoration('Product Name'),
                    onChanged: (value) {
                      InputOnChange("ProductName", value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: AppInputDecoration('Product Code'),
                    onChanged: (value) {
                      InputOnChange("ProductCode", value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: AppInputDecoration('Product Image'),
                    onChanged: (value) {
                      InputOnChange("Img", value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: AppInputDecoration('Product Unit Price'),
                    onChanged: (value) {
                      InputOnChange("UnitPrice", value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: AppInputDecoration('Product Total Price'),
                    onChanged: (value) {
                      InputOnChange("TotalPrice", value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppDecoratedBox(DropdownButton(
                    value: FormValues['Qty'],
                    items: const [
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
                  const SizedBox(
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
