import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

import 'package:afk_admin/models/search_result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../utils/util.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

import 'korisnik_provider.dart';

abstract class BaseProvider<T> with ChangeNotifier{
  static String? _baseUrl;
  String _endpoint="";
  // late KorisnikProvider _korisniciProvider;


  BaseProvider(String endpoint){
    _endpoint=endpoint;
    _baseUrl=const String.fromEnvironment("baseUrl",defaultValue: "https://localhost:7181/");

  }

  Future<SearchResult<T>>get({dynamic filter})async{
    var fullAPI="$_baseUrl$_endpoint";

    if(filter!=null)
    {
      var queryString=getQueryString(filter);
      fullAPI="$fullAPI?$queryString";
    }
    var uriFullApi=Uri.parse(fullAPI);
    var headerz=createHeaders();

    var response = await http.get(uriFullApi, headers: headerz);

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

  Future<T> insert(dynamic request)async{
    var fullAPI="$_baseUrl$_endpoint";
    var uriFullApi=Uri.parse(fullAPI);
    var headerz=createHeaders();

    var jsonRequest=jsonEncode(request);

    var response=await http.post(uriFullApi, headers: headerz, body: jsonRequest);
    if(IsValidResponse(response))
        {
          var data=jsonDecode(response.body);
          return fromJson(data);
        }
        else {
          throw Exception("Unknown error.");
        }
  }

  Future<T> update(int id, [dynamic request])async{
    var fullAPI="$_baseUrl$_endpoint/$id";
    var uriFullApi=Uri.parse(fullAPI);
    var headerz=createHeaders();

    var jsonRequest=jsonEncode(request);

    var response=await http.put(uriFullApi, headers: headerz, body: jsonRequest);
    if(IsValidResponse(response)==true)
        {
          var data=jsonDecode(response.body);
          return fromJson(data);
        }
        else {
          throw Exception("Unknown error.");
        }
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
    else if(response.statusCode==403)
    {
      throw Exception("You do not have permissions");
    }
    else
    {
      throw Exception("Something happened. Try again" + response.statusCode.toString());
    }
  // return true;R
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
