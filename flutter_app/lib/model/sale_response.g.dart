class SaleResponseData {
  int? id;
  String? buyerSn;
  String? buyerName;
  String? sn;
  int? orderStatus;
  int? storageStatus;
  int? totalNum;
  int? sellerNum;
  int? sellerScanNum;
  int? sellerAutoNum;
  String? consignee;
  String? phone;
  int? province;
  int? city;
  int? district;
  String? region;
  String? address;
  String? zipCode;
  String? desc;
  int? createTime;

  SaleResponseData({
    this.id,
    this.buyerSn,
    this.buyerName,
    this.sn,
    this.orderStatus,
    this.storageStatus,
    this.totalNum,
    this.sellerNum,
    this.sellerScanNum,
    this.sellerAutoNum,
    this.consignee,
    this.phone,
    this.province,
    this.city,
    this.district,
    this.region,
    this.address,
    this.zipCode,
    this.desc,
    this.createTime,
  });
  SaleResponseData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    buyerSn = json["buyer_sn"]?.toString();
    buyerName = json["buyer_name"]?.toString();
    sn = json["sn"]?.toString();
    orderStatus = json["order_status"]?.toInt();
    storageStatus = json["storage_status"]?.toInt();
    totalNum = json["total_num"]?.toInt();
    sellerNum = json["seller_num"]?.toInt();
    sellerScanNum = json["seller_scan_num"]?.toInt();
    sellerAutoNum = json["seller_auto_num"]?.toInt();
    consignee = json["consignee"]?.toString();
    phone = json["phone"]?.toString();
    province = json["province"]?.toInt();
    city = json["city"]?.toInt();
    district = json["district"]?.toInt();
    region = json["region"]?.toString();
    address = json["address"]?.toString();
    zipCode = json["zip_code"]?.toString();
    desc = json["desc"]?.toString();
    createTime = json["create_time"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["buyer_sn"] = buyerSn;
    data["buyer_name"] = buyerName;
    data["sn"] = sn;
    data["order_status"] = orderStatus;
    data["storage_status"] = storageStatus;
    data["total_num"] = totalNum;
    data["seller_num"] = sellerNum;
    data["seller_scan_num"] = sellerScanNum;
    data["seller_auto_num"] = sellerAutoNum;
    data["consignee"] = consignee;
    data["phone"] = phone;
    data["province"] = province;
    data["city"] = city;
    data["district"] = district;
    data["region"] = region;
    data["address"] = address;
    data["zip_code"] = zipCode;
    data["desc"] = desc;
    data["create_time"] = createTime;
    return data;
  }
}

class SaleResponse {
  int? code;
  String? msg;
  SaleResponseData? data;

  SaleResponse({
    this.code,
    this.msg,
    this.data,
  });
  SaleResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();

    if (json["data"] is Map) {
      data = ((json["data"] != null)
          ? SaleResponseData.fromJson(json["data"])
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
