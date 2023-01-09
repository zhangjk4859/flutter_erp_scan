import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:convert/convert.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:crypto/crypto.dart';

String generate_MD5(String data) {
  var content = new Utf8Encoder().convert(data);
  var digest = md5.convert(content);
  // 这里其实就是 digest.toString()
  return hex.encode(digest.bytes);
}
