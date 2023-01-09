class GoodsIndexResponse {
  int? code;
  String? msg;
  List<GoodsIndexResponseData>? data;

  GoodsIndexResponse({this.code, this.msg, this.data});

  GoodsIndexResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new GoodsIndexResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GoodsIndexResponseData {
  String? barCode;
  int? relationId;
  String? relationSn;
  String? model;
  String? action;
  String? content;
  String? username;
  int? createBy;
  int? createTime;

  GoodsIndexResponseData(
      {this.barCode,
      this.relationId,
      this.relationSn,
      this.model,
      this.action,
      this.content,
      this.username,
      this.createBy,
      this.createTime});

  GoodsIndexResponseData.fromJson(Map<String, dynamic> json) {
    barCode = json['bar_code'];
    relationId = json['relation_id'];
    relationSn = json['relation_sn'];
    model = json['model'];
    action = json['action'];
    content = json['content'];
    username = json['username'];
    createBy = json['create_by'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bar_code'] = this.barCode;
    data['relation_id'] = this.relationId;
    data['relation_sn'] = this.relationSn;
    data['model'] = this.model;
    data['action'] = this.action;
    data['content'] = this.content;
    data['username'] = this.username;
    data['create_by'] = this.createBy;
    data['create_time'] = this.createTime;
    return data;
  }
}
