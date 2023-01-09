class GroupDataUsersItem {
  int? id;
  String? username;
  String? phone;
  String? email;
  int? organizeManage;

  GroupDataUsersItem({
    this.username,
    this.phone,
    this.email,
    this.organizeManage,
  });
  GroupDataUsersItem.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    username = json["username"]?.toString();
    phone = json["phone"]?.toString();
    email = json["email"]?.toString();
    organizeManage = json["organize_manage"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["username"] = username;
    data["phone"] = phone;
    data["email"] = email;
    data["organize_manage"] = organizeManage;
    return data;
  }
}

class GroupDataOrganize {
  String? name;
  String? desc;

  GroupDataOrganize({
    this.name,
    this.desc,
  });
  GroupDataOrganize.fromJson(Map<String, dynamic> json) {
    name = json["name"]?.toString();
    desc = json["desc"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = name;
    data["desc"] = desc;
    return data;
  }
}

class GroupData {
  GroupDataOrganize? organize;
  List<GroupDataUsersItem>? users;

  GroupData({
    this.organize,
    this.users,
  });
  GroupData.fromJson(Map<String, dynamic> json) {
    organize = (json["organize"] != null)
        ? GroupDataOrganize.fromJson(json["organize"])
        : null;
    if (json["users"] != null) {
      var v = json["users"];
      List<GroupDataUsersItem> arr0 = [];
      v.forEach((v) {
        arr0.add(GroupDataUsersItem.fromJson(v));
      });
      users = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (organize != null) {
      data["organize"] = organize!.toJson();
    }
    if (users != null) {
      var v = users;
      List arr0 = [];
      v!.forEach((v) {
        arr0.add(v.toJson());
      });
      data["users"] = arr0;
    }
    return data;
  }
}

class GroupResponse {
  int? code;
  String? msg;
  GroupData? data;

  GroupResponse({
    this.code,
    this.msg,
    this.data,
  });
  GroupResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();
    data = (json["data"] != null) ? GroupData.fromJson(json["data"]) : null;
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
