class AllocationGoodsResponseDataItem {
  int? storageId;
  int? goodsId;
  int? type;
  String? name;
  String? brand;
  String? theClass;
  int? theNum;
  int? inNum;
  int? outNum;
  int? createTime;
  String? sn;
  int? state;
  int? storageState;

  AllocationGoodsResponseDataItem({
    this.storageId,
    this.goodsId,
    this.type,
    this.name,
    this.brand,
    this.theClass,
    this.theNum,
    this.inNum,
    this.outNum,
    this.createTime,
    this.sn,
    this.state,
    this.storageState,
  });
  AllocationGoodsResponseDataItem.fromJson(Map<String, dynamic> json) {
    storageId = json["storage_id"]?.toInt();
    goodsId = json["goods_id"]?.toInt();
    type = json["type"]?.toInt();
    name = json["name"]?.toString();
    brand = json["brand"]?.toString();
    theClass = json["class"]?.toString();
    theNum = json["num"]?.toInt();
    inNum = json["in_num"]?.toInt();
    outNum = json["out_num"]?.toInt();
    createTime = json["create_time"]?.toInt();
    sn = json["sn"]?.toString();
    state = json["state"]?.toInt();
    storageState = json["storage_state"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["storage_id"] = storageId;
    data["goods_id"] = goodsId;
    data["type"] = type;
    data["name"] = name;
    data["brand"] = brand;
    data["class"] = theClass;
    data["num"] = theNum;
    data["in_num"] = inNum;
    data["out_num"] = outNum;
    data["create_time"] = createTime;
    data["sn"] = sn;
    data["state"] = state;
    data["storage_state"] = storageState;
    return data;
  }
}

class AllocationGoodsOneResponse {
  int? code;
  String? msg;
  AllocationGoodsResponseDataItem? data;
  AllocationGoodsOneResponse({this.code, this.msg, this.data});

  AllocationGoodsOneResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    if (json["data"] is Map) {
      data = (json["data"] != null)
          ? AllocationGoodsResponseDataItem.fromJson(json["data"])
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

class AllocationGoodsResponse {
  int? code;
  String? msg;
  List<AllocationGoodsResponseDataItem>? data;
  int? count;

  AllocationGoodsResponse({
    this.code,
    this.msg,
    this.data,
    this.count,
  });
  AllocationGoodsResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    if (json["data"] != null) {
      var v = json["data"];
      List<AllocationGoodsResponseDataItem> arr0 = [];
      v.forEach((v) {
        arr0.add(AllocationGoodsResponseDataItem.fromJson(v));
      });
      this.data = arr0;
    }
    count = json["count"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["code"] = code;
    data["msg"] = msg;
    if (this.data != null) {
      var v = this.data;
      List arr0 = [];
      v!.forEach((v) {
        arr0.add(v.toJson());
      });
      data["data"] = arr0;
    }
    data["count"] = count;
    return data;
  }
}
