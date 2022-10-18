import 'package:eazy_shop/bloc/cat_bloc.dart';
import 'package:eazy_shop/bloc/search_bloc.dart';
import 'package:eazy_shop/cart/index.dart';
import 'package:eazy_shop/models/search/search_model.dart';
import 'package:eazy_shop/models/search/search_model_list.dart';
import 'package:eazy_shop/models/subCat/sub_cat.dart';
import 'package:eazy_shop/screens/detail/index.dart';
import 'package:eazy_shop/screens/detail_rental/index.dart';
import 'package:eazy_shop/utils/color/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  final String categoryId, pageTitle;
  SearchPage({this.categoryId, this.pageTitle});
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  TabController _tabController;
  Map<int, SubCategory> map = null;
  List<Tab> myTabs;
  String selectedTab = "";
  bool loading = true;
  void initState() {
    super.initState();
    initializeTabController();
  }

  initializeTabController() async {
    List<SubCategory> list =
        await catBloc.getSubCategoriesByCategoryId(widget.categoryId);
    setState(() {
      map = list.length > 0 ? list.asMap() : {};

      myTabs = map.values.map((e) {
        return Tab(
          text: e.subcategoryName,
        );
      }).toList();
      selectedTab = map.length > 0 ? map.values.first.id : "";
      _tabController =
          TabController(length: list.length, vsync: this, initialIndex: 0);
      loading = false;
    });
  }

  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  Widget build(BuildContext context) {
    searchBloc.getProductsByCategoryId(widget.categoryId, false);
    return loading
        ? Scaffold(body: Center(child: Text("Loading")))
        : SafeArea(
            top: true,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size(
                    double.infinity, MediaQuery.of(context).size.height * 0.08),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [HexColor("#2EB2F2"), HexColor("#2361AE")],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.navigate_before,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      Text(widget.pageTitle,
                          style: GoogleFonts.montserrat(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      Expanded(child: SizedBox()),
                      IconButton(
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (ctx) => CartPage()));
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  myTabs != null && myTabs.length > 0
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width,
                          child: TabBar(
                            onTap: (val) {
                              setState(() {
                                selectedTab = map[val].id;
                              });
                            },
                            tabs: myTabs,
                            unselectedLabelColor: const Color(0xffacb3bf),
                            indicatorColor: HexColor("#2EB2F2"),
                            labelColor: Colors.black,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorWeight: 3.0,
                            indicatorPadding: EdgeInsets.all(10),
                            isScrollable: true,
                            controller: _tabController,
                          ))
                      : myTabs.length == 0
                          ? Container()
                          : Center(
                              child: Text("Loading.."),
                            ),
                  Expanded(
                      child: GestureDetector(
                        onHorizontalDragEnd: (DragEndDetails details) {
                          if (_tabController.index < myTabs.length &&
                              details.primaryVelocity < 0) {
                            setState(() {
                              _tabController.animateTo(_tabController.index + 1,curve: Curves.linear,);
                              selectedTab = map[_tabController.index].id;
                            });
                          } else {
                            setState(() {
                              _tabController.animateTo(_tabController.index - 1);
                              selectedTab = map[_tabController.index].id;
                            });
                          }
                        },
                        child: StreamBuilder<SearchList>(
                            stream: searchBloc.searchList,
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                case ConnectionState.none:
                                  return Center(child: Text("Loading.."));
                                case ConnectionState.active:
                                case ConnectionState.done:
                                  if (snapshot.hasData) {
                                    if (snapshot.data.data.length == 0) {
                                      return Center(
                                          child: Text("No Products Found"));
                                    } else {
                                      return Container(
                                          child:
                                              ProductWidget(snapshot.data.data));
                                    }
                                  } else if (snapshot.hasError) {
                                    return Text("error");
                                  } else {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                              }
                            }),
                      ))
                ],
              ),
            ),
          );
  }

  Widget ProductWidget(List<SearchModel> search) {
    List<SearchModel> snapshot = [];
    snapshot = selectedTab == ""
        ? search.map((e) {
            return e;
          }).toList()
        : search
            .map((e) {
              if (e.subCategoryId == selectedTab) return e;
            })
            .where((element) => element != null)
            .toList();

    return snapshot != null && snapshot.length != 0
        ? ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: snapshot.length,
            itemBuilder: (context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) =>
                              ProductDetailPage(id: snapshot[index].id)));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                snapshot[index].img1,
                                fit: BoxFit.fill,
                              ))),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           /* Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.add_location,
                                    color: HexColor("#CF2F2F")),
                                Text(
                                  "25 Km Away",
                                  style: TextStyle(fontSize: 12.0),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 5.0,
                            ),*/
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.6,
                                child: Text(
                                  snapshot[index].name.toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 20.0, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right:8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/rupee_sign.jpg",
                                    width: 15.0,
                                    colorBlendMode: BlendMode.color,
                                    color: Colors.red,
                                    height: 15.0,
                                  ),
                                  Text(
                                    snapshot[index].price,
                                    style: TextStyle(fontSize: 15.0),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 0.3,
                  margin: const EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 15.0,
                            offset: Offset(0.0, 0.75))
                      ]),
                ),
              );
            })
        : Center(
            child: Text("No Products Found"),
          );
  }
}
