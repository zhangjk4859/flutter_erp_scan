import 'package:flutter/material.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/dao/goods_index.dart';
import 'package:flutter_app/model/goods_index_response.g.dart';
import 'package:flutter_app/page/product_page.dart';
import 'package:flutter_app/utils/code.dart';
import 'package:flutter_app/utils/date.dart';
import 'package:flutter_app/utils/page_util.dart';
import 'package:flutter_app/widget/saoma_text_field.dart';

class GoodsIndexPage extends StatefulWidget {
  static const String routeName = '/goods_index';

  @override
  State<StatefulWidget> createState() => _GoodsIndexPageState();
}

// 商品溯源
class _GoodsIndexPageState extends State<GoodsIndexPage> {
  List<FlowEvent> events = [];

  TextEditingController? _goodsController;
  String goodsSn = "";

  DataResult? dataResult;
  GoodsIndexResponse? goodsIndexResponse;
  List<GoodsIndexResponseData>? goodsIndexData;

  @override
  void initState() {
    _goodsController =
        TextEditingController.fromValue(TextEditingValue(text: goodsSn));
    _goodsController!.addListener(() {
      goodsSn = _goodsController!.text;
      CodeType type = analysisCode(goodsSn);
      if (type == CodeType.product_instance) {
        getGoods(goodsSn);
      }
    });
    super.initState();
  }

  void getGoods(String sn) async {
    dataResult = await GoodsDao.getIndexScanDao(sn);
    goodsIndexResponse = dataResult!.data;
    goodsIndexData = goodsIndexResponse!.data!;
    if (goodsIndexResponse != null) {
      setState(() {
        events = goodsIndexData!
            .map((e) => FlowEvent(
                attr: e,
                author: e.username!,
                isCompleted: true,
                title: e.action!,
                date: e.createTime!,
                advise: getAdvise(e)))
            .toList();
      });
    }
  }

  Widget getAdvise(GoodsIndexResponseData item) {
    return Container();
  }

  void openOther(String relationSn) {
    CodeType type = analysisCode(relationSn);
    if (type != CodeType.none) {
      var element = getServicesItem(type);
      // ignore: unnecessary_null_comparison
      if (element != null) {
        Navigator.of(context).pushNamed(element.route, arguments: relationSn);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(
              // 绘制返回键
              child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context); // 关闭当前页面
            },
          )),
          title: Text("商品溯源"),
        ),
        body: Container(
            padding: EdgeInsets.all(5),
            child: Column(children: [
              Container(
                  padding: EdgeInsets.all(3),
                  child: SaomaTextField(
                    _goodsController!,
                    "",
                    hintText: "请输入产品或扫码",
                    autofocus: false,
                  )),
              Expanded(
                child: events.length > 0
                    ? Card(
                        elevation: 0,
                        margin:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                        child: SingleChildScrollView(
                          child: Stack(
                            fit: StackFit.loose,
                            children: <Widget>[
                              Positioned(
                                left: 21,
                                top: 15,
                                bottom: 15,
                                child: VerticalDivider(
                                  width: 1,
                                ),
                              ),
                              ListView.separated(
                                padding: EdgeInsets.zero,
                                itemCount: events.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () => {
                                            if (events[index].attr.relationId ==
                                                0)
                                              {
                                                Navigator.of(context).pushNamed(
                                                    ProductPage.routeName,
                                                    arguments: events[index]
                                                        .attr
                                                        .barCode)
                                              }
                                            else
                                              {
                                                openOther(events[index]
                                                    .attr
                                                    .relationSn!)
                                              }
                                          },
                                      child: FlowEventRow(events[index]));
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Divider(
                                    height: 1,
                                    indent: 45,
                                  );
                                },
                              )
                            ],
                          ),
                        ))
                    : Center(child: Text("没有发现商品历史信息")),
              )
            ])));
  }
}

class FlowEvent {
  FlowEvent({
    required this.date,
    required this.author,
    required this.title,
    required this.advise,
    required this.attr,
    this.isCompleted = true,
  });

  Widget advise;
  final String title;
  final int date;
  final bool isCompleted;
  final String author;
  final GoodsIndexResponseData attr;

  bool get hasAdvise => isCompleted && advise != null ? true : false;
}

@immutable
class FlowEventRow extends StatelessWidget {
  FlowEventRow(this.event);

  final FlowEvent event;

  double get circleRadius => event.isCompleted ? 8 : 6;
  Color get circleColor =>
      event.isCompleted ? const Color(0xFF40BE7F) : const Color(0xFFD5D5D5);

  @override
  Widget build(BuildContext context) {
    final Color dimColor = const Color(0xFFC5C5C5);
    final Color highlightColor = const Color(0xFF40BE7F);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0 - circleRadius),
            child: Container(
              width: circleRadius * 2,
              height: circleRadius * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleColor,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 0, right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              event.title,
                              style: TextStyle(
                                fontSize: 13,
                                color: event.isCompleted
                                    ? highlightColor
                                    : dimColor,
                              ),
                            ),
                            Text(
                              "${event.author}  ",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      Text(
                        timeToDateFormat(event.date),
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: dimColor),
                      )
                    ],
                  ),
                  ...event.hasAdvise
                      ? [
                          SizedBox(
                            height: 4,
                          ),
                          event.advise
                        ]
                      : [],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
