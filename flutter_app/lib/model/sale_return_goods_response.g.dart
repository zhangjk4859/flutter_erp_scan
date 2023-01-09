class SaleReturnGoodsResponseDataItem {
  int? returnId;
  int? goodsId;
  String? name;
  String? brand;
  String? theClass;
  int? theNum;
  int? returnNum;
  int? returnInNum;
  int? redNum;
  int? scrapNum;
  int? state;

  SaleReturnGoodsResponseDataItem(
      {this.returnId,
      this.goodsId,
      this.name,
      this.brand,
      this.theClass,
      this.theNum,
      this.redNum,
      this.scrapNum,
      this.returnNum,
      this.returnInNum,
      this.state});
  SaleReturnGoodsResponseDataItem.fromJson(Map<String, dynamic> json) {
    returnId = json["return_id"]?.toInt();
    goodsId = json["goods_id"]?.toInt();
    name = json["name"]?.toString();
    brand = json["brand"]?.toString();
    theClass = json["class"]?.toString();
    theNum = json["num"]?.toInt();
    redNum = json["red_num"]?.toInt();
    scrapNum = json["scrap_num"]?.toInt();
    returnNum = json["return_num"]?.toInt();
    returnInNum = json["return_in_num"]?.toInt();
    state = json["state"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["return_id"] = returnId;
    data["goods_id"] = goodsId;
    data["name"] = name;
    data["brand"] = brand;
    data["class"] = theClass;
    data["num"] = theNum;
    data["red_num"] = redNum;
    data["scrap_num"] = scrapNum;
    data["state"] = state;
    data["return_num"] = returnNum;
    data["return_in_num"] = returnInNum;
    return data;
  }
}

class SaleReturnGoodsOneResponse {
  int? code;
  String? msg;
  SaleReturnGoodsResponseDataItem? data;

  SaleReturnGoodsOneResponse({
    this.code,
    this.msg,
    this.data,
  });

  SaleReturnGoodsOneResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();

    if (json["data"] is Map) {
      data = ((json["data"] != null)
          ? SaleReturnGoodsResponseDataItem.fromJson(json["data"])
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

class SaleReturnGoodsResponse {
  int? code;
  String? msg;
  List<SaleReturnGoodsResponseDataItem>? data;
  int? count;

  SaleReturnGoodsResponse({
    this.code,
    this.msg,
    this.data,
    this.count,
  });
  SaleReturnGoodsResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    if (json["data"] != null) {
      var v = json["data"];
      List<SaleReturnGoodsResponseDataItem> arr0 = [];
      v.forEach((v) {
        arr0.add(SaleReturnGoodsResponseDataItem.fromJson(v));
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
