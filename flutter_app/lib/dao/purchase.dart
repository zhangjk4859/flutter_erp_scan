// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:flutter_app/model/get_goods_sn_response.g.dart';
import 'package:flutter_app/model/public_response.g.dart';
import 'package:flutter_app/model/purchase_goods_response.g.dart';
import 'package:flutter_app/model/purchase_response.g.dart';
import 'package:flutter_app/net/address.dart';
import 'package:flutter_app/net/api.dart';
import 'package:flutter_app/vo/get_googs_sn_param.dart';
import 'package:flutter_app/vo/store_params.dart';

import 'data_result.dart';

class PurchaseDao {
  static getPurchaseScanDao(String sn) async {
    String url = Address.getPurchaseScan(sn);
    var res = await HttpManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, false);
      }
      var response = PurchaseResponse.fromJson(data);
      return new DataResult(response.data, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static getPurchaseGoodsDao(int id, int page) async {
    var pageIndex = 1;
    if (page > 0) {
      pageIndex = (page / 10 + 1).toInt();
    }

    String url = Address.getPurchaseGoodsScan(id, pageIndex);
    var res = await HttpManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = PurchaseGoodsResponse.fromJson(data);
      return new DataResult(response, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static getPurchaseGoodsOneScan(int id, String sn) async {
    String url = Address.getPurchaseGoodsOneScan(id, sn);
    var res = await HttpManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = PurchaseGoodsOneResponse.fromJson(data);
      return new DataResult(response, true);
    } else {
      return new DataResult(null, false);
    }
  }

  // 采购入库操作
  static postPurchaseStoreIn(StoreGoodsParams data) async {
    String url = Address.getPurchaseStoreIn();

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
