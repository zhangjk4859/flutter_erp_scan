class StoreParam {
  int serviceId; //
  String serviceCode;
  String goodsSn; // 序列号
  int? number = 1; // 批次数

  StoreParam(this.serviceId, this.serviceCode, this.goodsSn, {this.number = 1});

  bool isIn() {
    return StoreGoodsIn.indexOf(this.serviceCode) >= 0;
  }

  bool isOut() {
    return StoreGoodsOut.indexOf(this.serviceCode) >= 0;
  }

  String? getName() {
    return StoreGoodsName[this.serviceCode];
  }
}

const List<String> StoreGoodsIn = [
  StoreGoods.PurchaseIn,
  StoreGoods.SaleIn,
  StoreGoods.AllocationIn,
  StoreGoods.AssemblyIn
];

const List<String> StoreGoodsOut = [
  StoreGoods.PurchaseOut,
  StoreGoods.SaleOut,
  StoreGoods.AllocationOut,
  StoreGoods.AssemblyOut
];

const Map<String, String> StoreGoodsName = {
  StoreGoods.PurchaseIn: "采购入库",
  StoreGoods.PurchaseOut: "采购退货",
  StoreGoods.SaleIn: "销售退货",
  StoreGoods.SaleOut: "销售出库",
  StoreGoods.AllocationIn: "调拨入库",
  StoreGoods.AllocationOut: "调拨入库",
  StoreGoods.AssemblyIn: "组装入库",
  StoreGoods.AssemblyOut: "组装出库",
};

class StoreGoods {
  static const String PurchaseIn = "PurchaseIn";
  static const String PurchaseOut = "PurchaseOut";

  static const String SaleIn = "SaleIn";
  static const String SaleOut = "SaleOut";

  static const String AllocationIn = "AllocationIn";
  static const String AllocationOut = "AllocationOut";

  static const String AssemblyIn = "AssemblyIn";
  static const String AssemblyOut = "AssemblyOut";
}

class StoreGoodsParams {
  int id; // 订单序列号
  List<String> goodsSn; // 商品列表

  StoreGoodsParams(this.id, this.goodsSn);
}
