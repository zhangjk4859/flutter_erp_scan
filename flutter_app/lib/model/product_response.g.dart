class ProductResponseDataSubGoodsItem {
  int? id;
  String? oe;
  String? name;
  String? sn;

  ProductResponseDataSubGoodsItem({
    this.id,
    this.oe,
    this.name,
    this.sn,
  });
  ProductResponseDataSubGoodsItem.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    oe = json["oe"]?.toString();
    name = json["name"]?.toString();
    sn = json["sn"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["oe"] = oe;
    data["name"] = name;
    data["sn"] = sn;
    return data;
  }
}

class ProductResponseData {
  int? id;
  List<String>? image;
  String? sn;
  String? oe;
  String? name;
  String? car;
  int? type;
  String? theClass;
  String? brand;
  List<String>? supplier;
  List<String>? carBrand;
  int? stock;
  int? stockRemind;
  List<ProductResponseDataSubGoodsItem>? subGoods;

  ProductResponseData({
    this.id,
    this.image,
    this.sn,
    this.oe,
    this.name,
    this.car,
    this.type,
    this.theClass,
    this.brand,
    this.carBrand,
    this.stock,
    this.stockRemind,
    this.subGoods,
    this.supplier,
  });
  ProductResponseData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    if (json["image"] != null) {
      var v = json["image"];
      List<String> arr0 = [];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      image = arr0;
    }
    sn = json["sn"]?.toString();
    oe = json["oe"]?.toString();
    name = json["name"]?.toString();
    car = json["car"]?.toString();
    type = json["type"]?.toInt();
    theClass = json["class"]?.toString();
    brand = json["brand"]?.toString();

    if (json["supplier"] != null) {
      var v = json["supplier"];
      List<String> arr0 = [];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      supplier = arr0;
    }

    if (json["car_brand"] != null) {
      var v = json["car_brand"];
      List<String> arr0 = [];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      carBrand = arr0;
    }

    stock = json["stock"]?.toInt();
    stockRemind = json["stock_remind"]?.toInt();
    if (json["sub_goods"] != null) {
      var v = json["sub_goods"];
      List<ProductResponseDataSubGoodsItem> arr0 = [];
      v.forEach((v) {
        arr0.add(ProductResponseDataSubGoodsItem.fromJson(v));
      });
      subGoods = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;

    if (image != null) {
      List<String> v = image!;
      List<String> arr0 = [];
      v.forEach((v) {
        arr0.add(v);
      });
      data["image"] = arr0;
    }

    data["sn"] = sn;
    data["oe"] = oe;
    data["name"] = name;
    data["car"] = car;
    data["type"] = type;
    data["class"] = theClass;
    data["brand"] = brand;

    if (supplier != null) {
      List<String> v = supplier!;
      List<String> arr0 = [];
      v.forEach((v) {
        arr0.add(v);
      });
      data["supplier"] = arr0;
    }

    if (carBrand != null) {
      List<String> v = carBrand!;
      List<String> arr0 = [];
      v.forEach((v) {
        arr0.add(v);
      });
      data["car_brand"] = arr0;
    }
    data["stock"] = stock;
    data["stock_remind"] = stockRemind;
    if (subGoods != null) {
      List<ProductResponseDataSubGoodsItem> v = subGoods!;
      List<Map<String, dynamic>> arr0 = [];
      v.forEach((v) {
        arr0.add(v.toJson());
      });
      data["sub_goods"] = arr0;
    }
    return data;
  }
}

class ProductResponse {
  int? code;
  String? msg;
  ProductResponseData? data;

  ProductResponse({
    this.code,
    this.msg,
    this.data,
  });
  ProductResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();

    if (json["data"] is Map) {
      data = (json["data"] != null)
          ? ProductResponseData.fromJson(json["data"])
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
