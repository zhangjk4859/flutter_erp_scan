class SaleReturnResponseData {
  int? id;
  String? buyer;
  String? buyerName;
  String? sn;
  int? orderStatus;
  int? storageStatus;
  int? totalNum;
  int? totalReturnNum;
  int? totalReturnInNum;
  int? totalRedNum;
  int? totalScrapNum;
  int? completeTime;
  int? createTime;

  SaleReturnResponseData({
    this.id,
    this.buyer,
    this.buyerName,
    this.sn,
    this.orderStatus,
    this.storageStatus,
    this.totalNum,
    this.totalRedNum,
    this.totalScrapNum,
    this.completeTime,
    this.createTime,
  });
  SaleReturnResponseData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    buyer = json["buyer"]?.toString();
    buyerName = json["buyer_name"]?.toString();
    sn = json["sn"]?.toString();
    orderStatus = json["order_status"]?.toInt();
    storageStatus = json["storage_status"]?.toInt();
    totalNum = json["total_num"]?.toInt();
    totalReturnNum = json["total_return_num"]?.toInt();
    totalReturnInNum = json["total_return_in_num"]?.toInt();
    totalRedNum = json["total_red_num"]?.toInt();
    totalScrapNum = json["total_scrap_num"]?.toInt();
    completeTime = json["complete_time"]?.toInt();
    createTime = json["create_time"]?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["buyer"] = buyer;
    data["buyer_name"] = buyerName;
    data["sn"] = sn;
    data["order_status"] = orderStatus;
    data['storage_status'] = storageStatus;
    data["total_num"] = totalNum;
    data["total_return_num"] = totalReturnNum;
    data["total_return_in_num"] = totalReturnInNum;
    data["total_red_num"] = totalRedNum;
    data["total_scrap_num"] = totalScrapNum;
    data["complete_time"] = completeTime;
    data["create_time"] = createTime;
    return data;
  }
}

class SaleReturnResponse {
  int? code;
  String? msg;
  SaleReturnResponseData? data;

  SaleReturnResponse({
    this.code,
    this.msg,
    this.data,
  });
  SaleReturnResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    if (json["data"] is Map) {
      data = ((json["data"] != null)
          ? SaleReturnResponseData.fromJson(json["data"])
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
