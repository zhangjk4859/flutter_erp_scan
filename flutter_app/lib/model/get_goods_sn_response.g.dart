class GetGoodsSnResponse {
  int? code;
  String? msg;
  List<String>? data;

  GetGoodsSnResponse({
    this.code,
    this.msg,
    this.data,
  });

  GetGoodsSnResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    if (json["data"] != null) {
      var v = json["data"];
      List<String> arr0 = [];
      v.forEach((v) {
        arr0.add(v);
      });
      this.data = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["code"] = code;
    data["msg"] = msg;
    if (this.data != null) {
      var v = this.data;
      List arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data["data"] = arr0;
    }
    return data;
  }
}
