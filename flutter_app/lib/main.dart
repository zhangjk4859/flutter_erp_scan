import 'dart:io';

import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/page/afresh_in_out.dart';
import 'package:flutter_app/page/allocation_in_out.dart';
import 'package:flutter_app/page/allocation_page.dart';
import 'package:flutter_app/page/assembly_in_out.dart';
import 'package:flutter_app/page/assembly_page.dart';
import 'package:flutter_app/page/distribution_page.dart';
import 'package:flutter_app/page/goods_index.dart';
import 'package:flutter_app/page/goods_page.dart';
import 'package:flutter_app/page/group_page.dart';
import 'package:flutter_app/page/index_page.dart';
import 'package:flutter_app/page/loading_page.dart';
import 'package:flutter_app/page/login_page.dart';
import 'package:flutter_app/page/product_page.dart';
import 'package:flutter_app/page/purchase_in_page.dart';
import 'package:flutter_app/page/purchase_out_page.dart';
import 'package:flutter_app/page/purchase_page.dart';
import 'package:flutter_app/page/purchase_return_page.dart';
import 'package:flutter_app/page/sale_in_page.dart';
import 'package:flutter_app/page/sale_out_page.dart';
import 'package:flutter_app/page/sale_page.dart';
import 'package:flutter_app/page/sale_return_page.dart';
import 'package:flutter_app/page/saoma_page.dart';
import 'package:flutter_app/page/scanner_page.dart';
import 'package:flutter_app/page/stock_area_page.dart';
import 'package:flutter_app/page/stock_page.dart';
import 'package:flutter_app/page/stock_shelves.dart';
import 'package:flutter_app/page/store_in_out.dart';
import 'package:flutter_app/page/supplier_page.dart';
import 'package:flutter_app/theme/input.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProgressHud(
        isGlobalHud: true,
        child: MaterialApp(
          routes: <String, WidgetBuilder>{
            IndexPage.routeName: (BuildContext context) =>
                new IndexPage(), //主页面
            LoginPage.routeName: (BuildContext context) => new LoginPage(),
            PurchaseInPage.routeName: (BuildContext context) =>
                new PurchaseInPage(),
            PurchaseOutPage.routeName: (BuildContext context) =>
                new PurchaseOutPage(),
            SaleInPage.routeName: (BuildContext context) => new SaleInPage(),
            SaleOutPage.routeName: (BuildContext context) => new SaleOutPage(),
            AllocationInOutPage.routeName: (BuildContext context) =>
                new AllocationInOutPage(),
            SaomaPage.routeName: (BuildContext context) => new SaomaPage(),
            GoodsPage.routeName: (BuildContext context) => new GoodsPage(),
            GoodsIndexPage.routeName: (BuildContext context) =>
                new GoodsIndexPage(),
            GroupPage.routeName: (BuildContext context) => new GroupPage(),
            DistributionPage.routeName: (BuildContext context) =>
                new DistributionPage(),
            AssemblyInOutPage.routeName: (BuildContext context) =>
                new AssemblyInOutPage(),
            AssemblyPage.routeName: (BuildContext context) =>
                new AssemblyPage(),

            SupplierPage.routeName: (BuildContext context) =>
                new SupplierPage(), // 供应商
            ProductPage.routeName: (BuildContext context) =>
                new ProductPage(), // 产品
            PurchasePage.routeName: (BuildContext context) =>
                new PurchasePage(), // 采购
            PurchaseReturnPage.routeName: (BuildContext context) =>
                new PurchaseReturnPage(), // 采购退货
            SalePage.routeName: (BuildContext context) => new SalePage(), //销售订单
            SaleReturnPage.routeName: (BuildContext context) =>
                new SaleReturnPage(), // 销售退货
            AllocationPage.routeName: (BuildContext context) =>
                new AllocationPage(), // 重新贴牌
            ARefreshInOutPage.routeName: (BuildContext context) =>
                new ARefreshInOutPage(),
            StockPage.routeName: (BuildContext context) =>
                new StockPage(), // 仓库管理
            StockAreaPage.routeName: (BuildContext context) =>
                new StockAreaPage(), // 库区管理
            StockShelvesPage.routeName: (BuildContext context) =>
                new StockShelvesPage(), // 库位管理
            ScannerPage.routeName: (BuildContext context) =>
                new ScannerPage(), // scan
          },
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
            inputDecorationTheme: InputTheme(context),
          ),
          home: LoadingPage(),
        ));
  }
}
