import 'package:flutter_app/model/supplier_response.g.dart';
import 'package:flutter_app/net/address.dart';
import 'package:flutter_app/net/api.dart';

import 'data_result.dart';

class SupplierDao {
  static getSupplierScanDao(String sn) async {
    String url = Address.getSupplierScan(sn);
    var res = await HttpManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = SupplierResponse.fromJson(data);
      return new DataResult(response.data, true);
    } else {
      return new DataResult(null, false);
    }
  }
}
