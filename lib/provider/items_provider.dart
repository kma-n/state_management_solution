import 'package:flutter/material.dart';
import 'package:state_management_provider/models/items_model.dart';
import 'package:state_management_provider/services/api_servies.dart';

class ItemProvider with ChangeNotifier {
  Future fetchList() {
    Future<List<Items>> items = ApiProvider().fetchList();

    return items;
  }

  final List<String> _favList = [];

  List<String> get getCart => _favList;

  void addtoCart(String item) {
    _favList.add(item);
    notifyListeners();
  }

  void delCart(String item) {
    _favList.remove(item);
    notifyListeners();
  }
}
