import 'package:flutter_app/model/goods_index_response.g.dart';
import 'package:flutter_app/net/address.dart';
import 'package:flutter_app/net/api.dart';

import 'data_result.dart';

class GoodsDao {
  static getIndexScanDao(String sn) async {
    String url = Address.getGoodsScan(sn);
    var res = await HttpManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = GoodsIndexResponse.fromJson(data);
      return new DataResult(response, true);
    } else {
      return new DataResult(null, false);
    }
  }
}
