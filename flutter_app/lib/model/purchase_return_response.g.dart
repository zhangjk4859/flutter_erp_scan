class PurchaseReturnResponseData {
  int? id;
  String? sn;
  String? supplier;
  String? supplierSn;
  int? orderStatus;
  int? storageStatus;
  int? totalNum;
  int? totalReturnNum;
  int? totalReturnOutNum;
  int? totalRedNum;
  int? totalScrapNum;
  int? createTime;
  String? desc;

  PurchaseReturnResponseData({
    this.id,
    this.sn,
    this.supplier,
    this.supplierSn,
    this.orderStatus,
    this.storageStatus,
    this.totalReturnNum,
    this.totalReturnOutNum,
    this.totalNum,
    this.totalRedNum,
    this.totalScrapNum,
    this.createTime,
    this.desc,
  });
  PurchaseReturnResponseData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    sn = json["sn"]?.toString();
    supplier = json["supplier"]?.toString();
    supplierSn = json["supplier_sn"]?.toString();
    orderStatus = json["order_status"]?.toInt();
    storageStatus = json["storage_status"]?.toInt();
    totalNum = json["total_num"]?.toInt();
    totalReturnNum = json["total_return_num"]?.toInt();
    totalReturnOutNum = json["total_return_out_num"]?.toInt();
    totalRedNum = json["total_red_num"]?.toInt();
    totalScrapNum = json["total_scrap_num"]?.toInt();
    createTime = json["create_time"]?.toInt();
    desc = json["desc"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["sn"] = sn;
    data["supplier"] = supplier;
    data["supplier_sn"] = supplierSn;
    data["order_status"] = orderStatus;
    data["storage_status"] = storageStatus;
    data["total_num"] = totalNum;
    data["total_return_num"] = totalReturnNum;
    data["total_return_out_num"] = totalReturnOutNum;
    data["total_red_num"] = totalRedNum;
    data["total_scrap_num"] = totalScrapNum;
    data["create_time"] = createTime;
    data["desc"] = desc;
    return data;
  }
}

class PurchaseReturnResponse {
  int? code;
  String? msg;
  PurchaseReturnResponseData? data;

  PurchaseReturnResponse({
    this.code,
    this.msg,
    this.data,
  });
  PurchaseReturnResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    if (json["data"] is Map) {
      data = ((json["data"] != null)
          ? PurchaseReturnResponseData.fromJson(json["data"])
          : null);
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["code"] = code;
    data["msg"] = msg;
    if (data != null) {
      data["data"] = this.data!.toJson();
    }
    return data;
  }
}
