// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:flutter_app/model/allocation_goods_response.g.dart';
import 'package:flutter_app/model/allocation_response.g.dart';
import 'package:flutter_app/model/public_response.g.dart';
import 'package:flutter_app/net/address.dart';
import 'package:flutter_app/net/api.dart';
import 'package:flutter_app/vo/store_params.dart';

import 'data_result.dart';

class AllocationDao {
  static getAllocationScanDao(String sn) async {
    String url = Address.getAllocationScan(sn);
    var res = await HttpManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = AllocationResponse.fromJson(data);
      return new DataResult(response.data, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static getAllocationGoodsDao(int id, int type, int page) async {
    var pageIndex = 1;
    if (page > 0) {
      pageIndex = (page / 10 + 1).toInt();
    }

    String url = Address.getAllocationGoodsScan(id, type, pageIndex);
    var res = await HttpManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = AllocationGoodsResponse.fromJson(data);
      return new DataResult(response, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static getAllocationGoodsOneScan(int id, int type, String sn) async {
    String url = Address.getAllocationGoodsOneScan(id, type, sn);
    var res = await HttpManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = AllocationGoodsOneResponse.fromJson(data);
      return new DataResult(response, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static postAllocationStoreIn(StoreGoodsParams data) async {
    String url = Address.getAllocationStoreIn();

    FormData params = FormData.fromMap({
      "id": data.id,
      "goods_sn": data.goodsSn.reduce((curr, next) => curr + "," + next),
    });

    Options option = new Options(method: 'post');
    var res = await HttpManager.netFetch(url, params, null, option);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = PublicResponse.fromJson(data);
      return new DataResult(response, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static postAllocationStoreOut(StoreGoodsParams data) async {
    String url = Address.getAllocationStoreOut();

    FormData params = FormData.fromMap({
      "id": data.id,
      "goods_sn": data.goodsSn.reduce((curr, next) => curr + "," + next),
    });

    Options option = new Options(method: 'post');
    var res = await HttpManager.netFetch(url, params, null, option);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = PublicResponse.fromJson(data);
      return new DataResult(response, true);
    } else {
      return new DataResult(null, false);
    }
  }
}
