class PublicResponse {
  int? code;
  String? msg;

  PublicResponse({
    this.code,
    this.msg,
  });
  PublicResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["code"] = code;
    data["msg"] = msg;
    return data;
  }
}
