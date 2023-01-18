import 'package:http/http.dart' as http;
import 'dart:convert';

const String ipAddress = "http://192.168.100.16:8081";

// GET
Future<http.Response> getData() async {
  String url = "$ipAddress/api/product/getProduct";
  Uri uri = Uri.parse(url);
  var result = await http.get(uri);
  print(result.body);
  if (result.statusCode == 200) {
    return result;
  } else {
    throw Exception("Failed To Get Method");
  }
}

// POST
Future<http.Response> postData(data) async {
  String url = "$ipAddress/api/product/insert";
  Uri uri = Uri.parse(url);

  var result = await http.post(uri,
      headers: <String, String>{'Content-type': 'application/json'},
      body: json.encode(data));

  print(result.body);
  print("Post Berhasil!");
  print("Kode : ${result.statusCode}");
  return result;
}

// UPDATE
Future<http.Response> updateData(id, data) async {
  String url = "$ipAddress/api/product/update/$id";
  Uri uri = Uri.parse(url);

  var result = await http.put(
    uri,
    body: json.encode(data),
    headers: <String, String>{'Content-type': 'application/json'},
  );

  print(result.body);
  print("Update Berhasil!");
  print("Kode : ${result.statusCode}");
  return result;
}

// DELETE
Future<http.Response> deleteData(id) async {
  String url = "$ipAddress/api/product/delete/$id";
  Uri uri = Uri.parse(url);

  var result = await http.delete(
    uri,
    headers: <String, String>{'Content-type': 'application/json'},
  );
  // print(result.body);
  print("Delete Berhasil!");
  print("Kode : ${result.statusCode}");
  return result;
}
