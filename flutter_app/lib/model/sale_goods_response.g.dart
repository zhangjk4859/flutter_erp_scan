class SaleGoodsResponseDataItem {
  String? name;
  String? brand;
  String? theClass;
  int? theNum;
  int? sellerNum;
  int? sellerScanNum;
  int? sellerAutoNum;
  int? stock;
  int? state;
  int? waitNum;

  SaleGoodsResponseDataItem({
    this.name,
    this.brand,
    this.theClass,
    this.theNum,
    this.sellerNum,
    this.sellerScanNum,
    this.sellerAutoNum,
    this.waitNum,
    this.stock,
    this.state,
  });
  SaleGoodsResponseDataItem.fromJson(Map<String, dynamic> json) {
    name = json["name"]?.toString();
    brand = json["brand"]?.toString();
    theClass = json["class"]?.toString();

    theNum = json["num"]?.toInt();
    sellerNum = json["seller_num"]?.toInt();
    sellerScanNum = json["seller_scan_num"]?.toInt();
    sellerAutoNum = json["seller_auto_num"]?.toInt();

    stock = json["stock"]?.toInt();
    waitNum = json["wait_num"]?.toInt();
    state = json["state"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = name;
    data["brand"] = brand;
    data["class"] = theClass;

    data["num"] = theNum;
    data["seller_num"] = sellerNum;
    data["seller_scan_num"] = sellerScanNum;
    data["seller_auto_num"] = sellerAutoNum;

    data["stock"] = stock;
    data['wait_num'] = waitNum;
    data["state"] = state;
    return data;
  }
}

class SaleGoodsResponse {
  int? code;
  String? msg;
  List<SaleGoodsResponseDataItem>? data;
  int? count;

  SaleGoodsResponse({
    this.code,
    this.msg,
    this.data,
    this.count,
  });
  SaleGoodsResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    if (json["data"] != null) {
      var v = json["data"];
      List<SaleGoodsResponseDataItem> arr0 = [];
      v.forEach((v) {
        arr0.add(SaleGoodsResponseDataItem.fromJson(v));
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

class SaleGoodsOneResponse {
  int? code;
  String? msg;
  SaleGoodsResponseDataItem? data;

  SaleGoodsOneResponse({
    this.code,
    this.msg,
    this.data,
  });
  SaleGoodsOneResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    if (json["data"] is Map) {
      data = (json["data"] != null)
          ? SaleGoodsResponseDataItem.fromJson(json["data"])
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
