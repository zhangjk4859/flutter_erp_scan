import 'package:dio/dio.dart';
import 'package:flutter_app/model/get_goods_sn_response.g.dart';
import 'package:flutter_app/model/product_response.g.dart';
import 'package:flutter_app/net/address.dart';
import 'package:flutter_app/net/api.dart';
import 'package:flutter_app/vo/get_googs_sn_param.dart';

import 'data_result.dart';

class ProductDao {
  static getProductScanDao(String sn, {int type = 0}) async {
    String url = Address.getProductScan(sn, type);
    var res = await HttpManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = ProductResponse.fromJson(data);
      return new DataResult(response.data, true);
    } else {
      return new DataResult(null, false);
    }
  }

  // 获取商品可用序列号
  static postProductGoodsSn(GetGoodsSnParam data) async {
    String url = Address.getProductGoodsSn();

    FormData params = FormData.fromMap({
      "goods_sn": data.goodsSn,
      "goods_num": data.goodsNum,
      "state": data.state,
    });

    Options option = new Options(method: 'post');
    var res = await HttpManager.netFetch(url, params, null, option);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = GetGoodsSnResponse.fromJson(data);
      return new DataResult(response, true);
    } else {
      return new DataResult(null, false);
    }
  }

  // 获取商品可用序列号
  static postProductGoodsSnAll(GetGoodsSnParamAll data) async {
    String url = Address.getProductGoodsSnAll();

    FormData params = FormData.fromMap({
      "goods_sn": data.goodsSn.length > 0
          ? data.goodsSn.reduce((value, element) => value + "," + element)
          : "",
      "goods_num": data.goodsNum.length > 0
          ? data.goodsNum.reduce((value, element) => value + "," + element)
          : "",
      "goods_exclude": data.goodsExclude.length > 0
          ? data.goodsExclude.reduce((value, element) => value + "," + element)
          : "",
      "state": data.state,
    });

    Options option = new Options(method: 'post');
    var res = await HttpManager.netFetch(url, params, null, option);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = GetGoodsSnResponse.fromJson(data);
      return new DataResult(response, true);
    } else {
      return new DataResult(null, false);
    }
  }
}
