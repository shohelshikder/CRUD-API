import 'dart:convert';
import 'package:crud_api/Style/style.dart';
import 'package:http/http.dart' as http;

Future<bool> ProductDeleteRequest(id) async {
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/$id");
  var PostHeader = {"Content-Type": "application/json"};
  var response = await http.get(URL, headers: PostHeader);
  var responseBody = json.decode(response.body);

  if (response.statusCode == 200 && responseBody['status'] == "success") {
    SuccessToast("Request Success");
    return true;
  } else {
    SuccessToast("Request Failed try again");
    return false;
  }
}

Future<List> ProductGridViewListRequest() async {
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
  var PostHeader = {"Content-Type": "application/json"};
  var response = await http.get(URL, headers: PostHeader);
  var responseBody = json.decode(response.body);

  if (response.statusCode == 200 && responseBody['status'] == "success") {
    return responseBody['data'];
  } else {
    SuccessToast("Request Failed try again");
    return [];
  }
}

Future<bool> ProductCreateRequest(FormValues) async {
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
  var PostBody = jsonEncode(FormValues);
  var PostHeader = {"Content-Type": "application/json"};
  var response = await http.post(URL, headers: PostHeader, body: PostBody);
  var responseBody = jsonDecode(response.body);
  if (response.statusCode == 200 && responseBody['status'] == "success") {
    SuccessToast("Request Success");
    return true;
  } else {
    SuccessToast("Request Failed try again");
    return false;
  }
}

Future<bool> ProductUpdateRequest(FormValues, id) async {
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/UpdateProduct/$id");
  var PostBody = jsonEncode(FormValues);
  var PostHeader = {"Content-Type": "application/json"};
  var response = await http.post(URL, headers: PostHeader, body: PostBody);
  var responseBody = jsonDecode(response.body);
  if (response.statusCode == 200 && responseBody['status'] == "success") {
    SuccessToast("Request Success");
    return true;
  } else {
    SuccessToast("Request Failed try again");
    return false;
  }
}
