// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:flutter_app/model/group_response.g.dart';
import 'package:flutter_app/model/login_response.g.dart';
import 'package:flutter_app/model/user_info_response.dart';
import 'package:flutter_app/net/address.dart';
import 'package:flutter_app/net/api.dart';
import 'package:flutter_app/utils/md5.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

import 'data_result.dart';

class IndexDao {
  // ignore: non_constant_identifier_names
  static IsManage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("manage");
  }

  static setManage(bool manage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("manage", manage);
  }

  // ignore: non_constant_identifier_names
  static IsLoginDao() async {
    String url = Address.getIsLogin();
    var res = await HttpManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = UserInfoResponse.fromJson(data);
      if (response.data == null) {
        return new DataResult(false, true);
      } else {
        setManage(response.data!.organizeManage! == 1);

        JPush jpush = new JPush();
        jpush.getRegistrationID().then((value) async => {
              await HttpManager.netFetch(
                  Address.getRegistration(value, [
                    "u" + response.data!.id.toString(),
                    "o" + response.data!.organizeId.toString()
                  ]),
                  null,
                  null,
                  null)
            });

        return new DataResult(true, true);
      }
    } else {
      return new DataResult(null, false);
    }
  }

  static getGroup() async {
    String url = Address.getGroup();
    var res = await HttpManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = GroupResponse.fromJson(data);
      return new DataResult(response.data, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static getUserInfoDao() async {
    String url = Address.getUserInfo();

    var res = await HttpManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = UserInfoResponse.fromJson(data);
      return new DataResult(response.data, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static getLoginDao(String username, String password) async {
    String url = Address.getLogin();

    FormData params = FormData.fromMap({
      "username": username,
      "password": generate_MD5(password),
    });

    Options option = new Options(method: 'post');
    var res = await HttpManager.netFetch(url, params, null, option);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = LoginResponse.fromJson(data);
      return new DataResult(response, true);
    } else {
      return new DataResult(null, false);
    }
  }
}
