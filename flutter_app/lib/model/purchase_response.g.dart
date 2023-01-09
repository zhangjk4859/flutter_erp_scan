class PurchaseResponseData {
  int? id;
  String? sn;
  String? supplier;
  String? supplierSn;
  int? orderStatus;
  int? storageStatus;
  int? totalNum;
  int? inNum;
  int? createTime;
  String? desc;

  PurchaseResponseData({
    this.id,
    this.sn,
    this.supplier,
    this.supplierSn,
    this.orderStatus,
    this.storageStatus,
    this.totalNum,
    this.inNum,
    this.createTime,
    this.desc,
  });
  PurchaseResponseData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    sn = json["sn"]?.toString();
    supplier = json["supplier"]?.toString();
    supplierSn = json["supplier_sn"]?.toString();
    orderStatus = json["order_status"]?.toInt();
    storageStatus = json["storage_status"]?.toInt();
    totalNum = json["total_num"]?.toInt();
    inNum = json["in_num"]?.toInt();
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
    data["in_num"] = inNum;
    data["create_time"] = createTime;
    data["desc"] = desc;
    return data;
  }
}

class PurchaseResponse {
  int? code;
  String? msg;
  PurchaseResponseData? data;

  PurchaseResponse({
    this.code,
    this.msg,
    this.data,
  });
  PurchaseResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();

    if (json["data"] is Map) {
      data = (json["data"] != null)
          ? PurchaseResponseData.fromJson(json["data"])
          : null;
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
