import 'package:flutter_app/vo/store_params.dart';

class Address {
  //static const String host = "http://test.sneikparts.com/scan/";
  static const String host = "http://erp.shjieguan.com/";

  static getLogin() {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}index/login";
  }

  static getLogout() {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}index/logout";
  }

  static getRegistration(String value, List<String?> list) {
    return "${host}index/registration?id=$value&tags=${list.toString()}";
  }

  static getGroup() {
    return "${host}index/group";
  }

  static getIsLogin() {
    return "${host}index/is_login";
  }

  static getUserInfo() {
    return "${host}index/user_info";
  }

  static getSupplierScan(String sn) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}supplier/scan?sn=${sn}";
  }

  static getProductScan(String sn, int type) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}product/scan?sn=${sn}&type=$type";
  }

  static getPurchaseScan(String sn) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}purchase/scan?sn=${sn}";
  }

  static getPurchaseGoodsScan(int id, int page, {limit = 10}) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}purchase/goods?page=${page}&limit=${limit}&id=${id}";
  }

  static getPurchaseGoodsOneScan(int id, String sn) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}purchase/goods_one?sn=${sn}&id=${id}";
  }

  static getProductGoodsSn() {
    return "${host}product/get_goods_sn";
  }

  static getProductGoodsSnAll() {
    return "${host}product/get_goods_sn_all";
  }

  static getPurchaseStoreIn() {
    return "${host}purchase/store_in";
  }

  static getPurchaseReturnScan(String sn) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}purchase_return/scan?sn=${sn}";
  }

  static getPurchaseReturnGoodsScan(int id, int page, {limit = 10}) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}purchase_return/goods?page=${page}&limit=${limit}&id=${id}";
  }

  static String getPurchaseReturnGoodsOneScan(int id, String sn) {
    return "${host}purchase_return/goods_one?sn=${sn}&id=${id}";
  }

  static String getPurchaseReturnStoreOut() {
    return "${host}purchase_return/store_out";
  }

  static getSaleScan(String sn) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}sale/scan?sn=${sn}";
  }

  static getSaleGoodsScan(int id, int page, {limit = 10}) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}sale/goods?page=${page}&limit=${limit}&id=${id}";
  }

  static getSaleGoodsOneScan(int id, String sn) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}sale/goods_one?sn=${sn}&id=${id}";
  }

  static getSaleStoreOut() {
    return "${host}sale/store_out";
  }

  static getSaleReturnScan(String sn) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}sale_return/scan?sn=${sn}";
  }

  static getSaleReturnGoodsScan(int id, int page, {limit = 10}) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}sale_return/goods?page=${page}&limit=${limit}&id=${id}";
  }

  static String getSaleReturnGoodsOneScan(int id, String sn) {
    return "${host}sale_return/goods_one?sn=${sn}&id=${id}";
  }

  static String getSaleReturnStoreIn() {
    return "${host}sale_return/store_in";
  }

  static getTask(int type, int page, {limit = 10}) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}task/index?page=${page}&limit=${limit}&type=${type}";
  }

  static String getDistribution(int id, int userId) {
    return "${host}task/distribution?id=$id&user_id=$userId";
  }

  static String getStorageScan(StoreParam param) {
    return "${host}storage/scan?service_code=${param.serviceCode}&service_id=${param.serviceId}&goods_sn=${param.goodsSn}&service_name=${param.getName()}";
  }

  static String getAllocationScan(String sn) {
    return "${host}allocation/scan?sn=$sn";
  }

  static getAllocationGoodsScan(int id, int type, int page, {limit = 10}) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}allocation/goods?page=${page}&limit=${limit}&id=${id}&type=${type}";
  }

  static getAllocationGoodsOneScan(int id, int type, String sn) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}allocation/goods_one?sn=${sn}&id=${id}&type=${type}";
  }

  static getAllocationStoreIn() {
    return "${host}allocation/store_in";
  }

  static getAllocationStoreOut() {
    return "${host}allocation/store_out";
  }

  static String getGoodsScan(String sn) {
    return "${host}goods/index?sn=$sn";
  }

  static String getAssemblyScan(String sn) {
    return "${host}assembly/scan?sn=$sn";
  }

  static getAssemblyGoodsScan(int id, int type, int page, {limit = 10}) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}assembly/goods?page=${page}&limit=${limit}&id=${id}&type=${type}";
  }

  static getAssemblyGoodsOneScan(int id, int type, String sn) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}assembly/goods_one?sn=${sn}&id=${id}&type=${type}";
  }

  static getAssemblyStoreIn() {
    return "${host}assembly/store_in";
  }

  static getAssemblyStoreOut() {
    return "${host}assembly/store_out";
  }

  static String getARefreshScan(String sn) {
    return "${host}arefresh/scan?sn=$sn";
  }

  // 重新贴牌
  static getARefreshGoodsScan(int id, int type, int page, {limit = 10}) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}arefresh/goods?page=${page}&limit=${limit}&id=${id}&type=${type}";
  }

  static getARefreshGoodsOneScan(int id, int type, String sn) {
    // ignore: unnecessary_brace_in_string_interps
    return "${host}arefresh/goods_one?sn=${sn}&id=${id}&type=${type}";
  }

  static getARefreshStoreIn() {
    return "${host}arefresh/store_in";
  }

  static getARefreshStoreOut() {
    return "${host}arefresh/store_out";
  }

  // 仓库
  static getStockScan(int id, int type, int page, {limit = 10}) {
    return "${host}stock/goods?page=${page}&limit=${limit}&id=${id}&type=${type}";
  }

  static getStockAreaScan(int id, int type, int page, {limit = 10}) {
    return "${host}stock_area/goods?page=${page}&limit=${limit}&id=${id}&type=${type}";
  }

  static getStockShelvesScan(int id, int type, int page, {limit = 10}) {
    return "${host}stock_shelves/goods?page=${page}&limit=${limit}&id=${id}&type=${type}";
  }

  // 其他仓库 位置
  static getStockOtherScan(int id, int type, int page, {limit = 10}) {
    return "${host}stock_other/goods?page=${page}&limit=${limit}&id=${id}&type=${type}";
  }
}
