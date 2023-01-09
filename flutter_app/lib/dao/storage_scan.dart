import 'package:flutter_app/model/storage_scan_response.g.dart';
import 'package:flutter_app/net/address.dart';
import 'package:flutter_app/net/api.dart';
import 'package:flutter_app/vo/store_params.dart';

import 'data_result.dart';

class StorageScanDao {
  static getStorageScan(StoreParam param) async {
    String url = Address.getStorageScan(param);
    var res = await HttpManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return new DataResult(null, true);
      }
      var response = StorageScanResponse.fromJson(data);
      return new DataResult(response, true);
    } else {
      return new DataResult(null, false);
    }
  }
}
