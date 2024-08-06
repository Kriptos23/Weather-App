import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Networking{
  String url;

  Networking(this.url);

  Future getData() async{
    Response response = await get(Uri.parse(url));
    String data = response.body;
    print(response.statusCode);

    var decodedData = jsonDecode(data);
    return decodedData;
  }
  }