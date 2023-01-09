class GetGoodsSnParam {
  String goodsSn; // 第一个商品序列号
  int goodsNum; //商品个数

  int state; // 状态
  GetGoodsSnParam(this.goodsSn, this.goodsNum, {this.state = 0});
}

// 出入库参数
class GetGoodsSnParamVo {
  String name;
  int num; // 总数量
  int optNum; //操作商品数
  int waitNum;
  String goodsSn; //第一个商品编号

  GetGoodsSnParamVo(this.name, this.goodsSn,
      {this.num = 1, this.optNum = 1, this.waitNum = 1});
}

class GetGoodsSnParamAll {
  List<String> goodsSn = []; // 第一个商品序列号
  List<String> goodsNum = []; //商品个数
  List<String> goodsExclude = [];
  int state; // 状态

  GetGoodsSnParamAll(this.goodsSn, this.goodsNum, this.goodsExclude,
      {this.state = 0});
}
