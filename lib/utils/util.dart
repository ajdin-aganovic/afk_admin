
import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class Authorization{
  static String? username;
  static String? password;
  String ConvertToHash(String password)
  {
    return password;
  }  
    String generateSalt() {
      final random = Random.secure();
      final List<int> saltBytes = List<int>.generate(16, (_) => random.nextInt(256));
      return base64Encode(saltBytes);
      }
                            
    String generateHash(String password, String salt) {
    // final salt=generateSalt();
    final src = base64.decode(salt);
    final bytes = utf8.encode(password);
    final dst = Uint8List(src.length + bytes.length);

    dst.setAll(0, src);
    dst.setAll(src.length, bytes);

    final algorithm = sha1;
    final inArray = algorithm.convert(dst).bytes;
    return base64.encode(inArray);
  }

  
}
