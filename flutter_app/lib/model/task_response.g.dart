class TaskResponseDataItem {
  int? id;
  int? serviceId;
  String? serviceCode;
  String? serviceName;
  int? organizeId;
  int? userId;
  String? userName;
  String? sn;
  String? totalNum;
  int? finish;

  TaskResponseDataItem({
    this.id,
    this.serviceId,
    this.serviceCode,
    this.serviceName,
    this.organizeId,
    this.userId,
    this.userName,
    this.sn,
    this.totalNum,
    this.finish,
  });
  TaskResponseDataItem.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    finish = json["finish"]?.toInt();
    serviceId = json["service_id"]?.toInt();
    serviceCode = json["service_code"]?.toString();
    serviceName = json["service_name"]?.toString();
    organizeId = json["organize_id"]?.toInt();
    userId = json["user_id"]?.toInt();
    userName = json["user_name"]?.toString();
    sn = json["sn"]?.toString();
    totalNum = json["total_num"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["finish"] = finish;
    data["service_id"] = serviceId;
    data["service_code"] = serviceCode;
    data["service_name"] = serviceName;
    data["organize_id"] = organizeId;
    data["user_id"] = userId;
    data["user_name"] = userName;
    data["sn"] = sn;
    data["total_num"] = totalNum;
    return data;
  }
}

class TaskResponse {
  int? code;
  String? msg;
  List<TaskResponseDataItem>? data;
  int? count;

  TaskResponse({
    this.code,
    this.msg,
    this.data,
    this.count,
  });
  TaskResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    if (json["data"] != null) {
      var v = json["data"];
      List<TaskResponseDataItem> arr0 = [];
      v.forEach((v) {
        arr0.add(TaskResponseDataItem.fromJson(v));
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
