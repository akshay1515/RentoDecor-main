import 'package:eazy_shop/bloc/search_bloc.dart';
import 'package:eazy_shop/models/search/search_model.dart';
import 'package:eazy_shop/models/search/search_model_list.dart';
import 'package:eazy_shop/screens/detail/index.dart';
import 'package:eazy_shop/utils/color/color.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';

class SearchBarPage extends StatefulWidget {
  SearchBarPageState createState() => SearchBarPageState();
}
SearchBarController searchController = SearchBarController();
class SearchBarPageState extends State<SearchBarPage> {
  List<SearchModel> suggested = [
    SearchModel('', 'Chair', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''),
    SearchModel('', 'Party', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''),
    SearchModel('', 'Decoration', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''),
    SearchModel('', 'Ballons', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''),
    SearchModel('', 'Chair', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''),
    SearchModel('', 'Chair', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''),
    SearchModel('', 'Chair', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''),


  ];

  Future<List<SearchModel>> search(String search) async {
    SearchList list = await searchBloc.getProductsBySearchKeyword(search);
    return list.data;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchBar<SearchModel>(
            onSearch: search,
            buildSuggestion: (SearchModel,index){
              return Column(
                children: [
                  Text(
                    'Trending Search',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {

                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black38,
                                        style: BorderStyle.solid,
                                        width: 0.5))),
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Text(suggested[index].name),
                                Spacer(),
                                Transform.rotate(
                                    angle: 50, child: Icon(Icons.arrow_forward,color: Colors.black45,))
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              );
            },
            minimumChars: 3,
            suggestions: [

            ],
            debounceDuration: Duration(milliseconds: 800),
            loader: Center(
              child: Text("Loading"),
            ),
            placeHolder: Center(
              child: Text("Products will be displayed here"),
            ),
            onError: (error) {
              return Center(
                child: Text("Error occurred : $error"),
              );
            },
            emptyWidget: Center(child: Text("No Products Found")),
            onItemFound: (SearchModel search, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => ProductDetailPage(id: search.id)));
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
                                search.img1,
                                fit: BoxFit.fill,
                              ))),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
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
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.person, color: HexColor("#CF2F2F")),
                                Text(
                                  search.price,
                                  style: TextStyle(fontSize: 12.0),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                        child: Text(
                          search.name,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      )
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
            },
          ),
        ),
      ),
    );
  }
}
