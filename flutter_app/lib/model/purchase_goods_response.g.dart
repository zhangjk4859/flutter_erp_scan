class PurchaseGoodsResponseDataItem {
  String? name;
  String? brand;
  String? theClass;
  String? car;
  String? carBrand;
  String? deliveryPeriod;
  int? theNum;
  int? inNum;
  int? waitNum;
  int? state;

  PurchaseGoodsResponseDataItem({
    this.name,
    this.brand,
    this.theClass,
    this.car,
    this.carBrand,
    this.deliveryPeriod,
    this.theNum,
    this.inNum,
    this.state,
  });
  PurchaseGoodsResponseDataItem.fromJson(Map<String, dynamic> json) {
    name = json["name"]?.toString();
    brand = json["brand"]?.toString();
    theClass = json["class"]?.toString();
    car = json["car"]?.toString();
    carBrand = json["car_brand"]?.toString();
    deliveryPeriod = json["delivery_period"]?.toString();
    theNum = json["num"]?.toInt();
    inNum = json["in_num"]?.toInt();
    state = json["state"]?.toInt();
    waitNum = json["wait_num"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = name;
    data["brand"] = brand;
    data["class"] = theClass;
    data["car"] = car;
    data["car_brand"] = carBrand;
    data["delivery_period"] = deliveryPeriod;
    data["num"] = theNum;
    data["in_num"] = inNum;
    data["state"] = state;
    data["wait_num"] = waitNum;
    return data;
  }
}

class PurchaseGoodsResponse {
  int? code;
  String? msg;
  List<PurchaseGoodsResponseDataItem>? data;
  int? count;

  PurchaseGoodsResponse({
    this.code,
    this.msg,
    this.data,
    this.count,
  });
  PurchaseGoodsResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    if (json["data"] != null) {
      var v = json["data"];
      List<PurchaseGoodsResponseDataItem> arr0 = [];
      v.forEach((v) {
        arr0.add(PurchaseGoodsResponseDataItem.fromJson(v));
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

class PurchaseGoodsOneResponse {
  int? code;
  String? msg;
  PurchaseGoodsResponseDataItem? data;

  PurchaseGoodsOneResponse({
    this.code,
    this.msg,
    this.data,
  });
  PurchaseGoodsOneResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    if (json["data"] is Map) {
      data = (json["data"] != null)
          ? PurchaseGoodsResponseDataItem.fromJson(json["data"])
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
