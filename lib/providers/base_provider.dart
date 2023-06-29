import 'dart:async';
import 'dart:convert';


import 'package:afk_admin/models/search_result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../utils/util.dart';

abstract class BaseProvider<T> with ChangeNotifier{
  static String? _baseUrl;
  String _endpoint="";

  BaseProvider(String endpoint){
    _endpoint=endpoint;
    _baseUrl=const String.fromEnvironment("baseUrl",defaultValue: "http://localhost:7048/");

  }

  Future<SearchResult<T>>get({dynamic filter})async{
    var fullAPI="$_baseUrl$_endpoint";

    if(filter!=null)
    {
      var queryString=getQueryString(filter);
      fullAPI="$fullAPI?$queryString";
    }
    var uriFullApi=Uri.parse(fullAPI);
    var headers=createHeaders();

    var response = await http.get(uriFullApi, headers: headers);

    if(IsValidResponse(response))
    {
      var data=jsonDecode(response.body);

      var result = SearchResult<T>();
      result.count=data['count'];
      
      for(var item in data['result'])
      {
        
        result.result.add(fromJson(item));

      }

      return result;
    }
    else {
      throw Exception("Unknown error.");
    }

    // print("response: ${response.statusCode}, ${response.body}");
    

  }

  T fromJson(data)
  {
    throw Exception("Method not implemented");
  }

bool IsValidResponse(Response response){
  if(response.statusCode<299) {
    return true;
  } else if(response.statusCode==401)
    {
      throw Exception("Unauthorized");
    }
    else
    {
      throw Exception("Something happened. Try again");
    }
}


  Map<String,String>createHeaders(){
    String username=Authorization.username??"";
    String password=Authorization.password??"";

    print("passed creds: $username, $password");

    String basicAuth="Basic ${base64Encode(utf8.encode('$username:$password'))}";
    
    var headers={
      "Content-Type":"application/json",
      "Authorization":basicAuth
    };

    return headers;
  }

  
}

String getQueryString(Map params,
    {String prefix= '&', bool inRecursion= false}) {
  String query = '';

  params.forEach((key, value) {
    if (inRecursion) {
      key = Uri.encodeComponent('[$key]');
    }

    if (value is String || value is int || value is double || value is bool) {
      query += '$prefix$key=${Uri.encodeComponent(value.toString())}';
    } else if (value is List || value is Map) {
      if (value is List) value = value.asMap();
      value.forEach((k, v) {
        query +=
            getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
      });
    }
  });

  return inRecursion || query.isEmpty
      ? query
      : query.substring(1, query.length);
}
