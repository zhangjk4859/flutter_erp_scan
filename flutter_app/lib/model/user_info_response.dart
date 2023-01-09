class UserInfoResponseData {
  int? id;
  String? username;
  String? phone;
  String? email;
  int? organizeId;
  int? organizeManage;
  String? site;
  String? authorize;
  String? desc;
  int? loginTime;
  int? loginIp;

  UserInfoResponseData({
    this.id,
    this.username,
    this.phone,
    this.email,
    this.organizeId,
    this.organizeManage,
    this.site,
    this.authorize,
    this.desc,
    this.loginTime,
    this.loginIp,
  });
  UserInfoResponseData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    username = json["username"]?.toString();
    phone = json["phone"]?.toString();
    email = json["email"]?.toString();
    organizeId = json["organize_id"]?.toInt();
    organizeManage = json["organize_manage"]?.toInt();
    site = json["site"]?.toString();
    authorize = json["authorize"]?.toString();
    desc = json["desc"]?.toString();
    loginTime = json["login_time"]?.toInt();
    loginIp = json["login_ip"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["username"] = username;
    data["phone"] = phone;
    data["email"] = email;
    data["organize_id"] = organizeId;
    data["organize_manage"] = organizeManage;
    data["site"] = site;
    data["authorize"] = authorize;
    data["desc"] = desc;
    data["login_time"] = loginTime;
    data["login_ip"] = loginIp;
    return data;
  }
}

class UserInfoResponse {
  int? code;
  String? msg;
  UserInfoResponseData? data;

  UserInfoResponse({
    this.code,
    this.msg,
    this.data,
  });
  UserInfoResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    if (json["data"] is Map) {
      data = (json["data"] != null)
          ? UserInfoResponseData.fromJson(json["data"])
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
