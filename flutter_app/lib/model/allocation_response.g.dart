class AllocationResponseData {
  int? createTime;
  int? id;
  String? sn;
  String? brand;
  int? orderStatus;
  int? storageStatus;
  int? targetBrandId;
  int? totalInNum;
  int? inNum;
  int? totalOutNum;
  int? outNum;
  int? type;
  bool? notAuth;

  AllocationResponseData({
    this.createTime,
    this.id,
    this.sn,
    this.orderStatus,
    this.storageStatus,
    this.targetBrandId,
    this.totalInNum,
    this.inNum,
    this.totalOutNum,
    this.outNum,
    this.type,
    this.brand,
    this.notAuth,
  });
  AllocationResponseData.fromJson(Map<String, dynamic> json) {
    createTime = json["create_time"]?.toInt();
    id = json["id"]?.toInt();
    sn = json["sn"]?.toString();
    brand = json["brand"]?.toString();
    orderStatus = json["order_status"]?.toInt();
    storageStatus = json["storage_status"]?.toInt();
    targetBrandId = json["target_brand_id"]?.toInt();
    totalInNum = json["total_in_num"]?.toInt();
    inNum = json["in_num"]?.toInt();
    totalOutNum = json["total_out_num"]?.toInt();
    outNum = json["out_num"]?.toInt();
    type = json["type"]?.toInt();
    notAuth = json["not_auth"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["create_time"] = createTime;
    data["id"] = id;
    data["sn"] = sn;
    data["brand"] = brand;
    data["order_status"] = orderStatus;
    data["storage_status"] = storageStatus;
    data["target_brand_id"] = targetBrandId;
    data["total_in_num"] = totalInNum;
    data["n_num"] = inNum;
    data["total_out_num"] = totalOutNum;
    data["out_num"] = outNum;
    data["type"] = type;
    data["not_auth"] = notAuth;
    return data;
  }
}

class AllocationResponse {
  int? code;
  String? msg;
  AllocationResponseData? data;

  AllocationResponse({
    this.code,
    this.msg,
    this.data,
  });
  AllocationResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    if (json["data"] is Map) {
      data = (json["data"] != null)
          ? AllocationResponseData.fromJson(json["data"])
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
