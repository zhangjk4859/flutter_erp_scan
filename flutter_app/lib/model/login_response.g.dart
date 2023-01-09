class LoginResponse {
  int? code;
  String? msg;
  String? data;

  LoginResponse({
    this.code,
    this.msg,
    this.data,
  });
  LoginResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    data = json["data"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["code"] = code;
    data["msg"] = msg;
    data["data"] = this.data;
    return data;
  }
}
