import 'package:dio/dio.dart';
import 'package:flutter_app/model/public_response.g.dart';
import 'package:flutter_app/model/sale_return_goods_response.g.dart';
import 'package:flutter_app/model/sale_return_response.g.dart';
import 'package:flutter_app/net/address.dart';
import 'package:flutter_app/net/api.dart';
import 'package:flutter_app/vo/store_params.dart';

import 'data_result.dart';

class SaleReturnDao {
  static getSaleReturnScanDao(String sn) async {
    String url = Address.getSaleReturnScan(sn);
    var res = await HttpManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = SaleReturnResponse.fromJson(data);
      return new DataResult(response.data, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static getSaleReturnGoodsDao(int id, int page) async {
    var pageIndex = 1;
    if (page > 0) {
      pageIndex = (page / 10 + 1).toInt();
    }

    String url = Address.getSaleReturnGoodsScan(id, pageIndex);
    var res = await HttpManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = SaleReturnGoodsResponse.fromJson(data);
      return new DataResult(response, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static getSaleReturnGoodsOneScan(int id, String sn) async {
    String url = Address.getSaleReturnGoodsOneScan(id, sn);
    var res = await HttpManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = SaleReturnGoodsOneResponse.fromJson(data);
      return new DataResult(response, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static postSaleReturnStoreIn(StoreGoodsParams data) async {
    String url = Address.getSaleReturnStoreIn();

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
