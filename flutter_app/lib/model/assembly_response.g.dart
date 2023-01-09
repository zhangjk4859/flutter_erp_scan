class AssemblyResponseData {
  int? createTime;
  int? id;
  String? sn;
  int? orderStatus;
  int? storageStatus;
  int? totalInNum;
  int? inNum;
  String? name;
  String? brand;
  String? theClass;

  AssemblyResponseData({
    this.createTime,
    this.id,
    this.sn,
    this.orderStatus,
    this.storageStatus,
    this.totalInNum,
    this.inNum,
    this.brand,
    this.name,
    this.theClass,
  });
  AssemblyResponseData.fromJson(Map<String, dynamic> json) {
    createTime = json["create_time"]?.toInt();
    id = json["id"]?.toInt();
    sn = json["sn"]?.toString();
    brand = json["brand"]?.toString();
    orderStatus = json["order_status"]?.toInt();
    storageStatus = json["storage_status"]?.toInt();
    totalInNum = json["total_in_num"]?.toInt();
    inNum = json["in_num"]?.toInt();
    name = json["name"]?.toString();
    theClass = json["class"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["create_time"] = createTime;
    data["id"] = id;
    data["sn"] = sn;
    data["brand"] = brand;
    data["order_status"] = orderStatus;
    data["storage_status"] = storageStatus;
    data["total_in_num"] = totalInNum;
    data["in_num"] = inNum;
    data["name"] = name;
    data["class"] = theClass;
    return data;
  }
}

class AssemblyResponse {
  int? code;
  String? msg;
  AssemblyResponseData? data;

  AssemblyResponse({
    this.code,
    this.msg,
    this.data,
  });
  AssemblyResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    if (json["data"] is Map) {
      data = (json["data"] != null)
          ? AssemblyResponseData.fromJson(json["data"])
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
