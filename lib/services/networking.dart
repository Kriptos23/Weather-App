import 'dart:convert';
import 'package:http/http.dart';

class Networking{
  String url;

  Networking(this.url);

  Future<dynamic> getData() async{
    Response response = await get(Uri.parse(url));//get a data from the link
    // as a json or xml
    String data = response.body;//main body part of the response
    // print(response.statusCode);
    var decodedData = jsonDecode(data);//convert Json data to String
    print(decodedData['main']);
    return decodedData;
  }
  }