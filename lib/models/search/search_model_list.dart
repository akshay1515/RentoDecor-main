import 'package:eazy_shop/models/cat/cat_model.dart';
import 'package:eazy_shop/models/search/search_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_model_list.g.dart';

@JsonSerializable()
class SearchList {
  String result, message;

  List<SearchModel> data;
  SearchList({this.result, this.message, this.data});
  factory SearchList.fromJson(Map<String, dynamic> json) =>
      _$SearchListFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SearchListToJson(this);
}
