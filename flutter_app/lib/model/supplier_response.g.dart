class SupplierResponseData {
  int? id;
  String? sn;
  String? code;
  String? name;
  String? contactsName;
  String? contactsPosition;
  String? contactsPhone;
  String? address;
  String? desc;
  int? status;

  SupplierResponseData({
    this.id,
    this.sn,
    this.code,
    this.name,
    this.contactsName,
    this.contactsPosition,
    this.contactsPhone,
    this.address,
    this.desc,
    this.status,
  });
  SupplierResponseData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    sn = json["sn"]?.toString();
    code = json["code"]?.toString();
    name = json["name"]?.toString();
    contactsName = json["contacts_name"]?.toString();
    contactsPosition = json["contacts_position"]?.toString();
    contactsPhone = json["contacts_phone"]?.toString();
    address = json["address"]?.toString();
    desc = json["desc"]?.toString();
    status = json["status"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["sn"] = sn;
    data["code"] = code;
    data["name"] = name;
    data["contacts_name"] = contactsName;
    data["contacts_position"] = contactsPosition;
    data["contacts_phone"] = contactsPhone;
    data["address"] = address;
    data["desc"] = desc;
    data["status"] = status;
    return data;
  }
}

class SupplierResponse {
  int? code;
  String? msg;
  SupplierResponseData? data;

  SupplierResponse({
    this.code,
    this.msg,
    this.data,
  });
  SupplierResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toInt();
    msg = json["msg"]?.toString();

    if (json["data"] is Map) {
      data = (json["data"] != null)
          ? SupplierResponseData.fromJson(json["data"])
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
