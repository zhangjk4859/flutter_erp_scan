const Map<int, String> orderStatus = {
  0: '待确认',
  1: '待发货',
  2: '出库中',
  3: '已发货',
  4: '待收货',
  5: '入库中',
  6: '待完成',
  7: '已完成',
  8: '已取消',
  9: '已作废',
};

const Map<int, String> storageStatus = {
  1: '待出库',
  2: '已出库',
  3: '部分出库',
  4: '待入库',
  5: '已入库',
  6: '部分入库',
  7: '不足量',
  8: '缺货',
};

const IN_ORDER_STATUS = [
  4,
  5,
  6,
];
const OUT_ORDER_STATUS = [1, 2, 3, 6];

class Status {
  static outShow(orderStatus) {
    return OUT_ORDER_STATUS.indexOf(orderStatus) >= 0;
  }

  static inShow(orderStatus) {
    return IN_ORDER_STATUS.indexOf(orderStatus) >= 0;
  }

  static order(val) {
    var status = orderStatus[val];
    if (status == null) {
      return "未知";
    }
    return status;
  }

  static storage(val) {
    var status = storageStatus[val];
    if (status == null) {
      return "未知";
    }
    return status;
  }
}
