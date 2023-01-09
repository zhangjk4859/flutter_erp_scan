import 'dart:collection';
import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cookie_jar/cookie_jar.dart';
// ignore: import_of_legacy_library_into_null_safe

// ignore: import_of_legacy_library_into_null_safe
import 'package:connectivity/connectivity.dart';
import 'package:flutter_app/config/config.dart';
import 'package:flutter_app/net/result.dart';
import 'package:path_provider/path_provider.dart';

import 'code.dart';

//http请求
class HttpManager {
  static const CONTENT_TYPE_JSON = 'application/json';
  static const CONTENT_TYPE_FORM = 'application/x-www-form-urlencoded';

  static Map optionParams = {
    'timeoutMs': 15000,
  };

  static netFetch(url, params, Map<String, String>? header, Options? option,
      {noTip = false}) async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return new Result(Code.errorHandleFunction(Code.NETWORK_ERROR, "", noTip),
          false, Code.NETWORK_ERROR);
    }
    Map<String, String> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }
    headers["X-Requested-With"] = "XMLHttpRequest";

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: 'get');
      option.headers = headers;
    }

    Dio dio = new Dio();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    dio.interceptors.add(
        CookieManager(PersistCookieJar(dir: "${appDocDir.path}/.cookies")));

    Response response;
    try {
      response = await dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      if (Config.DEBUG) {
        print('请求异常：' + e.toString());
        print('请求异常url:' + url);
      }
      return new Result(
          Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip),
          false,
          errorResponse.statusCode);
    }
    if (Config.DEBUG) {
      print('请求url:' + url);
      print('请求头' + option.headers.toString());
      if (params != null) {
        print('请求参数：' + params.toString());
      }
      if (response != null) {
        //print('返回参数' + response.toString());
      }
    }
    try {
      if (option.contentType != null && option.contentType == 'text') {
        print('返回参数' + response.data.toString());
        return new Result(response.data, true, Code.SUCCESS);
      } else {
        if (response.statusCode == 200 || response.statusCode == 201) {
          print('返回参数' + response.data.toString());
          return new Result(response.data, true, Code.SUCCESS,
              headers: response.headers);
        }
      }
    } catch (e) {
      print('返回参数' + e.toString() + url);
      return new Result(response.data, false, response.statusCode,
          headers: response.headers);
    }
    return new Result(Code.errorHandleFunction(response.statusCode, "", noTip),
        false, response.statusCode);
  }
}
