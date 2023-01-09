class PurchaseReturnGoodsResponseDataItem {
  int? state;
  String? name;
  String? brand;
  String? theClass;
  int? theNum;
  int? returnNum;
  int? returnOutNum;
  int? redNum;
  int? scrapNum;
  String? confirmPrice;
  String? costPrice;
  String? subtotalPrice;

  PurchaseReturnGoodsResponseDataItem({
    this.state,
    this.name,
    this.brand,
    this.theClass,
    this.theNum,
    this.returnNum,
    this.returnOutNum,
    this.redNum,
    this.scrapNum,
    this.confirmPrice,
    this.costPrice,
    this.subtotalPrice,
  });
  PurchaseReturnGoodsResponseDataItem.fromJson(Map<String, dynamic> json) {
    state = json["state"]?.toInt();
    name = json["name"]?.toString();
    brand = json["brand"]?.toString();
    theClass = json["class"]?.toString();
    theNum = json["num"]?.toInt();
    returnNum = json["return_num"]?.toInt();
    returnOutNum = json["return_out_num"]?.toInt();
    redNum = json["red_num"]?.toInt();
    scrapNum = json["scrap_num"]?.toInt();
    confirmPrice = json["confirm_price"]?.toString();
    costPrice = json["cost_price"]?.toString();
    subtotalPrice = json["subtotal_price"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["state"] = state;
    data["name"] = name;
    data["brand"] = brand;
    data["class"] = theClass;
    data["num"] = theNum;
    data["return_num"] = returnNum;
    data["return_out_num"] = returnOutNum;
    data["red_num"] = redNum;
    data["scrap_num"] = scrapNum;
    data["confirm_price"] = confirmPrice;
    data["cost_price"] = costPrice;
    data["subtotal_price"] = subtotalPrice;
    return data;
  }
}

class PurchaseReturnGoodsOneResponse {
  int? code;
  String? msg;
  PurchaseReturnGoodsResponseDataItem? data;

  PurchaseReturnGoodsOneResponse({
    this.code,
    this.msg,
    this.data,
  });
  PurchaseReturnGoodsOneResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    if (json["data"] is Map) {
      data = ((json["data"] != null)
          ? PurchaseReturnGoodsResponseDataItem.fromJson(json["data"])
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

class PurchaseReturnGoodsResponse {
  int? code;
  String? msg;
  List<PurchaseReturnGoodsResponseDataItem>? data;
  int? count;

  PurchaseReturnGoodsResponse({
    this.code,
    this.msg,
    this.data,
    this.count,
  });
  PurchaseReturnGoodsResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    if (json["data"] != null) {
      var v = json["data"];
      List<PurchaseReturnGoodsResponseDataItem> arr0 = [];
      v.forEach((v) {
        arr0.add(PurchaseReturnGoodsResponseDataItem.fromJson(v));
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
