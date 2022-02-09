import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:state_management_provider/models/items_model.dart';
import 'dart:convert' as convert;

class ApiProvider with ChangeNotifier {
  final _baseUrl = "https://fakestoreapi.com/products";
  List<Items> items = [];
  Future<List<Items>> fetchList() async {
    List<Items> items = [];
    List data;
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      data = convert.jsonDecode(response.body);
      items = data.map((e) => Items.fromJson(e)).toList();
      return items;
    } else {
      throw Exception('Error');
    }
  }

  List<Items> get getItems => items;

  final List<Items> _favList = [];
  List<Items> get getCart => _favList;

  void addtoCart(Items item) {
    _favList.add(item);
    notifyListeners();
  }

  void delCart(Items item) {
    _favList.remove(item);
    notifyListeners();
  }
}
