import 'package:eazy_shop/bloc/cat_bloc.dart';
import 'package:eazy_shop/bloc/search_bloc.dart';
import 'package:eazy_shop/cart/index.dart';
import 'package:eazy_shop/models/search/search_model.dart';
import 'package:eazy_shop/models/search/search_model_list.dart';
import 'package:eazy_shop/models/subCat/sub_cat.dart';
import 'package:eazy_shop/screens/detail_rental/index.dart';
import 'package:eazy_shop/utils/color/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchRentalPage extends StatefulWidget {
  final String categoryId, subCategoryId, pageTitle;

  SearchRentalPage(
      {this.categoryId = "0", this.subCategoryId = "0", this.pageTitle});

  SearchRentalPageState createState() => SearchRentalPageState();
}

class SearchRentalPageState extends State<SearchRentalPage>
    with TickerProviderStateMixin {
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
      _tabController = TabController(
        length: list.length,
        vsync: this,
        initialIndex: 0,
      );
      loading = false;
    });
  }

  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  Widget build(BuildContext context) {
    if (widget.subCategoryId == "0")
      searchBloc.getProductsByCategoryId(widget.categoryId, false);
    else
      searchBloc.getProductsBySubCategoryId(widget.subCategoryId, true);
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size(double.infinity, MediaQuery.of(context).size.height * 0.08),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            map != null
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width,
                    //margin: EdgeInsets.only(left: 60),
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
                    ),
                  )
                : Center(
                    child: Text("Loading.."),
                  ),
            Expanded(
              child: map != null
                  ? GestureDetector(
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
                            if (snapshot.hasData) {
                              if (snapshot.data.data.length == 0)
                                return Center(child: Text("No Products Found"));
                              return Container(
                                  child: ProductsGridView(snapshot.data.data));
                            } else if (snapshot.hasError) {
                              return Text("error");
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    )
                  : Center(
                      child: Text("Loading.."),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ProductsGridView(List<SearchModel> search) {
    List<SearchModel> searchList = [];
    searchList = selectedTab == ""
        ? search.map((e) {
            return e;
          }).toList()
        : search
            .map((e) {
              if (e.subCategoryId == selectedTab) return e;
            })
            .where((element) => element != null)
            .toList();
    return searchList.length != 0
        ? GridView.builder(
            shrinkWrap: true,
            itemCount: searchList.length,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.60,
              crossAxisSpacing: 15,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) =>
                              ProductRentalPage(id: searchList[index].id)));
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Container(
                              //height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10)),
                                child: Image.network(
                                  "${searchList[index].img1}",
                                  fit: BoxFit.fill,
                                ),
                              ))),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          searchList[index].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/rupee_sign.jpg",
                              width: 10.0,
                              height: 10.0,
                            ),
                            Expanded(
                                child: Text(
                              '${searchList[index].price} /day',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                            IconButton(
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => CartPage()));
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                  //height: MediaQuery.of(context).size.height * 0.3,
                  margin: const EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                            offset: Offset(0.0, 0.75))
                      ]),
                ),
              );
            })
        : Center(
            child: Text("No Products Found."),
          );
  }
}
